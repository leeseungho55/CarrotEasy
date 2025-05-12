<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String status = (String) request.getAttribute("status");
    String msg = request.getParameter("msg");
    if ("needLogin".equals(msg)) {
%>
    <script>
        alert('로그인이 필요합니다.');
    </script>
<%
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <script src="/CarrotEasy/resource/js/jquery-3.7.1.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
/*             background: #f0f2f5; */
			background : black;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            flex-direction: column;
        }
        .title-bar {
            background-color: black;
            color: #FFA500;
            font-size: 2rem;
            font-weight: bold;
            padding: 1rem 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        .login-container {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0px 0px 10px rgba(0,0,0,0.1);
            width: 320px;
            text-align: center;
        }
        .login-container h2 {
            margin-bottom: 1.5rem;
        }
        .login-container input[type="text"],
        .login-container input[type="password"] {
            width: 100%;
            padding: 0.7rem;
            margin-bottom: 1rem;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .login-container input[type="submit"] {
            width: 100%;
            padding: 0.7rem;
            background: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            margin-bottom: 1rem;
            cursor: pointer;
        }
        .extra-links {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 0.5rem;
            flex-wrap: wrap;
        }
        .extra-links button {
            background: none;
            border: none;
            color: #007BFF;
            font-size: 0.9rem;
            cursor: pointer;
            padding: 0;
        }
        .kakao-button {
            background-color: #FEE500;
            color: #3c1e1e;
            font-weight: bold;
            width: 100%;
            padding: 0.7rem;
            border: none;
            border-radius: 5px;
            margin-top: 1rem;
            cursor: pointer;
        }
        #CarrotEasy {
        	width : 50px;
        	height: 50px;
        }
        
        #modal {
		    display: none;
		    width: 450px;
		    max-width: 90%;
		    height: 300px;
		    max-height: 40vh;
		    overflow-y: hidden;
		    overflow-x: hidden;
		    position: fixed;
		    top: 50%;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    background: white;
		    border: 1px solid #ccc;
		    padding: 10px;
		    z-index: 1000;
		    border-radius: 10px;
		}
		
		#modalOverlay {
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100vw;
		    height: 100vh;
		    background-color: rgba(0, 0, 0, 0.3); /* 살짝 어둡게 처리 */
		    z-index: 999; /* 모달보다 아래, 다른 요소보다 위 */
		}
		
		.button-inline {
	        margin-left: 10px;
	        padding: 7px 12px;
	        background: orange;
	        color: white;
	        border: none;
	        border-radius: 4px;
	        cursor: pointer;
	    }
    </style>
    <script  src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script>
	    var status = "<%=status%>";
		if(status === "fail") alert("로그인 실패");
		
		function openModal(page) {
		    // 모달 보이기
		    $('#modal').show();
		    $('#modalOverlay').show();
// 		    document.getElementById('modal').style.display = 'block';
		    
		    // 페이지 내용 불러오기
		    fetch(page)
		        .then(response => response.text())
		        .then(data => {
		        	$('#modalContent').html(data);
		        })
		        .catch(error => {
		            $('#modalContent').html('불러오기 실패!');
		            console.error('오류 발생:', error);
		        });
		}

		function closeModal() {
		    $('#modal').hide();	// 모달창 숨기기
		    $('#modalOverlay').hide();	// 오버레이 숨기기
		    $('#modalContent').html(''); // 내용 비우기
		} 
    
    </script>
</head>
<body>

    <!-- 여기 추가된 부분 -->
    <div class="title-bar">
        당근이지
    	<img src="/CarrotEasy/resource/img/CarrotEasy.png" id="CarrotEasy" alt="CarrotEasy">
    </div>
	<div id="modalOverlay" style="display:none;"></div>
    <form class="login-container" action="login.do" method="post">
        <h2>일반회원 로그인</h2>

        <% 
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) { 
        %>
            <div style="color: red; margin-bottom: 1rem;"><%= errorMessage %></div>
        <% 
            } 
        %>

        <input type="text" name="memId" placeholder="아이디" required>
        <input type="password" name="memPass" placeholder="비밀번호" required>
        <input type="submit" value="로그인">
        
        <!-- 모달 영역 -->
<!-- 		<div id="modal" style="display:none; width:500px; height:500px; position:fixed; top:50%; left:50%; transform:translate(-50%, -50%); background:white; border:1px solid #ccc; padding:20px; z-index:1000;"> -->
			<div id="modal">
		    <div id="modalContent"></div>
		    <button type="button" onclick="closeModal()" class="button-inline">닫기</button>
		</div>

        <div class="extra-links">
            <button type="button" onclick="location.href='register.do'">회원가입</button>
            <button type="button" onclick="openModal('findId.do')">아이디 찾기</button>
            <button type="button" onclick="openModal('findPass.do')">비밀번호 찾기</button>
        </div>

<!--         <button type="button" class="kakao-button" onclick="location.href='https://kauth.kakao.com/oauth/authorize?...'"> -->
<!--             카카오 로그인 -->
<!--         </button> -->
    </form>
</body>
</html>
