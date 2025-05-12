package kr.or.ddit.file.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.file.dao.FileDaoImpl;
import kr.or.ddit.file.dao.IFileDao;
import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.prod.vo.ProdImageVo;

public class FileServiceImpl implements IFileService {
	private static FileServiceImpl instance;

	private FileServiceImpl() {

	}

	public static FileServiceImpl getInstance() {
		if (instance == null) {
			instance = new FileServiceImpl();
		}

		return instance;
	}
	
	IFileDao fileDao = FileDaoImpl.getInstance();

	@Override
    public int fileInsert(FileVo vo) {
        return fileDao.fileInsert(vo);
    }

    @Override
    public int fileInsert(FileVo vo, SqlSession session) {
        return fileDao.fileInsert(vo, session);
    }

    @Override
    public int getLastFileNo() {
        return fileDao.getLastFileNo();
    }

    @Override
    public int getLastFileNo(SqlSession session) {
        return fileDao.getLastFileNo(session);
    }

	@Override
	public List<FileVo> getFilesByFileNos(List<ProdImageVo> prodImageList) {
		List<FileVo> fileList = new ArrayList();
	    
	    for (ProdImageVo prodImage : prodImageList) {
	        FileVo fileVo = fileDao.getFileByFileNo(prodImage.getFileNo());
	        if (fileVo != null) {
	            fileList.add(fileVo);
	        }
	    }
	    
	    return fileList;
	}

	@Override
	public FileVo getFileByFileNo(int fileNo) {
        return fileDao.getFileByFileNo(fileNo);
	}

	@Override
	public int fileDelete(int fileNo, SqlSession session) {
		return fileDao.fileDelete(fileNo, session);
	}
	
}
