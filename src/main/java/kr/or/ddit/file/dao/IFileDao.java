package kr.or.ddit.file.dao;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.file.vo.FileVo;

public interface IFileDao {
    public int fileInsert(FileVo vo);
    
    public int fileInsert(FileVo vo, SqlSession session);
	
    public int getLastFileNo();
    
    public int getLastFileNo(SqlSession session);

	public FileVo getFileByFileNo(int fileNo);

	public int fileDelete(int fileNo, SqlSession session);
}
