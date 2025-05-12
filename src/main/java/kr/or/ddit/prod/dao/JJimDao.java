package kr.or.ddit.prod.dao;

import kr.or.ddit.prod.vo.JJimVo;
import kr.or.ddit.util.MybatisDao;

public class JJimDao extends MybatisDao implements IJJimDao{
	private static final JJimDao instance = new JJimDao();

	private JJimDao() {
		// private constructor
	}

	public static JJimDao getInstance() {
		return instance;
	}

	@Override
	public void jjimOn(JJimVo vo) {
		// TODO Auto-generated method stub
		update("jjim.jjimOn",vo);
	}

	@Override
	public void jjimOut(JJimVo vo) {
		// TODO Auto-generated method stub
		update("jjim.jjimOut",vo);
	}

	@Override
	public int getJJimCount(int prodNo) {
		// TODO Auto-generated method stub
		return selectOne("jjim.getJJimCount",prodNo);
	}

	@Override
	public int checkJJim(JJimVo vo) {
		// TODO Auto-generated method stub
		return selectOne("jjim.checkJJim", vo);
	}

}
