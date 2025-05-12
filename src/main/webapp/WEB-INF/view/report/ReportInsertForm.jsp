<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 작성</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap CDN -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        html, body {
            height: 100%;
            margin: 0;
            padding: 0; /* 👈 여백 제거 */
        }

        .full-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100%;
            background-color: #f8f9fa;
            padding: 0; /* 👈 여백 제거 */
            box-sizing: border-box;
        }

        .report-card {
            width: 100%;
            max-width: 600px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            background-color: white;
            padding: 30px;
        }

        .form-label {
            font-weight: bold;
        }

        .btn-danger {
            width: 100%;
        }
    </style>
</head>
<body>

<div class="full-container">
    <div class="report-card">
        <h3 class="mb-4 text-center">🚨 신고 작성</h3>

		<form action="${pageContext.request.contextPath}/ReportInsert.do" method="post">
		    <input type="hidden" name="prodTitle" value="${prodTitle}">
		
		    <div class="mb-3">
		        <label for="rep_title" class="form-label">📝 제목</label>
		        <input type="text" class="form-control" id="rep_title" name="repTitle" placeholder="신고 제목을 입력하세요" required maxlength="100">
		    </div>
		
		    <div class="mb-3">
		        <label for="rep_content" class="form-label">📄 내용</label>
		        <textarea class="form-control" id="rep_content" name="repContent" rows="6" placeholder="신고 사유를 구체적으로 작성해주세요." required maxlength="1000"></textarea>
		    </div>
		
		    <button type="submit" class="btn btn-danger">🚀 신고 등록</button>
		</form>

    </div>
</div>

</body>
</html>
