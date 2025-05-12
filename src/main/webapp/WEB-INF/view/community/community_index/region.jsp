<%@page import="kr.or.ddit.community.community_index.vo.CommunityVo"%>
<%@page import="kr.or.ddit.member.vo.MemberVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    List<CommunityVo> list = (List<CommunityVo>) request.getAttribute("list");
    String region = (String) request.getAttribute("region");
    String catrgory = (String) request.getAttribute("catrgory");
    String stype = request.getParameter("stype");
    String sword = request.getParameter("sword");
    MemberVo loginMember = (MemberVo) session.getAttribute("member");
%>

<style>
 /* 기본 스타일 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f7f7f7;
    margin: 0;
    padding: 0;
}

/* 컨테이너 */
.carroteasy-container {
    max-width: 1180px; /* 고정된 너비 */
    margin: 8px auto; /* 중앙 정렬 */
    padding: 20px;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

/* 제목 */
.carroteasy-title {
    font-size: 28px;
    font-weight: bold;
    color: #333;
    text-align: center;
    margin-bottom: 30px;
}

/* 상단 바 */
.carroteasy-top-bar {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.carroteasy-search-form {
    display: flex;
    align-items: center;
    gap: 15px;
    width: 60%;
}

.carroteasy-search-form select,
.carroteasy-search-form input {
    padding: 8px;
    font-size: 14px;
    border: 1px solid #ccc;
    border-radius: 5px;
}

.carroteasy-btn-group {
    display: flex;
    gap: 15px;
}

.carroteasy-btn {
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 8px;
    text-decoration: none;
    cursor: pointer;
    text-align: center;
    display: inline-block;
}

.carroteasy-btn-primary {
    background-color: #FF8A3D;
    color: white;
    border: none;
    transition: background-color 0.3s ease;
}

.carroteasy-btn-secondary {
    background-color: #b5b5b5;
    color: white;
    border: none;
    transition: background-color 0.3s ease;
}

.carroteasy-btn-danger {
    background-color: #FF8A3D;
    color: white;
    border: none;
    transition: background-color 0.3s ease;
}

.carroteasy-btn:hover {
    opacity: 0.8;
}

/* 테이블 스타일 */
.carroteasy-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 30px;
}

.carroteasy-table th, .carroteasy-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #ccc;
}

.carroteasy-table th {
    background-color: #f7f7f7;
    font-weight: bold;
}

.carroteasy-table td a {
    color: #333333;
    text-decoration: none;
    font-weight: bold;
}

.carroteasy-table td a:hover {
    text-decoration: underline;
}

/* 게시글 없을 때 */
.carroteasy-no-posts {
    text-align: center;
    font-size: 18px;
    color: #666;
    margin-top: 20px;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .carroteasy-title {
        font-size: 22px;
    }

    .carroteasy-search-form {
        width: 100%;
        flex-direction: column;
        align-items: stretch;
    }

    .carroteasy-btn-group {
        flex-direction: column;
        gap: 10px;
    }

    .carroteasy-btn {
        width: 100%;
    }

    .carroteasy-table th, .carroteasy-table td {
        padding: 8px;
    }

    .carroteasy-btn-secondary {
        width: 100%;
    }
}
.inline-form {
    display: inline-block;
    margin-right: 10px;  /* 버튼 간의 간격을 줄 수 있음 */
}

.carroteasy-btn {
    display: inline-block;
    padding: 10px 20px;
    font-size: 16px;
    border-radius: 8px;
    cursor: pointer;
    text-align: center;
    text-decoration: none;
    width: auto;
}

.carroteasy-btn-group {
    display: flex;
    gap: 10px;  /* 버튼들 사이의 간격을 설정 */
    flex-direction: row;  /* 버튼들이 가로로 배치되도록 설정 */
}
 
</style>

<div class="carroteasy-container">
    <h2 class="carroteasy-title">${region} 소모임 - ${not empty catrgory ? catrgory : '전체'}</h2>

    <div class="carroteasy-top-bar">
        <form action="CommunityRegion.do" method="get" class="carroteasy-search-form">
            <input type="hidden" name="commuRegion" value="${region}" />

            <select name="commuCatrgory" aria-label="카테고리 선택">
                <option value="" ${empty catrgory ? 'selected' : ''}>전체</option>
                <option value="운동" ${catrgory eq '운동' ? 'selected' : ''}>운동</option>
                <option value="교육" ${catrgory eq '교육' ? 'selected' : ''}>교육</option>
                <option value="반려동물" ${catrgory eq '반려동물' ? 'selected' : ''}>반려동물</option>
                <option value="동네친구" ${catrgory eq '동네친구' ? 'selected' : ''}>동네친구</option>
            </select>

            <select name="stype" aria-label="검색 타입 선택">
                <option value="commuTitle" ${stype eq 'commuTitle' ? 'selected' : ''}>모임명</option>
                <option value="memNick" ${stype eq 'memNick' ? 'selected' : ''}>작성자</option>
            </select>

            <input type="text" name="sword" placeholder="검색어 입력" value="${sword}" aria-label="검색어 입력" />
            <button type="submit" class="carroteasy-btn carroteasy-btn-secondary">검색</button>
        </form>

        <div class="carroteasy-btn-group">
            <a href="CommunityInsertForm.do?commuRegion=${region}" class="carroteasy-btn carroteasy-btn-primary" role="button" aria-label="소모임 등록">소모임 등록</a>
            <button type="button" onclick="location.href='MainType.do'" class="carroteasy-btn carroteasy-btn-secondary" aria-label="지역 선택">지역 선택</button>
        </div>
    </div>

    <c:choose>
        <c:when test="${not empty list}">
            <table class="carroteasy-table" role="table" aria-label="${region} 소모임 목록">
                <thead>
                    <tr>
                        <th scope="col">작성자</th>
                        <th scope="col">모임</th>
                        <th scope="col">카테고리</th>
                        <th scope="col">게시글</th>
                        <th scope="col">관리</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${list}" var="vo">
                        <tr>
                            <td>${vo.member.memNick}</td>
                            <td>
                                <a href="CommunitySelectList.do?commuNo=${vo.commuNo}&commuRegion=${vo.commuRegion}">
                                    ${vo.commuTitle}
                                </a>
                            </td>
                            <td>${vo.commuCatrgory}</td>
                            <td>${vo.commuBoardCount}</td>
                            <td>
                                <c:if test="${sessionScope.member.memNo eq vo.member.memNo}">
                                    <c:if test="${vo.commuBoardCount == 0}">
                                        <form action="CommunityUpdate.do" method="get" class="inline-form" aria-label="수정 폼">
                                            <input type="hidden" name="commuNo" value="${vo.commuNo}" />
                                            <button type="submit" class="carroteasy-btn carroteasy-btn-primary" aria-label="수정">수정</button>
                                        </form>
                                    </c:if>
                                    <form action="CommunityDelete.do" method="post" class="inline-form" aria-label="삭제 폼">
                                        <input type="hidden" name="commuNo" value="${vo.commuNo}" />
                                        <input type="hidden" name="commuRegion" value="${vo.commuRegion}" />
                                        <button type="submit" class="carroteasy-btn carroteasy-btn-danger" onclick="return confirm('정말 삭제하시겠습니까?')" aria-label="삭제">삭제</button>
                                    </form>
                                </c:if>
                                <c:if test="${sessionScope.member.memNo ne vo.member.memNo}">
                                    <form action="CommunityReport.do" method="get" class="inline-form" aria-label="신고 폼">
                                        <input type="hidden" name="commuNo" value="${vo.commuNo}" />
                                        <input type="hidden" name="commuRegion" value="${region}" />
                                        <button type="submit" class="carroteasy-btn carroteasy-btn-danger" aria-label="신고">신고</button>
                                    </form>
                                </c:if>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <p class="carroteasy-no-posts" role="alert" aria-live="polite">해당 조건에 맞는 게시글이 없습니다.</p>
        </c:otherwise>
    </c:choose>
</div>
