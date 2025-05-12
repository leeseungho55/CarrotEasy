package kr.or.ddit.cate.dao;

import java.util.List;

import kr.or.ddit.cate.vo.CateVo;
import kr.or.ddit.util.MybatisDao;

public class CateDaoImpl extends MybatisDao implements ICateDao {
	private static CateDaoImpl instance;

	private CateDaoImpl() {

	}

	public static CateDaoImpl getInstance() {
		if (instance == null) {
			instance = new CateDaoImpl();
		}

		return instance;
	}

	private static final Object lock = new Object();

	@Override
	public List<CateVo> selectAllCategories() {
		return selectList("cate.selectAllCategories");
	}

	@Override
	public List<CateVo> selectSubcategoriesByParent(int cateParentNo) {
		synchronized(lock) {
			return selectList("cate.selectSubcategoriesByParent", cateParentNo);
		}
	}

	@Override
	public CateVo selectCategoryByCateNo(int cateNo) {
		return selectOne("cate.selectCategoryByCateNo", cateNo);
	}

	@Override
	public int categoryInsert(CateVo vo) {
		return update("cate.categoryInsert", vo);
	}

	@Override
	public int categoryUpdate(CateVo vo) {
		return update("cate.categoryUpdate", vo);
	}

	@Override
	public Integer getMaxCateNoForParentNull() {
		return selectOne("cate.getMaxCateNoForParentNull");
	}

	@Override
	public Integer getMaxCateNoForParentNotNull(int cateParentNo) {
		return selectOne("cate.getMaxCateNoForParentNotNull", cateParentNo);
	}

	@Override
	public int categoryDelete(int cateNo) {
		return update("cate.categoryDelete", cateNo);
	}
}
