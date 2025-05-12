package kr.or.ddit.qna.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.qna.service.IQnaService;
import kr.or.ddit.qna.service.QnaServiceImpl;
import kr.or.ddit.qna.vo.QnaVo;

@WebServlet("/qnaList.do")
public class QnaListController extends HttpServlet {
	
	IQnaService qnaService = QnaServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		MemberVo member = (MemberVo) session.getAttribute("member");
		
		req.setAttribute("member", member);
		
		List<QnaVo> qnaList = qnaService.qnaList();
		System.out.println("qnaList : " + qnaList);
		
		req.setAttribute("qnaList", qnaList);
		
		req.setAttribute("contentPage", "/WEB-INF/view/qna/qnaList.jsp");
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
		
	}

}
