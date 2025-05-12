package kr.or.ddit.admember.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admember.service.AdmemberServiceImpl;
import kr.or.ddit.admember.service.IAdmemberService;
import kr.or.ddit.admember.vo.AdmemberVo;

@WebServlet("/join/duplicateId")
public class DuplicateIdController extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String amemId = req.getParameter("amemId");

		AdmemberVo vo = new AdmemberVo();
		vo.setAmemId(amemId);
		
		IAdmemberService admemberService = AdmemberServiceImpl.getInstance();
		
		boolean isDuplicated = admemberService.countId(vo);
		
		PrintWriter out = resp.getWriter();
		out.print(isDuplicated);
		out.flush();
		out.close();
	}
}
