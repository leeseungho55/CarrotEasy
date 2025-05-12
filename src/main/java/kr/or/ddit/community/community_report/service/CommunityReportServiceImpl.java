package kr.or.ddit.community.community_report.service;

import java.util.List;

import kr.or.ddit.community.community_report.dao.CommunityReportDaoImpl;
import kr.or.ddit.community.community_report.dao.ICommunityReportDao;
import kr.or.ddit.community.community_report.vo.CommunityReportVo;
import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.util.MybatisDao;

public class CommunityReportServiceImpl extends MybatisDao implements ICommunityReportService{

	private static CommunityReportServiceImpl instance;

	private CommunityReportServiceImpl() {

	}

	public static CommunityReportServiceImpl getInstance() {
		if (instance == null) {
			instance = new CommunityReportServiceImpl();
		}
		return instance;
	}
	
	ICommunityReportDao reportDao = CommunityReportDaoImpl.getInstance();
	IMemberDao memberDao = MemberDaoImpl.getInstance();

	@Override
	public List<CommunityReportVo> communityReportList() {
		List<CommunityReportVo> reportList = reportDao.communityReportList();
		
		for(CommunityReportVo report : reportList) {
			int reporterMemNo = report.getReporterMemNo();
			MemberVo member = memberDao.findMemberByNo(reporterMemNo);
			report.setMember(member);
		}
		
		return reportList;
	}

	@Override
	public int communityInsertReport(CommunityReportVo report) {
		return reportDao.communityInsertReport(report);
	}

	@Override
	public int communityUpdateReportCount(int commuNo) {
		return reportDao.communityUpdateReportCount(commuNo);
	}

	@Override
	public boolean communityReportProcessStatus(int reportNo, String processStatus) {
		return reportDao.communityReportProcessStatus(reportNo, processStatus);
	}

	@Override
	public int communityDeleteReport(CommunityReportVo report) {
		return reportDao.communityDeleteReport(report);
	}
	
	
	
}
