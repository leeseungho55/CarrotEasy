package kr.or.ddit.community.community_board.vo;

import kr.or.ddit.member.vo.MemberVo;
import lombok.Data;

@Data
public class CommunityBoardVo {
	private int commubNo;
	private int commuNo;
	private String commubTitle;
	private String commubContent;
	private int commubGood;
	private int commubCnt;
	private String createDate;
	private String updateDate;
	private String delyn;
	private int memNo;
	
	private String search;
	private String commuRegion;
	
	private MemberVo member;
}
