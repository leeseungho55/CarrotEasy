package kr.or.ddit.admember.dao;

import kr.or.ddit.admember.vo.AdmemberVo;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.util.MybatisDao;

public class AdmemberDaoImpl extends MybatisDao implements IAdmemberDao {
	private static AdmemberDaoImpl instance;

	private AdmemberDaoImpl() {

	}

	public static AdmemberDaoImpl getInstance() {
		if (instance == null) {
			instance = new AdmemberDaoImpl();
		}

		return instance;
	}

	@Override
	public AdmemberVo admemberLogin(AdmemberVo vo) {
		return selectOne("admember.admemberLogin", vo);
	}

	@Override
	public int admemberJoin(AdmemberVo vo) {
		return update("admember.admemberJoin", vo);
	}

	@Override
	public int countRegNo(AdmemberVo vo) {
		return selectOne("admember.countRegNo", vo);
	}

	@Override
	public int countId(AdmemberVo vo) {
		return selectOne("admember.countId", vo);
	}

	@Override
	public AdmemberVo getAdmemberByNo(int amemNo) {
		return selectOne("admember.getAdmemberByNo", amemNo);
	}
	
	

}
