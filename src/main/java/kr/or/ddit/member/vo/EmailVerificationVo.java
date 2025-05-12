package kr.or.ddit.member.vo;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class EmailVerificationVo {
    private String email;
    private String verificationCode;
    private LocalDateTime createdAt;
    private LocalDateTime expiresAt;
    private boolean verified;
    
    // 기본 생성자
    public EmailVerificationVo() {
    }
    
    // 인증 코드 생성 시 사용할 생성자
    public EmailVerificationVo(String email, String verificationCode, LocalDateTime expiresAt) {
        this.email = email;
        this.verificationCode = verificationCode;
        this.createdAt = LocalDateTime.now();
        this.expiresAt = expiresAt;
        this.verified = false;
    }
}
