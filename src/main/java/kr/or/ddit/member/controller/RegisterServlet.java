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
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.vo.StoreVo;

@WebServlet("/join.do")
public class RegisterServlet extends HttpServlet {
    private IMemberService memberService = MemberServiceImpl.getInstance();
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
            throws ServletException, IOException {
        
        HttpSession session = req.getSession();
        String verifiedEmail = (String) session.getAttribute("verifiedEmail");
        
        JsonObject jsonResponse = new JsonObject();
        
        // 이메일 인증 확인
        if (verifiedEmail == null) {
            jsonResponse.addProperty("success", false);
            jsonResponse.addProperty("message", "이메일 인증이 필요합니다.");
        } else {
            // 폼에서 이메일 값 가져오기
            String email = req.getParameter("email");
            
            // 인증된 이메일과 폼에서 제출된 이메일이 일치하는지 확인
            if (!verifiedEmail.equals(email)) {
                jsonResponse.addProperty("success", false);
                jsonResponse.addProperty("message", "인증된 이메일과 입력한 이메일이 일치하지 않습니다.");
            } else {
                // 나머지 회원 정보 가져오기
                String memId = req.getParameter("id");
                String memPass = req.getParameter("pass");
                String memNick = req.getParameter("nick");
                String memAddr = req.getParameter("postcode");
                String memAddr1 = req.getParameter("roadAddress");
                String memAddr2 = req.getParameter("detailAddress");
                String memTel = req.getParameter("memTel");
                
                System.out.println("memTel : " + memTel);
                System.out.println("memAddr2 : " + memAddr2);
                
                // 회원 객체 생성
                MemberVo member = new MemberVo();
                member.setMemId(memId);
                member.setMemEmail(email);
                member.setMemPass(memPass); // 실제로는 비밀번호 암호화 필요
                member.setMemNick(memNick);
                member.setMemAddr(memAddr);
                member.setMemAddr1(memAddr1);
                member.setMemAddr2(memAddr2);
                member.setMemTel(memTel);
                
                // 회원 등록
                boolean registered = memberService.memberJoin(member);
                System.out.println("registered : " + registered);
                
                // 내상점 등록
                StoreVo vo = new StoreVo();
                int memNo = memberService.store_memNo(memNick);
                vo.setMemNo(memNo);
                vo.setStoreName(memNick + "의 상점");
                
                int result = memberService.storeInsert(vo);
                System.out.println("내상점 등록 result : " + result);
                
                if (registered) {
                    // 회원가입 성공 시 인증 이메일 세션 정보 삭제
                    session.removeAttribute("verifiedEmail");
                    
//                    resp.sendRedirect("login.do");
                } else {
                    jsonResponse.addProperty("success", false);
                    jsonResponse.addProperty("message", "회원가입 처리 중 오류가 발생했습니다.");
                }
            }
        }
        
        // JSON 응답 전송
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
    }
}
