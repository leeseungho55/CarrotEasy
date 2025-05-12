<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>카카오 퀵 선택</title>
<style type="text/css">
	body {
		margin: 0;
        padding: 0;
        background-color: white;
        height: 100vh;
        display: flex;
        flex-direction: column; /* 세로 배치 */
        justify-content: center;
        align-items: center;
        font-family: Arial, sans-serif;
  	}

  	h2 {
  		margin-bottom: 30px;
  		font-size: 2rem;
  		color: #333;
  	}

  	.container {
      	display: flex;
      	gap: 30px; /* 버튼 사이 간격 */
  	}

  	.kakaoQuickSelect {
    	width: 250px;
      	height: 200px;
      	background-color: lightgray;
      	border-radius: 15px;
      	display: flex;
      	justify-content: center;
      	align-items: center;
      	font-size: 1.5rem;
      	font-weight: bold;
      	cursor: pointer;
      	transition: background-color 0.3s, transform 0.2s;
      	box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
  	}

  	.kakaoQuickSelect:hover {
      	background-color: #d3d3d3;
      	transform: translateY(-5px); /* 살짝 띄우는 효과 */
  	}
</style>
<script type="text/javascript">
	function cashInAdvance() {
		alert("선불 선택됨");
		//location.href = "/CarrotEasy/result.do?deliveryType=선불&prodPrice="+ 5000; //임시로 지정
		deliveryType ="선불"
		deliveryPrice="50000"
	    // 부모창에 전달
	    if (window.opener && !window.opener.closed) {
	        window.opener.receiveDeliveryInfo(deliveryType, deliveryPrice);
	    }
		
		window.close();
	}

	function cashOndelivery() {
		alert("착불 선택됨");
		// 실제 로직 작성
	}
</script>
</head>
<body>

<h2>카카오 퀵 배송 방식 선택</h2>
<div class="container">
    <div class="kakaoQuickSelect" onclick="cashInAdvance()">
       선불
    </div>
    <div class="kakaoQuickSelect" onclick="cashOndelivery()">
       착불
    </div>
</div>

</body>
</html>
