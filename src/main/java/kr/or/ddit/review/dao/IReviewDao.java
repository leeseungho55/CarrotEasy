package kr.or.ddit.review.dao;

import java.util.List;

import kr.or.ddit.review.vo.HasReviewVo;
import kr.or.ddit.review.vo.ReviewVo;

public interface IReviewDao {
	public List<ReviewVo> listReview(int prodMemNo);
	public int getProdMemNo(int prodNo);
	public int insertProdReview(ReviewVo vo);
	public void deleteRiview(int prodNo);
	public boolean hasReview(HasReviewVo vo);
	public int isPurchase(int prodNo);
}
