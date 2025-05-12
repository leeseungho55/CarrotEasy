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
        body {
    		font-family: 'Noto Sans KR', sans-serif;
    		background-color: #f7f7f7;
    		margin: 0;
    		padding: 0;
		}
		
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
        .filters {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-bottom: 30px;
            padding: 15px;
            background-color: #f8f8f8;
            border-radius: 5px;
        }
        .filter-group {
            flex: 1;
            min-width: 200px;
        }
        .filter-group label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .filter-select-group {
            display: flex;
            gap: 10px;
        }
        .filter-select-group select {
            flex: 1;
        }
        .filter-group select, .filter-group input {
            width: 90%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
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
        <h1>중고물품 목록</h1>
        
        <form action="/CarrotEasy/prod/list.do" method="get" id="filterForm">
            <div class="filters">
                <div class="filter-group">
                    <label>카테고리</label>
                    <div class="filter-select-group">
                        <select id="parentCateSelect" name="parentCateNo">
                            <option value="0">전체 카테고리</option>
                            <c:forEach items="${categoryList}" var="category">
                                <option value="${category.cateNo}" ${selectedParentCateNo == category.cateNo ? 'selected' : ''}>${category.cateName}</option>
                            </c:forEach>
                        </select>
                        <select id="subCateSelect" name="cateNo">
                            <option value="0">하위 카테고리</option>
                            <c:forEach items="${subCategoryList}" var="subCategory">
                                <option value="${subCategory.cateNo}" ${selectedCateNo == subCategory.cateNo ? 'selected' : ''}>${subCategory.cateName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                
                <div class="filter-group">
                    <label>지역</label>
                    <div class="filter-select-group">
                        <select id="districtSelect" name="districtNo">
                            <option value="0">전체 지역</option>
                            <c:forEach items="${districtList}" var="district">
                                <option value="${district.areaNo}" ${selectedDistrictNo == district.areaNo ? 'selected' : ''}>${district.areaName}</option>
                            </c:forEach>
                        </select>
                        <select id="dongSelect" name="areaNo">
                            <option value="0">동 선택</option>
                            <c:forEach items="${dongList}" var="dong">
                                <option value="${dong.areaNo}" ${selectedAreaNo == dong.areaNo ? 'selected' : ''}>${dong.areaName}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
                <!-- 
                <div class="filter-group search-group">
                    <div style="flex-grow: 1;">
                        <label for="keyword">검색어</label>
                        <input type="text" id="keyword" name="keyword" value="${keyword}" placeholder="상품명, 내용 검색">
                    </div>
                    <button type="submit" class="btn">검색</button>
                </div>
                 --> 
            </div>
        </form>
        
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
        
        <div class="actions">
            <a href="/CarrotEasy/prod/insert.do" class="btn">상품 등록하기</a>
        </div>
    </div>
    
    <script>
        // 상위 카테고리 선택 시 이벤트 처리
        document.getElementById('parentCateSelect').addEventListener('change', function() {
	    const parentCateNo = this.value;
	    
	    // 상위 카테고리가 변경되면 하위 카테고리 초기화
	    const subCateSelect = document.getElementById('subCateSelect');
	    subCateSelect.innerHTML = '<option value="0">하위 카테고리</option>';
	    
	    if (parentCateNo > 0) {
	        // AJAX로 하위 카테고리 목록 로드
	        fetch('/CarrotEasy/cate/subcategories?parentCateNo=' + parentCateNo)
	            .then(response => {
	                if (!response.ok) {
	                    throw new Error('서버 응답 오류');
	                }
	                return response.json();
	            })
	            .then(data => {
	                // 받아온 하위 카테고리 목록으로 옵션 추가
	                data.forEach(subcategory => {
	                    const option = document.createElement('option');
	                    option.value = subcategory.cateNo;
	                    option.textContent = subcategory.cateName;
	                    subCateSelect.appendChild(option);
	                });
	            })
	            .catch(error => {
	                console.error('하위 카테고리 목록을 불러오는 중 오류 발생:', error);
	            });
	    }
	    
	    // 폼 제출 (상위 카테고리 선택만으로 검색 실행)
	    document.getElementById('filterForm').submit();
	});
        
        // 하위 카테고리 목록 로드 함수
        function loadSubcategories(parentCateNo) {
            // 상위 카테고리가 전체(0)인 경우 하위 카테고리 초기화하고 폼 제출
            if (parentCateNo == 0) {
                const subCateSelect = document.getElementById('subCateSelect');
                subCateSelect.innerHTML = '<option value="0">하위 카테고리</option>';
                document.getElementById('filterForm').submit();
                return;
            }
            
            // AJAX 요청으로 하위 카테고리 목록 가져오기
            fetch('/CarrotEasy/cate/subcategories?parentCateNo=' + parentCateNo)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('서버 응답 오류');
                    }
                    return response.json();
                })
                .then(data => {
                    const subCateSelect = document.getElementById('subCateSelect');
                    
                    // 기존 옵션 초기화 (첫 번째 옵션은 유지)
                    subCateSelect.innerHTML = '<option value="0">하위 카테고리</option>';
                    
                    // 받아온 하위 카테고리 목록으로 옵션 추가
                    data.forEach(subcategory => {
                        const option = document.createElement('option');
                        option.value = subcategory.cateNo;
                        option.textContent = subcategory.cateName;
                        subCateSelect.appendChild(option);
                    });
                    
                    // 폼 제출
                    document.getElementById('filterForm').submit();
                })
                .catch(error => {
                    console.error('하위 카테고리 목록을 불러오는 중 오류 발생:', error);
                    alert('카테고리 정보를 불러오는데 실패했습니다.');
                });
        }
        
        // 구 선택 시 이벤트 처리
        document.getElementById('districtSelect').addEventListener('change', function() {
            const districtNo = this.value;
            loadDongs(districtNo);
        });
        
        // 동 목록 로드 함수
        function loadDongs(districtNo) {
            // 구가 전체(0)인 경우 동 초기화하고 폼 제출
            if (districtNo == 0) {
                const dongSelect = document.getElementById('dongSelect');
                dongSelect.innerHTML = '<option value="0">동 선택</option>';
                document.getElementById('filterForm').submit();
                return;
            }
            
            // AJAX 요청으로 동 목록 가져오기
            fetch('/CarrotEasy/area/dongs?districtNo=' + districtNo)
                .then(response => {
                    if (!response.ok) {
                        throw new Error('서버 응답 오류');
                    }
                    return response.json();
                })
                .then(data => {
                    const dongSelect = document.getElementById('dongSelect');
                    
                    // 기존 옵션 초기화 (첫 번째 옵션은 유지)
                    dongSelect.innerHTML = '<option value="0">동 선택</option>';
                    
                    // 받아온 동 목록으로 옵션 추가
                    data.forEach(dong => {
                        const option = document.createElement('option');
                        option.value = dong.areaNo;
                        option.textContent = dong.areaName;
                        dongSelect.appendChild(option);
                    });
                    
                    // 폼 제출
                    document.getElementById('filterForm').submit();
                })
                .catch(error => {
                    console.error('동 목록을 불러오는 중 오류 발생:', error);
                    alert('지역 상세 정보를 불러오는데 실패했습니다.');
                });
        }
        
        // 하위 카테고리 변경 시 직접 폼 제출
        document.getElementById('subCateSelect').addEventListener('change', function() {
            document.getElementById('filterForm').submit();
        });
        
        // 동 변경 시 직접 폼 제출
        document.getElementById('dongSelect').addEventListener('change', function() {
            document.getElementById('filterForm').submit();
        });
    </script>
</body>
</html>