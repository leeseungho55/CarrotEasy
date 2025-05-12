package kr.or.ddit.qna.service;

import java.util.List;

import kr.or.ddit.qna.vo.QnaVo;

public interface IQnaService {
	
	// 문의 등록
	public int qnaInsert(QnaVo qna);
	
	// 문의 목록
	public List<QnaVo> qnaList();
	
	// 문의 상세
	public QnaVo qnaDetail(int qnaNo);
	
	// 문의 수정
	public int qnaUpdate(QnaVo qna);
	
	// 문의 삭제
	public int qnaDelete(int qnaNo);
	
	// 관리자 댓글 추가
	public int qnaInsertAnswer(QnaVo qna);
	
	// 자신 게시글만 보기
	public List<QnaVo> qnaListByMember(int memNo);

}
