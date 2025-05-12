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

@WebServlet("/verifyCode")
public class VerifyCodeServlet extends HttpServlet {
    private EmailVerificationService emailVerificationService = EmailVerificationService.getInstance();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession();
        String pendingEmail = (String) session.getAttribute("pendingEmail");
        String code = request.getParameter("code");
        
        JsonObject jsonResponse = new JsonObject();
        
        if (pendingEmail == null) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "이메일 인증 세션이 만료되었습니다. 다시 시도해주세요.");
        } else if (code == null || code.trim().isEmpty()) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "인증 코드를 입력해주세요.");
        } else {
            boolean verified = emailVerificationService.verifyCode(pendingEmail, code);
            
            if (verified) {
                // 인증 성공 - 세션에 인증 완료 상태 저장
                session.setAttribute("verifiedEmail", pendingEmail);
                session.removeAttribute("pendingEmail");
                
                jsonResponse.addProperty("success", true);
                jsonResponse.addProperty("message", "이메일 인증이 완료되었습니다.");
            } else {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "인증 코드가 일치하지 않거나 만료되었습니다.");
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
