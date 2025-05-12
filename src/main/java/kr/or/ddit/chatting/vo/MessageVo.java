package kr.or.ddit.chatting.vo;

import lombok.Data;

@Data
public class MessageVo {
	private int mesNo;
	private int chatNo;
	private String chatContent;
	private String startDate;
	private String readDate;
	private int readyn;
	private String senderNo;
	private String receiverNo;
	private int prodNo;
	
}
