package kr.or.ddit.prod.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.util.MybatisDao;
import kr.or.ddit.util.MybatisUtil;

public class ProdDaoImpl extends MybatisDao implements IProdDao {
    private static ProdDaoImpl instance;

    private ProdDaoImpl() {
        // 기본 생성자 - 자동 커밋 true
        super();
    }
    
    // 트랜잭션 관리를 위한 생성자
    private ProdDaoImpl(boolean autoCommit) {
        super(autoCommit);
    }

    public static ProdDaoImpl getInstance() {
        if (instance == null) {
            instance = new ProdDaoImpl();
        }
        return instance;
    }
    
    // 트랜잭션 관리를 위한 인스턴스 획득 메서드
    public static ProdDaoImpl getInstance(boolean autoCommit) {
        return new ProdDaoImpl(autoCommit);
    }

    @Override
    public List<ProdVo> prodList() {
    	SqlSession sql = MybatisUtil.getInstance(); 

		try {
			return sql.selectList("prod.prodList");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(sql != null) {
				sql.commit();
				sql.close();
			}
		}
		
		return null;
    }
    
    @Override
    public List<ProdVo> prodList(SqlSession session) {
        return session.selectList("prod.prodList");
    }

    @Override
    public ProdVo getProdByNo(int prodNo) {
        return selectOne("prod.getProdByNo", prodNo);
    }
    
    @Override
    public ProdVo getProdByNo(int prodNo, SqlSession session) {
        return session.selectOne("prod.getProdByNo", prodNo);
    }

    @Override
    public int prodInsert(ProdVo vo) {
        update("prod.prodInsert", vo);
        return selectOne("prod.getLastInsertedProdNo");
    }
    
    @Override
    public int prodInsert(ProdVo vo, SqlSession session) {
        session.update("prod.prodInsert", vo);
        return session.selectOne("prod.getLastInsertedProdNo");
    }

    @Override
    public int prodUpdate(ProdVo vo) {
        return update("prod.prodUpdate", vo);
    }
    
    @Override
    public int prodUpdate(ProdVo vo, SqlSession session) {
        return session.update("prod.prodUpdate", vo);
    }

    @Override
    public int prodDelete(int prodNo) {
        return update("prod.prodDelete", prodNo);
    }
    
    @Override
    public int prodDelete(int prodNo, SqlSession session) {
        return session.update("prod.prodDelete", prodNo);
    }
    
    @Override
    public int getLastInsertedProdNo() {
        return selectOne("prod.getLastInsertedProdNo");
    }
    
    @Override
    public int getLastInsertedProdNo(SqlSession session) {
        return session.selectOne("prod.getLastInsertedProdNo");
    }

	@Override
	public List<ProdVo> getProdListWithFilters(List<Integer> cateNoList, List<Integer> areaNoList, String keyword) {
		Map<String, Object> params = new HashMap();
		params.put("cateNoList", cateNoList);
        params.put("areaNoList", areaNoList);
        params.put("keyword", keyword);
	
		SqlSession sql = MybatisUtil.getInstance(); 

		try {
			return sql.selectList("prod.getProdListWithFilters", params);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(sql != null) {
				sql.commit();
				sql.close();
			}
		}
		
		return null;
	}

	@Override
	public int prodCntUpdate(int prodNo) {
		return update("prod.prodCntUpdate", prodNo);
	}

	@Override
	public List<ProdVo> prodMainRecentlyList() {
		// TODO Auto-generated method stub
		return selectList("prod.prodMainRecentlyList");
	}

	@Override
	public List<ProdVo> prodMainBestList() {
		// TODO Auto-generated method stub
		return selectList("prod.prodMainBestList");
	}
}