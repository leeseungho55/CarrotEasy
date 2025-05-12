package kr.or.ddit.adboard.dao;

import java.util.List;

import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.adboard.vo.SwiperAdVo;

public interface IAdboardDao {
	
	public List<AdboardVo> adboardList();
	
	public int adboardWrite(AdboardVo vo);

	public AdboardVo getBoardByNo(int adNo);

	public int adboardUpdate(AdboardVo vo);
	
	public int adboardDelete(int adNo);

	public int updateAdBoardConfirm(AdboardVo vo);
	
	public void updateAdConfirm(int adNo);

	public List<SwiperAdVo> getAdForSwiper();
}
