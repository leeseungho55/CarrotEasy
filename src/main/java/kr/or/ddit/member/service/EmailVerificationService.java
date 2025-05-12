package kr.or.ddit.member.service;

import kr.or.ddit.member.dao.EmailVerificationDao;

public class EmailVerificationService {
	private static EmailVerificationService instance;
    private EmailVerificationDao emailVerificationDao;
    private EmailService emailService;
    private PassService passService;
    
    private EmailVerificationService() {
        this.emailVerificationDao = EmailVerificationDao.getInstance();
        this.emailService = EmailService.getInstance();
        this.passService = PassService.getInstance();
    }
    
    public static EmailVerificationService getInstance() {
        if (instance == null) {
            instance = new EmailVerificationService();
        }
        return instance;
    }
    
    // 이메일 인증 코드 발송
    public boolean sendVerificationCode(String email) {
        // 인증 코드 생성 및 저장
        String code = emailVerificationDao.createVerificationCode(email);
        System.out.println("code : " + code);
        if (code == null) {
            return false;
        }
        
        // 인증 코드 이메일 발송
        return emailService.sendVerificationCode(email, code);
    }
    
    
    
    // 이메일 인증 코드 발송(비번 찾기)
    public boolean sendVerificationCodePass(String email) {
//        // 인증 코드 생성 및 저장
//        String code = emailVerificationDao.createVerificationCode(email);
//        System.out.println("code : " + code);
//        if (code == null) {
//            return false;
//        }
    	String pass = "qwer1234";
        
        // 인증 코드 이메일 발송
        return passService.sendVerificationCode(email, pass);
    }
    
    // 인증 코드 검증
    public boolean verifyCode(String email, String code) {
        return emailVerificationDao.verifyCode(email, code);
    }
    
    // 이메일 인증 상태 확인
    public boolean isEmailVerified(String email) {
        return emailVerificationDao.isEmailVerified(email);
    }
    
//    public boolean sendVerificationCode(String email) {
//        // 인증 코드 생성 및 저장
//        String code = emailVerificationDao.createVerificationCode(email);
//        System.out.println("code : " + code);
//        if (code == null) {
//            return false;
//        }
//        
//        // 인증 코드 이메일 발송
//        return emailService.sendVerificationCode(email, code);
//    }
}
