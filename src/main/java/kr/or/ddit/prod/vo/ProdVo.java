package kr.or.ddit.prod.vo;

import kr.or.ddit.prod.type.ProdStatus;
import kr.or.ddit.prod.type.ProdType;
import lombok.Data;

@Data
public class ProdVo {
	private int prodNo;
	private int memNo;
	private int cateNo;
	private int areaNo;
	private String prodTitle;
	private int prodPrice;
	private String prodContent;
	private String prodLocation;
	private int prodCnt;
	private String prodType;
	private String prodStatus;
	private String prodDelyn;
	private String createDate;
	private String updateDate;
	
	private String cateName;
    private String areaName;
	
    public ProdType getProdType() {
        return ProdType.fromCode(prodType);
    }
    
    public void setProdType(ProdType prodType) {
        if (prodType != null) {
            this.prodType = prodType.getCode();
        }
    }
    
    public ProdStatus getProdStatus() {
        return ProdStatus.fromCode(prodStatus);
    }
    
    public void setProdStatus(ProdStatus prodStatus) {
        if (prodStatus != null) {
            this.prodStatus = prodStatus.getCode();
        }
	}
}