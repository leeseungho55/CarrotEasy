package kr.or.ddit.area.service;

import java.util.List;

import kr.or.ddit.area.dao.AreaDaoImpl;
import kr.or.ddit.area.dao.IAreaDao;
import kr.or.ddit.area.vo.AreaVo;

public class AreaServiceImpl implements IAreaService {
	private static AreaServiceImpl instance;

	private AreaServiceImpl() {

	}

	public static AreaServiceImpl getInstance() {
		if (instance == null) {
			instance = new AreaServiceImpl();
		}

		return instance;
	}
	
	IAreaDao areaDao = AreaDaoImpl.getInstance();
	
	@Override
	public List<AreaVo> selectAllDistricts() {
		return areaDao.selectAllDistricts();
	}

	@Override
	public List<AreaVo> selectDongsByDistrict(int areaParentNo) {
		return areaDao.selectDongsByDistrict(areaParentNo);
	}

	@Override
	public AreaVo selectAreaByAreaNo(int areaNo) {
        return areaDao.selectAreaByAreaNo(areaNo);
	}

}
