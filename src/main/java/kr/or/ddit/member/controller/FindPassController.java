package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/findPass.do")
public class FindPassController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/member/findPass.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		JsonObject jsonResponse = new JsonObject();
		
		String memId = req.getParameter("memId");
		System.out.println("memId : " + memId);
		
		MemberVo member = new MemberVo();
		member.setMemId(memId);
		
		IMemberService memberService = MemberServiceImpl.getInstance();
		
		String findEmail = memberService.findPass(member);
		System.out.println("findEmail : " + findEmail);
		
		if(findEmail == null || findEmail.isEmpty()) {
			jsonResponse.addProperty("success", false);
		    jsonResponse.addProperty("message", "해당 아이디로 가입된 이메일이 없습니다.");
		}
		else {
			jsonResponse.addProperty("success", true);
			jsonResponse.addProperty("findEmail", findEmail);
			
			int updatePass = memberService.updatePass(findEmail);
			System.out.println("updatePass : " + updatePass);
		}
		
		// JSON 응답 전송
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        PrintWriter out = resp.getWriter();
        out.print(jsonResponse.toString());
        out.flush();
		
		
		
		
		
	}

}
