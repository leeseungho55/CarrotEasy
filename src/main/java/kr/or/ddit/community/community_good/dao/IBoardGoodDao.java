package kr.or.ddit.community.community_good.dao;

public interface IBoardGoodDao {
	
	public int isBoardGood(int commubNo, String memId);

	public int insertBoardGood(int commubNo, String memId);

	public int deleteBoardGood(int commubNo, String memId);

	public int countBoardGood(int commubNo);

}
