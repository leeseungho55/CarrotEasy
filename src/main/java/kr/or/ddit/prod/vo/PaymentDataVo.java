package kr.or.ddit.prod.vo;

import lombok.Data;

@Data
public class PaymentDataVo {
	private int memNo; // 사용자 정보
	private int prodNo; // 상품번호
	private String payType; // 거래타입
}
