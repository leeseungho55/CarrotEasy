package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.service.EmailVerificationService;

@WebServlet("/sendVerificationCode")
public class SendVerificationCodeServlet extends HttpServlet {
    private EmailVerificationService emailVerificationService = EmailVerificationService.getInstance();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String email = request.getParameter("email");
        JsonObject jsonResponse = new JsonObject();
        
        // 이메일 유효성 검사 (간단한 예시)
        if (email == null || !email.matches("^[\\w.-]+@([\\w-]+\\.)+[\\w-]{2,4}$")) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "유효하지 않은 이메일 형식입니다.");
        } else {
            boolean sent = emailVerificationService.sendVerificationCode(email);
            
            if (sent) {
                // 세션에 이메일 저장 (인증 과정에서 사용)
                HttpSession session = request.getSession();
                session.setAttribute("pendingEmail", email);
                
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "인증 코드가 발송되었습니다. 이메일을 확인해주세요.");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "인증 코드 발송에 실패했습니다. 다시 시도해주세요.");
            }
        }
        
        // JSON 응답 전송
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
