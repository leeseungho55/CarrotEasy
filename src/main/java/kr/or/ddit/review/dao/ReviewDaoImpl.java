package kr.or.ddit.review.dao;

import java.util.List;

import kr.or.ddit.review.vo.HasReviewVo;
import kr.or.ddit.review.vo.ReviewVo;
import kr.or.ddit.util.MybatisDao;

public class ReviewDaoImpl extends MybatisDao implements IReviewDao{

	private static final ReviewDaoImpl instance = new ReviewDaoImpl();

	private ReviewDaoImpl() {
		// private constructor
	}

	public static ReviewDaoImpl getInstance() {
		return instance;
	}

	@Override
	public List<ReviewVo> listReview(int prodMemNo) { // review 리스트 가져오기
		// TODO Auto-generated method stub
		return selectList("review.listReview",prodMemNo);
	}

	@Override
	public int getProdMemNo(int prodNo) { // 상품에 대한 memNo 구하기 위함
		// TODO Auto-generated method stub
		return selectOne("review.getProdMemNo",prodNo);
	}

	@Override
	public int insertProdReview(ReviewVo vo) {
		// TODO Auto-generated method stub
		return update("review.insertProdReview",vo);
	}

	@Override
	public void deleteRiview(int prodNo) {
		// TODO Auto-generated method stub
		update("review.deleteRiview",prodNo);
	}

	@Override
	public boolean hasReview(HasReviewVo vo) {
		// TODO Auto-generated method stub
		return selectOne("review.hasReview",vo);
	}

	@Override
	public int isPurchase(int prodNo) {
		// TODO Auto-generated method stub
	    Integer result = selectOne("review.isPurchased", prodNo);  // null 가능성 있음
	    if (result == null) {
	        return 0;  // 구매하지 않은 경우를 0으로 처리
	    }
	    return result; // 구매한 경우, DB에서 넘어온 값 사용
	}

}
