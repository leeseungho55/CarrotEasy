package kr.or.ddit.member.dao;

import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.vo.StoreVo;
import kr.or.ddit.util.MybatisDao;

public class MemberDaoImpl extends MybatisDao implements IMemberDao {
	
	private static MemberDaoImpl instance;

	private MemberDaoImpl() {

	}

	public static MemberDaoImpl getInstance() {
		if (instance == null) {
			instance = new MemberDaoImpl();
		}

		return instance;
	}

	@Override
	public MemberVo memberLogin(MemberVo member) {
		return selectOne("member.memberLogin", member);
	}

	@Override
	public int countId(MemberVo member) {
		return selectOne("member.countId", member);
	}

	@Override
	public int countNick(MemberVo member) {
		return selectOne("member.countNick", member);
	}
	
	@Override
	public boolean memberJoin(MemberVo member) {
		int res = update("member.memberJoin", member);
		return res > 0;
	}
	
	// 회원 등록
    public boolean registerMember(MemberVo member) {
        try {
            int cnt = update("member.registerMember1", member);
            return cnt > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 이메일로 회원 조회
    public MemberVo findMemberByEmail(String email) {
        try {
            return selectOne("member.findMemberByEmail", email);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

	@Override
	public String findId(MemberVo member) {
		return selectOne("member.findId", member);
	}

	@Override
	public String findPass(MemberVo member) {
		return selectOne("member.findPass", member);
	}

	@Override
	public int updatePass(String findEmail) {
		return update("member.updatePass", findEmail);
	}

	@Override
	public MemberVo findMemberByNo(int memNo) {
		return selectOne("member.findMemberByNo", memNo);
	}

	@Override
	public int store_memNo(String memNick) {
		return selectOne("member.store_memNo", memNick);
	}


	@Override
	public int storeInsert(StoreVo vo) {
		return update("member.storeInsert", vo);
	}

}
