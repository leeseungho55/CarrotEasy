<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String commuNo = request.getParameter("commuNo");
    String commuRegion = request.getParameter("commuRegion");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>소모임 신고하기</title>
    <!-- Noto Sans KR 폰트 적용 -->
    <link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:400,700&display=swap" rel="stylesheet">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }
        .maincontent .container {
            max-width: 1800px;
            margin: 8px auto;
            background: #fff;
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 6px 12px rgba(0,0,0,0.08);
        }
        .maincontent h2 {
            text-align: center;
            margin-bottom: 36px;
            font-size: 24px;
            font-weight: 700;
            color: #ff4e50;
            letter-spacing: -1px;
        }
        .maincontent .report-form-area {
            max-width: 500px;
            margin: 0 auto;
            background: #f8f8f8;
            border-radius: 10px;
            padding: 32px 28px 24px 28px;
            box-sizing: border-box;
            box-shadow: 0 2px 8px rgba(0,0,0,0.04);
        }
        .maincontent label {
            font-size: 1.08em;
            font-weight: 600;
            color: #222;
            display: block;
            margin-bottom: 10px;
        }
        .maincontent textarea {
            width: 100%;
            min-height: 100px;
            border-radius: 10px;
            border: 1px solid #ccc;
            padding: 12px;
            font-size: 15px;
            margin-bottom: 22px;
            resize: vertical;
            background: #fefefe;
            color: #333;
            box-sizing: border-box;
        }
        .maincontent .btn-wrap {
            text-align: right;
            margin-top: 10px;
        }
        .maincontent .btn {
            padding: 8px 26px;
            border: none;
            border-radius: 20px;
            cursor: pointer;
            color: #fff;
            font-size: 15px;
            font-weight: 500;
            margin-left: 6px;
            transition: background 0.2s;
            box-shadow: 0 2px 8px rgba(255,78,80,0.08);
        }
        .maincontent .btn-danger {
            background-color: #ff4e50;
        }
        .maincontent .btn-danger:hover {
            background-color: #e0423f;
        }
        .maincontent .btn-secondary {
            background-color: #bbb;
            color: #fff;
        }
        .maincontent .btn-secondary:hover {
            background-color: #888;
        }
        @media (max-width: 900px) {
            .maincontent .container {
                padding: 20px;
                max-width: 98vw;
            }
            .maincontent .report-form-area {
                padding: 18px 10px;
            }
        }
        @media (max-width: 600px) {
            .maincontent .container {
                padding: 10px;
            }
            .maincontent .report-form-area {
                padding: 10px 2vw;
            }
            .maincontent .btn-wrap {
                text-align: center;
            }
            .maincontent .btn {
                width: 100px;
                margin: 6px 3px 0 3px;
            }
        }
    </style>
</head>
<body>
<div class="maincontent">
    <div class="container">
        <h2>소모임 신고하기</h2>
        <form action="CommunityReport.do" method="post" autocomplete="off">
            <div class="report-form-area">
                <input type="hidden" name="commuNo" value="<%=commuNo%>">
                <input type="hidden" name="commuRegion" value="<%=commuRegion%>">
                <label for="reportContent">신고 사유</label>
                <textarea name="reportContent" id="reportContent" required placeholder="신고 사유를 입력해주세요."></textarea>
                <div class="btn-wrap">
                    <button type="submit" class="btn btn-danger">신고하기</button>
                    <button type="button" class="btn btn-secondary" onclick="history.back();">취소</button>
                </div>
            </div>
        </form>
    </div>
</div>
</body>
</html>
