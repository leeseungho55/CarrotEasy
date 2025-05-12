package kr.or.ddit.community.community_report.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_report.service.CommunityReportServiceImpl;
import kr.or.ddit.community.community_report.service.ICommunityReportService;

import java.io.IOException;

@WebServlet("/CommunityReportProcess.do")
public class CommunityReportProcessController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityReportService reportService = CommunityReportServiceImpl.getInstance();
       
    public CommunityReportProcessController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 받기
        int reportNo = Integer.parseInt(request.getParameter("reportNo"));
        String action = request.getParameter("action"); // "approve" 또는 "reject"

        // 처리 상태 결정
        String newStatus = null;
        if ("approve".equals(action)) {
            newStatus = "승인"; // 또는 "APPROVED" 등 DB에 맞는 값
        } else if ("reject".equals(action)) {
            newStatus = "반려"; // 또는 "REJECTED"
        }

        // DB 업데이트
        boolean result = false;
        if (newStatus != null) {
            result = reportService.communityReportProcessStatus(reportNo, newStatus);
        }

        // 결과 처리
        if (result) {
            request.getSession().setAttribute("msg", "처리가 완료되었습니다.");
        } else {
            request.getSession().setAttribute("msg", "처리 중 오류가 발생했습니다.");
        }

        // 목록으로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/CommunityReportList.do");
	}

}
