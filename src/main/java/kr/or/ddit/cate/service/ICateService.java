package kr.or.ddit.cate.service;

import java.util.List;

import kr.or.ddit.cate.vo.CateVo;

public interface ICateService {
	public List<CateVo> selectAllCategories();
	
	public CateVo selectCategoryByCateNo(int cateNo);
	
	public List<CateVo> selectSubcategoriesByParent(int cateParentNo);
	
	public int categoryInsert(CateVo vo);
	
	public int categoryUpdate(CateVo vo);
	
	public Integer getMaxCateNoForParentNull();
	
	public Integer getMaxCateNoForParentNotNull(int cateParentNo);

	public int categoryDelete(int cateNo);
}
