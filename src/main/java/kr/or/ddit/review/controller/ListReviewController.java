package kr.or.ddit.review.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;
import kr.or.ddit.review.vo.GetSellerVo;
import kr.or.ddit.review.vo.ReviewVo;
@WebServlet("/review/listBoard.do")
public class ListReviewController extends HttpServlet {

	IReviewService service = ReviewServiceImpl.getInstance();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 테스트 데이터
		GetSellerVo gvo = new GetSellerVo();
		
		//1. 상품 리스트 가져오기
		List<ReviewVo> rlist= service.listReview(2);
		System.out.println("상품 리스트 ==> "+rlist);
		
		//2. 보내기
		req.setAttribute("reviewList",rlist);
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/review/reviewList.jsp").forward(req, resp);
	}
	
}
