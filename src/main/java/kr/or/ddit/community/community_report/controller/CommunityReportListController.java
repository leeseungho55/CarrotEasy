package kr.or.ddit.community.community_report.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_index.service.CommunityServiceImpl;
import kr.or.ddit.community.community_index.service.ICommunityService;
import kr.or.ddit.community.community_index.vo.CommunityVo;
import kr.or.ddit.community.community_report.service.CommunityReportServiceImpl;
import kr.or.ddit.community.community_report.service.ICommunityReportService;
import kr.or.ddit.community.community_report.vo.CommunityReportVo;

@WebServlet("/CommunityReportList.do")
public class CommunityReportListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService service = CommunityServiceImpl.getInstance();
	ICommunityReportService reportService = CommunityReportServiceImpl.getInstance();
       
    public CommunityReportListController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<CommunityReportVo> reportList = reportService.communityReportList();
		
		for (CommunityReportVo report : reportList) {
			CommunityVo communityVo = service.findCommunityByNo(report.getCommuNo());
			if (communityVo != null) {
				report.setCommuTitle(communityVo.getCommuTitle());
				report.setCommuRegion(communityVo.getCommuRegion());
			}
		}
		
		request.setAttribute("reportList", reportList);
		request.setAttribute("contentPage", "/WEB-INF/view/community/community_index/community_reportlist.jsp");
		request.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(request, response);
	}

}
