package kr.or.ddit.community.community_reply.dao;

import java.util.List;

import kr.or.ddit.community.community_reply.vo.CommunityBoardReplyVo;
import kr.or.ddit.util.MybatisDao;

public class CommunityBoardReplyDaoImpl extends MybatisDao implements ICommunityBoardReplyDao{
	
	private static CommunityBoardReplyDaoImpl instance;

	private CommunityBoardReplyDaoImpl() {

	}

	public static CommunityBoardReplyDaoImpl getInstance() {
		if (instance == null) {
			instance = new CommunityBoardReplyDaoImpl();
		}
		return instance;
	}

	@Override
	public List<CommunityBoardReplyVo> boardReplyList(int commubNo) {
		return selectList("reply.boardReplyList", commubNo);
	}

	@Override
	public int boardInsertReply(CommunityBoardReplyVo replyVo) {
		return update("reply.boardInsertReply", replyVo);
	}

	@Override
	public int boardUpdateReply(CommunityBoardReplyVo replyVo) {
		return update("reply.boardUpdateReply", replyVo);
	}

	@Override
	public int boardDeleteReply(CommunityBoardReplyVo replyNo) {
		return update("reply.boardDeleteReply", replyNo);
	}
	
	
	

}
