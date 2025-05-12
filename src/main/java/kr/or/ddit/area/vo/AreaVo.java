package kr.or.ddit.area.vo;

import lombok.Data;

@Data
public class AreaVo {
	private int areaNo;
    private String areaName;
    private Integer areaParentNo; // Integer로 해서 null 허용
    private String createDate;
}
