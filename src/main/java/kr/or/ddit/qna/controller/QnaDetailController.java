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

@WebServlet("/qnaDetail.do")
public class QnaDetailController extends HttpServlet {
	
	IQnaService qnaService = QnaServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		int qnaNo = Integer.parseInt(req.getParameter("qnaNo"));
		System.out.println("qnaNo : " + qnaNo);
		
		QnaVo qnaVo = qnaService.qnaDetail(qnaNo);
		System.out.println("qnaVo : " + qnaVo);
		
		req.setAttribute("qnaVo", qnaVo);
		
		req.setAttribute("contentPage", "/WEB-INF/view/qna/qnaDetail.jsp");
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
		
	}

}
