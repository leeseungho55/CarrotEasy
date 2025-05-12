package kr.or.ddit.prod.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import kr.or.ddit.prod.dao.IProdImageDao;
import kr.or.ddit.prod.dao.ProdImageDaoImpl;
import kr.or.ddit.prod.vo.ProdImageVo;

public class ProdImageServiceImpl implements IProdImageService {
    private static ProdImageServiceImpl instance;
    
    private ProdImageServiceImpl() {
    }
    
    public static ProdImageServiceImpl getInstance() {
        if (instance == null) {
            instance = new ProdImageServiceImpl();
        }
        return instance;
    }
    
    IProdImageDao dao = ProdImageDaoImpl.getInstance();
    
    @Override
    public int prodImageInsert(ProdImageVo vo) {
        return dao.prodImageInsert(vo);
    }
    
    @Override
    public int prodImageInsert(ProdImageVo vo, SqlSession session) {
        return dao.prodImageInsert(vo, session);
    }

	@Override
	public List<ProdImageVo> getProdImagesByProdNo(int prodNo) {
	    return dao.getProdImagesByProdNo(prodNo);
	}
	
	@Override
	public List<ProdImageVo> getProdImagesByProdNo(int prodNo, SqlSession session) {
	    return dao.getProdImagesByProdNo(prodNo, session);
	}

	@Override
	public int prodImageDelete(int prodNo, SqlSession session) {
		return dao.prodImageDelete(prodNo, session);
	}
}