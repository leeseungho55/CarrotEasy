package kr.or.ddit.community.community_board.dao;

import java.util.List;

import kr.or.ddit.community.community_board.vo.CommunityBoardVo;
import kr.or.ddit.util.MybatisDao;

public class CommunityBoardDaoImpl extends MybatisDao implements ICommunityBoardDao{
	
	private static CommunityBoardDaoImpl instance;

	private CommunityBoardDaoImpl() {

	}

	public static CommunityBoardDaoImpl getInstance() {
		if (instance == null) {
			instance = new CommunityBoardDaoImpl();
		}
		return instance;
	}

	@Override
	public List<CommunityBoardVo> communitySelectList(int commuNo) {
		return selectList("communityBoard.communitySelectList", commuNo);
	}

	@Override
	public int communityBoardInsert(CommunityBoardVo board) {
		return update("communityBoard.communityBoardInsert", board);
	}

	@Override
	public CommunityBoardVo communityBoardByNo(int commubNo) {
		return selectOne("communityBoard.communityBoardByNo", commubNo);
	}

	@Override
	public int communityBoardUpdate(CommunityBoardVo board) {
		return update("communityBoard.communityBoardUpdate", board);
	}

	@Override
	public int communityBoardDelete(CommunityBoardVo board) {
		return update("communityBoard.communityBoardDelete", board);
	}

	@Override
	public int communityBoardCnt(int commubNo) {
		return update("communityBoard.communityBoardCnt", commubNo);
	}

	@Override
	public int communityBoardGood(int commubNo) {
		return update("communityBoard.communityBoardGood", commubNo);
	}

	@Override
	public List<CommunityBoardVo> getMyBoardList(int memNo) {
		return selectList("communityBoard.getMyBoardList", memNo);
	}
	

}
