<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>카테고리 목록</title>
    <script>
        function confirmDelete(cateNo) {
            if (confirm("정말로 이 카테고리를 삭제하시겠습니까?")) {
                location.href = '/CarrotEasy/cate/delete.do?cateNo=' + cateNo;
            }
        }
    </script>
</head>
<body>
    <h1>카테고리 목록</h1>
    
    <a href="/CarrotEasy/cate/insert.do">새 카테고리 추가</a>
    
    <table border="1">
        <thead>
            <tr>
                <th>카테고리 번호</th>
                <th>카테고리 이름</th>
                <th>상위 카테고리</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
        </thead>
        <tbody>
            <!-- 상위 카테고리들 출력 -->
            <c:forEach items="${cateList}" var="cate">
                <!-- 상위 카테고리 -->
                <tr>
                    <td>${cate.cateNo}</td>
                    <td>${cate.cateName}</td>
                    <td>${cate.cateParentNo != null ? cate.cateParentNo : "없음"}</td>
                    <td><a href="/CarrotEasy/cate/update.do?cateNo=${cate.cateNo}">수정</a></td>
                    <td><a href="javascript:void(0);" onclick="confirmDelete(${cate.cateNo})">삭제</a></td>
                </tr>

                <!-- 하위 카테고리들 출력 -->
                <c:if test="${not empty cate.subCategoryList}">
                    <c:forEach items="${cate.subCategoryList}" var="subCate">
                        <tr>
                            <td>${subCate.cateNo}</td>
                            <td>&nbsp;&nbsp;&nbsp;${subCate.cateName}</td>
                            <td>${subCate.cateParentNo != null ? subCate.cateParentNo : "없음"}</td>
                            <td><a href="/CarrotEasy/cate/update.do?cateNo=${subCate.cateNo}">수정</a></td>
                            <td><a href="javascript:void(0);" onclick="confirmDelete(${subCate.cateNo})">삭제</a></td>
                        </tr>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </tbody>
    </table>
</body>
</html>
