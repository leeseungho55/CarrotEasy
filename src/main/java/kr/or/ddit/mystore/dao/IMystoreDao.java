package kr.or.ddit.mystore.dao;

import java.util.List;

import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.vo.ProfileVo;
import kr.or.ddit.mystore.vo.StoreVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.review.vo.ReviewVo;

public interface IMystoreDao {
	
	// 내상점 프로필 변경
	public int profileUpdate(ProfileVo vo);

	// 내상점 프로필 변경 후 세션 업데이트
	public MemberVo sessionUpdate(int memNo);
	
	// 내상점 프로필 보여주기
	public MemberVo appendProfile(int memNo);
	
	// 상점명, 소개글
	public StoreVo storeInfo(int memNo);
	
	// 상점오픈일
	public int storeOpenDay(int memNo);
	
	// 상점 방문수
	public int storeVisitCnt(int memNo);
	
	// 상점 상품판매
	public int storeProdSellCnt(int memNo);
	
	// 상점 상품 전체 개수
	public int storeProdAllCnt(int memNo);
	
	// 상점 상품 찜 전체 개수
	public int storeJjimAllCnt(int memNo);
	
	// 상점 상품 리뷰 전체 개수
	public int storeReviewAllCnt(int memNo);
	
	// 상점 상품 판매중 리스트
	public List<ProdVo> storeProdForSale(int memNo);
	
	// 상점 상품 예약중 리스트
	public List<ProdVo> storeProdReserved(int memNo);
		
	// 상점 상품 판매완료 리스트
	public List<ProdVo> storeProdSoldOut(int memNo);
	
	// 상점 구매 리스트
	public List<ProdVo> storePurchaseList(int memNo);
	
	// 상품번호로 memNo가져오기
	public ProdVo prodmemNo(int prodNo);
	
	// 상점 찜한 상품 리스트
	public List<ProdVo> storeJjimList(int memNo);
	
	// 상점명 수정
	public void storeNameUpdate(StoreVo store);
	
	// 상점내용 수정
	public void storeContentUpdate(StoreVo store);
	
	// 상점 리뷰 리스트
	public List<ReviewVo> storeReviewList(int memNo);
	
	// 상점 리뷰 상품 제목 가져오기
	public String storeReviewProdTitle(int prodNo);
	
	// 상점 리뷰 구매자 닉네임 가져오기
	public String storeReviewBuyerNick(int memNo);
	
	
}
