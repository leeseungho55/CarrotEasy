package kr.or.ddit.prod.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.prod.vo.ProdVo;

public interface IProdDao {
    public List<ProdVo> prodList();
    public List<ProdVo> prodList(SqlSession session);
    
    public ProdVo getProdByNo(int prodNo);
    public ProdVo getProdByNo(int prodNo, SqlSession session);
    
    public int prodInsert(ProdVo vo);
    public int prodInsert(ProdVo vo, SqlSession session);
    
    public int prodUpdate(ProdVo vo);
    public int prodUpdate(ProdVo vo, SqlSession session);
    
    public int prodDelete(int prodNo);
    public int prodDelete(int prodNo, SqlSession session);
    
    public int getLastInsertedProdNo();
    public int getLastInsertedProdNo(SqlSession session);
	
    public List<ProdVo> getProdListWithFilters(List<Integer> cateNoList, List<Integer> areaNoList, String keyword);
    
    public int prodCntUpdate(int prodNo);
    
    // 최신 상품 리스트용
	public List<ProdVo> prodMainRecentlyList();
    // 추천 상품 리스트용
	public List<ProdVo> prodMainBestList();
}