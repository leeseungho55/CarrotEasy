package kr.or.ddit.notice.dao;

import java.util.List;

import kr.or.ddit.notice.vo.NoticeVo;
import kr.or.ddit.util.MybatisDao;

public class NoticeDaoImpl extends MybatisDao implements INoticeDao {
	private static NoticeDaoImpl instance;

	private NoticeDaoImpl() {

	}

	public static NoticeDaoImpl getInstance() {
		if (instance == null) {
			instance = new NoticeDaoImpl();
		}

		return instance;
	}

	@Override
	public List<NoticeVo> noticeList() {
		return selectList("notice.noticeList");
	}

	@Override
	public int noticeWrite(NoticeVo vo) {
		return update("notice.noticeWrite", vo);
	}

	@Override
	public NoticeVo getNoticeByNo(int notiNo) {
		return selectOne("notice.getNotice", notiNo);
	}

	@Override
	public int noticeUpdate(NoticeVo vo) {
		return update("notice.noticeUpdate", vo);
	}

	@Override
	public int noticeDelete(int notiNo) {
		return update("notice.noticeDelete", notiNo);
	}

	
}
