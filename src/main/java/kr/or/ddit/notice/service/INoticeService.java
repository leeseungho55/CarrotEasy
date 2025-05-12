package kr.or.ddit.notice.service;

import java.util.List;

import kr.or.ddit.notice.vo.NoticeVo;

public interface INoticeService {
	public List<NoticeVo> noticeList();
	
	public int noticeWrite(NoticeVo vo);

	public NoticeVo getNoticeByNo(int notiNo);

	public int noticeUpdate(NoticeVo vo);
	
	public int noticeDelete(int notiNo);
}
