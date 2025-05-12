package kr.or.ddit.qna.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.qna.service.IQnaService;
import kr.or.ddit.qna.service.QnaServiceImpl;
import kr.or.ddit.qna.vo.QnaVo;

@WebServlet("/qnaInsertAnswer.do")
public class QnaInsertAnswerController extends HttpServlet {
	
	IQnaService qnaService = QnaServiceImpl.getInstance();
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int qnaNo = Integer.parseInt(req.getParameter("qnaNo"));
		String content = req.getParameter("content");
		
		QnaVo qna = new QnaVo();
		qna.setQnaNo(qnaNo);
		qna.setQnaAnswer(content);
		
		int result = qnaService.qnaInsertAnswer(qna);
		System.out.println("관리자 댓글 result : " + result);
		
		resp.sendRedirect("/CarrotEasy/qnaDetail.do?qnaNo="+qnaNo);
		
	}

}
