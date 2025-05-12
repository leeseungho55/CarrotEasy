<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
	<meta charset="UTF-8">
    <script src="https://code.jquery.com/jquery-latest.min.js"></script>
	<style>
        .container {
			max-width: 1180px;
            margin: 8px auto;
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
            /* display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 20px;
            justify-items: center;	/* 각 카드 가운데 정렬 */
            /* 카드를 전체 폭으로 */
/*             justify-items: stretch; */
            
	        display: grid;
	        grid-template-columns: repeat(auto-fill, minmax(220px, 1fr));
			gap: 20px;
            
            
        }

        .product-card {
        	/* width: 100%;
        	max-width: 200px;
            border: 1px solid #ddd;
            border-radius: 10px;
            background-color: #fff;
            padding: 8px;
            text-decoration: none;
            color: inherit;
            transition: transform 0.2s; */
            
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            padding: 10px;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none;
			  
        }

        .product-card:hover {
            transform: translateY(-4px);
/*             box-shadow: 0 4px 10px rgba(0, 0, 0, 0.05); */
        }
        
        img.product-image {
            width: 100%;
            height: 200px;
		    object-fit: cover;
		    border-radius: 6px;
		}

        .product-image .no-image {
            /* width: 240px;
            height: 140px;
            object-fit: cover;
            border-radius: 6px;
            background-color: #f0f0f0; */
            
              display: flex;
			  align-items: center;
			  justify-content: center;
			  color: #999;
			  font-size: 14px;
        }

        .product-title {
            /* font-size: 14px;
            font-weight: bold;
            margin-top: 10px;
            height: 32px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical; */
            
            
              font-size: 14px;
			  font-weight: bold;
			  margin: 10px 0 4px;
			  height: 36px;
			  overflow: hidden;
			  display: -webkit-box;
			  -webkit-line-clamp: 2;
			  -webkit-box-orient: vertical;
        }

        .product-price {
            font-size: 13px;
            font-weight: bold;
            color: #ff6b00;
/*             margin: 6px 0 2px; */
        }

        .product-location {
            font-size: 12px;
            color: #666;
        }

        .swiper {
            width: 100%;
            height: 470px;
            margin-bottom: 30px;
            position: relative;
        }

        .swiper img {
            width: 100%;
            height: 470px;
            object-fit: cover;
        }
    </style>
</head>
<body>
	<div class="container">
		<hr style="border: none; border-top: 2px solid #eee; margin: 40px 0; width:99%;">
		<div class="section-header">
        	<div class="section-title">내가 찜한 상품</div>
    	</div>
		<div class="product-grid">
		        <c:forEach items="${storeJjimList}" var="jjim" varStatus="status">
		            <a href="/CarrotEasy/prod/view.do?prodNo=${jjim.prodNo}" class="product-card">
 		                <c:set var="thumbnail" value="${sumnailImg[status.index]}" />
		                <c:choose>
		                    <c:when test="${not empty thumbnail}">
 		                        <img class="product-image" src="/CarrotEasy/${thumbnail.filePath}" alt="${prod.prodTitle}">
		                        <%-- <img class="product-image" src="/CarrotEasy/resource/img/CarrotEasy.png" alt="${jjim.prodTitle}" style="width:100px; height: 100px;"> --%>
		                    </c:when>
		                    <c:otherwise>
		                        <div class="product-image no-image">
		                            <span style="color:#999;">이미지 없음</span>
		                        </div>
		                    </c:otherwise>
		                </c:choose>
		                <div class="product-title">${jjim.prodTitle}</div>
		                <div class="product-price"><fmt:formatNumber value="${jjim.prodPrice}" pattern="#,###"/>원</div>
		                <div class="product-location">${jjim.prodLocation}</div>
		            </a>
		        </c:forEach>
		    </div>
	</div>
</body>
</html>