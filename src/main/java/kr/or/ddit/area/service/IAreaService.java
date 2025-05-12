package kr.or.ddit.area.service;

import java.util.List;

import kr.or.ddit.area.vo.AreaVo;

public interface IAreaService {
	public List<AreaVo> selectAllDistricts();
	
	public List<AreaVo> selectDongsByDistrict(int areaParentNo);
	
    public AreaVo selectAreaByAreaNo(int areaNo);
}
