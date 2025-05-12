<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .container {
            max-width: 600px;
            margin: 0 auto;
            padding: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-group input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .email-group {
            display: flex;
            gap: 10px;
        }
        .email-group input {
            flex: 1;
        }
        .btn {
            padding: 10px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .btn-verify {
            background-color: #2196F3;
        }
        .verification-section {
            margin-top: 10px;
            display: none;
        }
        .verification-result {
            margin-top: 5px;
            font-weight: bold;
        }
        .success {
            color: green;
        }
        .error {
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>회원가입</h1>
        
        <form id="registerForm" method="post" action="${pageContext.request.contextPath}/register">
            <!-- 이메일 인증 섹션 -->
            <div class="form-group">
                <label for="email">이메일</label>
                <div class="email-group">
                    <input type="email" id="email" name="email" required>
                    <button type="button" id="sendVerificationBtn" class="btn btn-verify">인증코드 발송</button>
                </div>
                <div id="emailError" class="error"></div>
            </div>
            
            <div id="verificationSection" class="verification-section">
                <div class="form-group">
                    <label for="verificationCode">인증 코드</label>
                    <div class="email-group">
                        <input type="text" id="verificationCode" placeholder="인증 코드 6자리 입력">
                        <button type="button" id="verifyCodeBtn" class="btn btn-verify">확인</button>
                    </div>
                </div>
                <div id="verificationResult" class="verification-result"></div>
            </div>
            
            <!-- 나머지 회원정보 입력 필드들 -->
            <div class="form-group">
                <label for="id">아이디</label>
                <input type="text" id="id" name="id" required>
            </div>
            
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" id="password" name="password" required>
            </div>
            
            <div class="form-group">
                <label for="confirmPassword">비밀번호 확인</label>
                <input type="password" id="confirmPassword" required>
            </div>
            
            <div class="form-group">
                <label for="name">이름</label>
                <input type="text" id="name" name="name" required>
            </div>
            
            <div class="form-group">
                <label for="phone">연락처</label>
                <input type="tel" id="phone" name="phone" required>
            </div>
            
            <div class="form-group">
                <label for="address">주소</label>
                <input type="text" id="address" name="address" required>
            </div>
            
            <div class="form-group">
                <button type="submit" id="registerBtn" class="btn" disabled>회원가입</button>
            </div>
            
            <div id="registerResult"></div>
        </form>
    </div>

    <script>
        $(document).ready(function() {
            let emailVerified = false;
            
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
                
                $('#emailError').text('');
                $(this).prop('disabled', true).text('발송 중...');
                
                // AJAX 요청
                $.ajax({
                    url: '${pageContext.request.contextPath}/sendVerificationCode',
                    type: 'POST',
                    data: { email: email },
                    dataType: 'json',
                    success: function(response) {
                        $('#sendVerificationBtn').prop('disabled', false).text('인증코드 발송');
                        
                        if (response.success) {
                            $('#verificationSection').show();
                            $('#verificationResult').removeClass('error').addClass('success').text(response.message);
                        } else {
                            $('#emailError').text(response.message);
                        }
                    },
                    error: function() {
                        $('#sendVerificationBtn').prop('disabled', false).text('인증코드 발송');
                        $('#emailError').text('서버 오류가 발생했습니다. 잠시 후 다시 시도해주세요.');
                    }
                });
            });
            
            // 인증코드 확인 버튼 클릭
            $('#verifyCodeBtn').click(function() {
                const code = $('#verificationCode').val().trim();
                if (!code) {
                    $('#verificationResult').removeClass('success').addClass('error').text('인증 코드를 입력해주세요.');
                    return;
                }
                
                $(this).prop('disabled', true).text('확인 중...');
                
                // AJAX 요청
                $.ajax({
                    url: '${pageContext.request.contextPath}/verifyCode',
                    type: 'POST',
                    data: { code: code },
                    dataType: 'json',
                    success: function(response) {
                        $('#verifyCodeBtn').prop('disabled', false).text('확인');
                        
                        if (response.success) {
                            emailVerified = true;
                            $('#verificationResult').removeClass('error').addClass('success').text(response.message);
                            $('#email').prop('readonly', true);
                            $('#sendVerificationBtn').prop('disabled', true);
                            $('#verificationCode').prop('readonly', true);
                            $('#verifyCodeBtn').prop('disabled', true);
                            $('#registerBtn').prop('disabled', false);
                        } else {
                            $('#verificationResult').removeClass('success').addClass('error').text(response.message);
                        }
                    },
                    error: function() {
                        $('#verifyCodeBtn').prop('disabled', false).text('확인');
                        $('#verificationResult').removeClass('success').addClass('error').text('서버 오류가 발생했습니다.');
                    }
                });
            });
            
            // 회원가입 폼 제출
            $('#registerForm').submit(function(e) {
                e.preventDefault();
                
                if (!emailVerified) {
                    $('#registerResult').text('이메일 인증이 필요합니다.').addClass('error');
                    return;
                }
                
                const password = $('#password').val();
                const confirmPassword = $('#confirmPassword').val();
                
                if (password !== confirmPassword) {
                    $('#registerResult').text('비밀번호가 일치하지 않습니다.').addClass('error');
                    return;
                }
                
                // AJAX로 폼 데이터 전송
                $.ajax({
                    url: $(this).attr('action'),
                    type: 'POST',
                    data: $(this).serialize(),
                    dataType: 'json',
                    success: function(response) {
                        if (response.success) {
                            $('#registerResult').removeClass('error').addClass('success').text(response.message);
                            // 로그인 페이지로 리다이렉트
                            setTimeout(function() {
                                window.location.href = response.redirect;
                            }, 2000);
                        } else {
                            $('#registerResult').removeClass('success').addClass('error').text(response.message);
                        }
                    },
                    error: function() {
                        $('#registerResult').removeClass('success').addClass('error').text('서버 오류가 발생했습니다.');
                    }
                });
            });
        });
    </script>
</body>
</html>