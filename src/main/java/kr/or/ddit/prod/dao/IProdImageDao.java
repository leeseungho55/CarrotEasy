package kr.or.ddit.prod.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.prod.vo.ProdImageVo;

public interface IProdImageDao {
	public int prodImageInsert(ProdImageVo vo);
	
	public int prodImageInsert(ProdImageVo vo, SqlSession session);
	
	public List<ProdImageVo> getProdImagesByProdNo(int prodNo);
	
	public List<ProdImageVo> getProdImagesByProdNo(int prodNo, SqlSession session);
	
	public int prodImageDelete(int prodNo, SqlSession session);
}
