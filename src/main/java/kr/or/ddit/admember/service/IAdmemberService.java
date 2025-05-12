package kr.or.ddit.admember.service;

import kr.or.ddit.admember.vo.AdmemberVo;

public interface IAdmemberService {
	public AdmemberVo admemberLogin(AdmemberVo admember);
	
	public int admemberJoin(AdmemberVo admember);
	
	public boolean countRegNo(AdmemberVo admember);
	
	public boolean countId(AdmemberVo admember);
	
	public AdmemberVo getAdmemberByNo(int amemNo);
}
