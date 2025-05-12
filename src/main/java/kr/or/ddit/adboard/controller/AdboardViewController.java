package kr.or.ddit.adboard.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.admember.vo.AdmemberVo;

@WebServlet("/adboard/boardView")
public class AdboardViewController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int adNo = Integer.parseInt(req.getParameter("adNo"));
        HttpSession session = req.getSession();
        System.out.println("isAdmin ==>"+session.getAttribute("isAdmin"));
        System.out.println("isAdmin ==>"+session.getAttribute("isAdmin"));
        System.out.println("isAdmin ==>"+session.getAttribute("isAdmin"));
        // 관리자 권한 체크 추가
        Object isAdminObj = session.getAttribute("isAdmin");
        boolean isAdmin = (isAdminObj != null && (Boolean)isAdminObj);
        
        // 관리자이거나 권한이 있는 경우에만 접근 허용
        Boolean hasPermission = (Boolean) session.getAttribute("viewPermission_" + adNo);
        if (!isAdmin && (hasPermission == null || !hasPermission)) {
            resp.sendRedirect(req.getContextPath() + "/adboard/list.do");
            return;
        }
        
        // 관리자가 아닌 경우에만 세션에서 권한 제거 (관리자는 재접근 가능하도록)
        if (!isAdmin) {
            session.removeAttribute("viewPermission_" + adNo);
        }
        
        IAdboardService adboardService = AdboardServiceImpl.getInstance();
        AdboardVo board = adboardService.getBoardByNo(adNo);

        req.setAttribute("adboard", board);
	    req.setAttribute("contentPage", "/WEB-INF/view/adboard/boardView.jsp");

	    ServletContext ctx = req.getServletContext();
	    ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
	}
}
