<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<%@ page import="java.util.List" %>
<%@ page import="kr.or.ddit.report.vo.ReportVo" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>신고 확인</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <style>
        body {
            background-color: #fafafa;
            margin: 0;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .report-card {
            max-width: 1180;
            margin: 8px auto;
            background-color: #fff;
            padding: 40px 32px;
            border-radius: 14px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }
        h3 {
            text-align: center;
            margin-bottom: 32px;
            font-size: 22px;
            font-weight: bold;
            color: #222;
            letter-spacing: -1px;
        }
        .form-label {
            font-weight: 600;
            display: block;
            margin-bottom: 8px;
            color: #333;
            font-size: 15px;
        }
        .form-control {
            width: 100%;
            padding: 13px 10px;
            margin-bottom: 22px;
            border: 1px solid #eee;
            border-radius: 8px;
            font-size: 15px;
            background-color: #fafafa;
            transition: border-color 0.2s;
        }
        .form-control[readonly], .form-control[disabled] {
            color: #555;
            background-color: #f3f3f3;
        }
        .form-control:focus {
            border-color: #FF8A3D;
            outline: none;
        }
        .btn-wrapper {
            text-align: right;
        }
        .btn-secondary {
            display: inline-block;
            padding: 12px 32px;
            font-size: 16px;
            border-radius: 8px;
            text-align: center;
            text-decoration: none;
            background-color: #FF8A3D;
            color: #fff;
            border: none;
            font-weight: 700;
            box-shadow: 0 1px 4px rgba(255,78,80,0.08);
            transition: background-color 0.18s, transform 0.15s;
            cursor: pointer;
        }
        .btn-secondary:hover {
            background-color: #e0423f;
            transform: translateY(-1px) scale(1.03);
        }
        @media (max-width: 700px) {
            .report-card { padding: 18px 4vw; }
        }
    </style>
</head>
<body>

<div class="report-card">
    <h3>🚨 신고 내용 확인</h3>

    <%
        List<ReportVo> watchingFormData = (List<ReportVo>) request.getAttribute("Report");
        if (watchingFormData != null && !watchingFormData.isEmpty()) {
            ReportVo vo = watchingFormData.get(0);
    %>

    <label for="prod_no" class="form-label">📦 상품명</label>
    <input type="text" class="form-control" id="prod_no" value="<%= vo.getProdTitle() %>" readonly>

    <label for="mem_id" class="form-label">👤 회원 ID</label>
    <input type="text" class="form-control" id="mem_id" value="<%= vo.getMemId() %>" readonly>

    <label for="rep_title" class="form-label">📝 제목</label>
    <input type="text" class="form-control" id="rep_title" value="<%= vo.getRepTitle() %>" readonly>

    <label for="rep_content" class="form-label">📄 신고 내용</label>
    <textarea class="form-control" id="rep_content" rows="6" readonly><%= vo.getRepContent() %></textarea>

    <div class="btn-wrapper">
        <a href="/CarrotEasy/ListBoard.do" class="btn-secondary">← 목록으로</a>
    </div>

    <%
        } else {
    %>
        <p>신고 정보를 불러올 수 없습니다.</p>
    <%
        }
    %>
</div>

</body>
</html>
