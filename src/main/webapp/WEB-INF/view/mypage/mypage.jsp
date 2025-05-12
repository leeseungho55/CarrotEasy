<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>마이페이지</title>
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .container {
            max-width: 1180px;
            margin: 8px auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 16px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.08);
            position: relative;
        }
        .mycommunity-btn {
            position: absolute;
            top: 24px;
            left: 32px;
            padding: 7px 18px;
            font-size: 15px;
            background: #FF8A3D;
            color: #fff;
            border: none;
            border-radius: 16px;
            font-weight: 500;
            box-shadow: 0 2px 8px rgba(255,78,80,0.08);
            cursor: pointer;
            transition: background 0.2s;
            z-index: 10;
        }
        .mycommunity-btn:hover {
            background: #e0423f;
        }
        h1 {
            font-size: 28px;
            font-weight: bold;
            color: #333;
            margin-bottom: 40px;
            text-align: center;
        }
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #222;
        }
        .mypage-input {
            width: 100%;
            padding: 12px 15px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            font-size: 15px;
            background-color: #fefefe;
            color: #333;
        }
        .button-group {
            margin-top: 20px;
            display: flex;
            gap: 10px;
        }
        .btn {
            flex: 1;
            padding: 12px;
            font-size: 15px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            font-weight: 500;
            transition: background 0.2s;
        }
        .edit-btn {
            background-color: #FF8A3D;
            color: white;
        }
        .edit-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        .edit-btn:hover {
            background-color: #e0423f;
        }
        .save-btn {
            background-color: #FF8A3D;
            color: white;
        }
        .save-btn:disabled {
        	background-color: #f5c6cb; /* 연한 빨간색 배경 */
		    color: white; /* 연한 빨간색 텍스트 */
		    cursor: not-allowed; /* 커서 모양을 '못 누르는' 형태로 변경 */
		    border: 1px solid #f5c6cb; /* 테두리도 연한 빨간색 */
        }
        .save-btn:hover {
            background-color: #e0423f;
        }
        /* 모달 스타일 */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0; top: 0;
            width: 100vw; height: 100vh;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: #fff;
            margin: 15% auto;
            padding: 30px;
            border-radius: 20px;
            width: 300px;
            text-align: center;
            position: relative;
            box-shadow: 0 6px 24px rgba(0,0,0,0.12);
        }
        .close {
            position: absolute;
            right: 15px;
            top: 10px;
            font-size: 20px;
            cursor: pointer;
            color: #aaa;
        }
        #confirmPassword {
            margin-top: 15px;
            padding: 10px 20px;
            background-color: #FF8A3D;
            color: white;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: 500;
            font-size: 15px;
            transition: background 0.2s;
        }
        #confirmPassword:hover {
            background-color: #e0423f;
        }
        #check-text {
            margin-top: 10px;
            min-height: 18px;
        }
        @media (max-width: 900px) {
            .container {
                padding: 20px;
                max-width: 98vw;
            }
            .mycommunity-btn {
                top: 12px;
                left: 12px;
                font-size: 14px;
                padding: 6px 12px;
            }
            h1 {
                font-size: 22px;
            }
        }
        @media (max-width: 600px) {
            .container {
                padding: 10px;
            }
            .button-group {
                flex-direction: column;
                gap: 8px;
            }
            .mycommunity-btn {
                position: static;
                display: block;
                margin-bottom: 10px;
            }
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script>
    let isPassValid = false;
    
    function checkVaild() {
    	
	    if(!isPassValid) $('#save-btn').prop("disabled", true).css("opacity", "0.5");
	    else $('#save-btn').prop("disabled", false).css("opacity", "1");
	    
    }
        // 기존 JS 그대로
        $(document).ready(function() {
            $("#editBtn").click(function() {
                $("#passwordModal").show();
            });
            $(".close").click(function() {
                $("#passwordModal").hide();
                $("#modalPassword").val("");
                $("#check-text").text("");
            });
            $("#confirmPassword").click(function() {
                var inputPass = $("#modalPassword").val().trim();
                if(inputPass.trim() === "") {
                    $('#check-text').text("비밀번호를 입력하세요.").css('color', 'red');
                    return;
                }
                $.ajax({
                    url: "/CarrotEasy/mypage.do",
                    type: 'post',
                    data: {memPass : inputPass},
                    success: function(res) {
                        if (res.status === "success") {
                            $("#editBtn").prop("disabled", true).css("opacity", "0.5");
                            $("#id").prop("disabled", true);
                            $("#pass").prop("readonly", false);
                            $("#tel").prop("readonly", false);
                            $("#passwordModal").hide();
                            $("#pass").focus();
                            $("#pass").attr("type", "text");
                            $("#editBtn").hide();
                        } else if (res.status === "fail") {
                            $("#check-text").text("비밀번호가 일치하지 않습니다.").css("color", "red");
                        } else if (res.status === "noSession") {
                            alert("로그인이 만료되었습니다. 다시 로그인해주세요.");
                            location.href = "/CarrotEasy/main/main.do";
                        }
                    },
                    error: function(xhr) {
                        console.error(xhr.responseText);
                        alert("오류");
                    }
                });
            });
            
            $('#pass').on('input', function() {
                let password1 = $(this).val();
                let hasUpperCase = /[A-Z]/.test(password1);
                let hasLowerCase = /[a-z]/.test(password1);
                let hasNumbers = /[0-9]/.test(password1);
                let hasSpecial = /[!@#$%^&*(),.?:{}|<>]/.test(password1);
                let typeCount = (hasUpperCase ? 1 : 0) + (hasLowerCase ? 1 : 0) + (hasNumbers ? 1 : 0) + (hasSpecial ? 1 : 0);
                if(password1.length < 8 || password1.length > 16) {
                    $("#pass-result").text("비밀번호는 8~16자 이내로 입력해주세요").css('color', 'red');
                    isPassValid = false;
                } else if(typeCount < 2) {
                    $("#pass-result").text("영문 대소문자/숫자/특수문자 중 2가지 이상을 조합해주세요").css('color', 'red');
                    isPassValid = false;
                } else {
                    $("#pass-result").text("사용 가능한 비밀번호 형식입니다").css('color', 'blue');
                    isPassValid = true;
                }
                checkVaild();
            });
            
            $('#tel').on('input', function() {
                let tel = $(this).val();
                tel = tel.replace(/[^0-9\-]/g, ''); 
                if(tel.length > 13) {
                    tel = tel.substring(0, 13);
                }
                $(this).val(tel);
            });
        });
    </script>
</head>
<body>
<div class="container">
    <c:if test="${not empty sessionScope.admember}">
		<button type="button" class="mycommunity-btn" onclick="alert('일반사용자만 사용할 수 있습니다.')">마이 커뮤니티</button>
	</c:if>
	<c:if test="${empty sessionScope.admember}">
		<button type="button" class="mycommunity-btn" onclick="location.href='/CarrotEasy/MyCommunity.do'">마이 커뮤니티</button>
	</c:if>
    <h1>마이페이지</h1>
    <form action="/CarrotEasy/mypageUpdate.do" method="POST">
        <c:choose>
            <c:when test="${not empty member}">
                <label for="id">아이디</label>
                <input type="text" class="mypage-input" id="id" name="id" value="${member.memId}" readonly>
                <label for="pass">비밀번호</label>
                <input type="password" class="mypage-input" id="pass" name="pass" value="${member.memPass}" readonly>
                <div id="pass-result"></div>
                <label for="tel">전화번호</label>
                <input type="text" class="mypage-input" id="tel" name="tel" value="${member.memTel}" readonly>
                <div id="tel-result"></div>
            </c:when>
            <c:when test="${not empty admember}">
                <label for="id">아이디</label>
                <input type="text" class="mypage-input" id="id" name="id" value="${admember.amemId}" readonly>
                <label for="pass">비밀번호</label>
                <input type="password" class="mypage-input" id="pass" name="pass" value="${admember.amemPass}" placeholder="영문소문자/숫자, 4~16자" readonly>
                <div id="pass-result"></div>
                <label for="tel">전화번호</label>
                <input type="text" class="mypage-input" id="tel" name="tel" value="${admember.amemTel}" placeholder="010-0000-0000" readonly>
                <div id="tel-result"></div>
            </c:when>
        </c:choose>
        <div class="button-group">
            <button type="button" class="btn edit-btn" id="editBtn">수정하기</button>
            <button type="submit" class="btn save-btn" id="save-btn">저장하기</button>
        </div>
        <input type="hidden" id="memId" name="memId" value="${member.memId}">
        <input type="hidden" id="amemId" name="amemId" value="${admember.amemId}">
    </form>
    <!-- 비밀번호 입력 모달 -->
    <div id="passwordModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <h3>비밀번호 입력</h3>
            <input type="password" class="mypage-input" id="modalPassword" placeholder="비밀번호 입력" style="width: 100%; padding: 10px; margin-top: 15px; border-radius: 10px; border: 1px solid #ccc;">
            <div id="check-text"></div>
            <button id="confirmPassword">확인</button>
        </div>
    </div>
</div>
</body>
</html>
