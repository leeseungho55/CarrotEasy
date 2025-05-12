package kr.or.ddit.member.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.member.service.IMemberService;
import kr.or.ddit.member.service.MemberServiceImpl;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/duplicateNick.do")
public class DuplicateNickController extends HttpServlet {
	
	IMemberService memberService = MemberServiceImpl.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String memNick = req.getParameter("memNick");
		
		MemberVo member = new MemberVo();
		member.setMemNick(memNick);
		
		boolean isDuplicated = memberService.countNick(member);
		
		PrintWriter out = resp.getWriter();
		out.print(isDuplicated);
		out.flush();
		out.close();
		
	}

}
