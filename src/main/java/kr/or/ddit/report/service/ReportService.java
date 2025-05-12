package kr.or.ddit.report.service;

import java.util.List;

import kr.or.ddit.report.dao.RepoerBoardDao;
import kr.or.ddit.report.vo.ReportPagingVo;
import kr.or.ddit.report.vo.ReportVo;
import kr.or.ddit.report.vo.MVo;

public class ReportService {
	private static final ReportService instance = new ReportService();

	private ReportService() {
		// private constructor
	}


	public static ReportService getInstance() {
		return instance;
	}
	RepoerBoardDao dao = RepoerBoardDao.getInstance();
	
	public void insertReport(ReportVo vo) {
		dao.insertReport(vo);
	}
	public List<ReportVo>listReport(){
		return dao.listReport();
	}
	public List<ReportVo> UpdateForm(int rep_no) {
		return dao.updateForm(rep_no);
	}
	public void updateReportNow(ReportVo vo) {
		dao.updateReportNow(vo);
	}
	public void deleteReport(int rep_no) {
		dao.deleteReport(rep_no);
	}
	public int totalPosts() {
		return dao.totalPosts();
	}
	public List<ReportVo> pagingReport(ReportPagingVo vo) {
	    return dao.pagingReport(vo);
	}
	public List<ReportVo> pagingReportAll(ReportPagingVo vo) {
	    return dao.pagingReportAll(vo);
	}
	public List<MVo> role1Member() {
		return dao.role1Member();
	}	
	public String findMemId(int memNo) {
		return dao.findMemId(memNo);
	}
}
