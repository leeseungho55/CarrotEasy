package kr.or.ddit.cate.service;

import java.util.List;

import kr.or.ddit.area.service.AreaServiceImpl;
import kr.or.ddit.cate.dao.CateDaoImpl;
import kr.or.ddit.cate.dao.ICateDao;
import kr.or.ddit.cate.vo.CateVo;

public class CateServiceImpl implements ICateService {
	private static CateServiceImpl instance;

	private CateServiceImpl() {

	}

	public static CateServiceImpl getInstance() {
		if (instance == null) {
			instance = new CateServiceImpl();
		}

		return instance;
	}
	
	ICateDao cateDao = CateDaoImpl.getInstance();
	
	@Override
	public List<CateVo> selectAllCategories() {
		return cateDao.selectAllCategories();
	}

	@Override
	public List<CateVo> selectSubcategoriesByParent(int cateParentNo) {
	    return cateDao.selectSubcategoriesByParent(cateParentNo);
	}

	@Override
	public CateVo selectCategoryByCateNo(int cateNo) {
		return cateDao.selectCategoryByCateNo(cateNo);
	}

	@Override
	public int categoryInsert(CateVo vo) {
		return cateDao.categoryInsert(vo);
	}

	@Override
	public int categoryUpdate(CateVo vo) {
		return cateDao.categoryUpdate(vo);
	}

	@Override
	public Integer getMaxCateNoForParentNull() {
		return cateDao.getMaxCateNoForParentNull();
	}

	@Override
	public Integer getMaxCateNoForParentNotNull(int cateParentNo) {
		return cateDao.getMaxCateNoForParentNotNull(cateParentNo);
	}

	@Override
	public int categoryDelete(int cateNo) {
		return cateDao.categoryDelete(cateNo);
	}	
}
