package kr.or.ddit.member.service;

import kr.or.ddit.member.dao.IMemberDao;
import kr.or.ddit.member.dao.MemberDaoImpl;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.vo.StoreVo;

public class MemberServiceImpl implements IMemberService {
	
	IMemberDao memberDao = MemberDaoImpl.getInstance();
	
	private static MemberServiceImpl instance;

	private MemberServiceImpl() {

	}

	public static MemberServiceImpl getInstance() {
		if (instance == null) {
			instance = new MemberServiceImpl();
		}

		return instance;
	}

	@Override
	public MemberVo memberLogin(MemberVo member) {
		return memberDao.memberLogin(member);
	}

	@Override
	public boolean countId(MemberVo member) {
		return memberDao.countId(member) > 0;
	}

	@Override
	public boolean countNick(MemberVo member) {
		return memberDao.countNick(member) > 0;
	}
	
	@Override
	public boolean memberJoin(MemberVo member) {
		return memberDao.memberJoin(member);
	}
	
	// 회원가입
    public boolean registerMember(MemberVo member) {
        try {
            return memberDao.registerMember(member);
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 이메일로 회원 조회
    public MemberVo findMemberByEmail(String email) {
        return memberDao.findMemberByEmail(email);
    }

	@Override
	public String findId(MemberVo member) {
		return memberDao.findId(member);
	}

	@Override
	public String findPass(MemberVo member) {
		return memberDao.findPass(member);
	}

	@Override
	public int updatePass(String findEmail) {
		return memberDao.updatePass(findEmail);
	}

	@Override
	public MemberVo findMemberByNo(int memNo) {
		return memberDao.findMemberByNo(memNo);
	}
	
	@Override
	public int store_memNo(String memNick) {
		return memberDao.store_memNo(memNick);
	}
	
	@Override
	public int storeInsert(StoreVo vo) {
		return memberDao.storeInsert(vo);
	}

}