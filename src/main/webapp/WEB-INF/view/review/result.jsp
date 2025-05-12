<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>요청 파라미터 확인</title>
    <style>
        body {
            font-family: sans-serif;
            padding: 30px;
        }
        table {
            border-collapse: collapse;
            width: 50%;
            margin: 0 auto;
        }
        th, td {
            padding: 10px;
            border: 1px solid #ccc;
        }
        th {
            background: #f2f2f2;
        }
        h2 {
            text-align: center;
        }
    </style>
</head>
<body>

    <h2>요청 파라미터 확인</h2>

    <table>
        <tr>
            <th>파라미터 이름</th>
            <th>값</th>
        </tr>
        <tr>
            <td>prodNo</td>
            <td><%= request.getParameter("prodNo") %></td>
        </tr>
        <tr>
            <td>memNo</td>
            <td><%= request.getParameter("memNo") %></td>
        </tr>
        <tr>
            <td>reviewScore</td>
            <td><%= request.getParameter("reviewScore") %></td>
        </tr>
        <tr>
            <td>reviewTitle</td>
            <td><%= request.getParameter("reviewTitle") %></td>
        </tr>
        <tr>
            <td>reviewContent</td>
            <td><%= request.getParameter("reviewContent") %></td>
        </tr>
    </table>

</body>
</html>
