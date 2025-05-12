package kr.or.ddit.report.controller;
	
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.report.service.ReportService;
import kr.or.ddit.report.vo.MVo;
import kr.or.ddit.report.vo.ReportPagingVo;
import kr.or.ddit.report.vo.ReportVo;

@WebServlet("/ListBoard.do")
public class ReportListController extends HttpServlet {

	ReportPagingVo pvo = new ReportPagingVo();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    
	    HttpSession session = req.getSession();
	    MemberVo member = (MemberVo) session.getAttribute("member");
	    int memNo = member.getMemNo();

	    ReportPagingVo pvo = new ReportPagingVo();  

	    if (memNo != 0) {
	        pvo.setMemNo(memNo);
	    }

	    int currentPage = 1;
	    String data = req.getParameter("page");
	    if (data != null) {
	        currentPage = Integer.parseInt(data);
	    }

	    pvo.setPageSize(10);
	    pvo.setPage(currentPage);

	    ReportService service = ReportService.getInstance();
	    int totalCount = service.totalPosts();
	    pvo.setTotalCount(totalCount);

	    System.out.println("pvo ==>"+pvo);
	    
	    // 관리자 리스트 불러오기
	    Map<Integer, Boolean> adminMap = new HashMap<>();
	    for (MVo m : service.role1Member()) {
	        adminMap.put(m.getMemNo(), true);
	    }
	    List<ReportVo> vo;
	    if (adminMap.containsKey(memNo) && adminMap.get(memNo)) {
	    	vo = service.pagingReportAll(pvo);
	        System.out.println("이 사용자는 관리자입니다.");
	    } else {
		    vo = service.pagingReport(pvo);
	        System.out.println("이 사용자는 일반 사용자입니다.");
	    }

	    System.out.println("aiminMap ==> "+adminMap);
	    System.out.println("vo ==> "+vo);
	    
	    req.setAttribute("adminMap", adminMap);
	    req.setAttribute("boardList", vo);
	    req.setAttribute("pagingVo", pvo);
	    req.setAttribute("contentPage", "/WEB-INF/view/report/ReportList.jsp");

	    ServletContext ctx = req.getServletContext();
	    ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
	}

}

	