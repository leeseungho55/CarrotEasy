package kr.or.ddit.cate.dao;

import java.util.List;

import kr.or.ddit.cate.vo.CateVo;

public interface ICateDao {
	public List<CateVo> selectAllCategories();
	
	public List<CateVo> selectSubcategoriesByParent(int cateParentNo);

	public CateVo selectCategoryByCateNo(int cateNo);
	
	public int categoryInsert(CateVo vo);
	
	public int categoryUpdate(CateVo vo);
	
	public Integer getMaxCateNoForParentNull();
	
	public Integer getMaxCateNoForParentNotNull(int cateParentNo);

	public int categoryDelete(int cateNo);
}
