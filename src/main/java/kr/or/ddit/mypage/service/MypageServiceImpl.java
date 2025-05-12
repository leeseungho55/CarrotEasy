package kr.or.ddit.mypage.service;

import kr.or.ddit.admember.vo.AdmemberVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mypage.dao.IMypageDao;
import kr.or.ddit.mypage.dao.MypageDaoImpl;

public class MypageServiceImpl implements IMypageService {
	
	IMypageDao mypageDao = MypageDaoImpl.getInstance();
	
	private static MypageServiceImpl instance;

	private MypageServiceImpl() {

	}

	public static MypageServiceImpl getInstance() {
		if (instance == null) {
			instance = new MypageServiceImpl();
		}
		return instance;
	}


	@Override
	public int profileUpdate(MemberVo member) {
		return mypageDao.profileUpdate(member);
	}

	@Override
	public int profileUpdateAd(AdmemberVo admember) {
		return mypageDao.profileUpdateAd(admember);
	}

	

}
