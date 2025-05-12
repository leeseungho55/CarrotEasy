package kr.or.ddit.delivery.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.util.KakaoConfig;

@WebServlet("/api/priceCheck.do")
public class QuickPriceController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RequestDispatcher view = req.getRequestDispatcher("/WEB-INF/view/quick/pricePopup.jsp");
        view.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		JsonObject result = new JsonObject();
        
        try {
            // 클라이언트에서 전송된 파라미터들 추출
        	// 주문 기본 정보
        	String orderType = req.getParameter("orderType");

        	// 픽업 정보
            String pickupAddress = req.getParameter("pickupAddress");
            String pickupDetailAddress = req.getParameter("pickupDetailAddress");
        	String pickupLatitude = req.getParameter("pickupLatitude");
        	String pickupLongitude = req.getParameter("pickupLongitude");
        	        	
        	// 배송지 정보
        	String deliveryAddress = req.getParameter("deliveryAddress");
        	String deliveryDetailAddress = req.getParameter("deliveryDetailAddress");
        	String deliveryLatitude = req.getParameter("deliveryLatitude");
        	String deliveryLongitude = req.getParameter("deliveryLongitude");

        	// 상품 정보
            String productSize = req.getParameter("productSize");
            
            JsonObject requestBody = new JsonObject();
            requestBody.addProperty("orderType", orderType);
            
            JsonObject pickup = new JsonObject();
            JsonObject pickupLocation = new JsonObject();
            pickupLocation.addProperty("basicAddress", pickupAddress);
            pickupLocation.addProperty("detailAddress", pickupDetailAddress);
            pickupLocation.addProperty("latitude", 36.3243180); // 실제 구현에서는 주소 기반으로 좌표 계산 필요
            pickupLocation.addProperty("longitude", 127.4082598);
            pickup.add("location", pickupLocation);
            
            requestBody.add("pickup", pickup);
            
            JsonObject dropoff = new JsonObject();
            JsonObject dropoffLocation = new JsonObject();

            dropoffLocation.addProperty("basicAddress", deliveryAddress);
            dropoffLocation.addProperty("detailAddress", deliveryDetailAddress);
            dropoffLocation.addProperty("latitude", 36.3576690); // 임시 좌표값 (실제로는 주소 기반으로 좌표 계산 필요)
            dropoffLocation.addProperty("longitude", 127.3489974);
            dropoff.add("location", dropoffLocation);
            
            requestBody.add("dropoff", dropoff);
            
            requestBody.addProperty("productSize", productSize);
            
            // 로그용으로 콘솔에 출력
            System.out.println("Generated Request Body: " + requestBody.toString());

            JsonObject response = callKakaoQuickAPI(requestBody);
            int totalPrice = response.get("totalPrice").getAsInt();
            
            result.addProperty("totalPrice", totalPrice);
            result.addProperty("success", true);
            result.addProperty("message", "배송 요청이 성공적으로 처리되었습니다.");
            
        } catch (Exception e) {
            e.printStackTrace();
            result.addProperty("success", false);
            result.addProperty("message", "배송 요청 처리 중 오류가 발생했습니다: " + e.getMessage());
        }
        
        resp.setContentType("application/json");  // 응답 타입을 JSON으로 설정
        resp.getWriter().write(new Gson().toJson(result));
	}
	
	private JsonObject callKakaoQuickAPI(JsonObject requestBody) throws IOException {
        // 카카오 퀵 API 엔드포인트 URL
        String apiUrl = KakaoConfig.KAKAO_QUICK_PRICE_API_URL;
        
        String apiKey = KakaoConfig.API_KEY;
        String authorization = "";

        try {
            authorization = KakaoConfig.createAuthorization(apiKey);
        } catch (InvalidKeyException | NoSuchAlgorithmException e) {
            e.printStackTrace();
            throw new IOException("서명 생성 실패: " + e.getMessage());
        }
                
        // HTTP 연결 설정
        URL url = new URL(apiUrl);
        HttpURLConnection connection = (HttpURLConnection) url.openConnection();
        connection.setRequestMethod("POST");
        connection.setDoOutput(true);
        connection.setRequestProperty("accept", "application/json");
        connection.setRequestProperty("Content-Type", "application/json");
        connection.setRequestProperty("Authorization", authorization);
        connection.setRequestProperty("vendor", KakaoConfig.VENDOR_ID);
        
        // 주문 정보 생성 (요청 본문)
        String requestBodyStr = requestBody.toString();
                
        // 요청 본문 전송
        try (OutputStream os = connection.getOutputStream()) {
            byte[] input = requestBodyStr.getBytes("utf-8");
            os.write(input, 0, input.length);
        }
        
        // 응답 받기
        System.out.println("Attempting to connect to API...");
        
        try {
            int responseCode = connection.getResponseCode();
            System.out.println("Response Code: " + responseCode);
            
            // 정상적인 응답 처리 (200번대 응답 코드)
            if (responseCode >= 200 && responseCode < 300) {
                System.out.println("Response Message: " + connection.getResponseMessage());
                BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream(), "utf-8"));
                StringBuilder response = new StringBuilder();
                String inputLine;
                while ((inputLine = in.readLine()) != null) {
                    response.append(inputLine);
                }
                in.close();
                
                // 응답 처리
                String responseBody = response.toString();
                System.out.println("Response Body: " + responseBody);
                JsonObject jsonResponse = new Gson().fromJson(responseBody, JsonObject.class);
                int totalPrice = jsonResponse.get("totalPrice").getAsInt();
                
                // 성공 응답 생성
                JsonObject result = new JsonObject();
                result.addProperty("success", true);
                result.addProperty("totalPrice", totalPrice);
                result.addProperty("message", "배송 요청이 성공적으로 처리되었습니다.");
                
                return result;
            } else {
                // 오류 응답 처리
                handleErrorStream(connection);
                JsonObject result = new JsonObject();
                result.addProperty("success", false);
                result.addProperty("message", "API 호출 실패: " + responseCode);
                return result;
            }
        } catch (IOException e) {
            System.out.println("Exception during API call: " + e.getMessage());
            handleErrorStream(connection);
            JsonObject result = new JsonObject();
            result.addProperty("success", false);
            result.addProperty("message", "API 호출 중 오류 발생: " + e.getMessage());
            return result;
        }
    }
    
    private void handleErrorStream(HttpURLConnection connection) {
        try {
            // 오류 응답 스트림 읽기
            BufferedReader errorReader = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            StringBuilder errorResponse = new StringBuilder();
            String line;
            while ((line = errorReader.readLine()) != null) {
                errorResponse.append(line);
            }
            
            // 오류 응답 확인
            String errorJson = errorResponse.toString();
            System.out.println("Error Response: " + errorJson);

            // JSON 파싱하여 카카오 API의 error code, status, message를 추출
            JsonObject errorObject = new Gson().fromJson(errorJson, JsonObject.class);
            String code = errorObject.get("code").getAsString();  // error code
            String message = errorObject.get("message").getAsString();  // error message

            // 디버깅 정보 출력
            System.out.println("Error Code: " + code);
            System.out.println("Error Message: " + message);
            
        } catch (IOException e) {
            System.out.println("Error while reading the error stream: " + e.getMessage());
        }
    }
}
