package kr.or.ddit.delivery.vo;

import lombok.Data;

@Data
public class DeliveryVo {
    private int deliNo;           // 배송 번호 (PK)
    private int payNo;            // 결제 번호 (FK)
    private String deliId;        // 카카오퀵 배송 ID
    private String deliType;      // 배송 유형 (QUICK)
    private String deliStatus;    // 배송 상태 (배차중, 배달중, 완료 등)
    private int deliPrice;        // 배송 가격
    private String recipientName; // 수령인 이름
    private String recipientTel;  // 수령인 연락처
    private String deliAddress;   // 배송 주소
    private String deliMessage;   // 배송 요청사항
    private String paymentType;   // 결제 유형 (선불, 착불)
    private int senderNo;     	  // 발송인(판매자) 번호
    private int prodNo;			  // 상품 번호
    private String createDate;      // 생성일
    
    @Override
    public String toString() {
        return "DeliveryVo{" +
                "payNo=" + payNo +
                ", deliId='" + deliId + '\'' +
                ", deliType='" + deliType + '\'' +
                ", deliStatus='" + deliStatus + '\'' +
                ", deliPrice=" + deliPrice +
                ", recipientName='" + recipientName + '\'' +
                ", recipientTel='" + recipientTel + '\'' +
                ", deliAddress='" + deliAddress + '\'' +
                ", deliMessage='" + deliMessage + '\'' +
                ", paymentType='" + paymentType + '\'' +
                ", senderNo=" + senderNo +
                ", prodNo=" + prodNo +
                '}';
    }
}
