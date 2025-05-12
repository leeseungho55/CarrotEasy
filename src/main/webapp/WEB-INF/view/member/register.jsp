<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #f9f9f9;
            padding: 30px;
        }

        .container {
            width: 800px;
            margin: 0 auto;
            background: #fff;
            padding: 20px;
            border: 1px solid orange;
            border-radius: 8px;
        }

        h3 {
            text-align: center;
            margin-bottom: 20px;
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .form-group label {
            width: 120px;
            font-weight: bold;
        }

        .form-group input,
        .form-group select {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .form-group .subtext {
            font-size: 12px;
            color: #888;
            margin-left: 10px;
        }

        .form-group .button-inline {
            margin-left: 10px;
            padding: 7px 12px;
            background: orange;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .form-group .radio-group {
            display: flex;
            gap: 15px;
            align-items: center;
        }

        .form-group .radio-group label {
            font-weight: normal;
        }

        .form-group.address input {
            margin-bottom: 5px;
        }

        .submit-btn {
            width: 100%;
            padding: 12px;
            background-color: orange;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            margin-top: 20px;
            cursor: pointer;
        }
        
        .submit-btn:disabled {
		    background-color: #f5c6cb; /* 연한 빨간색 배경 */
		    color: white; /* 연한 빨간색 텍스트 */
		    cursor: not-allowed; /* 커서 모양을 '못 누르는' 형태로 변경 */
		    border: 1px solid #f5c6cb; /* 테두리도 연한 빨간색 */
		}

        .required {
            color: red;
            margin-right: 5px;
        }
        
        .valid-text {
		    margin: -10px 0 10px 140px;
		    font-size: 12px;
		    min-height: 16px;
		    color: red;
		}

		.home-btn {
            width: 100%;
            padding: 12px;
            background-color: orange;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 16px;
            margin-top: 20px;
            cursor: pointer;
		}

		
		
    </style>
    <script  src="https://code.jquery.com/jquery-latest.min.js"></script>
    
	<!-- 우편번호 api -->
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    
    <script>
    let isIdValid = false; // 아이디 유효성 확인 변수 추가
    let isPasswordMatch = false; // 비밀번호 일치 확인 변수 추가
    let isNickValid = false; // 닉네임 유효성 확인 변수 추가
    let isEmailValid = false; // 이메일 유효성 확인 변수 추가
    let isTel = false; // 전화번호 앞자리 확인 변수 추가
    let isEmailVerifiedValid = false;  // 이메일 api 검증
    
    // 폼 validation 체크
    function checkFormValidity() {
        let allFilled = true;

        // 필수 입력값 확인
        $("input[required], select[required]").each(function () {
            if ($(this).val().trim() === "") {
                allFilled = false;
            }
        });

     	// 이메일 유효성 검사
        let email = $("#email").val().trim();
        let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        isEmailValid = emailRegex.test(email);

        if (!isEmailValid && email !== "") {
            $("#email-result").text("유효한 이메일 주소를 입력해주세요").css('color', 'red');
        } else {
            $("#email-result").text("");
        }
        
        
        // 연락처 입력 확인
        let tel2 = $("#tel2").val().trim();
        let tel3 = $("#tel3").val().trim();
        let isTelValid = tel2.length >= 3 && tel3.length === 4;

        if (!isTelValid && (tel2 !== "" || tel3 !== "")) {
            console.log("전화번호 자릿수가 부족합니다.");
        }

        if (
            allFilled &&
            isIdValid &&
            isPasswordMatch &&
            isEmailValid &&
            isTelValid &&
            isEmailVerifiedValid

        ) {
            $(".submit-btn").prop("disabled", false);
        } else {
            $(".submit-btn").prop("disabled", true);
        }
    }
    
   	function home() {
   		location.href = "login.do";
   	}
    
    // 우편번호 api function()
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 우편번호와 도로명 주소만 채워넣기
                document.getElementById('postcode').value = data.zonecode;
                document.getElementById('roadAddress').value = data.roadAddress;
                
                // 상세주소는 사용자가 직접 입력
                document.getElementById('detailAddress').focus();
            }
        }).open();
    }
    	
    	$(document).ready(function() {
    		
    		// 아이디 중복확인
    		$('#check-id-btn').on('click', function() {
    			let userId = $("input[name='id']").val().trim();
    			
    			$.ajax({
    				url : "/CarrotEasy/duplicateId.do",
    				method : "post",
    				data : {memId : userId},
    				success: function(isDuplicated) {
    	                if(isDuplicated === "true") {
    	                    $("#id-result").text("이미 사용 중인 아이디입니다").css('color', 'red');
    	                    isIdValid = false;
    	                } else {
    	                    $("#id-result").text("사용 가능한 아이디입니다").css('color', 'blue');
    	                    isIdValid = true;
    	                }
    	                checkFormValidity();
    	            },
    	            error: function(error) {
    	                console.log(error.responseText);
    	                $("#id-result").text("아이디 중복 확인 중 오류가 발생했습니다").css('color', 'red');
    	                isIdValid = false;
    	                checkFormValidity();
    	            }
    			});
    			
    		});
    		
    		// 비밀번호 형식 검사
    		$('#password').on('input', function() {
    			let password = $(this).val();
    	        // 영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8~16자
    	        let hasUpperCase = /[A-Z]/.test(password);
    	        let hasLowerCase = /[a-z]/.test(password);
    	        let hasNumbers = /[0-9]/.test(password);
    	        let hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);
    	        
    	        let typeCount = (hasUpperCase ? 1 : 0) + (hasLowerCase ? 1 : 0) + 
    	                        (hasNumbers ? 1 : 0) + (hasSpecial ? 1 : 0);
    	        
    	        if(password.length < 8 || password.length > 16) {
    	            $("#password-format-result").text("비밀번호는 8~16자 이내로 입력해주세요").css('color', 'red');
    	        } else if(typeCount < 2) {
    	            $("#password-format-result").text("영문 대소문자/숫자/특수문자 중 2가지 이상을 조합해주세요").css('color', 'red');
    	        } else {
    	            $("#password-format-result").text("사용 가능한 비밀번호 형식입니다").css('color', 'blue');
    	        }
    	        
    	        // 비밀번호 확인란도 함께 체크
    	        if($("#confirm-password").val() !== "") {
    	            $("#confirm-password").trigger("input");
    	        }
    			
    		});
    		
    		// 비밀번호 일치 확인
    	    $("#password, #confirm-password").on("input", function() {
    	        let password = $("#password").val();
    	        let confirmPassword = $("#confirm-password").val();
    	        
    	        if(confirmPassword === "") {
    	            $("#password-result").text("");
    	            isPasswordMatch = false;
    	        } else if(password !== confirmPassword) {
    	            $("#password-result").text("비밀번호가 일치하지 않습니다").css('color', 'red');
    	            isPasswordMatch = false;
    	        } else {
    	            $("#password-result").text("비밀번호가 일치합니다").css('color', 'blue');
    	            isPasswordMatch = true;
    	        }
    	        
    	        checkFormValidity();
    	    });
    		
    		// 닉네임 중복확인
    		$('#check-nick-btn').on('click', function() {
				let userNick = $("input[name='nick']").val().trim();
    			
    			$.ajax({
    				url : "/CarrotEasy/duplicateNick.do",
    				method : "post",
    				data : {memNick : userNick},
    				success: function(isDuplicated) {
    	                if(isDuplicated === "true") {
    	                    $("#nick-result").text("이미 사용 중인 닉네임 입니다").css('color', 'red');
    	                    isNickValid = false;
    	                } else {
    	                    $("#nick-result").text("사용 가능한 닉네임 입니다").css('color', 'blue');
    	                    isNickValid = true;
    	                }
    	                checkFormValidity();
    	            },
    	            error: function(error) {
    	                console.log(error.responseText);
    	                $("#nick-result").text("닉네임 중복 확인 중 오류가 발생했습니다").css('color', 'red');
    	                isNickValid = false;
    	                checkFormValidity();
    	            }
    			});
    			
    		});
    		
    		$('#nick').on('input', function() {
    			let nick = $(this).val();
    			
    			if(nick.length > 10) {
    				$("#nick-result").text("글자 수 초과").css('color', 'red');
    				$("#nick").val("");
    			}
    		});
    		
    		// 아이디 변경 시 중복 확인 상태 초기화
    	    $("input[name='id']").on("input", function() {
    	        $("#id-result").text("");
    	        isIdValid = false;
    	        checkFormValidity();
    	    });
    		
    	    $("input, select").on("input change", function () {
    	        checkFormValidity();
    	    });
    		
    		$('#selectTel').on('click', function() {
    			if($(this).val() != 0) isTel = true;
    			
    		});
    		
    		$("#tel2, #tel3").on("input", function () {
    	        checkFormValidity();
    	    });
    		
    		
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
                        	isEmailVerifiedValid = true;
                        	checkFormValidity();
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
            $('#joinForm').on('submit', function(e) {
                e.preventDefault();
                
             	// 모든 유효성 조건이 만족하는지 마지막 확인
                if (!isIdValid || !isPasswordMatch || !isNickValid) {
                    alert("모든 항목을 올바르게 입력해주세요.");
                    return;
                }
             	
             	// 이메일 유효성도 다시 체크 (혹시나 중간에 수동으로 변경한 경우)
                let email = $("#email").val().trim();
                let emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    alert("유효한 이메일 주소를 입력해주세요.");
                    return;
                }
                
             	// 전화번호 조합
             	let tel1 = $('#tel1').val();
                let tel2 = $('#tel2').val();
                let tel3 = $('#tel3').val();
                let fullTel = tel1 + tel2 + tel3;
                
                // hidden input에 값 세팅
                $('#memTel').val(fullTel);
                
                
                // AJAX로 폼 데이터 전송
                $.ajax({
                    url: "/CarrotEasy/join.do",
                    type: 'POST',
//                     data: JSON.stringify(formData),
                    data: $(this).serialize(),
                    dataType: 'json',
                    success: function(res) {
                    	alert("회원가입이 완료됐습니다.");
                        window.location.href = "/CarrotEasy/login.do";
                    },
                    error: function(xhr) {
                    	console.error(xhr.responseText);
                    	alert("회원가입 중 오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
    		
    		
    		
    	});	//$(document).ready(function) 끝
    
    </script>
</head>
<body>
    <div class="container">
        <h3>회원가입</h3>
        <form id="joinForm" action="join.do" method="post">
            <div class="form-group">
                <label><span class="required">*</span>아이디</label>
                <input type="text" placeholder="영문소문자/숫자, 4~16자" name="id" required>
                <button type="button" class="button-inline" id="check-id-btn">중복확인</button>
            </div>
                <p class="valid-text" id="id-result"></p>

            <div class="form-group">
                <label><span class="required" >*</span>비밀번호</label>
                <input type="password" id="password" placeholder="영문 대소문자/숫자/특수문자 중 2가지 이상 조합, 8~16자" name="pass" required>
            </div>
            <p class="valid-text" id="password-format-result"></p>

            <div class="form-group">
                <label><span class="required">*</span>비밀번호 확인</label>
                <input type="password" id="confirm-password" required>
            </div>
            <p class="valid-text" id="password-result"></p>

            <div class="form-group">
                <label><span class="required">*</span>닉네임</label>
                <input type="text" placeholder="최대 10자 가능" name="nick" id="nick"
                oninput="this.value = this.value.replace(/[!@#$%^&*(),.?:{}|<>_=+-]/g, '');" required>
                <button type="button" class="button-inline" id="check-nick-btn">중복확인</button>
            </div>
            <p class="valid-text" id="nick-result"></p>

            <div class="form-group">
                <label><span class="required">*</span>전화번호</label>
                <select id="tel1" required>
                	<option value="010">010</option>
                </select>
                <input type="text" inputmode="numeric" maxlength="4" name="tel2" id="tel2" 
				       style="width: 30%; margin-left: 5px;" placeholder="0000"
				       oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 4);" required> 
				
				<input type="text" inputmode="numeric" maxlength="4" name="tel3" id="tel3" 
				       style="width: 30%; margin-left: 5px;" placeholder="0000"
				       oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 4);" required>
            </div>
            <p class="valid-text" id="tel-result"></p>
            
            <div class="form-group address">
                <label><span class="required">*</span>주소</label>
                <div style="flex: 1;">
                    <input type="text" id="postcode" name="postcode" placeholder="우편번호" readonly>
					<input type="button" onclick="execDaumPostcode()" value="우편번호 찾기" class="button-inline">
					<input type="text" id="roadAddress" name="roadAddress" placeholder="도로명주소" readonly>
					<input type="text" id="detailAddress" name="detailAddress" placeholder="상세주소(선택)">
                </div>
            </div>

            <div class="form-group">
                <label><span class="required">*</span>이메일</label>
                <input type="email" name="email" id="email" placeholder="예: user@example.com" required>
                <button type="button" id="sendVerificationBtn" class="button-inline">인증코드전송</button>
				<div id="emailError" class="error"></div>
            </div>
            
            <div id="verificationSection" class="verification-section">
                <div class="form-group">
                    <label for="verificationCode">인증 코드</label>
                    <div class="email-group">
                        <input type="text" id="verificationCode" placeholder="인증 코드 6자리 입력" required>
                        <button type="button" id="verifyCodeBtn" class="button-inline">확인</button>
                    </div>
                </div>
                <div id="verificationResult" class="verification-result"></div>
            </div>

            <!-- <div class="form-group">
                <label><span class="required">*</span>프로필 이미지</label>
                <input type="file" name="profileImage" accept="image/*"><br>
    			<img id="preview" src="" alt="미리보기" style="width: 100px; height: 100px; display:none; object-fit: cover;">
            </div>
            <p class="valid-text" id="nick-result"></p> -->
            
            <button type="submit" class="submit-btn" disabled>회원가입</button>
            <div id="registerResult"></div>
            <input type="hidden" name="memTel" id="memTel">
        </form>
        <button type="button" onclick="home()" class="home-btn">홈</button>
    </div>
</body>
</html>

