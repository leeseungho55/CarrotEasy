<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    String region = (String) request.getAttribute("region");
    String commuCatrgory = (String) request.getParameter("commuCatrgory");
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
        max-width: 1180px;
        margin: 8px auto;
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

    /* 폼 그룹 */
    .form-group {
        margin-bottom: 20px;
    }

    .form-group label {
        display: block;
        font-size: 16px;
        color: #333;
        margin-bottom: 8px;
    }

    .form-group input,
    .form-group select,
    .form-group textarea {
        width: 100%;
        padding: 10px;
        font-size: 14px;
        border: 1px solid #ccc;
        border-radius: 8px;
        box-sizing: border-box;
    }

    .form-group textarea {
        height: 150px;
        resize: vertical;
    }

    /* 버튼 그룹 */
    .button-group {
        display: flex;
        justify-content: space-between;
        gap: 20px;
    }

    .button-group button {
        padding: 10px 20px;
        font-size: 16px;
        border-radius: 8px;
        text-decoration: none;
        cursor: pointer;
        text-align: center;
        display: inline-block;
        width: 48%;
    }

    .btn-submit {
        background-color: #FF8A3D;
        color: white;
        border: none;
        transition: background-color 0.3s ease;
    }

    .btn-cancel {
        background-color: #b5b5b5;
        color: white;
        border: none;
        transition: background-color 0.3s ease;
    }

    .btn-submit:hover {
        background-color: #e7792a;
    }

    .btn-cancel:hover {
        background-color: #9c9c9c;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .carroteasy-title {
            font-size: 22px;
        }

        .form-group {
            margin-bottom: 15px;
        }

        .button-group {
            flex-direction: column;
            gap: 10px;
        }

        .button-group button {
            width: 100%;
        }
    }
</style>

<!-- 본문 시작 -->
<div class="carroteasy-container">
    <h2 class="carroteasy-title"><%= region %> 소모임 등록</h2>
    <form action="CommunityInsert.do" method="post">
        <input type="hidden" name="commuRegion" value="<%= region %>">

        <div class="form-group">
            <label for="commuTitle">소모임 제목</label>
            <input type="text" id="commuTitle" name="commuTitle" required>
        </div>

        <div class="form-group">
            <label for="commuContent">소모임 내용</label>
            <textarea id="commuContent" name="commuContent" required></textarea>
        </div>

        <div class="form-group">
            <label for="commuCatrgory">카테고리 선택</label>
            <select id="commuCatrgory" name="commuCatrgory" required>
                <option value="">카테고리 선택</option>
                <option value="운동" <%= "운동".equals(commuCatrgory) ? "selected" : "" %>>운동</option>
                <option value="교육" <%= "교육".equals(commuCatrgory) ? "selected" : "" %>>교육</option>
                <option value="반려동물" <%= "반려동물".equals(commuCatrgory) ? "selected" : "" %>>반려동물</option>
                <option value="동네친구" <%= "동네친구".equals(commuCatrgory) ? "selected" : "" %>>동네친구</option>
            </select>
        </div>

        <div class="button-group">
            <button type="submit" class="btn-submit">등록하기</button>
            <button type="button" class="btn-cancel" onclick="history.back();">취소하기</button>
        </div>
    </form>
</div>
