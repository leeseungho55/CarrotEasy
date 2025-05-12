package kr.or.ddit.community.community_board.service;

import java.util.List;

import kr.or.ddit.community.community_board.dao.CommunityBoardDaoImpl;
import kr.or.ddit.community.community_board.dao.ICommunityBoardDao;
import kr.or.ddit.community.community_board.vo.CommunityBoardVo;
import kr.or.ddit.util.MybatisDao;

public class CommunityBoardServiceImpl extends MybatisDao implements ICommunityBoardService{
	
	private static CommunityBoardServiceImpl instance;

	private CommunityBoardServiceImpl() {

	}

	public static CommunityBoardServiceImpl getInstance() {
		if (instance == null) {
			instance = new CommunityBoardServiceImpl();
		}
		return instance;
	}
	
	ICommunityBoardDao boardDao = CommunityBoardDaoImpl.getInstance(); 

	@Override
	public List<CommunityBoardVo> communitySelectList(int commuNo) {
		return boardDao.communitySelectList(commuNo);
	}

	@Override
	public int communityBoardInsert(CommunityBoardVo board) {
		return boardDao.communityBoardInsert(board);
	}

	@Override
	public CommunityBoardVo communityBoardByNo(int commubNo) {
		return boardDao.communityBoardByNo(commubNo);
	}

	@Override
	public int communityBoardUpdate(CommunityBoardVo board) {
		return boardDao.communityBoardUpdate(board);
	}

	@Override
	public int communityBoardDelete(CommunityBoardVo board) {
		return boardDao.communityBoardDelete(board);
	}

	@Override
	public int communityBoardCnt(int commubNo) {
		return boardDao.communityBoardCnt(commubNo);
	}

	@Override
	public int communityBoardGood(int commubNo) {
		return boardDao.communityBoardGood(commubNo);
	}

	@Override
	public List<CommunityBoardVo> getMyBoardList(int memNo) {
		return boardDao.getMyBoardList(memNo);
	}
	

}
