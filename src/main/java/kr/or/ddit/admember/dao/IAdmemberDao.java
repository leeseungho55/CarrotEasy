package kr.or.ddit.admember.dao;

import kr.or.ddit.admember.vo.AdmemberVo;

public interface IAdmemberDao {
	public AdmemberVo admemberLogin(AdmemberVo vo);
	
	public int admemberJoin(AdmemberVo vo);
	
	public int countRegNo(AdmemberVo vo);
	
	public int countId(AdmemberVo vo);

	public AdmemberVo getAdmemberByNo(int amemNo);
}
