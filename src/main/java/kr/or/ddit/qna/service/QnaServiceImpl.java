package kr.or.ddit.qna.service;

import java.util.List;

import kr.or.ddit.qna.dao.IQnaDao;
import kr.or.ddit.qna.dao.QnaDaoImpl;
import kr.or.ddit.qna.vo.QnaVo;

public class QnaServiceImpl implements IQnaService {
	
	IQnaDao qnaDao = QnaDaoImpl.getInstance();
	
	private static QnaServiceImpl instance;

	private QnaServiceImpl() {

	}

	public static QnaServiceImpl getInstance() {
		if (instance == null) {
			instance = new QnaServiceImpl();
		}
		return instance;
	}

	@Override
	public int qnaInsert(QnaVo qna) {
		return qnaDao.qnaInsert(qna);
	}

	@Override
	public List<QnaVo> qnaList() {
		return qnaDao.qnaList();
	}

	@Override
	public QnaVo qnaDetail(int qnaNo) {
		return qnaDao.qnaDetail(qnaNo);
	}

	@Override
	public int qnaUpdate(QnaVo qna) {
		return qnaDao.qnaUpdate(qna);
	}

	@Override
	public int qnaDelete(int qnaNo) {
		return qnaDao.qnaDelete(qnaNo);
	}

	@Override
	public int qnaInsertAnswer(QnaVo qna) {
		return qnaDao.qnaInsertAnswer(qna);
	}

	@Override
	public List<QnaVo> qnaListByMember(int memNo) {
		return qnaDao.qnaListByMember(memNo);
	}

	

}
