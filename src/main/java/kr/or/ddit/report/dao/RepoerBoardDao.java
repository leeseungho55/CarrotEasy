package kr.or.ddit.report.dao;

import java.util.List;

import kr.or.ddit.report.vo.ReportPagingVo;
import kr.or.ddit.report.vo.ReportVo;
import kr.or.ddit.report.vo.MVo;
import kr.or.ddit.util.MybatisDao;

public class RepoerBoardDao extends MybatisDao {
	private static final RepoerBoardDao instance = new RepoerBoardDao();

	private RepoerBoardDao() {
		// private constructor
	}

	public static RepoerBoardDao getInstance() {
		return instance;
	}
	public void insertReport(ReportVo vo) {
		int data = update("report.insert",vo);
		System.out.println("XML->Insert 실행"+data);
	}
	public List<ReportVo> listReport(){
		System.out.println("report.list 실행");		
		return selectList("report.list");
	}
	public List<ReportVo> updateForm(int repNum) {
		System.out.println("updateForm 실행");
		return selectList("report.updateForm", repNum);
	}
	public void updateReportNow(ReportVo vo) {
		System.out.println("updateReportNow 실행");
		update("report.updateReport", vo);
	}
	public void deleteReport(int rep_no) {
		System.out.println("report.deleteReport 실행");
		update("report.deleteReport",rep_no);
	}
	public int totalPosts() {
		return selectOne("report.totalPosts");
	}
	public List<ReportVo> pagingReport(ReportPagingVo vo){
		return selectList("report.pagingReport",vo);
	}
	public List<ReportVo> pagingReportAll(ReportPagingVo vo){
		return selectList("report.pagingReportAll",vo);
	}
	public List<MVo> role1Member() {
		return selectList("report.role1Member");
	}
	
	public String findMemId(int memNo) {
		return selectOne("report.findMemId");
	}
}
