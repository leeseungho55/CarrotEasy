package kr.or.ddit.community.community_report.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import kr.or.ddit.community.community_report.vo.CommunityReportVo;
import kr.or.ddit.util.MybatisDao;

public class CommunityReportDaoImpl extends MybatisDao implements ICommunityReportDao{
	private static CommunityReportDaoImpl instance;

	private CommunityReportDaoImpl() {

	}

	public static CommunityReportDaoImpl getInstance() {
		if (instance == null) {
			instance = new CommunityReportDaoImpl();
		}
		return instance;
	}

	@Override
	public List<CommunityReportVo> communityReportList() {
		return selectList("communityReport.communityReportList");
	}

	@Override
	public int communityInsertReport(CommunityReportVo report) {
		return insert("communityReport.communityInsertReport", report);
	}

	@Override
	public int communityUpdateReportCount(int commuNo) {
		return update("communityReport.communityUpdateReportCount", commuNo);
	}

	@Override
	public boolean communityReportProcessStatus(int reportNo, String processStatus) {
		Map<String, Object> param = new HashMap<>();
		param.put("reportNo", reportNo);
		param.put("processStatus", processStatus);
		return update("communityReport.communityReportProcessStatus", param) > 0;
	}

	@Override
	public int communityDeleteReport(CommunityReportVo report) {
		return update("communityReport.communityDeleteReport", report);
	}
	
	
	
}
