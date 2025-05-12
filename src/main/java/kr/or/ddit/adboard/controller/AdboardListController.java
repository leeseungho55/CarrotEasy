package kr.or.ddit.adboard.controller;

import java.io.IOException;
import java.util.List;

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
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/adboard/list.do")
public class AdboardListController extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 임시 테스트 데이터
        HttpSession session = req.getSession();
		
        AdmemberVo vo = (AdmemberVo)session.getAttribute("admember");
		AdboardVo boardVo = new AdboardVo(); 
		boardVo.setAdmember(vo);
		
		
		boolean isAdmin = false;
		MemberVo memVo = (MemberVo)session.getAttribute("member");
		if(memVo != null) {
			session.setAttribute("loginUser", memVo); 
			if(memVo.getMemRole() == 1) {
				isAdmin = true;
			}
		}
		session.setAttribute("isAdmin",isAdmin);
		
		IAdboardService service = AdboardServiceImpl.getInstance();
		List<AdboardVo> boardList = service.adboardList(); 
		
		req.setAttribute("boardList", boardList);
	    req.setAttribute("contentPage", "/WEB-INF/view/adboard/boardList.jsp");

	    ServletContext ctx = req.getServletContext();
	    ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
	}
}
