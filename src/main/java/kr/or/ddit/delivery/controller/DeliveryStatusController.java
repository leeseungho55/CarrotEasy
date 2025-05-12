package kr.or.ddit.delivery.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.TimeZone;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.delivery.service.DeliveryService;
import kr.or.ddit.delivery.vo.DeliveryVo;
import kr.or.ddit.util.KakaoConfig;

@WebServlet("/api/deliveryStatus.do")
public class DeliveryStatusController extends HttpServlet {
       
	private DeliveryService service = DeliveryService.getInstance();
	private static Map<String, JsonArray> deliveryHistories = new HashMap();

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    response.setContentType("application/json");
	    response.setCharacterEncoding("UTF-8");
	    PrintWriter out = response.getWriter();
	    
	    System.out.println("All request parameters: ");
	    request.getParameterMap().forEach((key, value) -> {
	        System.out.println(key + ": " + String.join(", ", value));
	    });
	    
	    String deliId = request.getParameter("partnerOrderId");

	    if (deliId == null || deliId.trim().isEmpty()) {
	        JsonObject errorResult = new JsonObject();
	        errorResult.addProperty("success", false);
	        errorResult.addProperty("message", "배송 ID가 필요합니다.");
	        out.print(errorResult.toString());
	        return;
	    }
	    
	    try {
	        // 데이터베이스에서 현재 저장된 상태를 확인
	        String savedStatus = service.getDeliveryStatus(deliId);
	        
	        // Kakao API에서 최신 상태 확인
	        JsonObject kakaoResponse = getKakaoDeliveryStatus(deliId);
	        
	        if (kakaoResponse == null) {
	            JsonObject errorResult = new JsonObject();
	            errorResult.addProperty("success", false);
	            errorResult.addProperty("message", "배송 정보를 찾을 수 없습니다.");
	            out.print(errorResult.toString());
	            return;
	        }
	        
	        // Kakao API에서 받은 최신 상태
	        String kakaoStatus = "";
	        if (kakaoResponse.has("receipt") && kakaoResponse.getAsJsonObject("receipt").has("status")) {
	            kakaoStatus = kakaoResponse.getAsJsonObject("receipt").get("status").getAsString();
	        }
	        
	        // 상태가 변경되었다면 데이터베이스 업데이트
	        if (kakaoStatus != null && !kakaoStatus.isEmpty() && !kakaoStatus.equals(savedStatus)) {
	            DeliveryVo vo = new DeliveryVo();
	            vo.setDeliId(deliId);
	            vo.setDeliStatus(kakaoStatus);
	            service.deliveryStatusUpdate(vo);
	        }
	        
	        // 히스토리 정보 생성 또는 가져오기
	        JsonArray histories = new JsonArray();

	        // 이전에 저장된 히스토리가 있는지 확인
	        if (deliveryHistories.containsKey(deliId)) {
	            histories = deliveryHistories.get(deliId);
	        }

	        // Kakao API에서 새로운 상태 정보 확인
	        if (kakaoStatus != null && !kakaoStatus.isEmpty()) {
	            // 이미 같은 상태의 히스토리가 있는지 확인
	            boolean statusExists = false;
	            for (int i = 0; i < histories.size(); i++) {
	                JsonObject existingHistory = histories.get(i).getAsJsonObject();
	                if (existingHistory.get("status").getAsString().equals(kakaoStatus)) {
	                    // 이미 있는 상태라면 시간만 업데이트
	                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
	                    sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
	                    String now = sdf.format(new Date());
	                    existingHistory.addProperty("updatedAt", now);
	                    statusExists = true;
	                    break;
	                }
	            }
	            
	            // 해당 상태가 없다면 새로 추가
	            if (!statusExists) {
	                JsonObject newHistory = new JsonObject();
	                newHistory.addProperty("status", kakaoStatus);
	                
	                // 현재 시간을 ISO 8601 형식으로 변환
	                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssXXX");
	                sdf.setTimeZone(TimeZone.getTimeZone("Asia/Seoul"));
	                String now = sdf.format(new Date());
	                
	                newHistory.addProperty("updatedAt", now);
	                histories.add(newHistory);
	            }
	            
	            // 업데이트된 히스토리를 메모리에 저장
	            deliveryHistories.put(deliId, histories);
	        }

	        // kakaoResponse에 histories 설정
	        kakaoResponse.add("histories", histories);
	        
	        System.out.println("histories : " + histories);
	        
	        // JSP로 데이터 전달
	        request.setAttribute("deliveryData", kakaoResponse.toString());
	        request.setAttribute("deliId", deliId);
	        
	        // JSP로 포워드
	        RequestDispatcher view = request.getRequestDispatcher("/WEB-INF/view/quick/deliveryTracking.jsp");
	        view.forward(request, response);
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        JsonObject errorResult = new JsonObject();
	        errorResult.addProperty("success", false);
	        errorResult.addProperty("message", "오류가 발생했습니다: " + e.getMessage());
	        out.print(errorResult.toString());
	    }
	}

    private JsonObject getKakaoDeliveryStatus(String partnerOrderId) {
        try {
            // Kakao Mobility API URL
            String apiUrl = KakaoConfig.KAKAO_STATUS_API_URL + partnerOrderId;
            URL url = new URL(apiUrl);
            
            String apiKey = KakaoConfig.API_KEY;
            String authorization = "";

            try {
                authorization = KakaoConfig.createAuthorization(apiKey);
            } catch (InvalidKeyException | NoSuchAlgorithmException e) {
                e.printStackTrace();
                throw new IOException("서명 생성 실패: " + e.getMessage());
            }
            
            // HTTP 연결 설정
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("accept", "application/json");
            conn.setRequestProperty("vendor", KakaoConfig.VENDOR_ID);
            conn.setRequestProperty("Authorization", authorization);
            
            // 응답 코드 확인
            int responseCode = conn.getResponseCode();
            if (responseCode != 200) {
                System.out.println("Kakao API 오류: " + responseCode);
                return null;
            }
            
            // 응답 결과 읽기
            BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            String inputLine;
            StringBuilder response = new StringBuilder();
            
            while ((inputLine = in.readLine()) != null) {
                response.append(inputLine);
            }
            in.close();
            
            // JSON 파싱
            Gson gson = new Gson();
            JsonObject jsonResponse = gson.fromJson(response.toString(), JsonObject.class);
           
            return jsonResponse;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}