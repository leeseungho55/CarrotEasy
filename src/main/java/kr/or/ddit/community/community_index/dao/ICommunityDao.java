package kr.or.ddit.community.community_index.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.community.community_index.vo.CommunityVo;

public interface ICommunityDao {
	
	// 리스트
	public List<CommunityVo> getRegionList(Map<String, Object> param);
	
	// 소모임 조회
	public CommunityVo communityByNo(int commuNo);
	
	// 소모임 등록
	public int communityInsert(CommunityVo vo);
	
	// 소모임 수정
	public int communityUpdate(CommunityVo vo);
	
	// 소모임 삭제
	public int communityDelete(CommunityVo vo);
	
	// 소모임 신고
	public int communityReport(Map<String, Object> param);
	
	// 소모임 명 불러오기
	public CommunityVo findCommunityByNo(int commuNo);
	
	// 내가 만든 소모임 조회
	public List<CommunityVo> communityByCreatList(int memNo);
	
	// 내가 게시글 등록한 소모임 조회
	public List<CommunityVo> communityByPostList(int memNo);
	
	
	
	// 서비스만 선언
	// public ComP_PageVo petPageInfo(int page, String stype, String sword);

}
