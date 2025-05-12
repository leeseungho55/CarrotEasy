package kr.or.ddit.cate.vo;

import java.util.List;

import lombok.Data;

@Data
public class CateVo {
	private int cateNo;
    private String cateName;
    private Integer cateParentNo; // Integer로 해서 null 허용
    private String createDate;
    
    private List<CateVo> subCategoryList;
}
