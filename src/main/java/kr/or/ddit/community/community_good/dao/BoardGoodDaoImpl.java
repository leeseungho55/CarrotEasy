package kr.or.ddit.community.community_good.dao;

import java.util.HashMap;
import java.util.Map;

import kr.or.ddit.util.MybatisDao;

public class BoardGoodDaoImpl extends MybatisDao implements IBoardGoodDao{
	
	private static BoardGoodDaoImpl instance;

	private BoardGoodDaoImpl() {

	}

	public static BoardGoodDaoImpl getInstance() {
		if (instance == null) {
			instance = new BoardGoodDaoImpl();
		}
		return instance;
	}

	@Override
    public int isBoardGood(int commubNo, String memId) {
        Map<String, Object> param = new HashMap<>();
        param.put("commubNo", commubNo);
        param.put("memId", memId);
        return selectOne("boardgood.isBoardGood", param);
    }

	@Override
	public int insertBoardGood(int commubNo, String memId) {
        Map<String, Object> param = new HashMap<>();
        param.put("commubNo", commubNo);
        param.put("memId", memId);
        return insert("boardgood.insertBoardGood", param);
	}

	@Override
	public int deleteBoardGood(int commubNo, String memId) {
        Map<String, Object> param = new HashMap<>();
        param.put("commubNo", commubNo);
        param.put("memId", memId);
        return delete("boardgood.deleteBoardGood", param);
    }

	@Override
	public int countBoardGood(int commubNo) {
		Integer result = selectOne("boardgood.countBoardGood", commubNo);
		return result != null ? result : 0;
	}
	
	
	

}
