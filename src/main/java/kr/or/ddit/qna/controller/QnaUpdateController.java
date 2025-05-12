package kr.or.ddit.qna.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.qna.service.IQnaService;
import kr.or.ddit.qna.service.QnaServiceImpl;
import kr.or.ddit.qna.vo.QnaVo;

@WebServlet("/qnaUpdate.do")
public class QnaUpdateController extends HttpServlet {
	
	IQnaService qnaService = QnaServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int qnaNo = Integer.parseInt(req.getParameter("qnaNo"));
		System.out.println("수정하기 클릭 시 가져오는 qnaNo : " + qnaNo);
		
		QnaVo qnaVo = qnaService.qnaDetail(qnaNo);
		
		req.setAttribute("qnaVo", qnaVo);
		
		req.setAttribute("contentPage", "/WEB-INF/view/qna/qnaUpdate.jsp");
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int qnaNo = Integer.parseInt(req.getParameter("qnaNo"));
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		QnaVo qna = new QnaVo();
		qna.setQnaNo(qnaNo);
		qna.setQnaTitle(title);
		qna.setQnaContent(content);
		
		int result = qnaService.qnaUpdate(qna);
		
		resp.sendRedirect("/CarrotEasy/qnaDetail.do?qnaNo="+qnaNo);
		
	}

}
