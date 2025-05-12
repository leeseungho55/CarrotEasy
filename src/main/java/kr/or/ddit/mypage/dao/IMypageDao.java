package kr.or.ddit.mypage.dao;

import kr.or.ddit.admember.vo.AdmemberVo;
import kr.or.ddit.member.vo.MemberVo;

public interface IMypageDao {
	
	// 회원 정보 수정
	public int profileUpdate(MemberVo member);
	
	// 광고주 정보 수정
	public int profileUpdateAd(AdmemberVo admember);

}
