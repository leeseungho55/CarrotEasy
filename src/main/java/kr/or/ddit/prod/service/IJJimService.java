package kr.or.ddit.prod.service;

import kr.or.ddit.prod.vo.JJimVo;

public interface IJJimService {
	public void jjimOn(JJimVo vo);
	public void jjimOut(JJimVo vo);
	public int getJJimCount(int prodNo);
	public boolean checkJJim(JJimVo vo);
}
