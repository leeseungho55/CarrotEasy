<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 목록</title>
<!-- head 태그에 Font Awesome CDN 추가 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
	table {
    	width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    th, td {
    	padding: 10px;
        border: 1px solid #ccc;
        text-align: center;
    }
    th {
    	background-color: #f2f2f2;
	}
	.no-data {
    	margin-top: 20px;
        color: gray;
        font-size: 16px;
}
</style>
</head>
<body>

    <h2>리뷰 목록</h2>

    <c:choose>
        <c:when test="${empty reviewList}">
            <div class="no-data">등록된 리뷰가 없습니다.</div>
        </c:when>
        <c:otherwise>
            <table>
                <thead>
                    <tr>
                        <th>상품 번호</th>
                        <th>작성자 번호</th>
                        <th>리뷰 점수</th>
                        <th>리뷰 제목</th>
                        <th>작성일자</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="review" items="${reviewList}">
                        <tr>
                            <td>${review.prodNo}</td>
                            <td>${review.memNo}</td>
							<td>
							    <c:forEach begin="1" end="5" var="i">
							        <c:choose>
							            <c:when test="${i <= review.reviewScore}">
							                <i class="fa-solid fa-star" style="color: gold;"></i>
							            </c:when>
							            <c:otherwise>
							                <i class="fa-regular fa-star" style="color: #ccc;"></i>
							            </c:otherwise>
							        </c:choose>
							    </c:forEach>
							</td>
                            <td>${review.reviewTitle}</td>
                            <td>${review.createDate}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:otherwise>
    </c:choose>
</body>
</html>
