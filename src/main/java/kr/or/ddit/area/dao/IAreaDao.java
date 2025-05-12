package kr.or.ddit.area.dao;

import java.util.List;

import kr.or.ddit.area.vo.AreaVo;

public interface IAreaDao {
	public List<AreaVo> selectAllDistricts();
	
	public List<AreaVo> selectDongsByDistrict(int areaParentNo);

	public AreaVo selectAreaByAreaNo(int areaNo);
}
