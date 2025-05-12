package kr.or.ddit.area.dao;

import java.util.List;

import kr.or.ddit.area.vo.AreaVo;
import kr.or.ddit.util.MybatisDao;

public class AreaDaoImpl extends MybatisDao implements IAreaDao {
	private static AreaDaoImpl instance;

	private AreaDaoImpl() {

	}

	public static AreaDaoImpl getInstance() {
		if (instance == null) {
			instance = new AreaDaoImpl();
		}

		return instance;
	}
	
	private static final Object lock = new Object();

	@Override
	public List<AreaVo> selectAllDistricts() {
		return selectList("area.selectAllDistricts");
	}

	@Override
	public List<AreaVo> selectDongsByDistrict(int areaParentNo) {
		return selectList("area.selectDongsByDistrict", areaParentNo);
	}

	@Override
	public AreaVo selectAreaByAreaNo(int areaNo) {
		synchronized(lock) {
            return selectOne("area.selectAreaByAreaNo", areaNo);
        }
	}
}
