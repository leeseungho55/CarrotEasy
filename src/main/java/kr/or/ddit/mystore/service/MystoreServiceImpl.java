package kr.or.ddit.mystore.service;

import java.util.List;

import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.dao.IMystoreDao;
import kr.or.ddit.mystore.dao.MystoreDaoImpl;
import kr.or.ddit.mystore.vo.ProfileVo;
import kr.or.ddit.mystore.vo.StoreVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.review.vo.ReviewVo;

public class MystoreServiceImpl implements IMystoreService {
	
	IMystoreDao mystoreDao = MystoreDaoImpl.getInstance();
	
	private static MystoreServiceImpl instance;

	private MystoreServiceImpl() {

	}

	public static MystoreServiceImpl getInstance() {
		if (instance == null) {
			instance = new MystoreServiceImpl();
		}
		return instance;
	}

	@Override
	public int profileUpdate(ProfileVo vo) {
		return mystoreDao.profileUpdate(vo);
	}

	@Override
	public MemberVo appendProfile(int memNo) {
		return mystoreDao.appendProfile(memNo);
	}

	@Override
	public MemberVo sessionUpdate(int memNo) {
		return mystoreDao.sessionUpdate(memNo);
	}

	@Override
	public StoreVo storeInfo(int memNo) {
		return mystoreDao.storeInfo(memNo);
	}

	@Override
	public int storeOpenDay(int memNo) {
		return mystoreDao.storeOpenDay(memNo);
	}

	@Override
	public int storeVisitCnt(int memNo) {
		return mystoreDao.storeVisitCnt(memNo);
	}
	
	@Override
	public int storeProdSellCnt(int memNo) {
		return mystoreDao.storeProdSellCnt(memNo);
	}

	@Override
	public int storeProdAllCnt(int memNo) {
		return mystoreDao.storeProdAllCnt(memNo);
	}

	@Override
	public int storeJjimAllCnt(int memNo) {
		return mystoreDao.storeJjimAllCnt(memNo);
	}
	
	@Override
	public int storeReviewAllCnt(int memNo) {
		return mystoreDao.storeReviewAllCnt(memNo);
	}

	@Override
	public List<ProdVo> storeProdForSale(int memNo) {
		return mystoreDao.storeProdForSale(memNo);
	}

	@Override
	public List<ProdVo> storeProdReserved(int memNo) {
		return mystoreDao.storeProdReserved(memNo);
	}

	@Override
	public List<ProdVo> storeProdSoldOut(int memNo) {
		return mystoreDao.storeProdSoldOut(memNo);
	}
	
	@Override
	public List<ProdVo> storePurchaseList(int memNo) {
		return mystoreDao.storePurchaseList(memNo);
	}

	@Override
	public ProdVo prodmemNo(int prodNo) {
		return mystoreDao.prodmemNo(prodNo);
	}

	@Override
	public List<ProdVo> storeJjimList(int memNo) {
		return mystoreDao.storeJjimList(memNo);
	}

	@Override
	public void storeNameUpdate(StoreVo store) {
		mystoreDao.storeNameUpdate(store);
	}

	@Override
	public void storeContentUpdate(StoreVo store) {
		mystoreDao.storeContentUpdate(store);
	}

	@Override
	public List<ReviewVo> storeReviewList(int memNo) {
		return mystoreDao.storeReviewList(memNo);
	}

	@Override
	public String storeReviewProdTitle(int prodNo) {
		return mystoreDao.storeReviewProdTitle(prodNo);
	}

	@Override
	public String storeReviewBuyerNick(int memNo) {
		return mystoreDao.storeReviewBuyerNick(memNo);
	}


	



	

}
