package kr.or.ddit.member.dao;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import kr.or.ddit.member.vo.EmailVerificationVo;
import kr.or.ddit.util.MybatisDao;

public class EmailVerificationDao extends MybatisDao {
	private static EmailVerificationDao instance;

	private EmailVerificationDao() {

	}

	public static EmailVerificationDao getInstance() {
		if (instance == null) {
			instance = new EmailVerificationDao();
		}

		return instance;
	}

	// 인증 코드 생성 및 저장
    public String createVerificationCode(String email) {
        String code = generateVerificationCode();
        LocalDateTime expiryTime = LocalDateTime.now().plusMinutes(30); // 30분 유효
        
        EmailVerificationVo vo = new EmailVerificationVo(email, code, expiryTime);
        
        try {
            int cnt = update("emailVerification.saveVerificationCode", vo);
            if (cnt > 0) {
                return code;
            }
            return null;
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    
    // 인증 코드 검증
    public boolean verifyCode(String email, String code) {
        Map<String, String> params = new HashMap<>();
        params.put("email", email);
        params.put("code", code);
        
        try {
            EmailVerificationVo result = selectOne("emailVerification.verifyCode", params);
            
            if (result != null) {
                // 인증 성공 시 verified 상태 업데이트
                update("emailVerification.updateVerificationStatus", email);
                // 회원 테이블의 이메일 인증 상태도 업데이트
//                update("emailVerification.updateMemberEmailVerified", email);
                return true;
            }
            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 이메일 인증 상태 확인
    public boolean isEmailVerified(String email) {
        try {
            Integer count = selectOne("emailVerification.isEmailVerified", email);
            return count != null && count > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // 인증 코드 생성 (6자리 숫자)
    private String generateVerificationCode() {
        Random random = new Random();
        int code = 100000 + random.nextInt(900000); // 100000-999999 사이의 난수
        return String.valueOf(code);
    }
}
