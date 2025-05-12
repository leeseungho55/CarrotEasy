<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 리스트</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
    	body {
    		font-family: 'Noto Sans KR', sans-serif;
    		background-color: #f7f7f7;
    		margin: 0;
    		padding: 0;
		}
		
        .table-container {
            max-width: 1180px;
            margin: 8px auto;
            background: #fff;
            padding: 20px 20px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
            border-radius: 14px;
        }
        .report-asdf {
            text-align: center;
            font-size: 22px;
            margin-bottom: 24px;
            font-weight: bold;
            color: #222;
            letter-spacing: -1px;
        }
        .table-scroll-wrapper {
            overflow-x: auto;
        }
        .table {
            width: 100%;
            min-width: 900px;
            border-collapse: collapse;
            font-size: 15px;
            background-color: #fff;
            margin-bottom: 20px;
        }
        th, td {
            text-align: center;
            padding: 13px 8px;
            border-bottom: 1px solid #eee;
            color: #333;
        }
        th {
            background-color: #fafafa;
            font-weight: 700;
            color: #222;
        }
        tr:hover {
            background-color: #f7f7f7;
        }
        .table td a,
        .table-container td a,
        td a {
            padding: 7px 14px;
            background-color: #FF8A3D;
            color: #fff !important;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            text-decoration: none;
            margin: 0 2px;
            display: inline-block;
            transition: background-color 0.18s, transform 0.15s;
        }
        .table td a:hover,
        .table-container td a:hover,
        td a:hover {
            background-color: #e12c17;
            color: #fff !important;
            transform: translateY(-1px) scale(1.03);
        }
        .pagination {
            margin-top: 30px;
            text-align: center;
        }
        .pagination a, .pagination strong {
            margin: 0 5px;
            text-decoration: none;
            color: #333;
            font-size: 15px;
            padding: 6px 12px;
            border: 1px solid #ddd;
            border-radius: 6px;
            display: inline-block;
        }
        .pagination a.active, .pagination strong {
            background-color: #FF8A3D;
            color: #fff;
            border: 1px solid #ff3a1e;
            font-weight: bold;
        }
        .pagination a:hover {
            background-color: #FF8A3D;
        }
    </style>
</head>
<body>

<div class="table-container">
    <div class="report-asdf">🚨 신고 목록</div>

    <div class="table-scroll-wrapper">
        <table class="table">
            <thead>
                <tr>
                    <th>신고번호</th>
                    <th>상품명</th>
                    <th>회원ID</th>
                    <th>제목</th>
                    <th>작성일</th>
                    <th>
  						<c:if test="${sessionScope.member.memRole == 1}">관리</c:if>
					</th>
                </tr>
            </thead>
            <tbody>
                <c:choose>
                    <c:when test="${not empty boardList}">
                        <c:forEach var="vo" items="${boardList}">
                            <tr>
                                <td>${vo.repNo}</td>
                                <td>${vo.prodTitle}</td>
                                <td>${vo.memId}</td>
                                <td>${vo.repTitle}</td>
                                <td><fmt:formatDate value="${vo.createDate}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>
  									<c:if test="${sessionScope.member.memRole == 1}">
    									<a href="/CarrotEasy/ReportWatchingForm.do?repNo=${vo.repNo}">확인</a>
    									<a href="/CarrotEasy/DeleteReport.do?rep_no=${vo.repNo}" onclick="return confirm('정말 삭제하시겠습니까?')">삭제</a>
  									</c:if>
								</td>
                            </tr>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <tr>
                            <td colspan="6">등록된 신고가 없습니다.</td>
                        </tr>
                    </c:otherwise>
                </c:choose>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
