package kr.or.ddit.notice.service;

import java.util.List;

import kr.or.ddit.notice.dao.INoticeDao;
import kr.or.ddit.notice.dao.NoticeDaoImpl;
import kr.or.ddit.notice.vo.NoticeVo;

public class NoticeServiceImpl implements INoticeService {
	private static NoticeServiceImpl instance;

	private NoticeServiceImpl() {

	}

	public static NoticeServiceImpl getInstance() {
		if (instance == null) {
			instance = new NoticeServiceImpl();
		}

		return instance;
	}
	
	INoticeDao noticeDao = NoticeDaoImpl.getInstance();

	@Override
	public List<NoticeVo> noticeList() {
		return noticeDao.noticeList();
	}

	@Override
	public int noticeWrite(NoticeVo vo) {
		return noticeDao.noticeWrite(vo);
	}

	@Override
	public NoticeVo getNoticeByNo(int notiNo) {
		return noticeDao.getNoticeByNo(notiNo);
	}

	@Override
	public int noticeUpdate(NoticeVo vo) {
		return noticeDao.noticeUpdate(vo);
	}

	@Override
	public int noticeDelete(int notiNo) {
		return noticeDao.noticeDelete(notiNo);
	}

	
}
