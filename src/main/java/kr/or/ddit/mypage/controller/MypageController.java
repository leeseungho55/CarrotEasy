package kr.or.ddit.mypage.controller;

import java.io.IOException;

import com.google.gson.JsonObject;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.admember.vo.AdmemberVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/mypage.do")
public class MypageController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setAttribute("contentPage", "/WEB-INF/view/mypage/mypage.jsp");
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		JsonObject jsonResponse = new JsonObject();
		
		String memPass = req.getParameter("memPass");
		System.out.println("memPass : " + memPass);
		
		HttpSession session = req.getSession();
		MemberVo member = (MemberVo)session.getAttribute("member");
		AdmemberVo admember = (AdmemberVo)session.getAttribute("admember");
		System.out.println("member : " + member);
		System.out.println("admember : " + admember);
		
		if (member != null) {
		    String sessionPass = member.getMemPass();

		    if (memPass != null && memPass.equals(sessionPass)) {
		        jsonResponse.addProperty("status", "success");
		    } else {
		        jsonResponse.addProperty("status", "fail");
		    }
		} else if (admember != null) {
		    String sessionPass = admember.getAmemPass();

		    if (memPass != null && memPass.equals(sessionPass)) {
		        jsonResponse.addProperty("status", "success");
		    } else {
		        jsonResponse.addProperty("status", "fail");
		    }
		} else {
		    jsonResponse.addProperty("status", "noSession");
		}
		
		resp.setContentType("application/json");
	    resp.setCharacterEncoding("UTF-8");
	    resp.getWriter().write(jsonResponse.toString());
		
	}

}
