<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>리뷰 목록</title>
    <style>
        .review-container { max-width: 700px; margin: 0 auto; }
        h2 { text-align: center; margin-bottom: 20px; }
        .review { border-bottom: 1px solid #ddd; padding: 15px 0; }
        .review .meta { font-size: 14px; color: #555; margin-bottom: 5px; }
        .review .rating { color: #f39c12; }
        #load-more { margin-top: 20px; text-align: center; }
        #load-more button {
            padding: 10px 20px; font-size: 14px;
            border: 1px solid #333; background: #fff; cursor: pointer;
        }
    </style>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
</head>
<body>
<div class="review-container">
    <h2>리뷰 목록</h2>

    <div id="review-list">
        <c:forEach var="review" items="${storeReviewList}">
            <div class="review">
                <div class="meta">
                    <strong>${review.reviewMemberNick}</strong> |
                    <span class="rating">
                        <c:forEach begin="1" end="${review.reviewScore}">★</c:forEach>
                    </span> |
                    ${review.createDate}
                </div>
                <div class="content">${review.reviewTitle}</div>
            </div>
        </c:forEach>
    </div>

<!--     <div id="load-more"> -->
<!--         <button id="loadMoreBtn">더보기</button> -->
<!--     </div> -->
</div>

<script>
    /* let currentPage = 1;
    const pageSize = 5;

    $("#loadMoreBtn").click(function () {
        currentPage++;
        $.ajax({
            url: "/review-more",
            type: "GET",
            data: { page: currentPage, size: pageSize },
            dataType: "json",
            success: function (data) {
                if (data.length === 0) {
                    $("#loadMoreBtn").hide();
                    return;
                }

                data.forEach(function (review) {
                    const stars = "★".repeat(review.reviewScore);
                    const html = `
                        <div class="review">
                            <div class="meta">
                                <strong>${review.reviewMemberNick}</strong> |
                                <span class="rating">${stars}</span> |
                                ${review.date}
                            </div>
                            <div class="content">${review.reviewTitle}</div>
                        </div>
                    `;
                    $("#review-list").append(html);
                });
            }
        });
    }); */
</script>
</body>
</html>
