package kr.or.ddit.community.community_good.service;

import kr.or.ddit.community.community_good.dao.BoardGoodDaoImpl;
import kr.or.ddit.community.community_good.dao.IBoardGoodDao;
import kr.or.ddit.util.MybatisDao;

public class BoardGoodServiceImpl extends MybatisDao implements IBoardGoodService{
	
	private static BoardGoodServiceImpl instance;

	private BoardGoodServiceImpl() {

	}

	public static BoardGoodServiceImpl getInstance() {
		if (instance == null) {
			instance = new BoardGoodServiceImpl();
		}
		return instance;
	}
	
	IBoardGoodDao goodDao = BoardGoodDaoImpl.getInstance();

	@Override
	public int isBoardGood(int commubNo, String memId) {
		return goodDao.isBoardGood(commubNo, memId);
	}

	@Override
	public int insertBoardGood(int commubNo, String memId) {
		return goodDao.insertBoardGood(commubNo, memId);
	}

	@Override
	public int deleteBoardGood(int commubNo, String memId) {
		return goodDao.deleteBoardGood(commubNo, memId);
	}

	@Override
	public int countBoardGood(int commubNo) {
		return goodDao.countBoardGood(commubNo);
	}
	
	
}
