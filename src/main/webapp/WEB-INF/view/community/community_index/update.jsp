<%@page import="kr.or.ddit.community.community_index.vo.CommunityVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    CommunityVo vo = (CommunityVo) request.getAttribute("community");
%>

<style>
/* 전체 컨테이너 */
.community-edit-container {
    max-width: 1180px;      /* 전체 폭 고정 */
    margin: 8px auto;       /* 상하 8px, 좌우 자동 중앙 정렬 */
    padding: 20px;          /* 안쪽 여백 */
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    box-sizing: border-box;
    font-family: 'Noto Sans KR', sans-serif;
}

/* 제목 */
.community-edit-container h2 {
    font-size: 24px;
    font-weight: 700;
    color: #222;
    text-align: center;
    margin-bottom: 30px;
}

/* 입력 그룹 */
.form-group {
    margin-bottom: 22px;
}
.form-group label {
    display: block;
    font-size: 15px;
    font-weight: 600;
    color: #333;
    margin-bottom: 8px;
}
.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 13px 10px;
    font-size: 15px;
    border: 1px solid #eee;
    border-radius: 8px;
    background-color: #fafafa;
    transition: border-color 0.2s;
    box-sizing: border-box;
}
.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    border-color: #FF8A3D;
    outline: none;
}
.form-group textarea {
    resize: vertical;
    min-height: 180px;      /* 좀 더 넉넉하게 */
}

/* 버튼 영역 */
.btn-area {
    text-align: right;
    margin-top: 28px;
}

.btn-submit,
.btn-cancel {
    padding: 12px 32px;
    font-size: 16px;
    font-weight: 600;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.18s, transform 0.15s;
    text-decoration: none;
    color: #fff;
    margin-left: 12px;
}

.btn-submit {
    background-color: #FF8A3D;
}
.btn-submit:hover {
    background-color: #e0423f;
    transform: translateY(-1px);
}

.btn-cancel {
    background-color: #ccc;
}
.btn-cancel:hover {
    background-color: #bbb;
    transform: translateY(-1px);
}

/* 반응형 */
@media (max-width: 700px) {
    .community-edit-container {
        padding: 18px 4vw;
    }
    .community-edit-container h2 {
        font-size: 22px;
        margin-bottom: 24px;
    }
    .form-group input,
    .form-group select,
    .form-group textarea {
        font-size: 14px;
        padding: 12px 8px;
    }
    .btn-submit,
    .btn-cancel {
        width: 100%;
        margin: 8px 0 0;
    }
    .btn-area {
        text-align: center;
    }
}
</style>


<!-- Wrapper 추가 -->
<div class="maincontent">
  <div class="community-edit-container">
      <h2>소모임 정보 수정</h2>
      <form action="CommunityUpdate.do" method="post">
          <input type="hidden" name="commuNo" value="<%= vo.getCommuNo() %>">
          <input type="hidden" name="commuRegion" value="<%= vo.getCommuRegion() %>">

          <div class="form-group">
              <label for="commuTitle">소모임명</label>
              <input type="text" id="commuTitle" name="commuTitle" value="<%= vo.getCommuTitle() %>" required>
          </div>
          <div class="form-group">
              <label for="commuContent">소개</label>
              <textarea id="commuContent" name="commuContent" required><%= vo.getCommuContent() %></textarea>
          </div>
          <div class="form-group">
              <label for="commuCatrgory">카테고리</label>
              <select id="commuCatrgory" name="commuCatrgory" required>
                  <option value="운동" <%= "운동".equals(vo.getCommuCatrgory()) ? "selected" : "" %>>운동</option>
                  <option value="교육" <%= "교육".equals(vo.getCommuCatrgory()) ? "selected" : "" %>>교육</option>
                  <option value="반려동물" <%= "반려동물".equals(vo.getCommuCatrgory()) ? "selected" : "" %>>반려동물</option>
                  <option value="동네친구" <%= "동네친구".equals(vo.getCommuCatrgory()) ? "selected" : "" %>>동네친구</option>
              </select>
          </div>

          <div class="btn-area">
              <button type="submit" class="btn-submit">수정 완료</button>
              <a href="CommunityRegion.do?commuNo=<%= vo.getCommuNo() %>&commuRegion=<%= vo.getCommuRegion() %>" class="btn-cancel">취소</a>
          </div>
      </form>
  </div>
</div>
