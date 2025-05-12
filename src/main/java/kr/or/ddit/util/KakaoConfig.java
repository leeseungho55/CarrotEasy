package kr.or.ddit.util;

import java.math.BigInteger;
import java.security.InvalidKeyException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;

public class KakaoConfig {
	
	// 퀵 주문 API 엔드포인트
	public static final String KAKAO_QUICK_ORDER_API_URL = "https://open-api-logistics.kakaomobility.com/goa-sandbox-service/api/v2/orders";

	// 퀵 배송조회 API 엔드포인트
    public static final String KAKAO_STATUS_API_URL = "https://open-api-logistics.kakaomobility.com/goa-sandbox-service/api/v2/orders/";
    
    // 퀵 가격조회 API 엔드포인트
    public static final String KAKAO_QUICK_PRICE_API_URL = "https://open-api-logistics.kakaomobility.com/goa-sandbox-service/api/v2/orders/price";
    
    // 벤더 ID (카카오 모빌리티에서 발급)
    public static final String VENDOR_ID = "VZQSQZ";
    
    // 인증 키 (카카오 모빌리티에서 발급)
    public static final String API_KEY = "28e84194-3bdc-4461-8007-a0cc1a35181d";
    
    // 서명 생성
    private static String generateSignature(String timestamp, String nonce, String apiKey)
            throws InvalidKeyException, NoSuchAlgorithmException {
        String plainText = timestamp + nonce + apiKey;
        return generateSHA512(plainText);
    }
	
	// SHA-512 해싱
    private static String generateSHA512(String plainText)
            throws NoSuchAlgorithmException, InvalidKeyException {
        MessageDigest md = MessageDigest.getInstance("SHA-512");
        md.update(plainText.getBytes());
        return String.format("%0128x", new BigInteger(1, md.digest()));
    }

    // Authorization 헤더 생성
    private static String generateAuthorizationHeader(String timestamp, String nonce, String sign) {
        String plainText = timestamp + "$$" + nonce + "$$" + sign;
        return Base64.getEncoder().encodeToString(plainText.getBytes());
    }
    
    // 난수 생성 메서드
    private static String generateNonce() {
        return String.valueOf(100000 + (int)(Math.random() * 900000)); // 6자리 난수
    }
    
    // Authorization 값을 미리 생성하는 메서드
    public static String createAuthorization(String apiKey) throws InvalidKeyException, NoSuchAlgorithmException {
        String timestamp = String.valueOf(System.currentTimeMillis());
        String nonce = generateNonce();
        String signKey = generateSignature(timestamp, nonce, apiKey);
        return generateAuthorizationHeader(timestamp, nonce, signKey);
    }
}
