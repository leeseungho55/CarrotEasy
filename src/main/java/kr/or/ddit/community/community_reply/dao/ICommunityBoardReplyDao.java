package kr.or.ddit.community.community_reply.dao;

import java.util.List;

import kr.or.ddit.community.community_reply.vo.CommunityBoardReplyVo;

public interface ICommunityBoardReplyDao {

	public List<CommunityBoardReplyVo> boardReplyList(int commubNo);
	
	// 댓글 등록
    public int boardInsertReply(CommunityBoardReplyVo replyVo);
    
    // 댓글 수정
    public int boardUpdateReply(CommunityBoardReplyVo replyVo);

    // 댓글 삭제 (논리삭제)
    public int boardDeleteReply(CommunityBoardReplyVo replyNo);
	
	
	
}
