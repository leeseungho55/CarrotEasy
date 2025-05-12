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

@WebServlet("/join/duplicateRegNo")
public class DuplicateRegNoController extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String regNo = req.getParameter("regNo");
		
		AdmemberVo vo = new AdmemberVo();
		vo.setAmemRegNo(regNo);
		
		IAdmemberService admemberService = AdmemberServiceImpl.getInstance();
		
		boolean isDuplicated = admemberService.countRegNo(vo);
		
		PrintWriter out = resp.getWriter();
		out.print(isDuplicated);
		out.flush();
		out.close();
	}
}
