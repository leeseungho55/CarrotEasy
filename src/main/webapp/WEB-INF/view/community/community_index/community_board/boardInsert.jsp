<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String commuNo = request.getParameter("commuNo");
    String commuRegion = request.getParameter("commuRegion");
    if (commuRegion == null) {
        commuRegion = (String) request.getAttribute("commuRegion");
    }
%>

<style>
/* maincontent 내부 컨테이너를 기존 페이지와 동일한 크기로 */
.maincontent .container {
    max-width: 1180px;      /* 기존과 같은 고정 최대 너비 */
    margin: 8px auto;       /* 상하 8px, 좌우 자동 중앙 정렬 */
    padding: 20px;          /* 안쪽 여백 */
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 제목 */
.maincontent .container h2 {
    font-size: 24px;
    font-weight: 700;
    color: #222;
    text-align: center;
    margin-bottom: 24px;
}

/* 입력 그룹 */
.maincontent .container .form-group {
    margin-bottom: 20px;
}
.maincontent .container .form-group label {
    display: block;
    font-size: 15px;
    font-weight: 600;
    color: #333;
    margin-bottom: 8px;
}
.maincontent .container .form-group input,
.maincontent .container .form-group textarea {
    width: 100%;
    padding: 13px 10px;
    font-size: 15px;
    border: 1px solid #eee;
    border-radius: 8px;
    background-color: #fafafa;
    transition: border-color 0.2s;
    box-sizing: border-box;
}
.maincontent .container .form-group input:focus,
.maincontent .container .form-group textarea:focus {
    border-color: #FF8A3D;
    outline: none;
}
.maincontent .container .form-group textarea {
    resize: vertical;
    min-height: 180px;
}

/* 버튼 영역 */
.maincontent .container .btn-area {
    text-align: right;
    margin-top: 24px;
}
.maincontent .container .btn-submit,
.maincontent .container .btn-cancel {
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
.maincontent .container .btn-submit {
    background-color: #FF8A3D;
}
.maincontent .container .btn-submit:hover {
    background-color: #e0423f;
    transform: translateY(-1px);
}
.maincontent .container .btn-cancel {
    background-color: #ccc;
}
.maincontent .container .btn-cancel:hover {
    background-color: #bbb;
    transform: translateY(-1px);
}

/* 반응형 */
@media (max-width: 700px) {
    .maincontent .container {
        padding: 18px 4vw;
    }
    .maincontent .container h2 {
        font-size: 22px;
        margin-bottom: 20px;
    }
    .maincontent .container .form-group input,
    .maincontent .container .form-group textarea {
        font-size: 14px;
        padding: 12px 8px;
    }
    .maincontent .container .btn-submit,
    .maincontent .container .btn-cancel {
        display: block;
        width: 100%;
        margin: 8px 0 0;
    }
    .maincontent .container .btn-area {
        text-align: center;
    }
}
</style>

<div class="maincontent">
  <div class="container">
    <h2>게시글 등록</h2>
    <form action="CommunityBoardInsert.do" method="post">
      <input type="hidden" name="commuNo" value="<%= commuNo %>">
      <input type="hidden" name="commuRegion" value="<%= commuRegion %>">

      <div class="form-group">
        <label for="commubTitle">제목</label>
        <input type="text" id="commubTitle" name="commubTitle" required>
      </div>
      <div class="form-group">
        <label for="commubContent">내용</label>
        <textarea id="commubContent" name="commubContent" required></textarea>
      </div>

      <div class="btn-area">
        <button type="submit" class="btn-submit">등록</button>
        <a href="CommunitySelectList.do?commuNo=<%= commuNo %>&commuRegion=<%= commuRegion %>" class="btn-cancel">취소</a>
      </div>
    </form>
  </div>
</div>
