package kr.or.ddit.community.community_report.vo;

import kr.or.ddit.member.vo.MemberVo;
import lombok.Data;

@Data
public class CommunityReportVo {
	private int reportNo;
	private int commuNo;
	private int reporterMemNo;
	private String reportContent;
	private String reportDate;
	private String processStatus;
	private String delyn;
	
	// 소모임 명, 지역 불러올때
	private String commuTitle;
	private String commuRegion;
	
	// 신고자 정보가 필요해서 씀
	private MemberVo member;
}
