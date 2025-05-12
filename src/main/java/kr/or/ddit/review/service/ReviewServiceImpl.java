package kr.or.ddit.review.service;

import java.util.List;

import kr.or.ddit.review.dao.IReviewDao;
import kr.or.ddit.review.dao.ReviewDaoImpl;
import kr.or.ddit.review.vo.HasReviewVo;
import kr.or.ddit.review.vo.ReviewVo;
import kr.or.ddit.util.MybatisDao;

public class ReviewServiceImpl extends MybatisDao implements IReviewService {

	private static final ReviewServiceImpl instance = new ReviewServiceImpl();

	private ReviewServiceImpl() {
		// private constructor
	}

	public static ReviewServiceImpl getInstance() {
		return instance;
	}

	IReviewDao dao = ReviewDaoImpl.getInstance();
	
	@Override
	public List<ReviewVo> listReview(int prodMemNo) {
		// TODO Auto-generated method stub
		return dao.listReview(prodMemNo);
	}

	@Override
	public int getProdMemNo(int prodNo) {
		// TODO Auto-generated method stub
		return dao.getProdMemNo(prodNo);
	}

	@Override
	public int insertProdReview(ReviewVo vo) {
		// TODO Auto-generated method stub
		return dao.insertProdReview(vo);
	}

	public void deleteRiview(int prodNo) {
		dao.deleteRiview(prodNo);
	}

	@Override
	public boolean hasReview(HasReviewVo vo) {
		// TODO Auto-generated method stub
		return dao.hasReview(vo);
	}

	@Override
	public int isPurchase(int prodNo) {
		return dao.isPurchase(prodNo);
	}

	
}
