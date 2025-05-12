<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 수정</title>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f7f7f7;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1180px;
    margin: 8px auto;
    padding: 20px;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

h2 {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    text-align: center;
    margin-bottom: 30px;
}

/* 입력 폼 스타일 */
label {
    font-size: 16px;
    color: #333;
    display: block;
    margin-bottom: 8px;
    font-weight: 600;
}

.qna-input, .qna-area {
    width: 100%;
    padding: 12px 15px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 8px;
    background-color: #fafafa;
    margin-bottom: 20px;
    box-sizing: border-box;
}

.qna-input:focus, .qna-area:focus {
    border-color: #FF8A3D;
    outline: none;
}

.qna-area {
    resize: vertical;
    height: 150px;
}

/* 버튼 그룹 스타일 */
.button-group {
    text-align: center;
}

.button-group button, .button-group a {
    padding: 12px 32px;
    font-size: 16px;
    border-radius: 8px;
    cursor: pointer;
    text-decoration: none;
    display: inline-block;
    margin: 0 10px;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

/* 수정 버튼 */
.btn-submit {
    background-color: #FF8A3D;
    color: white;
    border: none;
}

.btn-submit:hover {
    background-color: #e0423f;
    transform: translateY(-2px);
}

/* 취소 버튼 */
.btn-cancel {
    background-color: #ccc;
    color: white;
    border: none;
}

.btn-cancel:hover {
    background-color: #bbb;
    transform: translateY(-2px);
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .container {
        padding: 15px;
    }

    label {
        font-size: 14px;
    }

    .qna-input, .qna-area {
        font-size: 14px;
    }

    .button-group button, .button-group a {
        font-size: 14px;
        padding: 10px 20px;
    }
}
        
        .container {
            width: 700px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 8px;
            font-weight: bold;
        }
        .qna-input, .qna-area {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .qna-area {
            resize: vertical;
            min-height: 200px;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
        }
        .btn-cancel {
            background-color: #ccc;
            color: #333;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .container {
            width: 700px;
            margin: 50px auto;
            background: #fff;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .qna-title {
            text-align: center;
            margin-bottom: 30px;
        }
        .qnaUpdate-form {
            display: flex;
            flex-direction: column;
        }
        label {
            margin-bottom: 8px;
            font-weight: bold;
        }
        .qna-input, .qna-area {
            padding: 10px;
            margin-bottom: 20px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }
        .qna-area {
            resize: vertical;
            min-height: 200px;
        }
        .button-group {
            display: flex;
            justify-content: center;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            font-size: 14px;
            border-radius: 4px;
            cursor: pointer;
            text-decoration: none;
        }
        .btn-submit {
            background-color: #4CAF50;
            color: white;
        }
        .btn-cancel {
            background-color: #ccc;
            color: #333;
        }
        .btn:hover {
            opacity: 0.9;
        }

    </style>
</head>
<body>

<div class="container">
    <div class="qna-title"><h2>문의 수정</h2></div>

    <form action="/CarrotEasy/qnaUpdate.do" method="post" id="qnaUpdate-form" class="qnaUpdate-form">
        <input type="hidden" name="qnaNo" value="${qnaVo.qnaNo}">

        <label for="title">제목</label>
        <input type="text" class="qna-input" id="title" name="title" value="${qnaVo.qnaTitle}" required>

        <label for="content">내용</label>
        <textarea class="qna-area" id="content" name="content" required>${qnaVo.qnaContent}</textarea>

        <div class="button-group">
            <button type="submit" class="btn btn-submit">수정</button>
            <a href="/CarrotEasy/qnaDetail.do?qnaNo=${qnaVo.qnaNo}" class="btn btn-cancel">취소</a>
        </div>
    </form>
</div>

</body>
</html>
