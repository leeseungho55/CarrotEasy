<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>카테고리 등록</title>
</head>
<body>
    <h1>새 카테고리 등록</h1>
    
    <form action="/CarrotEasy/cate/insert.do" method="post">
        <label for="cateName">카테고리 이름:</label>
        <input type="text" id="cateName" name="cateName" required /><br><br>

        <label for="cateParentNo">상위 카테고리 (선택사항):</label>
        <select id="cateParentNo" name="cateParentNo">
            <option value="">선택</option>
            <c:forEach items="${cateList}" var="cate">
                <option value="${cate.cateNo}">${cate.cateName}</option>
            </c:forEach>
        </select><br><br>
        
        <button type="submit">등록</button>
    </form>
    
    <a href="/CarrotEasy/cate/list.do">카테고리 목록으로 돌아가기</a>
</body>
</html>
