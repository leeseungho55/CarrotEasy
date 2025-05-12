package kr.or.ddit.admember.service;

import kr.or.ddit.admember.dao.AdmemberDaoImpl;
import kr.or.ddit.admember.dao.IAdmemberDao;
import kr.or.ddit.admember.vo.AdmemberVo;

public class AdmemberServiceImpl implements IAdmemberService {
	private static AdmemberServiceImpl instance;

	private AdmemberServiceImpl() {

	}

	public static AdmemberServiceImpl getInstance() {
		if (instance == null) {
			instance = new AdmemberServiceImpl();
		}

		return instance;
	}
	
	IAdmemberDao iAdMemberDao = AdmemberDaoImpl.getInstance();

	@Override
	public AdmemberVo admemberLogin(AdmemberVo vo) {
		return iAdMemberDao.admemberLogin(vo);
	}

	@Override
	public int admemberJoin(AdmemberVo vo) {
		return iAdMemberDao.admemberJoin(vo);
	}

	@Override
	public boolean countRegNo(AdmemberVo vo) {
		return iAdMemberDao.countRegNo(vo) > 0;
	}

	@Override
	public boolean countId(AdmemberVo vo) {
		return iAdMemberDao.countId(vo) > 0;
	}

	@Override
	public AdmemberVo getAdmemberByNo(int amemNo) {
		return iAdMemberDao.getAdmemberByNo(amemNo);
	}

}
