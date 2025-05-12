<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 목록</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
    	body {
    		font-family: 'Noto Sans KR', sans-serif;
    		background-color: #f7f7f7;
    		margin: 0;
    		padding: 0;
		}
		
        .container {
            max-width: 1180;
            margin: 8px auto;
            background: #fff;
            padding: 20px 20px;
            border-radius: 14px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }
        h2 {
            text-align: center;
            font-size: 22px;
            margin-bottom: 24px;
            font-weight: bold;
            color: #222;
            letter-spacing: -1px;
        }
        .top-bar {
            text-align: right;
            margin-bottom: 12px;
        }
        .write-button {
            padding: 7px 14px;
            background-color: #FF8A3D;
            color: #fff;
            border-radius: 8px;
            text-decoration: none;
            font-size: 14px;
            font-weight: 600;
            margin-left: 8px;
            border: none;
            transition: background-color 0.18s, transform 0.15s;
        }
        .write-button:hover {
            background-color: #e12c17;
            transform: translateY(-1px) scale(1.03);
        }
        table {
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
        /* 제목 링크도 번개장터 스타일로 */
        td a {
            color: #333333;
            text-decoration: none;
            font-weight: 600;
            transition: color 0.18s;
        }
        td a:hover {
            color: #e12c17;
            text-decoration: underline;
        }
        /* 페이징 */
 /*        .pagination {
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
            border: 1px solid #FF8A3D;
            font-weight: bold;
        }
        .pagination a:hover {
            background-color: #FF8A3D; */
        }
        /* 체크박스 라벨 스타일 */
        .top-bar label {
            font-size: 14px;
            color: #444;
            margin-right: 8px;
            vertical-align: middle;
        }
        /* input[type=checkbox] 스타일은 필요시 추가 */
    </style>
    <script>
        $(document).ready(function() {
            $('#myPostsOnly').change(function() {
                const showMine = $(this).is(':checked');
                $.ajax({
                    url: '/CarrotEasy/QnaListAjax.do',
                    type: 'GET',
                    data: { myPostsOnly: showMine },
                    success: function(res) {
                        $('#qna-table-body').html(res);
                    },
                    error: function(xhr) {
                        alert('목록을 불러오지 못했습니다.');
                    }
                });
            });
        });
    </script>
</head>
<body>

<div class="container">
    <h2>💬 문의 목록</h2>

    <div class="top-bar">
        <label>
            <input type="checkbox" id="myPostsOnly"> 내가 쓴 글만 보기
        </label>
        <a href="/CarrotEasy/qnaInsert.do" class="write-button" id="qnaInsert-btn">문의 등록</a>
    </div>

    <table>
        <thead>
            <tr>
                <th>번호</th>
                <th>제목</th>
                <th>작성자</th>
                <th>등록일</th>
                <th>관리자 답변여부</th>
            </tr>
        </thead>
        <tbody id="qna-table-body">
            <c:choose>
                <c:when test="${not empty qnaList}">
                    <c:forEach var="qna" items="${qnaList}" varStatus="status">
                        <tr>
                            <td>${qna.qnaNo}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${sessionScope.member.memNo eq qna.memNo or sessionScope.member.memRole eq 1}">
                                        <a href="/CarrotEasy/qnaDetail.do?qnaNo=${qna.qnaNo}">
                                            ${qna.qnaTitle}
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <a href="javascript:void(0)" onclick="alert('작성자만 열람 가능합니다.');">
                                            ${qna.qnaTitle}
                                        </a>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${qna.memNick}</td>
                            <td>${qna.createDate}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty qna.qnaAnswer}">
                                        답변완료
                                    </c:when>
                                    <c:otherwise>
                                        -
                                    </c:otherwise>
                                </c:choose>
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="5">등록된 문의가 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>

<!--     <div class="pagination"> -->
<%--         <c:if test="${paging.startPage > 1}"> --%>
<%--             <a href="/CarrotEasy/inquiryList.do?currentPage=${paging.startPage - 1}&keyword=${param.keyword}">이전</a> --%>
<%--         </c:if> --%>
<%--         <c:forEach var="i" begin="${paging.startPage}" end="${paging.endPage}"> --%>
<%--             <c:choose> --%>
<%--                 <c:when test="${i == paging.currentPage}"> --%>
<%--                     <strong>${i}</strong> --%>
<%--                 </c:when> --%>
<%--                 <c:otherwise> --%>
<%--                     <a href="/CarrotEasy/inquiryList.do?currentPage=${i}&keyword=${param.keyword}">${i}</a> --%>
<%--                 </c:otherwise> --%>
<%--             </c:choose> --%>
<%--         </c:forEach> --%>
<%--         <c:if test="${paging.endPage < paging.totalPage}"> --%>
<%--             <a href="/CarrotEasy/inquiryList.do?currentPage=${paging.endPage + 1}&keyword=${param.keyword}">다음</a> --%>
<%--         </c:if> --%>
<!--     </div> -->
</div>

</body>
</html>
