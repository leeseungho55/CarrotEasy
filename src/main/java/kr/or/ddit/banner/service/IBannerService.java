package kr.or.ddit.banner.service;

import java.util.List;

import kr.or.ddit.banner.vo.BannerVo;

public interface IBannerService {

	List<BannerVo> bannerList();
	
	List<BannerVo> bannerListAll();

	int bannerInsert(BannerVo vo);

	int bannerUpdate(BannerVo vo);

}
