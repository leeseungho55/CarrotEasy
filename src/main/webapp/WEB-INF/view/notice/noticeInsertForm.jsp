<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    java.text.SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
    String today = sdf.format(new java.util.Date());
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시판 등록</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</head>
<body class="container mt-5">
    <h2>공지사항 등록</h2>
    
    <form action="${pageContext.request.contextPath}/notice/write.do" method="post">
        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" id="title" name="title" required>
        </div>
        
        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
        </div>
        
        <div class="form-group">
            <label>작성자</label>
            <input type="text" class="form-control" value="관리자" readonly>
        </div>
        
        <div class="form-group">
            <label>작성일</label>
            <input type="text" class="form-control" value="<%= today %>" readonly>
        </div>
        
        <button type="submit" class="btn btn-primary">등록</button>
        <a href="${pageContext.request.contextPath}/notice/list.do" class="btn btn-secondary">목록</a>
    </form>
    
</body>
</html>
