package kr.or.ddit.community.community_index.dao;

import java.util.List;
import java.util.Map;

import kr.or.ddit.community.community_index.vo.CommunityVo;
import kr.or.ddit.util.MybatisDao;

public class CommunityDaoImpl extends MybatisDao implements ICommunityDao{
	
	private static CommunityDaoImpl instance;

	private CommunityDaoImpl() {

	}

	public static CommunityDaoImpl getInstance() {
		if (instance == null) {
			instance = new CommunityDaoImpl();
		}
		return instance;
	}

	@Override
	public List<CommunityVo> getRegionList(Map<String, Object> param) {
		return selectList("community.getRegionList", param);
	}

	@Override
	public int communityInsert(CommunityVo vo) {
		return update("community.communityInsert", vo);
	}

	@Override
	public int communityUpdate(CommunityVo vo) {
		return update("community.communityUpdate", vo);
	}

	@Override
	public CommunityVo communityByNo(int commuNo) {
		return selectOne("community.communityByNo", commuNo);
	}

	@Override
	public int communityDelete(CommunityVo vo) {
		return update("community.communityDelete", vo);
	}

	@Override
	public int communityReport(Map<String, Object> param) {
		return update("community.communityReport", param);
	}

	@Override
	public CommunityVo findCommunityByNo(int commuNo) {
		return selectOne("community.findCommunityByNo", commuNo);
	}

	@Override
	public List<CommunityVo> communityByCreatList(int memNo) {
		return selectList("community.communityByCreatList", memNo);
	}

	@Override
	public List<CommunityVo> communityByPostList(int memNo) {
		return selectList("community.communityByPostList", memNo);
	}
	
}
