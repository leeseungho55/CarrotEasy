package kr.or.ddit.qna.dao;

import java.util.List;

import kr.or.ddit.qna.vo.QnaVo;
import kr.or.ddit.util.MybatisDao;

public class QnaDaoImpl extends MybatisDao implements IQnaDao {
	
	private static QnaDaoImpl instance;

	private QnaDaoImpl() {

	}

	public static QnaDaoImpl getInstance() {
		if (instance == null) {
			instance = new QnaDaoImpl();
		}
		return instance;
	}

	@Override
	public int qnaInsert(QnaVo qna) {
		return update("qna.qnaInsert", qna);
	}

	@Override
	public List<QnaVo> qnaList() {
		return selectList("qna.qnaList");
	}

	@Override
	public QnaVo qnaDetail(int qnaNo) {
		return selectOne("qna.qnaDetail", qnaNo);
	}

	@Override
	public int qnaUpdate(QnaVo qna) {
		return update("qna.qnaUpdate", qna);
	}

	@Override
	public int qnaDelete(int qnaNo) {
		return update("qna.qnaDelete", qnaNo);
	}

	@Override
	public int qnaInsertAnswer(QnaVo qna) {
		return update("qna.qnaInsertAnswer", qna);
	}

	@Override
	public List<QnaVo> qnaListByMember(int memNo) {
		return selectList("qna.qnaListByMember", memNo);
	}

	

}
