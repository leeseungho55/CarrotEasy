package kr.or.ddit.prod.dao;

import kr.or.ddit.prod.vo.ProdPurchaseVo;
import kr.or.ddit.util.MybatisDao;

public class ProdPurchaseDaoImpl extends MybatisDao implements IProdPurchaseDao {
	private static ProdPurchaseDaoImpl instance;

	public static ProdPurchaseDaoImpl getInstance() {
        if (instance == null) {
            instance = new ProdPurchaseDaoImpl();
        }
        return instance;
    }
	
	@Override
	public int prodPurchaseInsert(ProdPurchaseVo vo) {
		return update("prod_purchase.prodPurchaseInsert", vo);
	}
	
}
