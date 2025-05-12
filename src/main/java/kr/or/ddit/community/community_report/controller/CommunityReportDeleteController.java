package kr.or.ddit.community.community_report.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_report.service.CommunityReportServiceImpl;
import kr.or.ddit.community.community_report.service.ICommunityReportService;
import kr.or.ddit.community.community_report.vo.CommunityReportVo;

@WebServlet("/CommunityReportDelete.do")
public class CommunityReportDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityReportService reportService = CommunityReportServiceImpl.getInstance();
       
    public CommunityReportDeleteController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 파라미터 받기
        int reportNo = Integer.parseInt(request.getParameter("reportNo"));

        // VO 생성 (필요한 값만 셋팅)
        CommunityReportVo report = new CommunityReportVo();
        report.setReportNo(reportNo);

        // 삭제 처리
        int result = reportService.communityDeleteReport(report);

        // 결과 메시지 설정
        if (result > 0) request.getSession().setAttribute("msg", "신고내역이 삭제되었습니다.");

        // 목록으로 리다이렉트
        response.sendRedirect(request.getContextPath() + "/CommunityReportList.do");
	}

}
