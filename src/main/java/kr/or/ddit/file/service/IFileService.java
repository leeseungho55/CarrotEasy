package kr.or.ddit.file.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.prod.vo.ProdImageVo;

public interface IFileService {
	public int fileInsert(FileVo vo);
    
    public int fileInsert(FileVo vo, SqlSession session);
    
    public int getLastFileNo();
    
    public int getLastFileNo(SqlSession session);
    
    public List<FileVo> getFilesByFileNos(List<ProdImageVo> prodImageList);
    
    public FileVo getFileByFileNo(int fileNo);

	public int fileDelete(int fileNo, SqlSession session);

}
