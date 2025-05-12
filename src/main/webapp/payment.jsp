<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<!-- 포트원 결제 -->
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제하기 버튼</title>
    <!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <!-- 포트원 결제 -->
</head>
<body>
	<button onclick="kakaoPay()">asdsad</button>
</body>
<script type="text/javascript">

	//구매자 정보 --> 추후 컨트롤러에서 정보를 받아서 저정할 예정
 // 사용자 이름이 없어서 아이디로 대체
	//결제창 함수 넣어주기
	const buyButton = document.getElementById('payment')
	
	var IMP = window.IMP;
	
	var today = new Date();
	var hours = today.getHours(); // 시
	var minutes = today.getMinutes();  // 분
	var seconds = today.getSeconds();  // 초
	var milliseconds = today.getMilliseconds();
	var makeMerchantUid = `${hours}` + `${minutes}` + `${seconds}` + `${milliseconds}`;
	
	function kakaoPay() {
	    if (confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
	
	            IMP.init("imp74712831"); // 가맹점 식별코드
	            IMP.request_pay({
	                pg: 'kakaopay.TC0ONETIME', // PG사 코드표에서 선택
	                pay_method: 'card', // 결제 방식
	                merchant_uid: "IMP11" + makeMerchantUid, // 결제 고유 번호
	                name: 'data', // 제품명
	                amount: 100000, // 가격
	                //구매자 정보 
	                buyer_email: 'data',
	                buyer_name: 'data',
	                buyer_tel : '010-1234-5678',
	                buyer_addr : '서울특별시 강남구 삼성동',
	                buyer_postcode : '123-456'
	            }, async function (rsp) { // callback
	                if (rsp.success) { //결제 성공시
	                    console.log(rsp);

	
	                    if (response.status == 200) { // DB저장 성공시
	                        alert('결제 완료!')
	                        window.location.reload();
	                    } else { // 결제완료 후 DB저장 실패시
	                        alert(`error:[${response.status}]\n결제요청이 승인된 경우 관리자에게 문의바랍니다.`);
	                        // DB저장 실패시 status에 따라 추가적인 작업 가능성
	                    }
	                } else if (rsp.success == false) { // 결제 실패시
	                    alert(rsp.error_msg)
	                }
	            });
	        }
	     else { // 구매 확인 알림창 취소 클릭시 돌아가기
	        return false;
	    }
	}

	
</script>
</html>