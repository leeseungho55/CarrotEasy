package kr.or.ddit.report.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.report.service.ReportService;
import kr.or.ddit.report.vo.ReportVo;

//업데이트 폼 매핑
@WebServlet("/ReportWatchingForm.do")
public class ReportWatchingForm extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int repNo = Integer.parseInt(req.getParameter("repNo"));
		
		System.out.println("/ReportWatchingForm.do repNo==>"+repNo);
		ReportService service = ReportService.getInstance();
		List<ReportVo> vo = service.UpdateForm(repNo);
		req.setAttribute("Report", vo);
		System.out.println("ReportUpdateNow vo ==>"+vo);
        req.setAttribute("contentPage", "/WEB-INF/view/report/ReportWatchingForm.jsp");
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
	}
}
