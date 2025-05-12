package kr.or.ddit.chatting.vo;

import lombok.Data;

@Data
public class ChattingRoomVo {
	private int memNo; // 사용자
	private String memNick; // 사용자

	private int chatNo;
	private int prodNo; // 판매자 상품
	private int sellerMemNo; // 판매자 번호
	private int buyerMemNo; // 구매자 번호
	private String createDate;
	private String updateDate;
	private String buyerNick;//구매자 닉네임
	private String sellerNick;//판매자 닉네임
	private String lastChatContent;
	private int senderNo; // 송신자
	private int receiverNo; // 수신자
	private String myRole;
}
