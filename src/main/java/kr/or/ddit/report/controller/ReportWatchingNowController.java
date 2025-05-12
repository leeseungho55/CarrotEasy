package kr.or.ddit.report.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.report.service.ReportService;
import kr.or.ddit.report.vo.ReportVo;
@WebServlet("/ReportWatching.do")
public class ReportWatchingNowController extends HttpServlet {

	ReportService service = ReportService.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		HttpSession session = req.getSession();
		int memNo = Integer.parseInt((String)session.getAttribute("memNo"));
		String memId = service.findMemId(memNo);
		int repNo = Integer.parseInt(req.getParameter("repNo"));
		String prodTitle = (String)req.getParameter("prodTitle");
		String repTitle = req.getParameter("repTitle");
		String repContent = req.getParameter("repContent");
		
		
		System.out.println("/ReportWatching.do repNo ==>"+repNo);
		System.out.println("/ReportWatching.do prodTitle ==>"+prodTitle);
		System.out.println("/ReportWatching.do memNo ==>"+memNo);
		System.out.println("/ReportWatching.do memId ==>"+memId);		
		System.out.println("/ReportWatching.do repTitle ==>"+repTitle);
		System.out.println("/ReportWatching.do repContent ==>"+repContent);
		
		ReportVo vo = new ReportVo();
		vo.setMemId(memId);
		vo.setMemNo(memNo);
		vo.setProdTitle(prodTitle);
		vo.setRepNo(repNo);
		vo.setRepTitle(repTitle);
		vo.setRepContent(repContent);
		
		service.updateReportNow(vo);
		
		resp.sendRedirect(req.getContextPath() + "/ListBoard.do");
	}
}
