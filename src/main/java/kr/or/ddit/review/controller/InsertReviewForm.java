package kr.or.ddit.review.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/reivew/insertReviewForm.do")
public class InsertReviewForm extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		int prodNo = Integer.parseInt(req.getParameter("prodNo"));
		int memNo = Integer.parseInt(req.getParameter("memNo"));
		System.out.println("insertReviewForm 참고 ==> "+prodNo+""+memNo);
		
		req.setAttribute("prodNo", prodNo);
		req.setAttribute("memNo", memNo);
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/review/reviewInsert.jsp").forward(req, resp);
	}
}
