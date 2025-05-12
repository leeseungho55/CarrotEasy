<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 등록</title>
    <style>
        .container {
            max-width: 1180px;
            margin: 8px auto;
            background: #fff;
            padding: 20px 20px;
            border-radius: 14px;
            box-shadow: 0 2px 12px rgba(0,0,0,0.06);
        }
        .qna-title {
            text-align: center;
            margin-bottom: 30px;
            font-weight: bold;
            color: #222;
            letter-spacing: -1px;
        }
        .qnaInsert-form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 8px;
            font-weight: 600;
            color: #333;
            font-size: 15px;
        }
        .qna-input, .qna-area {
            padding: 13px 10px;
            margin-bottom: 22px;
            border: 1px solid #eee;
            border-radius: 8px;
            font-size: 15px;
            background: #fafafa;
            transition: border-color 0.2s;
        }
        .qna-input:focus, .qna-area:focus {
            border-color: #ff8a3d;
            outline: none;
        }
        .qna-area {
            resize: vertical;
            min-height: 200px;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 18px;
        }
        .btn {
            padding: 12px 32px;
            border: none;
            font-size: 16px;
            border-radius: 8px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 700;
            transition: background-color 0.18s, transform 0.15s;
            box-shadow: 0 1px 4px rgba(255,78,80,0.08);
        }
        .btn-submit {
            background-color: #ff8a3d;
            color: #fff;
        }
        .btn-submit:hover {
            background-color: #e0423f;
            transform: translateY(-1px) scale(1.03);
        }
        .btn-cancel {
            background-color: #ccc;
            color: #333;
        }
        .btn-cancel:hover {
            background-color: #b0b0b0;
        }
    </style>
</head>
<body>

<div class="container">
    <div class="qna-title"><h2>문의 등록</h2></div>

    <form action="/CarrotEasy/qnaInsert.do" method="post" id="qnaInsert-form" class="qnaInsert-form">
        <label for="title">제목</label>
        <input type="text" class="qna-input" id="title" name="title" required>

        <label for="content">내용</label>
        <textarea class="qna-input qna-area" id="content" name="content" required></textarea>

        <div class="button-group">
            <button type="submit" class="btn btn-submit">등록</button>
            <a href="/CarrotEasy/qnaList.do" class="btn btn-cancel" id="qnaList-btn">취소</a>
        </div>
    </form>
</div>

</body>
</html>
