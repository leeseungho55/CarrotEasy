package kr.or.ddit.util;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

public class MybatisDao {
	
	public MybatisDao() {
		this.session = MybatisUtil.getInstance(true);
	}
	
	public MybatisDao(boolean autoCommit) {
		this.session = MybatisUtil.getInstance(autoCommit);
	}
	
	SqlSession session = MybatisUtil.getInstance(true);

    // selectList (파라미터 없는 버전)
    public <T> List<T> selectList(String statement) {
        SqlSession session = MybatisUtil.getInstance(true); // autoCommit true for select
        List<T> list = null;
        try {
            list = session.selectList(statement);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    // selectList (파라미터 있는 버전)
    public <T> List<T> selectList(String statement, Object param) {
        SqlSession session = MybatisUtil.getInstance(true); // autoCommit true for select
        List<T> list = null;
        try {
            list = session.selectList(statement, param);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return list;
    }

    // selectOne (파라미터 없는 버전)
    public <T> T selectOne(String statement) {
        SqlSession session = MybatisUtil.getInstance(true);
        T obj = null;
        try {
            obj = session.selectOne(statement);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return obj;
    }

    // selectOne (파라미터 있는 버전)
    public <T> T selectOne(String statement, Object param) {
        SqlSession session = MybatisUtil.getInstance(true);
        T obj = null;
        try {
            obj = session.selectOne(statement, param);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            session.close();
        }
        return obj;
    }

    // update/insert/delete (파라미터 없는 버전)
    public int update(String statement) {
        SqlSession session = MybatisUtil.getInstance(false); // autoCommit false for DML
        int num = 0;
        try {
            num = session.update(statement);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return num;
    }

    // update/insert/delete (파라미터 있는 버전)
    public int update(String statement, Object param) {
        SqlSession session = MybatisUtil.getInstance(false); // autoCommit false for DML
        int num = 0;
        try {
            num = session.update(statement, param);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return num;
    }
    
    // insert (파라미터 없는 버전)
    public int insert(String statement) {
        SqlSession session = MybatisUtil.getInstance(false); // autoCommit false for DML
        int num = 0;
        try {
            num = session.insert(statement);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return num;
    }

    // insert (파라미터 있는 버전)
    public int insert(String statement, Object param) {
        SqlSession session = MybatisUtil.getInstance(false); // autoCommit false for DML
        int num = 0;
        try {
            num = session.insert(statement, param);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return num;
    }
    
    // delete (파라미터 없는 버전)
    public int delete(String statement) {
        SqlSession session = MybatisUtil.getInstance(false); // autoCommit false for DML
        int num = 0;
        try {
            num = session.delete(statement);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return num;
    }

    // delete (파라미터 있는 버전)
    public int delete(String statement, Object param) {
        SqlSession session = MybatisUtil.getInstance(false); // autoCommit false for DML
        int num = 0;
        try {
            num = session.delete(statement, param);
            session.commit();
        } catch (Exception e) {
            e.printStackTrace();
            session.rollback();
        } finally {
            session.close();
        }
        return num;
    }
}