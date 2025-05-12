package kr.or.ddit.file.dao;

import java.sql.Connection;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.prod.dao.ProdDaoImpl;
import kr.or.ddit.util.MybatisDao;

public class FileDaoImpl extends MybatisDao implements IFileDao {
	private static FileDaoImpl instance;

	private FileDaoImpl() {

	}

	public static FileDaoImpl getInstance() {
		if (instance == null) {
			instance = new FileDaoImpl();
		}

		return instance;
	}
	
	private FileDaoImpl(boolean autoCommit) {
        super(autoCommit);
    }
	
	public static FileDaoImpl getInstance(boolean autoCommit) {
        return new FileDaoImpl(autoCommit);
    }

	@Override
	public int fileInsert(FileVo vo) {
		return update("file.fileInsert", vo);
	}
	
	public int fileInsert(FileVo vo, SqlSession session) {
        return session.insert("file.fileInsert", vo);
    }

	@Override
	public int getLastFileNo() {
		return selectOne("file.getLastFileNo");
	}

	@Override
	public int getLastFileNo(SqlSession session) {
        return session.selectOne("file.getLastFileNo");
	}

	@Override
	public FileVo getFileByFileNo(int fileNo) {
		return selectOne("file.getFileByFileNo", fileNo);
	}

	@Override
	public int fileDelete(int fileNo, SqlSession session) {
		return update("file.fileDelete", fileNo);
	}

}
