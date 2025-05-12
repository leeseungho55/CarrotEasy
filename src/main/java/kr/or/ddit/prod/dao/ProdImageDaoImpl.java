package kr.or.ddit.prod.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.util.MybatisDao;
import kr.or.ddit.util.MybatisUtil;

public class ProdImageDaoImpl extends MybatisDao implements IProdImageDao {
	private static ProdImageDaoImpl instance;

	private ProdImageDaoImpl() {
        // 기본 생성자 - 자동 커밋 true
        super();
    }
    
    // 트랜잭션 관리를 위한 생성자
    private ProdImageDaoImpl(boolean autoCommit) {
        super(autoCommit);
    }

	public static ProdImageDaoImpl getInstance() {
		if (instance == null) {
			instance = new ProdImageDaoImpl();
		}

		return instance;
	}

	@Override
	public int prodImageInsert(ProdImageVo vo) {
		return update("prod_image.prodImageInsert", vo);
	}

	@Override
	public int prodImageInsert(ProdImageVo vo, SqlSession session) {
		return session.update("prod_image.prodImageInsert", vo);
	}

	@Override
	public List<ProdImageVo> getProdImagesByProdNo(int prodNo) {
		SqlSession sql = MybatisUtil.getInstance(); 

		try {
			return sql.selectList("prod_image.getProdImagesByProdNo", prodNo);
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
	public List<ProdImageVo> getProdImagesByProdNo(int prodNo, SqlSession session) {
		return selectList("prod_image.getProdImagesByProdNo", prodNo);
	}

	@Override
	public int prodImageDelete(int prodNo, SqlSession session) {
		return update("prod_image.prodImageDelete", prodNo);
	}
}
