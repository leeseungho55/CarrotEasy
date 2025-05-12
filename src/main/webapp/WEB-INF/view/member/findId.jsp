<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	.form-group .button-inline {
        margin-left: 10px;
        padding: 7px 12px;
        background: orange;
        color: white;
        border: none;
        border-radius: 4px;
        cursor: pointer;
    }
        
    .form-group input,
    .form-group select {
        flex: 1;
        padding: 8px;
        border: 1px solid #ccc;
        border-radius: 4px;
    }
    
    h3 {
        margin-top: 0; /* 기본 마진 제거 */
    }
    
    p {
        margin-top: 4px;  /* 살짝 여백만 주기 */
        margin-bottom: 8px;
    }
    
    h6 {
    	margin: 0;
    	padding : 0;
    	font-size : 1.0rem;
    }
    
    .email-group {
	    display: flex;
	    align-items: center;
	    gap: 10px; /* input과 버튼 사이 여백 */
	}
	
	#verificationCode {
		width: 30px;
	}
	
	.error {
		color : red;
	}
	
	#appendId {
	    margin-top: 10px;
	    font-weight: bold;
	    color: green;
	}

</style>
<script>
	$(document).ready(function() {
		
		let isEmailValid = false;
		// 인증코드 발송 버튼 클릭
        $('#sendVerificationBtn').click(function() {
            const email = $('#email').val().trim();
            if (!email) {
                $('#emailError').text('이메일을 입력해주세요.');
                return;
            }
            
            // 이메일 형식 검증
            const emailRegex = /^[\w.-]+@([\w-]+\.)+[\w-]{2,4}$/;
            if (!emailRegex.test(email)) {
                $('#emailError').text('유효한 이메일 형식이 아닙니다.');
                return;
            }
            
            // AJAX 요청
            $.ajax({
                url: 'findId.do',
                type: 'POST',
                data: { email: email },
                dataType: 'json',
                success: function(res) {
                	if (res.success) {
                        $('#appendId').text("찾은 아이디: " + res.findEmail);
                    } else {
                        $('#appendId').text(res.message).css("color", "red");
                    }
                },
                error: function(xhr) {
                	console.log(xhr);
                	alert(xhr.status);
                }
            });
        });
		
	});
</script>
</head>
<body>
	<h6>아이디 찾기</h6>
	<p>회원가입할 때 등록하신 이메일 입력해주세요</p>
	<div class="form-group">
	    <label><span class="required">*</span>이메일</label>
	    <input type="email" name="email" id="email" placeholder="예: user@example.com" required>
	    <button type="button" id="sendVerificationBtn" class="button-inline">메일 인증</button>
		<div id="emailError" class="error"></div>
    </div>
    <div id="appendId"></div>
    
<!--     <div id="verificationSection" class="verification-section"> -->
<!--         <div class="form-group"> -->
<!--             <label for="verificationCode">인증 코드</label> -->
<!--             <div class="email-group"> -->
<!--                 <input type="text" id="verificationCode" placeholder="인증 코드 6자리 입력" required> -->
<!--                 <button type="button" id="verifyCodeBtn" class="btn btn-verify button-inline">확인</button> -->
<!--             </div> -->
<!--         </div> -->
<!--         <div id="verificationResult" class="verification-result"></div> -->
<!--     </div> -->
	
</body>
</html>