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
<style>
    body {
        background-color: #f8f9fa;
        font-family: 'Segoe UI', sans-serif;
    }
    .form-container {
        background-color: white;
        border-radius: 10px;
        padding: 40px;
        box-shadow: 0 0 10px rgba(0,0,0,0.05);
        max-width: 700px;
        margin: 50px auto;
    }
    h2 {
        text-align: center;
        margin-bottom: 30px;
        color: #333;
    }
    .form-control, .form-control-file {
        border-radius: 6px;
    }
    .btn-primary {
        background-color: #FF8A3D;
        border-color: #FF8A3D;
    }
    .btn-primary:hover {
        background-color: #e57a2f;
        border-color: #e57a2f;
    }
    .btn-secondary {
        background-color: #6c757d;
    }
</style>
    
</head>
<body>
    <div class="form-container">
        <h2>🧡 광고 등록하기</h2>

        <form action="${pageContext.request.contextPath}/adboard/write.do" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" name="title" required>
            </div>

            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" id="content" name="content" rows="5" required></textarea>
            </div>

            <div class="form-group">
                <label for="adFile">광고 이미지</label>
                <input type="file" class="form-control-file" id="adFile" name="adFile">
            </div>

            <div class="form-group">
                <label for="adUrl">광고 링크(URL)</label>
                <input type="text" class="form-control" id="adUrl" name="adUrl">
            </div>

            <div class="form-group">
                <label>작성자</label>
                <input type="text" class="form-control" value="${sessionScope.admember.amemId}" readonly>
                <input type="hidden" name="amemNo" value="${sessionScope.admember.amemNo}">
            </div>

            <div class="form-group">
                <label>작성일</label>
                <input type="text" class="form-control" value="<%= today %>" readonly>
            </div>

            <div class="form-group">
                <label for="password">비밀번호 (숫자 4자리)</label>
                <input type="password" class="form-control" id="password" name="password"
                       pattern="\d{4}" maxlength="4" required
                       title="숫자 4자리 입력만 가능합니다.">
            </div>

            <div class="text-right">
                <a href="${pageContext.request.contextPath}/adboard/list.do" class="btn btn-secondary">목록</a>
                <button type="submit" class="btn btn-primary">등록</button>
            </div>
        </form>
    </div>
</body>

</html>
