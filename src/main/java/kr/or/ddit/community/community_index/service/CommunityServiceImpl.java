package kr.or.ddit.community.community_index.service;

import java.util.List;
import java.util.Map;

import kr.or.ddit.community.community_index.dao.CommunityDaoImpl;
import kr.or.ddit.community.community_index.dao.ICommunityDao;
import kr.or.ddit.community.community_index.vo.CommunityVo;
import kr.or.ddit.util.MybatisDao;

public class CommunityServiceImpl extends MybatisDao implements ICommunityService{
	
	private static CommunityServiceImpl instance;

	private CommunityServiceImpl() {

	}

	public static CommunityServiceImpl getInstance() {
		if (instance == null) {
			instance = new CommunityServiceImpl();
		}
		return instance;
	}
	
	ICommunityDao communityDao = CommunityDaoImpl.getInstance();

	@Override
	public List<CommunityVo> getRegionList(Map<String, Object> param) {
		return communityDao.getRegionList(param);
	}

	@Override
	public int communityInsert(CommunityVo vo) {
		return communityDao.communityInsert(vo);
	}

	@Override
	public int communityUpdate(CommunityVo vo) {
		return communityDao.communityUpdate(vo);
	}

	@Override
	public CommunityVo communityByNo(int commuNo) {
		return communityDao.communityByNo(commuNo);
	}

	@Override
	public int communityDelete(CommunityVo vo) {
		return communityDao.communityDelete(vo);
	}

	@Override
	public int communityReport(Map<String, Object> param) {
		return communityDao.communityReport(param);
	}

	@Override
	public CommunityVo findCommunityByNo(int commuNo) {
		return communityDao.findCommunityByNo(commuNo);
	}

	@Override
	public List<CommunityVo> communityByCreatList(int memNo) {
		return communityDao.communityByCreatList(memNo);
	}

	@Override
	public List<CommunityVo> communityByPostList(int memNo) {
		return communityDao.communityByPostList(memNo);
	}

}
