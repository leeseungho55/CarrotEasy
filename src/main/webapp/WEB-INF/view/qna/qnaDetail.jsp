<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>문의 상세보기</title>
    <style>
        /* 기본적인 스타일 */
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

/* 문의 내용 테이블 스타일 */
.detail-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 30px;
}

.detail-table th, .detail-table td {
    padding: 12px;
    border: 1px solid #eee;
    text-align: left;
}

.detail-table th {
    background-color: #f4f4f4;
    font-weight: bold;
    width: 150px;
}

.detail-table td {
    background-color: #fafafa;
}

/* 버튼 스타일 */
.button-bar {
    text-align: center;
    margin-top: 20px;
}

.button-bar button {
    padding: 10px 20px;
    font-size: 16px;
    border: none;
    border-radius: 8px;
    background-color: #FF8A3D;
    color: white;
    cursor: pointer;
    margin: 0 10px;
    transition: background-color 0.3s ease, transform 0.3s ease;
}

.button-bar button:hover {
    background-color: #e0423f;
    transform: translateY(-2px);
}

.answer-section {
    margin-top: 30px;
    padding: 20px;
    background-color: #f9f9f9;
    border-radius: 10px;
    box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.answer-section h3 {
    font-size: 20px;
    font-weight: bold;
    margin-bottom: 10px;
    color: #333;
}

.answer-content {
    padding: 15px;
    background-color: #fff;
    border-radius: 8px;
    box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

.answer-content {
    background-color: #f4f4f4;
    font-size: 16px;
    line-height: 1.5;
}

.answer-form {
    margin-top: 20px;
}

#answer-content {
    width: 100%;
    height: 120px;
    padding: 12px;
    font-size: 16px;
    border: 1px solid #ccc;
    border-radius: 8px;
    resize: none;
    background-color: #fafafa;
}

#answer-submit {
    margin-top: 10px;
    padding: 10px 20px;
    font-size: 16px;
    background-color: #ff8a3d;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#answer-submit:hover {
    background-color: #218838;
}

#answer-btn {
    padding: 10px 20px;
    font-size: 16px;
    background-color: #FF8A3D;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease;
}

#answer-btn:hover {
    background-color: #e0423f;
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .container {
        padding: 15px;
    }

    .detail-table th, .detail-table td {
        font-size: 14px;
        padding: 10px;
    }

    .button-bar button {
        padding: 8px 16px;
        font-size: 14px;
    }

    #answer-content {
        height: 100px;
        font-size: 14px;
    }

    #answer-submit {
        font-size: 14px;
    }

    #answer-btn {
        font-size: 14px;
    }
}


    </style>
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
    <script>
    $(function(){
        $('#qnaList').click(() => location.href="/CarrotEasy/qnaList.do");
        $('#edit-btn').click(() => location.href="/CarrotEasy/qnaUpdate.do?qnaNo=${qnaVo.qnaNo}");
        $('#delete-btn').click(() => {
            if(confirm("정말 삭제하시겠습니까?")){
                $('<form>', {
                    method: 'post',
                    action: '/CarrotEasy/qnaDelete.do'
                }).append($('<input>', {
                    type: 'hidden',
                    name: 'qnaNo',
                    value: '${qnaVo.qnaNo}'
                })).appendTo('body').submit();
            }
        });
        $('#answer-btn').click(() => {
            $('#answer-form').slideToggle();
            $('#answer-btn').text($('#answer-btn').text() === '답변 작성' ? '답변 작성' : '닫기');
        });
        $('#answer-submit').click(() => {
            $('<form>', {
                method: 'post',
                action: '/CarrotEasy/qnaInsertAnswer.do'
            }).append($('<input>', {
                type: 'hidden',
                name: 'qnaNo',
                value: '${qnaVo.qnaNo}'
            })).append($('<input>', {
                type: 'hidden',
                name: 'content',
                value: $('#answer-content').val()
            })).appendTo('body').submit();
        });
    });
    </script>
</head>
<body>
<div class="container">
    <h2>문의 상세보기</h2>
    <table class="detail-table">
        <tr><th>번호</th><td>${qnaVo.qnaNo}</td></tr>
        <tr><th>제목</th><td>${qnaVo.qnaTitle}</td></tr>
        <tr><th>작성자</th><td>${qnaVo.memNick}</td></tr>
        <tr><th>등록일</th><td>${qnaVo.createDate}</td></tr>
        <tr><th>수정일</th><td>${qnaVo.updateDate}</td></tr>
        <tr><th>내용</th><td><pre>${qnaVo.qnaContent}</pre></td></tr>
    </table>

    <div class="button-bar">
        <button class="back" id="qnaList">목록으로</button>
        <button id="edit-btn">수정하기</button>
        <button id="delete-btn">삭제하기</button>
    </div>

    <div class="answer-section">
        <h3>관리자 답변</h3>
        <c:choose>
            <c:when test="${not empty qnaVo.qnaAnswer}">
                <div class="answer-content">${qnaVo.qnaAnswer}</div>
            </c:when>
            <c:otherwise>
                <div class="answer-content">등록된 답변이 없습니다.</div>
                <c:if test="${sessionScope.member.memRole eq 1}">
                    <div class="answer-form" id="answer-form">
                        <textarea id="answer-content" placeholder="답변을 입력하세요..."></textarea>
                        <button id="answer-submit">답변 등록</button>
                    </div>
<!--                     <div style="margin-top: 10px;"> -->
<!--                         <button id="answer-btn">답변 작성</button> -->
<!--                     </div> -->
                </c:if>
            </c:otherwise>
        </c:choose>
    </div>
</div>
</body>
</html>
