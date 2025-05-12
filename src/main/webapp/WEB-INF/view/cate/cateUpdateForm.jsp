<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head><title>카테고리 수정</title></head>
<body>
    <h1>카테고리 수정</h1>
    
    <form action="/CarrotEasy/cate/update.do" method="post">
        <input type="hidden" name="cateNo" value="${cate.cateNo}" />

        <label for="cateName">카테고리 이름:</label>
        <input type="text" id="cateName" name="cateName" value="${cate.cateName}" required /><br><br>

        <label for="cateParentNo">상위 카테고리 (선택):</label>
        <select id="cateParentNo" name="cateParentNo">
            <option value="">선택</option>
            <c:forEach items="${cateList}" var="c">
                <c:if test="${c.cateNo != cate.cateNo}">
                    <option value="${c.cateNo}" ${c.cateNo == cate.cateParentNo ? 'selected' : ''}>${c.cateName}</option>
                </c:if>
            </c:forEach>
        </select><br><br>

        <button type="submit">수정</button>
    </form>

    <a href="/CarrotEasy/cate/list.do">목록으로</a>
</body>
</html>
