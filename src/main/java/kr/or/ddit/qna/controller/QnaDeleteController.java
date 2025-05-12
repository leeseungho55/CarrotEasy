package kr.or.ddit.qna.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.qna.service.IQnaService;
import kr.or.ddit.qna.service.QnaServiceImpl;

@WebServlet("/qnaDelete.do")
public class QnaDeleteController extends HttpServlet {
	
	IQnaService qnaService = QnaServiceImpl.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int qnaNo = Integer.parseInt(req.getParameter("qnaNo"));
		
		int result = qnaService.qnaDelete(qnaNo);
		
		resp.sendRedirect("/CarrotEasy/qnaList.do");
		
		
	}

}
