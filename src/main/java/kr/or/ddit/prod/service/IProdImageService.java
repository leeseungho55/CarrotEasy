package kr.or.ddit.prod.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.prod.vo.ProdImageVo;

public interface IProdImageService {
    public int prodImageInsert(ProdImageVo vo);
    
    public int prodImageInsert(ProdImageVo vo, SqlSession session);
    
    List<ProdImageVo> getProdImagesByProdNo(int prodNo);
    
    List<ProdImageVo> getProdImagesByProdNo(int prodNo, SqlSession session);

	public int prodImageDelete(int prodNo, SqlSession session);
}