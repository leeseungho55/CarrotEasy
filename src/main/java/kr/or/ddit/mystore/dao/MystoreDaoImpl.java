package kr.or.ddit.mystore.dao;

import java.util.List;

import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.vo.ProfileVo;
import kr.or.ddit.mystore.vo.StoreVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.review.vo.ReviewVo;
import kr.or.ddit.util.MybatisDao;

public class MystoreDaoImpl extends MybatisDao implements IMystoreDao {
	
	private static MystoreDaoImpl instance;

	private MystoreDaoImpl() {

	}

	public static MystoreDaoImpl getInstance() {
		if (instance == null) {
			instance = new MystoreDaoImpl();
		}
		return instance;
	}

	@Override
	public int profileUpdate(ProfileVo vo) {
		return update("mystore.profileUpdate", vo);
	}

	@Override
	public MemberVo appendProfile(int memNo) {
		return selectOne("mystore.appendProfile", memNo);
	}

	@Override
	public MemberVo sessionUpdate(int memNo) {
		return selectOne("mystore.sessionUpdate", memNo);
	}

	@Override
	public StoreVo storeInfo(int memNo) {
		return selectOne("mystore.storeInfo", memNo);
	}

	@Override
	public int storeOpenDay(int memNo) {
		return selectOne("mystore.storeOpenDay", memNo);
	}

	@Override
	public int storeVisitCnt(int memNo) {
		update("mystore.storeVisitUpdateCnt", memNo);
		
		return selectOne("mystore.storeVisitCnt", memNo);
	}
	
	@Override
	public int storeProdSellCnt(int memNo) {
		return selectOne("mystore.storeProdSellCnt", memNo);
	}

	@Override
	public int storeProdAllCnt(int memNo) {
		return selectOne("mystore.storeProdAllCnt", memNo);
	}

	@Override
	public int storeJjimAllCnt(int memNo) {
		return selectOne("mystore.storeJjimAllCnt", memNo);
	}
	
	@Override
	public int storeReviewAllCnt(int memNo) {
		return selectOne("mystore.storeReviewAllCnt", memNo);
	}

	@Override
	public List<ProdVo> storeProdForSale(int memNo) {
		return selectList("mystore.storeProdForSale", memNo);
	}

	@Override
	public List<ProdVo> storeProdReserved(int memNo) {
		return selectList("mystore.storeProdReserved", memNo);
	}

	@Override
	public List<ProdVo> storeProdSoldOut(int memNo) {
		return selectList("mystore.storeProdSoldOut", memNo);
	}

	@Override
	public List<ProdVo> storePurchaseList(int memNo) {
		return selectList("mystore.storePurchaseList", memNo);
	}
	
	@Override
	public ProdVo prodmemNo(int prodNo) {
		return selectOne("mystore.prodmemNo", prodNo);
	}

	@Override
	public List<ProdVo> storeJjimList(int memNo) {
		return selectList("mystore.storeJjimList", memNo);
	}

	@Override
	public void storeNameUpdate(StoreVo store) {
		update("mystore.storeNameUpdate", store);
	}

	@Override
	public void storeContentUpdate(StoreVo store) {
		update("mystore.storeContentUpdate", store);
	}

	@Override
	public List<ReviewVo> storeReviewList(int memNo) {
		return selectList("mystore.storeReviewList", memNo);
	}

	@Override
	public String storeReviewProdTitle(int prodNo) {
		return selectOne("mystore.storeReviewProdTitle", prodNo);
	}

	@Override
	public String storeReviewBuyerNick(int memNo) {
		return selectOne("mystore.storeReviewBuyerNick", memNo);
	}





	

}
