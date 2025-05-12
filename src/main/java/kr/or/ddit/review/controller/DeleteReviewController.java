package kr.or.ddit.review.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;
@WebServlet("/review/deleteReviewController.do")
public class DeleteReviewController extends HttpServlet{
	IReviewService service = ReviewServiceImpl.getInstance();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		//0. prdoNo값 가져오기
		int prodNo = Integer.parseInt(req.getParameter("prodNo"));
		//1. 삭제
		service.deleteRiview(prodNo);
		//2. 리다이렉트
        resp.sendRedirect(req.getContextPath() + "/prod/view.do?prodNo="+prodNo);
	}
}
