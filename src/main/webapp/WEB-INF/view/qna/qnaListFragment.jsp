<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:choose>
    <c:when test="${not empty qnaList}">
        <c:forEach var="qna" items="${qnaList}">
            <tr>
                <td>${qna.qnaNo}</td>
                <td>
                    <c:choose>
                        <c:when test="${sessionScope.member.memNo eq qna.memNo or sessionScope.member.memRole eq 1}">
                            <a href="/CarrotEasy/qnaDetail.do?qnaNo=${qna.qnaNo}">${qna.qnaTitle}</a>
                        </c:when>
                        <c:otherwise>
                            <a href="javascript:void(0)" onclick="alert('작성자만 열람 가능합니다.')">${qna.qnaTitle}</a>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>${qna.memNick}</td>
                <td>${qna.createDate}</td>
                <td>
                    <c:choose>
                        <c:when test="${not empty qna.qnaAnswer}">
                            답변완료
                        </c:when>
                        <c:otherwise>
                            -
                        </c:otherwise>
                    </c:choose>
                </td>
            </tr>
        </c:forEach>
    </c:when>
    <c:otherwise>
        <tr>
            <td colspan="5">등록된 문의가 없습니다.</td>
        </tr>
    </c:otherwise>
</c:choose>
