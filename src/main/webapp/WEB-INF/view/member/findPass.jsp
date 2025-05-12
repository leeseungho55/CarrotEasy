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
	
	#sendId:disabled {
	    background-color: silver; /* 연한 빨간색 배경 */
	    color: white; /* 연한 빨간색 텍스트 */
	    cursor: not-allowed; /* 커서 모양을 '못 누르는' 형태로 변경 */
	    border: 1px solid silver; /* 테두리도 연한 빨간색 */
	}

</style>
<script>
	$(document).ready(function() {
		
		let isEmailValid = false;
		
     	$('#sendId').on('click', function() {
     		
     		const memId = $('#id').val().trim();
            if (!memId) {
                $('#idError').text('아이디를 입력해주세요.');
                return;
            }
            
            // AJAX 요청
            $.ajax({
                url: 'findPass.do',
                type: 'POST',
                data: { memId: memId },
                dataType: 'json',
                success: function(res) {
                	if (res.success) {
                        $('#appendEmail').text(res.findEmail + "으로 이메일 발송");
                        
                     // AJAX 요청
                        $.ajax({
                            url: '${pageContext.request.contextPath}/sendVerificationCodePass',
                            type: 'POST',
                            data: { email: res.findEmail },
                            dataType: 'json',
                            success: function(res) {
                                $('#id').prop('readonly', true);	// 입력창 비활성화 (수정불가)
                                $('#sendId').prop('disabled', true);	// 버튼 비활성화
                            },
                            error: function(xhr) {
                                console.log(xhr);
                                alert(xhr.status);
                            }
                        });
                     
                    } else {
                        $('#appendEmail').text(res.message).css("color", "red");
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
	<h6>비밀번호 찾기</h6>
	<p>회원가입할 때 등록하신 아이디를 입력해주세요</p>
	<div class="form-group">
	    <label><span class="required"></span>아이디</label>
	    <div class="email-group">
	    <input type="text" name="id" id="id" placeholder="아이디 입력" required>
	    <button type="button" id="sendId" class="button-inline">검색</button>
	    </div>
<!-- 	    <button type="button" id="sendVerificationBtn" class="button-inline">메일 인증</button> -->
		<div id="idError" class="error"></div>
    </div>
    <div id="appendEmail"></div>
    
	
</body>
</html>