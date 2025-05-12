package kr.or.ddit.banner.service;

import java.util.List;

import kr.or.ddit.banner.dao.BannerDaoImpl;
import kr.or.ddit.banner.dao.IBannerDao;
import kr.or.ddit.banner.vo.BannerVo;

public class BannerServiceImpl implements IBannerService {
	private static BannerServiceImpl instance;

	private BannerServiceImpl() {

	}

	public static BannerServiceImpl getInstance() {
		if (instance == null) {
			instance = new BannerServiceImpl();
		}

		return instance;
	}

	IBannerDao bannerDao = BannerDaoImpl.getInstance();
	
	@Override
	public List<BannerVo> bannerList() {
		return bannerDao.bannerList();
	}

	@Override
	public int bannerInsert(BannerVo vo) {
		return bannerDao.bannerInsert(vo);
	}

	@Override
	public int bannerUpdate(BannerVo vo) {
		return bannerDao.bannerUpdate(vo);
	}

	@Override
	public List<BannerVo> bannerListAll() {
		return bannerDao.bannerListAll();
	}

}
