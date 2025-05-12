package kr.or.ddit.review.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;
import kr.or.ddit.review.vo.ReviewVo;
@WebServlet("/review/InsertReview.do")
public class InsertReviewController extends HttpServlet {
	IReviewService service = ReviewServiceImpl.getInstance();

	@Override
	protected void doPost(HttpServletRequest req, jakarta.servlet.http.HttpServletResponse resp)throws ServletException, IOException {
		
		// 테스트 데이터 => req.parameter 대용
		ReviewVo vo = new ReviewVo();
		int prodNo= Integer.parseInt((String)req.getParameter("prodNo"));
		int memNo = Integer.parseInt((String)req.getParameter("memNo"));
		int score = Integer.parseInt((String)req.getParameter("reviewScore"));
		String content = req.getParameter("reviewTitle");
		
		
		vo.setProdNo(prodNo);
		vo.setMemNo(memNo); // 세션
		vo.setReviewScore(score);
		vo.setReviewTitle(content);
		// 리뷰 등록
		System.out.println("vo ==>"+vo);
		service.insertProdReview(vo);

		req.setAttribute("prodNo", prodNo);
		req.getRequestDispatcher("/WEB-INF/view/review/insertSuccess.jsp").forward(req, resp);

	}
	
}
