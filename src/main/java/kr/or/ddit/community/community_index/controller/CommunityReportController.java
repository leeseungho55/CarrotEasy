package kr.or.ddit.community.community_index.controller;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.community.community_report.service.CommunityReportServiceImpl;
import kr.or.ddit.community.community_report.service.ICommunityReportService;
import kr.or.ddit.community.community_report.vo.CommunityReportVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/CommunityReport.do")
public class CommunityReportController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	ICommunityReportService reportService = CommunityReportServiceImpl.getInstance();

	public CommunityReportController() {
		super();
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    HttpSession session = req.getSession();
	    MemberVo loginMember = (MemberVo) session.getAttribute("member");
	    if (loginMember == null) {
	        resp.sendRedirect(req.getContextPath() + "/login.do?msg=needLogin");
	        return;
	    }

	    int commuNo = Integer.parseInt(req.getParameter("commuNo"));
	    String reportContent = req.getParameter("reportContent");
	    String commuRegion = req.getParameter("commuRegion"); // 추가

	    int reporterMemNo = loginMember.getMemNo();

	    CommunityReportVo vo = new CommunityReportVo();
	    vo.setCommuNo(commuNo);
	    vo.setReportContent(reportContent);
	    vo.setReporterMemNo(reporterMemNo);

	    int result = reportService.communityInsertReport(vo);
	    if(result > 0) {
	        reportService.communityUpdateReportCount(commuNo);
	    }

	    // 소모임 목록 페이지로 리다이렉트 (필요시 지역 파라미터 포함)
	    resp.sendRedirect(req.getContextPath() + "/CommunityRegion.do?commuRegion=" + URLEncoder.encode(commuRegion, "UTF-8"));
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 신고 폼을 main.jsp 레이아웃에서 보여주기
		request.setAttribute("contentPage", "/WEB-INF/view/community/community_index/community_report.jsp");
		request.getServletContext().getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(request, response);
	}

}
