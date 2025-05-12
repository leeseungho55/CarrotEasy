package kr.or.ddit.review.vo;

import lombok.Data;

@Data
public class GetSellerVo {
	private int prodNo;
	private int prodMemNo; // 상품 판매자 memNO;
	
	private int memNO;
	private String payType;
	private String purchaseDay;
}
