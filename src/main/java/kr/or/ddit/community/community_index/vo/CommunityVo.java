package kr.or.ddit.community.community_index.vo;

import kr.or.ddit.member.vo.MemberVo;
import lombok.Data;

@Data
public class CommunityVo {
	private int commuNo;
	private int memNo;
	private String commuTitle;
	private String commuContent;
	private String commuCatrgory;
	private String createDate;
	private String updateDate;
	private String delyn;
	private String commuRegion;
	private int reportCnt;
	private String lastReportContent;
	
	private String search;
	
	private MemberVo member;
	
	private int commuBoardCount;
}
