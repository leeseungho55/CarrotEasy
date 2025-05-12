<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 등록 완료</title>
    <script type="text/javascript">
        alert("등록되었습니다.");
        if (window.opener) {
            window.opener.location.reload(); // 부모 창 새로고침
        }
        window.close(); // 팝업 닫기
    </script>
</head>
<body></body>
</html>
