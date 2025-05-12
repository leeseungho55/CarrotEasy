package kr.or.ddit.member.service;

import java.util.Properties;

import jakarta.mail.Authenticator;
import jakarta.mail.Message;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

public class PassService {
    private static PassService instance;
    private final String username = "suekhyon@naver.com"; // 네이버 이메일 주소
    private final String password = "tjrgus2025!"; // 네이버 계정 비밀번호
    
    private PassService() {
    }
    
    public static PassService getInstance() {
        if (instance == null) {
            instance = new PassService();
        }
        return instance;
    }
    
    public boolean sendVerificationCode(String toEmail, String pass) {
        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.naver.com"); // 네이버 SMTP 서버
        prop.put("mail.smtp.port", "587"); // 네이버 SMTP 포트
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true");
        
        
        
        Session session = Session.getInstance(prop, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(username, password);
            }
        });
        
        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(username, "당근이지 관리자")); // 보내는 사람 이름
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("[비밀번호 찾기] 비밀번호 초기화");
            
            String htmlContent = "<!DOCTYPE html>"
                + "<html>"
                + "<head>"
                + "<style>"
                + "body { font-family: Arial, sans-serif; line-height: 1.6; }"
                + ".container { max-width: 600px; margin: 0 auto; padding: 20px; }"
                + ".verification-code { font-size: 32px; font-weight: bold; color: #4CAF50; "
                + "letter-spacing: 5px; text-align: center; margin: 20px 0; }"
                + "</style>"
                + "</head>"
                + "<body>"
                + "<div class='container'>"
                + "<h2>비밀번호 초기화</h2>"
                + "<p>안녕하세요! 비밀번호 초기화 시켜드립니다.</p>"
                + "<p>아래 비밀번호를 사용하여 로그인 하시면됩니다:</p>"
                + "<br><br>"
                + "<div class='verification-code'>" + pass + "</div>"
                + "<br><br>"
                + "<p>이 인증 코드는 30분 동안 유효합니다.</p>"
                + "<p>본인이 요청하지 않은 경우 이 이메일을 무시하셔도 됩니다.</p>"
                + "</div>"
                + "</body>"
                + "</html>";
            
            message.setContent(htmlContent, "text/html; charset=UTF-8");
            
            Transport.send(message);
            System.out.println("인증 이메일 발송 완료: " + toEmail);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}