<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 선택</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            background-color: white;
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: Arial, sans-serif;
        }

        .container {
            display: flex;
            gap: 30px; /* 버튼 사이 간격 */
        }

        .card {
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

        .card:hover {
            background-color: #d3d3d3;
            transform: translateY(-5px); /* 살짝 띄우는 효과 */
        }
    </style>
    <script>
        function login(type) {
            if (type === 'user') {
                location.href = '/CarrotEasy/login.do';  // 일반회원 로그인 페이지
            } else if (type === 'ad') {
                location.href = '/CarrotEasy/adLogin.do';    // 광고주 로그인 페이지
            }
        }
    </script>
</head>
<body>

<div class="container">
    <div class="card" onclick="login('user')">
        일반회원 로그인
    </div>
    <div class="card" onclick="login('ad')">
        광고주 로그인
    </div>
</div>

</body>
</html>
