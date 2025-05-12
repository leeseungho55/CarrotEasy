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
            width: 600px;
            margin: 0 auto;
            background: #fff;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        h2 {
            text-align: center;
            margin-bottom: 25px;
        }

        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        .form-group label {
            width: 140px;
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
            background: #e60023;
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
		
		.valid-text {
		    margin: -10px 0 10px 140px;
		    font-size: 12px;
		    min-height: 16px;
		    color: red;
		}

        .submit-btn {
            width: 100%;
            padding: 12px;
            background-color: #e60023;
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
    </style>
</head>
<script  src="https://code.jquery.com/jquery-latest.min.js"></script>
<script>
let isRegNoValied = false;
let isIdValid = false; // 아이디 유효성 확인 변수 추가
let isPasswordMatch = false; // 비밀번호 일치 확인 변수 추가
let isEmailValid = false; // 이메일 유효성 확인 변수 추가
   
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
        isRegNoValied &&
        isIdValid &&
        isPasswordMatch &&
        isEmailValid &&
        isTelValid
    ) {
        $(".submit-btn").prop("disabled", false);
    } else {
        $(".submit-btn").prop("disabled", true);
    }
}

$(document).ready(function () {
	
    let timeoutId;
    
 	// 아이디 중복 확인 이벤트
    $("#check-id-btn").on("click", function() {
        let userId = $("input[name='id']").val().trim();
        
        if(userId === "") {
            $("#id-result").text("아이디를 입력하세요").css('color', 'red');
            isIdValid = false;
            checkFormValidity();
            return;
        }
        
        // 아이디 형식 검사 (영문소문자/숫자, 4~16자)
        let idRegex = /^[a-z0-9]{4,16}$/;
        if(!idRegex.test(userId)) {
            $("#id-result").text("아이디는 영문소문자/숫자, 4~16자만 가능합니다").css('color', 'red');
            isIdValid = false;
            checkFormValidity();
            return;
        }
        
        // AJAX로 아이디 중복 검사
        $.ajax({
            url: "/CarrotEasy/join/duplicateId",
            type: "POST",
            data: {amemId: userId},
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
    
    // 비밀번호 형식 검사
    $("#password").on("input", function() {
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
 	
 	// 아이디 변경 시 중복 확인 상태 초기화
    $("input[name='id']").on("input", function() {
        $("#id-result").text("");
        isIdValid = false;
        checkFormValidity();
    });
    
    //사업자등록번호 유효성 검사
    $("#reg_no").on("blur", function () {
        if ($(this).val() === "") {
            $("#regNo-result").text("사업자등록번호를 입력하세요").css('color', 'red');
            isRegNoValied = false;
            checkFormValidity();
        }
    });
    
    $("#reg_no").on("keyup", function () {
        var inputValue = $(this).val();
    
        clearTimeout(timeoutId);
    
        timeoutId = setTimeout(function() {
            if (isNaN(inputValue)) {
                $("#regNo-result").text("사업자번호는 숫자만 입력하세요").css('color', 'red');
                isRegNoValied = false;
                checkFormValidity();
            } else if(inputValue.length !== 10) {  // 수정: length 오타 수정 및 조건 간소화
                $("#regNo-result").text("사업자번호 자릿수가 맞지 않습니다").css('color', 'red')
                isRegNoValied = false;
                checkFormValidity();
            } else if (inputValue.length === 10) {
                $("#regNo-result").text("");
                checkBusinessNoStatus(inputValue);
            }
        }, 500);
    });
    
    $("input, select").on("input change", function () {
        checkFormValidity();
    });
    
    $("#tel2, #tel3").on("input", function () {
        checkFormValidity();
    });
    
    // 회원가입 버튼 클릭 시 Ajax 요청
    $("#join-form").on("submit", function (e) {
        e.preventDefault(); // 기본 form 제출 막기

        // 모든 유효성 조건이 만족하는지 마지막 확인
        if (!isRegNoValied || !isIdValid || !isPasswordMatch) {
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
        let tel1 = $("select[name='tel']").val() || $("select").val();
        let tel2 = $('#tel2').val();
        let tel3 = $('#tel3').val();
        let fullTel = tel1 + "-" + tel2 + "-" + tel3;

        // 데이터 수집
        const formData = {
            amemId: $("input[name='id']").val().trim(),
            amemPass: $("input[name='pass']").val(),
            amemEmail: email,
            amemCompany: $("input[name='company']").val().trim(),
            amemRegNo: $("#reg_no").val().trim(),
            amemTel: fullTel
        };

        // Ajax 요청
        $.ajax({
            url: "/CarrotEasy/admemberJoin.do",
            type: "POST",
            data: JSON.stringify(formData),
            contentType: "application/json",
            success: function (res) {
                alert(res.flag);
                // window.location.href = "/CarrotEasy/login"; // 성공 후 메인? 페이지로 이동 등
            },
            error: function (xhr) {
                console.error(xhr.responseText);
                alert("회원가입 중 오류가 발생했습니다. 다시 시도해주세요.");
            }
        });
    });
});

//사업자등록번호 상태조회 함수
function checkBusinessNoStatus(regNo) {
    $.ajax({
        url: "/CarrotEasy/join/duplicateRegNo",
        type: "POST",
        data: {regNo: regNo},
        success: function (isDuplicated) {
            if (isDuplicated === "true") {
                $("#regNo-result").text("이미 사용 중인 사업자번호입니다").css('color', 'red');
                isRegNoValied = false;
                checkFormValidity();  // 추가: 상태 변경 후 폼 유효성 검사
            } else {
                var data = {
                    "b_no": [regNo]
                };

                $.ajax({
                    url: "https://api.odcloud.kr/api/nts-businessman/v1/status?serviceKey=7pDwW%2FHAxHnpqtRMHNPWXDIjFzTV%2FLPEHbTiM%2BZVMBvrIPRO5t9WeXF76dCyWr1Ee3qCSYYrB4eyL1ayzfQKVA%3D%3D",
                    type: "POST",
                    data: JSON.stringify(data),
                    dataType: "JSON",
                    contentType: "application/json",
                    accept: "application/json",
                    success: function (result) {
                        var taxType = result.data[0].tax_type;

                        if (taxType === "국세청에 등록되지 않은 사업자등록번호입니다.") {
                            $("#regNo-result").text(taxType).css('color', 'red');
                            isRegNoValied = false;
                        } else {
                            $("#regNo-result").text("유효한 사업자등록번호입니다.").css('color', 'blue');
                            isRegNoValied = true;
                        }
                        checkFormValidity();  // 상태 변경 후 폼 유효성 검사
                    },
                    error: function (result) {
                        console.log(result.responseText);
                        isRegNoValied = false;  // 추가: 오류 발생 시 유효하지 않음으로 처리
                        checkFormValidity();  // 추가: 상태 변경 후 폼 유효성 검사
                    }
                });
            }
        },
        error: function (error) {
            console.log(error.responseText);
            isRegNoValied = false;  // 추가: 오류 발생 시 유효하지 않음으로 처리
            checkFormValidity();  // 추가: 상태 변경 후 폼 유효성 검사
        }
    });
}
</script>
<body>
    <div class="container">
        <h2>기본정보</h2>
        <form id="join-form">
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
			    <label for="reg_no"><span class="required">*</span>사업자등록번호</label>
			    <input type="text" id="reg_no" name="regNo" required>
			</div>
			<p class="valid-text" id="regNo-result"></p>

            <div class="form-group">
                <label><span class="required">*</span>이메일</label>
                <input type="email" placeholder="예: user@example.com" id="email" name="email" required>
            </div>
            <p class="valid-text" id="email-result"></p>       
            
            <div class="form-group">
                <label><span class="required">*</span>회사명</label>
                <input type="text" name="company" required>
            </div>

            <div class="form-group">
                <label><span class="required">*</span>연락처</label>
                <select name="tel">
                    <option>010</option>
                    <option>02</option>
                    <option>031</option>
                    <option>032</option>
                    <option>033</option>
                    <option>041</option>
                    <option>042</option>
                    <option>043</option>
                    <option>051</option>
                    <option>052</option>
                    <option>053</option>
                    <option>054</option>
                    <option>055</option>
                    <option>061</option>
                    <option>062</option>
                    <option>063</option>
                    <option>064</option>
                    <option>070</option>
                </select>
				<input type="text" inputmode="numeric" maxlength="4" id="tel2"
				       style="width: 30%; margin-left: 5px;" placeholder="0000"
				       oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 4);">
				
				<input type="text" inputmode="numeric" maxlength="4" id="tel3"
				       style="width: 30%; margin-left: 5px;" placeholder="0000"
				       oninput="this.value = this.value.replace(/[^0-9]/g, '').slice(0, 4);">
            </div>

            <button type="submit" class="submit-btn" disabled>회원가입</button>
        </form>
    </div>
</body>
</html>

