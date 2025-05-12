package kr.or.ddit.member.dao;

import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.vo.StoreVo;

public interface IMemberDao {
	
	public MemberVo memberLogin(MemberVo member);
	
	public int countId(MemberVo member);
	
	public int countNick(MemberVo member);
	
	public boolean memberJoin(MemberVo member);
	
	// 이메일로 회원 조회
    public MemberVo findMemberByEmail(String email);
    
    // 회원가입
    public boolean registerMember(MemberVo member);
    
    // 아이디 찾기
    public String findId(MemberVo member);
    
    // 비밀번호 찾기(이메일 가져오기)
    public String findPass(MemberVo member);
    
    // 비밀번호 찾기(비밀번호 업데이트)
    public int updatePass(String findEmail);
    
    // 회원정보로 회원 조회
    public MemberVo findMemberByNo(int memNo);
    
    // 내상점 memNo 가져오기
    public int store_memNo(String memNick);
    
    // 내상점 등록
    public int storeInsert(StoreVo vo);

}