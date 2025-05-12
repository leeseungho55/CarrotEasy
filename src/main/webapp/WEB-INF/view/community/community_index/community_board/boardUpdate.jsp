<%@page import="kr.or.ddit.community.community_board.vo.CommunityBoardVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    CommunityBoardVo board =(CommunityBoardVo) request.getAttribute("board");
%>
<!-- 구글 폰트 적용 (head에 넣는 것이 정석이지만, 예시로 body에 둡니다) -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,700&display=swap" rel="stylesheet">

<style>
/* maincontent 내부 폼 박스를 기존 컨테이너와 동일하게 */
.maincontent .community-board-edit-container {
    max-width: 1180px;      /* 전체 고정 최대 너비 */
    margin: 8px auto;       /* 상하 8px, 좌우 중앙 정렬 */
    padding: 20px;          /* 내부 여백 */
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 폼 제목 */
.maincontent .community-board-edit-container h2 {
    font-size: 24px;
    font-weight: 700;
    color: #222;
    text-align: center;
    margin-bottom: 24px;
}

/* 입력 그룹 */
.maincontent .community-board-edit-container .form-group {
    margin-bottom: 20px;
}
.maincontent .community-board-edit-container .form-group label {
    display: block;
    font-size: 15px;
    font-weight: 600;
    color: #333;
    margin-bottom: 8px;
}
.maincontent .community-board-edit-container .form-group input,
.maincontent .community-board-edit-container .form-group textarea {
    width: 100%;
    padding: 13px 10px;
    font-size: 15px;
    border: 1px solid #eee;
    border-radius: 8px;
    background-color: #fafafa;
    transition: border-color 0.2s;
    box-sizing: border-box;
}
.maincontent .community-board-edit-container .form-group input:focus,
.maincontent .community-board-edit-container .form-group textarea:focus {
    border-color: #FF8A3D;
    outline: none;
}
.maincontent .community-board-edit-container .form-group textarea {
    resize: vertical;
    min-height: 180px;
}

/* 버튼 영역 */
.maincontent .community-board-edit-container .btn-area {
    text-align: right;
    margin-top: 24px;
}
.maincontent .community-board-edit-container .btn-submit,
.maincontent .community-board-edit-container .btn-cancel {
    padding: 12px 32px;
    font-size: 16px;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.18s, transform 0.15s;
    color: #fff;
    margin-left: 12px;
    text-decoration: none;
}
.maincontent .community-board-edit-container .btn-submit {
    background-color: #FF8A3D;
}
.maincontent .community-board-edit-container .btn-submit:hover {
    background-color: #e0423f;
    transform: translateY(-1px);
}
.maincontent .community-board-edit-container .btn-cancel {
    background-color: #ccc;
}
.maincontent .community-board-edit-container .btn-cancel:hover {
    background-color: #bbb;
    transform: translateY(-1px);
}

/* 반응형 */
@media (max-width: 700px) {
    .maincontent .community-board-edit-container {
        padding: 18px 4vw;
    }
    .maincontent .community-board-edit-container h2 {
        font-size: 22px;
        margin-bottom: 20px;
    }
    .maincontent .community-board-edit-container .form-group input,
    .maincontent .community-board-edit-container .form-group textarea {
        font-size: 14px;
        padding: 12px 8px;
    }
    .maincontent .community-board-edit-container .btn-submit,
    .maincontent .community-board-edit-container .btn-cancel {
        display: block;
        width: 100%;
        margin: 8px 0 0;
    }
    .maincontent .community-board-edit-container .btn-area {
        text-align: center;
    }
}

</style>


<div class="maincontent">
  <div class="community-board-edit-container">
    <h2>게시글 수정</h2>
    <form action="CommunityBoardUpdate.do" method="post">
        <input type="hidden" name="commubNo" value="<%= board.getCommubNo() %>">

        <div class="form-group">
            <label for="commubTitle">제목</label>
            <input type="text" id="commubTitle" name="commubTitle" value="<%= board.getCommubTitle() %>" required>
        </div>
        <div class="form-group">
            <label for="commubContent">내용</label>
            <textarea id="commubContent" name="commubContent" required><%= board.getCommubContent() %></textarea>
        </div>
        <div class="btn-area">
            <button type="submit" class="btn-submit">수정</button>
            <a href="CommunityBoardDetail.do?commubNo=<%= board.getCommubNo() %>" class="btn-cancel">취소</a>
        </div>
    </form>
  </div>
</div>
