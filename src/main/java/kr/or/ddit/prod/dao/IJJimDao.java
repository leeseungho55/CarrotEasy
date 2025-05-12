package kr.or.ddit.prod.dao;

import kr.or.ddit.prod.vo.JJimVo;

public interface IJJimDao  {

	public int getJJimCount(int prodNo);
	public void jjimOn(JJimVo vo);
	public void jjimOut(JJimVo vo);
	public int checkJJim(JJimVo vo);
}
