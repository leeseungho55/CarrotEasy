package kr.or.ddit.notice.vo;

import lombok.Data;

@Data
public class NoticeVo {
	private int notiNo;
	private int memNo;
	private String notiTitle;
	private String notiContent;
	private String notiDelyn;
	private String createDate;
	private String updateDate;
}
