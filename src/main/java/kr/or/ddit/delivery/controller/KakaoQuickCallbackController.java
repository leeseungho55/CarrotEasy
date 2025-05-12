package kr.or.ddit.delivery.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.Gson;
import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.delivery.service.DeliveryService;
import kr.or.ddit.delivery.vo.DeliveryVo;

@WebServlet("/api/kakaoQuickCallback.do")
public class KakaoQuickCallbackController extends HttpServlet {    
    private DeliveryService deliveryService = DeliveryService.getInstance();
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public KakaoQuickCallbackController() {
        super();
    }

    /**
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        JsonObject result = new JsonObject();
        
        try {
            // API에서 보낸 JSON 데이터 읽기
            StringBuilder jsonBuffer = new StringBuilder();
            BufferedReader reader = request.getReader();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuffer.append(line);
            }
            
            // JSON 파싱
            JsonObject jsonData = gson.fromJson(jsonBuffer.toString(), JsonObject.class);
            
            // 필요한 데이터 추출
            String deliveryId = jsonData.get("delivery_id").getAsString();
            String status = jsonData.get("status").getAsString();
            
            DeliveryVo deliveryVo = new DeliveryVo();
            deliveryVo.setDeliId(deliveryId);
            deliveryVo.setDeliStatus(status);
            
            // 배송 상태 업데이트
            int updated = deliveryService.deliveryStatusUpdate(deliveryVo);
            
            if (updated > 0) {
                result.addProperty("success", true);
                result.addProperty("message", "배송 상태가 업데이트되었습니다.");
            } else {
            	result.addProperty("success", false);
                result.addProperty("message", "배송 상태 업데이트 실패");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            result.addProperty("success", false);
            result.addProperty("message", "서버 오류: " + e.getMessage());
        }
        
        out.print(gson.toJson(result));
    }
}
