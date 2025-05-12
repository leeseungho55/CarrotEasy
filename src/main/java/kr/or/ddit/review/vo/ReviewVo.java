package kr.or.ddit.review.vo;

import lombok.Data;

@Data
public class ReviewVo {
	private int prodNo;
	private int memNo;
	private int reviewScore;
	private String reviewTitle;
	private String createDate;
	
	// 상품 제목
	private String reviewProdTitle;
	
	// 구매자 닉네임
	private String reviewMemberNick;
}
