<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
    
<!DOCTYPE html>
<html>

<head>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

</head>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<body>
	<div class="row">
		<div class="col-xl-12">
			<div class="card">
				<div class="card-header d-flex justify-content-between align-items-center">
					<h3>공지 사항 게시판</h3>
						<c:if test="${sessionScope.loginUser.memRole == 1}">
					        <a href="${pageContext.request.contextPath}/notice/write.do" class="btn btn-primary">등록</a>
					    </c:if>				
			    </div>
				<div class="card-body">
					<table border="1">
						<thead>
							<tr>
								<th>제목</th>
								<th>내용</th>
								<th>작성자</th>
								<th>등록일</th>
							</tr>
						</thead>
						<tbody>
							<c:choose>
								<c:when test="${empty boardList}">
									<tr>
										<td colspan="4"> 공지 사항이 없습니다. </td>	
									</tr>
								</c:when>
								<c:otherwise>

									<c:forEach var="notice" items="${boardList}">
									<tr>
										<td><a href="${pageContext.request.contextPath}/notice/noticeView.do?noticeNo=${notice.notiNo}">${notice.notiTitle}</a></td>
										<td>${notice.notiContent}</td>
										<td>관리자</td>
										<td>${notice.createDate}</td>
									</tr>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>
				</div>	
			</div>		
		</div>
	</div>
</body>
</html>