package kr.or.ddit.qna.vo;

import lombok.Data;

@Data
public class QnaVo {
	
	private int qnaNo;
	private int memNo;
	private String qnaTitle;
	private String qnaContent;
	private String qnaAnswer;
	private String createDate;
	private String updateDate;
	private String mcreateDate;
	private String mupdateDate;
	
	// memNick을 임시로 넣음(작성자 가져와야함)
	private String memNick;

}
