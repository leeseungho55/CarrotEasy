<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<head>
    <meta charset="UTF-8">
    <title>게시글 보기</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
</head>

<script>
$(document).ready(function () {
    $('#editBtn').click(function () {
        $('#viewMode').hide();
        $('#editForm').show();
    });

    $('#cancelEdit').click(function () {
        $('#editForm').hide();
        $('#viewMode').show();
    });
    
    $('#editForm').submit(function (e) {
       e.preventDefault();

       const formData = $(this).serialize();

       $.post('${pageContext.request.contextPath}/notice/update.do', formData, function (res) {
           if (res.success) {
               $('#viewTitle').text(res.title);
               $('#viewContent').html(res.content);

               $('#editForm').hide();
               $('#viewMode').show();
           } else {
               alert(res.message);
           }
       }, 'json');
   });
});
</script>
<body class="container mt-5">
	<div id="viewMode">
		
	    <h2 id="viewTitle">${notice.notiTitle}</h2>
	    
	    <div class="mb-3 text-muted">
	        작성자: <strong>관리자</strong> &nbsp; | &nbsp;
	        작성일: <strong>${notice.createDate}</strong>
	        <a href="${pageContext.request.contextPath}/notice/list.do" class="btn btn-secondary">목록</a>
			<c:if test="${sessionScope.loginUser.memRole == 1}">
			    <button id="editBtn" class="btn btn-warning">수정</button>
			    <form id="deleteForm" method="post" action="${pageContext.request.contextPath}/notice/delete.do" style="display: inline;">
			        <input type="hidden" name="notiNo" value="${notice.notiNo}">
			        <button type="submit" class="btn btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</button>
			    </form>
			</c:if>
	    </div>
	
	    <div class="border p-3 mb-5" id="viewContent" style="min-height: 200px;">
	        ${notice.notiContent}
	    </div>
    </div>
    
    <!-- 수정 모드: 기본 숨김 -->
	<form id="editForm" style="display: none;" method="post" action="${pageContext.request.contextPath}/notice/update.do">
	    <input type="hidden" name="notiNo" value="${notice.notiNo}">
	
	    <div class="form-group">
	        <label for="editTitle">제목</label>
	        <input type="text" class="form-control" id="editTitle" name="notiTitle" value="${notice.notiTitle}" required>
	    </div>
	
	    <div class="form-group">
	        <label for="editContent">내용</label>
	        <textarea class="form-control" id="editContent" name="notiContent" rows="5" required>${notice.notiContent}</textarea>
	    </div>
	
	    <button type="submit" class="btn btn-success">저장</button>
	    <button type="button" class="btn btn-secondary" id="cancelEdit">취소</button>
	</form>
	
    <!-- Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
