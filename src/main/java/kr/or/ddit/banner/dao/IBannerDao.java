package kr.or.ddit.banner.dao;

import java.util.List;

import kr.or.ddit.banner.vo.BannerVo;

public interface IBannerDao {

	List<BannerVo> bannerList();
	
	List<BannerVo> bannerListAll();

	int bannerInsert(BannerVo vo);

	int bannerUpdate(BannerVo vo);

}
