package kr.or.ddit.community.community_reply.service;

import java.util.List;

import kr.or.ddit.community.community_reply.dao.CommunityBoardReplyDaoImpl;
import kr.or.ddit.community.community_reply.dao.ICommunityBoardReplyDao;
import kr.or.ddit.community.community_reply.vo.CommunityBoardReplyVo;
import kr.or.ddit.util.MybatisDao;

public class CommunityBoardReplyServiceImpl extends MybatisDao implements ICommunityBoardReplyService{
	
	private static CommunityBoardReplyServiceImpl instance;

	private CommunityBoardReplyServiceImpl() {

	}

	public static CommunityBoardReplyServiceImpl getInstance() {
		if (instance == null) {
			instance = new CommunityBoardReplyServiceImpl();
		}
		return instance;
	}
	
	ICommunityBoardReplyDao boardReplyDao = CommunityBoardReplyDaoImpl.getInstance(); 

	@Override
	public List<CommunityBoardReplyVo> boardReplyList(int commubNo) {
		return boardReplyDao.boardReplyList(commubNo);
	}

	@Override
	public int boardInsertReply(CommunityBoardReplyVo replyVo) {
		return boardReplyDao.boardInsertReply(replyVo);
	}

	@Override
	public int boardUpdateReply(CommunityBoardReplyVo replyVo) {
		return boardReplyDao.boardUpdateReply(replyVo);
	}

	@Override
	public int boardDeleteReply(CommunityBoardReplyVo replyNo) {
		return boardReplyDao.boardDeleteReply(replyNo);
	}
	

}
