package kr.or.ddit.member.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/login.do")
public class LoginController extends HttpServlet {
	
	IMemberService memberService = MemberServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/member/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String memId = req.getParameter("memId");
		String memPass = req.getParameter("memPass");
		
		MemberVo member = new MemberVo();
		member.setMemId(memId);
		member.setMemPass(memPass);
		
		
		member = memberService.memberLogin(member);
		System.out.println("member : " + member);
		
		if(member == null) {
			req.setAttribute("status", "fail");
			
			ServletContext ctx = req.getServletContext();
			ctx.getRequestDispatcher("/WEB-INF/view/member/login.jsp").forward(req, resp);
			
		}
		else {
			HttpSession session = req.getSession();
			session.removeAttribute("admember");
			session.setAttribute("member", member);
			
			// 세션 유지 시간 설정(초 단위)
			session.setMaxInactiveInterval(1800);
			
			System.out.println("로그인 성공");
			
			resp.sendRedirect("/CarrotEasy/prodMain.do");
			
		}
		
	}

}
