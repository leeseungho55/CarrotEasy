<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="kr.or.ddit.member.vo.MemberVo" %>
<%@ page import="kr.or.ddit.community.community_index.vo.CommunityVo" %>
<%
    MemberVo loginMember = (MemberVo) session.getAttribute("member");
    CommunityVo community = (CommunityVo) request.getAttribute("community");
%>

<style>
/* 전체 컨테이너 */
.carroteasy-board-container {
    max-width: 1180px;
    margin: 8px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    font-family: 'Noto Sans KR', sans-serif;
}

/* 타이틀 & 지역 */
.carroteasy-board-title {
    font-size: 28px;
    font-weight: 700;
    color: #222;
    margin-bottom: 8px;
}
.carroteasy-board-region {
    font-size: 14px;
    color: #666;
    margin-bottom: 20px;
}

/* 소개 영역 */
.carroteasy-board-desc {
    font-size: 15px;
    color: #333;
    line-height: 1.6;
    background-color: #fafafa;
    padding: 16px;
    border-radius: 8px;
    border: 1px solid #eee;
    margin-bottom: 24px;
}

/* 상단 버튼 바 */
.carroteasy-board-topbar {
    text-align: right;
    margin-bottom: 20px;
}
.carroteasy-board-topbar .carroteasy-btn {
    padding: 10px 24px;
    font-size: 15px;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    margin-left: 12px;
    transition: background-color 0.2s, transform 0.1s;
    text-decoration: none;
    color: #fff;
}
.carroteasy-btn-list {
    background-color: #ccc;
}
.carroteasy-btn-list:hover {
    background-color: #bbb;
    transform: translateY(-1px);
}
.carroteasy-btn-write {
    background-color: #FF8A3D;
}
.carroteasy-btn-write:hover {
    background-color: #e0423f;
    transform: translateY(-1px);
}

/* 게시판 테이블 */
.carroteasy-board-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 0;
}
.carroteasy-board-table th,
.carroteasy-board-table td {
    padding: 12px;
    text-align: left;
    border-bottom: 1px solid #eee;
    font-size: 14px;
}
.carroteasy-board-table th {
    background-color: #f7f7f7;
    font-weight: 600;
    color: #333;
}
.carroteasy-board-table td a {
    color: #333333;
    text-decoration: none;
}
.carroteasy-board-table td a:hover {
    text-decoration: underline;
}

/* 게시글 없음 */
.carroteasy-no-posts {
    text-align: center;
    color: #666;
    padding: 24px 0;
}

/* 반응형 */
@media (max-width: 768px) {
    .carroteasy-board-container {
        padding: 16px;
    }
    .carroteasy-board-title {
        font-size: 22px;
    }
    .carroteasy-board-desc {
        font-size: 14px;
        padding: 12px;
    }
    .carroteasy-board-topbar .carroteasy-btn {
        padding: 8px 16px;
        font-size: 14px;
        margin-left: 8px;
    }
    .carroteasy-board-table th,
    .carroteasy-board-table td {
        padding: 8px;
        font-size: 13px;
    }
}
</style>


<script>
    var isLogin = <%= (loginMember != null) ? "true" : "false" %>;
    function goWrite(commuNo, commuRegion) {
        if(!isLogin) {
            alert('로그인 후 이용 가능합니다.');
            location.href = '/CarrotEasy/login.do';
            return;
        }
        location.href = 'CommunityBoardInsert.do?commuNo=' + commuNo + '&commuRegion=' + encodeURIComponent(commuRegion);
    }
</script>

<!-- 목록 URL을 JSTL로 생성 -->
<c:url var="listUrl" value="CommunityRegion.do">
    <c:param name="commuRegion" value="${commuRegion != null ? commuRegion : community.commuRegion}" />
    <c:param name="commuCatrgory" value="${param.commuCatrgory}" />
    <c:param name="stype" value="${param.stype}" />
    <c:param name="sword" value="${param.sword}" />
</c:url>

<div class="carroteasy-board-container">
    <div class="carroteasy-board-title">${community.commuTitle}</div>
    <div class="carroteasy-board-region">지역: ${community.commuRegion}</div>
    <div class="carroteasy-board-desc">
        <b>소모임 소개</b><br>
        <%
            if(community != null && community.getCommuContent() != null) {
                String safeContent = community.getCommuContent()
                    .replaceAll("&", "&amp;")
                    .replaceAll("<", "&lt;")
                    .replaceAll(">", "&gt;")
                    .replaceAll("\"", "&quot;")
                    .replaceAll("'", "&#39;")
                    .replaceAll("(\r\n|\n|\r)", "<br>");
                out.print(safeContent);
            }
        %>
    </div>

    <div class="carroteasy-board-topbar">
        <button type="button" class="carroteasy-btn carroteasy-btn-list" onclick="location.href='${listUrl}'">모임목록</button>
        <button type="button" class="carroteasy-btn carroteasy-btn-write" onclick="goWrite(${community.commuNo}, '${community.commuRegion}')">글쓰기</button>
    </div>

    <table class="carroteasy-board-table">
        <thead>
            <tr>
                <th>닉네임</th>
                <th>제목</th>
                <th>작성일</th>
                <th>조회수</th>
                <th>좋아요</th>
            </tr>
        </thead>
        <tbody>
            <c:choose>
                <c:when test="${empty boardList}">
                    <tr>
                        <td colspan="5" class="carroteasy-no-posts">게시글이 없습니다.</td>
                    </tr>
                </c:when>
                <c:otherwise>
                    <c:forEach items="${boardList}" var="board">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty board.member}">${board.member.memNick}</c:when>
                                    <c:otherwise>알수없음</c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="CommunityBoardDetail.do?commubNo=${board.commubNo}&commuRegion=${param.commuRegion}&commuCatrgory=${param.commuCatrgory}&stype=${param.stype}&sword=${param.sword}">
                                    ${board.commubTitle}
                                </a>
                            </td>
                            <td>${board.createDate}</td>
                            <td>${board.commubCnt}</td>
                            <td>${board.commubGood}</td>
                        </tr>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </tbody>
    </table>
</div>
