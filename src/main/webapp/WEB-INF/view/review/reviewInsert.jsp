<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 등록</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 40px 0;
        }

        h2 {
            text-align: center;
            color: #333;
            margin-bottom: 30px;
        }

        form {
            background: #fff;
            max-width: 500px;
            margin: 0 auto;
            padding: 30px 25px;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        label {
            display: block;
            margin-top: 20px;
            font-weight: bold;
            color: #444;
        }

        input[type="text"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 8px;
            border: 1px solid #ccc;
            border-radius: 6px;
            box-sizing: border-box;
            transition: border 0.3s;
        }

        input[type="text"]:focus,
        select:focus,
        textarea:focus {
            border-color: #f2b01e;
            outline: none;
        }

        select {
            font-size: 16px;
            color: #444;
        }

        button {
            width: 100%;
            margin-top: 30px;
            padding: 12px;
            background-color: #f2b01e;
            color: #fff;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background 0.3s;
        }

        button:hover {
            background-color: #d99a15;
        }
</style>
<script type="text/javascript">

</script>
</head>
<body>

    <h2>
        <i class="fa-solid fa-star" style="color: gold;"></i> 리뷰 작성
    </h2>

    <form action="/CarrotEasy/review/InsertReview.do" method="post">
        <!-- hidden 필드 -->
        <input type="hidden" name="prodNo" value="${prodNo}" />
        <input type="hidden" name="memNo" value="${memNo}" />

        <!-- 별점 선택 -->
        <label for="reviewScore">별점</label>
        <select id="reviewScore" name="reviewScore" required>
            <option value="">점수를 선택하세요</option>
            <option value="5">★★★★★ (5점)</option>
            <option value="4">★★★★☆ (4점)</option>
            <option value="3">★★★☆☆ (3점)</option>
            <option value="2">★★☆☆☆ (2점)</option>
            <option value="1">★☆☆☆☆ (1점)</option>
        </select>

        <!-- 내용 -->
        <label for="reviewTitle">리뷰 내용</label>
        <textarea id="reviewTitle" name="reviewTitle" rows="5" placeholder="상품에 대한 후기를 남겨주세요." required></textarea>

        <!-- 제출 버튼 + 취소 버튼 -->
        <div style="display: flex; gap: 10px; margin-top: 30px;">
            <button type="submit" style="flex: 1;">리뷰 등록</button>
            <button type="button" style="flex: 1; background-color: #ccc; color: #333;" onclick="window.close();">취소</button>
        </div>
    </form>

    </form>

</body>
</html>
