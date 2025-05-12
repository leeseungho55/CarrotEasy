package kr.or.ddit.prod.vo;

import lombok.Data;

@Data
public class ProdPurchaseVo {
	private int purchaseNo;
	private int prodNo;
	private int memNo;
	private String purchaseType;
	private String createDate;
}
