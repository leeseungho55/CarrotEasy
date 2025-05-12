package kr.or.ddit.mypage.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admember.vo.AdmemberVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mypage.service.IMypageService;
import kr.or.ddit.mypage.service.MypageServiceImpl;

@WebServlet("/mypageUpdate.do")
public class ProfileUpdateController extends HttpServlet {
	
	IMypageService mypageService = MypageServiceImpl.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		
		MemberVo member = (MemberVo) session.getAttribute("member");
		AdmemberVo admember = (AdmemberVo) session.getAttribute("admember");
		
		String pass = req.getParameter("pass");
		String tel = req.getParameter("tel");
		
		if(member != null) {
			String memId = req.getParameter("memId");
			
			member.setMemId(memId);
			member.setMemPass(pass);
			member.setMemTel(tel);
			
			int profileUpdate = mypageService.profileUpdate(member);
			System.out.println("profileUpdate : " + profileUpdate);
			
			session.setAttribute("member", member);
			System.out.println("member : " + member);
		}
		if(admember != null) {
			String amemId = req.getParameter("amemId");
			
			admember.setAmemId(amemId);
			admember.setAmemPass(pass);
			admember.setAmemTel(tel);
			
			int profileUpdateAd = mypageService.profileUpdateAd(admember);
			System.out.println("profileUpdateAd : " + profileUpdateAd);
			
			session.setAttribute("admember", admember);
			System.out.println("admember : " + admember);
		}
		
//		ServletContext ctx = req.getServletContext();
//		ctx.getRequestDispatcher("/WEB-INF/view/mypage/mypage.jsp").forward(req, resp);
		
		resp.sendRedirect(req.getContextPath() + "/mypage.do");
		
	}

}
