<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>당근이지 - 메인</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.css"/>
    <script src="https://cdn.jsdelivr.net/npm/swiper@9/swiper-bundle.min.js"></script>
    <style>
        body {
            margin: 0;
            width: 100%;
            font-family: '맑은 고딕', sans-serif;
            background-color: #f9f9f9;
        }

        .container {
            max-width: 1200px;
            margin: auto;
            padding: 20px;
            background: #fff;
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 40px 0 10px;
        }

        .section-title {
            font-size: 20px;
            font-weight: bold;
            display: flex;
            align-items: center;
        }

        .section-title span {
            background-color: royalblue;
            color: white;
            border-radius: 4px;
            padding: 2px 6px;
            margin-left: 4px;
            font-size: 16px;
        }

        .more-link {
            font-size: 14px;
            color: #007bff;
            text-decoration: none;
        }

        .more-link:hover {
            text-decoration: underline;
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
            gap: 20px;
        }

        .product-card {
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            padding: 10px;
            text-decoration: none;
            color: inherit;
            transition: transform 0.2s;
        }

        .product-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05);
        }

        .product-image {
            width: 100%;
            height: 160px;
            object-fit: cover;
            border-radius: 6px;
            background-color: #f0f0f0;
        }

        .product-title {
            font-size: 15px;
            font-weight: bold;
            margin-top: 10px;
            height: 38px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }

        .product-price {
            font-size: 15px;
            font-weight: bold;
            color: #ff6b00;
            margin: 6px 0 2px;
        }

        .product-location {
            font-size: 13px;
            color: #666;
        }

        .swiper {
            width: 100%;
            height: 470px;
            margin-bottom: 30px;
            position: relative;
            z-index: 1;
        }

        .swiper img {
            width: 100%;
            height: 470px;
            object-fit: cover;
        }
        .swiper-slide {
		  position: relative;
		  z-index: 0 !important; /* 이미지가 위에 덮는 것을 방지 */
		}
        
    </style>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            new Swiper('.swiper', {
                loop: true,
                slidesPerView: 1,
                autoplay: {
                    delay: 5000,
                    disableOnInteraction: false
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true
                },
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev'
                },
                scrollbar: {
                    el: '.swiper-scrollbar'
                }
            });
        });
    </script>
</head>

<body>
<div class="container">
    <!-- 🔶 상품 배너 -->
	<div class="swiper">
	    <div class="swiper-wrapper">
	        <c:forEach var="ad" items="${adBanner}">
	            <div class="swiper-slide">
	                <a href="${ad.adUrl}" target="_blank">
	                    <c:choose>
				            <c:when test="${fn:startsWith(ad.adImg, '/')}">
				              <!-- 경로가 /로 시작하면 그대로 사용 -->
				              <img src="${ad.adImg}" alt="배너 이미지">
				            </c:when>
				            <c:otherwise>
				              <!-- 그렇지 않으면 contextPath 추가 -->
				              <img src="${pageContext.request.contextPath}/${ad.adImg}" alt="배너 이미지">
				            </c:otherwise>
				          </c:choose>
	                </a>
	            </div>
	        </c:forEach>
	    </div>
	    <div class="swiper-button-next"></div>
	    <div class="swiper-button-prev"></div>
	    <div class="swiper-pagination"></div>
	    <div class="swiper-scrollbar"></div>
	</div>

    <!-- 추천 상품 -->
    <div class="section-header">
        <h2 class="section-title">🍠 인기 <span>상품</span></h2>
    </div>

    <div class="product-grid">
        <c:forEach items="${recommendList}" var="prod" varStatus="status">
            <a href="/CarrotEasy/prod/view.do?prodNo=${prod.prodNo}"  class="product-card">
                <c:set var="thumbnail" value="${recommendThumbnailList[status.index]}" />
                <c:choose>
                    <c:when test="${not empty thumbnail}">
                        <img class="product-image" src="/CarrotEasy${thumbnail.filePath}" alt="${prod.prodTitle}">
                    </c:when>
                    <c:otherwise>
                        <div class="product-image" style="display:flex;align-items:center;justify-content:center;">
                            <span style="color:#999;">이미지 없음</span>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="product-title">${prod.prodTitle}</div>
                <div class="product-price"><fmt:formatNumber value="${prod.prodPrice}" pattern="#,###"/>원</div>
                <div class="product-location">${prod.prodLocation}</div>
            </a>
        </c:forEach>
    </div>

    <!-- 최신 상품 -->
    <div class="section-header">
        <h2 class="section-title">🕒 최신 등록 상품</h2>
        <a class="more-link" href="/CarrotEasy/prod/list.do">+ 더보기</a>
    </div>

    <div class="product-grid">
        <c:forEach items="${latestList}" var="prod" varStatus="status">
            <a href="/CarrotEasy/prod/view.do?prodNo=${prod.prodNo}" class="product-card">
                <c:set var="thumbnail" value="${latestThumbnailList[status.index]}" />
                <c:choose>
                    <c:when test="${not empty thumbnail}">
                        <img class="product-image" src="/CarrotEasy${thumbnail.filePath}" alt="${prod.prodTitle}">
                    </c:when>
                    <c:otherwise>
                        <div class="product-image" style="display:flex;align-items:center;justify-content:center;">
                            <span style="color:#999;">이미지 없음</span>
                        </div>
                    </c:otherwise>
                </c:choose>
                <div class="product-title">${prod.prodTitle}</div>
                <div class="product-price"><fmt:formatNumber value="${prod.prodPrice}" pattern="#,###"/>원</div>
                <div class="product-location">${prod.prodLocation}</div>
            </a>
        </c:forEach>
    </div>
</div>
</body>
</html>
