package kr.or.ddit.banner.dao;

import java.util.List;

import kr.or.ddit.banner.vo.BannerVo;
import kr.or.ddit.util.MybatisDao;

public class BannerDaoImpl extends MybatisDao implements IBannerDao {
	private static BannerDaoImpl instance;
	
	private BannerDaoImpl() {
	
	}
	
	public static BannerDaoImpl getInstance() {
		if (instance == null) {
			instance = new BannerDaoImpl();
		}
	
		return instance;
	}
	
	@Override
	public List<BannerVo> bannerList() {
		return selectList("banner.bannerList");
	}

	@Override
	public int bannerInsert(BannerVo vo) {		
		return update("banner.bannerInsert", vo);
	}

	@Override
	public int bannerUpdate(BannerVo vo) {
		return update("banner.bannerUpdate", vo);
	}

	@Override
	public List<BannerVo> bannerListAll() {
		return selectList("banner.bannerListAll");
	}

}
