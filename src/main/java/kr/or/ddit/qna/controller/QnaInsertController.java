package kr.or.ddit.qna.controller;

import java.io.IOException;

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

@WebServlet("/qnaInsert.do")
public class QnaInsertController extends HttpServlet {
	
	IQnaService qnaService = QnaServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setAttribute("contentPage", "/WEB-INF/view/qna/qnaInsert.jsp");
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		MemberVo member = (MemberVo) session.getAttribute("member");
		int memNo = member.getMemNo();
		
		
		System.out.println("세션에서 가져온 memNo : " + memNo);
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		QnaVo qna = new QnaVo();
		qna.setMemNo(memNo);
		qna.setQnaTitle(title);
		qna.setQnaContent(content);
		
		int result = qnaService.qnaInsert(qna);
		
		resp.sendRedirect("/CarrotEasy/qnaList.do");
		
	}

}
