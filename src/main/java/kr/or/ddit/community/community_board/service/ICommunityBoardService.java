package kr.or.ddit.community.community_board.service;

import java.util.List;

import kr.or.ddit.community.community_board.vo.CommunityBoardVo;

public interface ICommunityBoardService {
	
	// 리스트
	public List<CommunityBoardVo> communitySelectList(int commuNo);
	
	// 게시글 생성
	public int communityBoardInsert(CommunityBoardVo board);
	
	// 게시글 상세조회
	public CommunityBoardVo communityBoardByNo(int commubNo);
	
	// 게시글 수정
	public int communityBoardUpdate(CommunityBoardVo board);
	
	//게시글 삭제
	public int communityBoardDelete(CommunityBoardVo board);
	
	// 조회수 증가
	public int communityBoardCnt(int commubNo);
	
	// 좋아요 증가
	public int communityBoardGood(int commubNo);
	
	// 내가 작성한 게시글 리스트 조회
    List<CommunityBoardVo> getMyBoardList(int memNo); // 이 부분을 추가!
	
	
	
	// 서비스만 선언
	// public ComP_PageVo petPageInfo(int page, String stype, String sword);

}
