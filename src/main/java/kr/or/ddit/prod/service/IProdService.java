package kr.or.ddit.prod.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.prod.vo.ProdVo;

public interface IProdService {
    public List<ProdVo> prodList();
    
    public ProdVo getProdByNo(int prodNo);
    
    public int prodInsert(ProdVo vo);
    
    public int prodUpdate(ProdVo vo);
    
    public int prodDelete(int prodNo);
    
    public List<ProdVo> getProdListWithFilters(int cateNo, int areaNo,String keyword); //, String keyword
    
    // 트랜잭션을 사용하는 메서드
    public int registerProductWithImages(ProdVo prodVo, List<FileVo> fileVoList);
    
    public int updateProductWithImages(ProdVo prodVo, List<FileVo> fileVoList, List<Integer> keepImageNoList);

	public int deleteProd(int prodNo, SqlSession session);
	
    // 최신 상품 리스트용
	public List<ProdVo> prodMainRecentlyList();
    // 추천 상품 리스트용
	public List<ProdVo> prodMainBestList();
	
}