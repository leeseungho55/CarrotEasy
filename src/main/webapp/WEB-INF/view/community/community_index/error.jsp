<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>오류 발생</title>
</head>
<body>
    <h2>오류가 발생했습니다.</h2>
    <p>
        <c:if test="${not empty msg}">
            ${msg}
        </c:if>
        <c:if test="${empty msg}">
            알 수 없는 오류입니다.
        </c:if>
    </p>
    <a href="javascript:history.back();">이전 페이지로</a>
</body>
</html>