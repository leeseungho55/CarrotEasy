package kr.or.ddit.prod.service;

import kr.or.ddit.prod.dao.IProdPurchaseDao;
import kr.or.ddit.prod.dao.ProdPurchaseDaoImpl;
import kr.or.ddit.prod.vo.ProdPurchaseVo;

public class ProdPurchaseServiceImpl implements IProdPurchaseService {
	private static ProdPurchaseServiceImpl instance;

	public static ProdPurchaseServiceImpl getInstance() {
        if (instance == null) {
            instance = new ProdPurchaseServiceImpl();
        }
        return instance;
    }
	
	IProdPurchaseDao dao = ProdPurchaseDaoImpl.getInstance();
	
	
	@Override
	public int prodPurchaseInsert(ProdPurchaseVo vo) {
		return dao.prodPurchaseInsert(vo);
	}

}
