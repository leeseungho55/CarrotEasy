package kr.or.ddit.adboard.dao;

import java.util.List;

import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.adboard.vo.SwiperAdVo;
import kr.or.ddit.util.MybatisDao;

public class AdboardDaoImpl extends MybatisDao implements IAdboardDao {
	private static AdboardDaoImpl instance;

	private AdboardDaoImpl() {

	}

	public static AdboardDaoImpl getInstance() {
		if (instance == null) {
			instance = new AdboardDaoImpl();
		}

		return instance;
	}

	@Override
	public List<AdboardVo> adboardList() {
		return selectList("adboard.adboardList");
	}

	@Override
	public int adboardWrite(AdboardVo vo) {
		return update("adboard.adboardWrite", vo);
	}

	@Override
	public AdboardVo getBoardByNo(int adNo) {
		return selectOne("adboard.getBoard", adNo);
	}

	@Override
	public int adboardUpdate(AdboardVo vo) {
		return update("adboard.adboardUpdate", vo);
	}

	@Override
	public int adboardDelete(int adNo) {
		return update("adboard.adboardDelete", adNo);
	}

	@Override
	public int updateAdBoardConfirm(AdboardVo vo) {
		return update("adboard.updateAdBoardConfirm", vo);		
	}

	@Override
	public void updateAdConfirm(int adNo) {
		// TODO Auto-generated method stub
		update("adboard.adBoardConfirm",adNo);
	}

	@Override
	public List<SwiperAdVo> getAdForSwiper() {
		// TODO Auto-generated method stub
		return selectList("adboard.getAdForSwiper");
	}

	
}
