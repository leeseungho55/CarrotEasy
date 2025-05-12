package kr.or.ddit.admember.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admember.service.AdmemberServiceImpl;
import kr.or.ddit.admember.service.IAdmemberService;
import kr.or.ddit.admember.vo.AdmemberVo;

@WebServlet("/adLogin.do")
public class AdLoginController extends HttpServlet {
	
	IAdmemberService memberService = AdmemberServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/admember/adlogin.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String amemId = req.getParameter("amemId");
		String amemPass = req.getParameter("amemPass");
		
		AdmemberVo admember = new AdmemberVo();
		admember.setAmemId(amemId);
		admember.setAmemPass(amemPass);
		
		admember = memberService.admemberLogin(admember);
		System.out.println("admember : " + admember);
		
		if(admember == null) {
//			req.setAttribute("status", "fail");
			
			ServletContext ctx = req.getServletContext();
			ctx.getRequestDispatcher("/WEB-INF/view/admember/adlogin.jsp").forward(req, resp);
			
		}
		else {
			HttpSession session = req.getSession();
			session.removeAttribute("member");
			session.setAttribute("admember", admember);
			System.out.println("session : " + session);
			
			// 세션 유지 시간 설정(초 단위)
			session.setMaxInactiveInterval(1800);
			
			System.out.println("로그인 성공");
			
			resp.sendRedirect("prodMain.do");
		}
		
	}

}
