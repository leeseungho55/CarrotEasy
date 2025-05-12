package kr.or.ddit.report.vo;

import java.util.Date;

import lombok.Data;

@Data
public class ReportVo {
	private int memNo;
	private int repNo; 
	private String prodTitle;
	private String memId; 
	private String repTitle; 
	private String repContent; 
	private Date createDate;
	private Date updateDate;
}
