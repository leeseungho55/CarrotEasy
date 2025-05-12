package kr.or.ddit.community.community_good.service;

public interface IBoardGoodService {
	
	public int isBoardGood(int commubNo, String memId);

	public int insertBoardGood(int commubNo, String memId);

	public int deleteBoardGood(int commubNo, String memId);

	public int countBoardGood(int commubNo);

}
