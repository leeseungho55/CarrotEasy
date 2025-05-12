package kr.or.ddit.community.community_report.service;

import java.util.List;

import kr.or.ddit.community.community_report.vo.CommunityReportVo;

public interface ICommunityReportService {
	
    /**
     * 신고 내역 등록
     * @param vo 신고 정보가 담긴 VO
     * @return 등록 성공 시 1 이상의 값, 실패 시 0
     */
	// 신고 내역조회
	public List<CommunityReportVo> communityReportList();
	
	// 신고 하기
	public int communityInsertReport(CommunityReportVo report);
	
	// 신고 삭제
	public int communityDeleteReport(CommunityReportVo report);
	
	// 신고 누적횟수
	public int communityUpdateReportCount(int commuNo);
	
    /**
     * 신고 처리상태 변경 (승인/반려 등)
     * @param reportNo 신고번호
     * @param processStatus 변경할 상태값 ("승인", "반려" 등)
     * @return 성공 시 true, 실패 시 false
     */
	boolean communityReportProcessStatus(int reportNo, String processStatus);
	
}
