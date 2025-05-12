package kr.or.ddit.report.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.report.service.ReportService;
@WebServlet("/DeleteReport.do")
public class DeleteReport extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int rep_no = Integer.parseInt(req.getParameter("rep_no"));
		System.out.println("/DeleteReport.do rep_no ==>"+rep_no);
		ReportService service = ReportService.getInstance();
		service.deleteReport(rep_no);

		resp.sendRedirect(req.getContextPath() + "/ListBoard.do");
		
	}
}
