package kr.or.ddit.prod.service;

import kr.or.ddit.prod.dao.IJJimDao;
import kr.or.ddit.prod.dao.JJimDao;
import kr.or.ddit.prod.vo.JJimVo;
import kr.or.ddit.util.MybatisDao;

public class JJimService extends MybatisDao implements IJJimService{
	private static final JJimService instance = new JJimService();

	private JJimService() {
		// private constructor
	}

	public static JJimService getInstance() {
		return instance;
	}

	IJJimDao dao = JJimDao.getInstance();
	@Override
	public void jjimOn(JJimVo vo) {
		// TODO Auto-generated method stub
		dao.jjimOn(vo);
	}

	@Override
	public void jjimOut(JJimVo vo) {
		// TODO Auto-generated method stub
		dao.jjimOut(vo);
	}

	@Override
	public int getJJimCount(int prodNo) {
		// TODO Auto-generated method stub
		return dao.getJJimCount(prodNo);
	}

	@Override
	public boolean checkJJim(JJimVo vo) {
		// TODO Auto-generated method stub
	    int count = dao.checkJJim(vo);
	    return count > 0;
	}

}
