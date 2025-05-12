package kr.or.ddit.mypage.dao;

import kr.or.ddit.admember.vo.AdmemberVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.util.MybatisDao;

public class MypageDaoImpl extends MybatisDao implements IMypageDao {
	
	private static MypageDaoImpl instance;

	private MypageDaoImpl() {

	}

	public static MypageDaoImpl getInstance() {
		if (instance == null) {
			instance = new MypageDaoImpl();
		}
		return instance;
	}

	@Override
	public int profileUpdate(MemberVo member) {
		return update("mypage.profileUpdate", member);
	}

	@Override
	public int profileUpdateAd(AdmemberVo admember) {
		return update("mypage.profileUpdateAd", admember);
	}

	

}
