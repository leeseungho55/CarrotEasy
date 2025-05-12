<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>중고물품 목록</title>
    <script src="/CarrotEasy/resource/js/jquery-3.7.1.js"></script>
    <style>
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
        .search-group {
            display: flex;
            align-items: flex-end;
            gap: 10px;
        }
        .btn {
            background-color: #ff6b00;
            color: white;
            border: none;
            padding: 10px 20px;
            text-align: center;
            text-decoration: none;
            display: inline-block;
            font-size: 16px;
            margin: 4px 2px;
            cursor: pointer;
            border-radius: 5px;
        }
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 25px;
        }
        .product-card {
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            overflow: hidden;
            transition: transform 0.2s, box-shadow 0.2s;
            text-decoration: none; /* 링크 밑줄 제거 */
        }
        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        .product-image {
            width: 100%;
            height: 200px;
            object-fit: cover;
            background-color: #f0f0f0;
        }
        .product-info {
            padding: 15px;
        }
        .product-title {
            font-size: 16px;
            font-weight: bold;
            margin-bottom: 10px;
            height: 40px;
            overflow: hidden;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
        }
        .product-price {
            font-size: 18px;
            font-weight: bold;
            color: #ff6b00;
            margin-bottom: 10px;
        }
        .product-meta {
            display: flex;
            justify-content: space-between;
            font-size: 12px;
            color: #666;
        }
        .product-status {
            display: inline-block;
            padding: 3px 6px;
            background-color: #e0e0e0;
            color: #333;
            border-radius: 3px;
            font-size: 11px;
            margin-right: 5px;
        }
        .product-location {
            overflow: hidden;
            white-space: nowrap;
            text-overflow: ellipsis;
        }
        .no-products {
            grid-column: 1 / -1;
            text-align: center;
            padding: 30px;
            background-color: #f8f8f8;
            border-radius: 5px;
        }
        .actions {
            margin-top: 20px;
            text-align: right;
        }
    </style>
</head>
<body>
    <div class="container">        
        <div class="product-grid">
            <c:if test="${empty prodList}">
                <div class="no-products">
                    <p>등록된 상품이 없습니다.</p>
                </div>
            </c:if>
            
            <c:forEach items="${prodList}" var="prod" varStatus="status">
                <a href="/CarrotEasy/prod/view.do?prodNo=${prod.prodNo}" class="product-card">
                    <c:set var="thumbnail" value="${thumbnailList[status.index]}" />
                    <c:choose>
                        <c:when test="${not empty thumbnail}">
                            <img class="product-image" src="/CarrotEasy${thumbnail.filePath}" alt="${prod.prodTitle}">
                        </c:when>
                        <c:otherwise>
                            <div class="product-image" style="display: flex; align-items: center; justify-content: center; background-color: #e9e9e9;">
                                <span style="color: #999;">이미지 없음</span>
                            </div>
                        </c:otherwise>
                    </c:choose>
                    
                    <div class="product-info">
                        <div class="product-title">${prod.prodTitle}</div>
                        <div class="product-price"><fmt:formatNumber value="${prod.prodPrice}" type="number" pattern="#,###"/>원</div>
                        <div class="product-meta">
                            <div>
                                <span class="product-status">
                                    <c:choose>
                                        <c:when test="${prod.prodType.code == 'FOR_SALE'}">판매중</c:when>
                                        <c:when test="${prod.prodType.code == 'RESERVED'}">예약중</c:when>
                                        <c:when test="${prod.prodType.code == 'SOLD_OUT'}">판매완료</c:when>
                                    </c:choose>
                                </span>
                                <span class="product-status">
                                    <c:choose>
                                        <c:when test="${prod.prodStatus.code == 'NEW'}">새상품</c:when>
                                        <c:when test="${prod.prodStatus.code == 'ALMOST_NEW'}">거의 새것</c:when>
                                        <c:when test="${prod.prodStatus.code == 'SLIGHTLY_USED'}">사용감 있음</c:when>
                                        <c:when test="${prod.prodStatus.code == 'USED'}">중고</c:when>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="product-location">${prod.areaName}</div>
                        </div>
                    </div>
                </a>
            </c:forEach>
        </div>
    </div>
</body>
</html>