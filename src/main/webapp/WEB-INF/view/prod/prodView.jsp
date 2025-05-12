<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>상품 상세 정보</title>
    <script src="/CarrotEasy/resource/js/jquery-3.7.1.js"></script>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <!-- 포트원 결제 -->
    <script src="https://cdn.iamport.kr/v1/iamport.js"></script>
    <!-- jQuery -->
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
    <!-- iamport.payment.js -->
    <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
    <!-- 포트원 결제 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
        <style>
        .container {
            max-width: 1180px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .title-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 5px;
            border-bottom: 1px solid #eee;
            gap: 0;
        }
        .shop-link {
            font-size: 14px;
            text-decoration: none;
            color: #007bff;
            font-weight: 500;
            margin-top: 25px;
            margin-right: 0;
            text-decoration: underline;
        }
        h1 {
            color: #333;
            margin-bottom: 5px;
            padding-bottom: 5px;
        }
        .product-info {
            margin-bottom: 30px;
        }
        .product-meta {
            display: flex;
            justify-content: space-between;
            color: #666;
            font-size: 14px;
            margin-bottom: 20px;
        }
        .product-price {
            font-size: 24px;
            font-weight: bold;
            color: #ff6b00;
            margin: 15px 0;
        }
        .product-status {
            display: inline-block;
            padding: 5px 10px;
            background-color: #e0e0e0;
            color: #333;
            border-radius: 5px;
            font-size: 12px;
            margin-right: 10px;
        }
        .product-content {
            line-height: 1.6;
            margin-bottom: 30px;
            white-space: pre-line;
        }
        .product-location {
            background-color: #f8f8f8;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 30px;
        }
        .product-price-wrapper {
            display: flex;
            align-items: center;
            justify-content: space-between; 
            margin-top: 10px;
        }
        .jjim-btn {
            background: none;
            border: none;
            cursor: pointer;
            padding: 0;
        }
        .jjim-icon {
            width: 28px;
            height: 28px;
        }
        .jjim-wrapper {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .product-location p {
            margin: 0;
            color: #555;
        }
        .image-gallery {
            margin-bottom: 30px;
        }
        .gallery-container {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }
        .main-image {
            width: 100%;
            height: 400px;
            object-fit: contain;
            margin-bottom: 10px;
            background-color: #f8f8f8;
            border-radius: 5px;
        }
        .thumbnail {
            width: 80px;
            height: 80px;
            object-fit: cover;
            cursor: pointer;
            border: 2px solid transparent;
            border-radius: 5px;
        }
        .thumbnail.active {
            border-color: #ff6b00;
        }
        .btn-group {
            margin-top: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .btn-group-right {
            margin-left: auto;
            display: flex;
            gap: 10px;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            text-align: center;
        }
        .btn-back {
            background-color: #6c757d;
            color: white;
        }
        .btn-primary {
            background-color: #FF8A3D;
            color: white;
        }
		.btn-good {
		    background-color: #FF8A3D;
		    color: white;
		    padding: 10px 20px;
		    font-size: 16px;
		    border: none;
		    border-radius: 5px;
		    cursor: pointer;
		    text-decoration: none;
		    text-align: center;
		}
        #buyer-select {
		    padding: 8px 12px;
		    padding-right: 30px; /* 👈 아이콘이랑 안 겹치게 */
		    border: 1px solid #ccc;
		    border-radius: 6px;
		    font-size: 14px;
		    background-color: #fff;
		    color: #333;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
		    outline: none;
		    appearance: none;
		    background-image: url("data:image/svg+xml;charset=UTF-8,%3Csvg width='14' height='10' viewBox='0 0 14 10' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath fill='%23666' d='M7 10L0 0h14z'/%3E%3C/svg%3E");
		    background-repeat: no-repeat;
		    background-position: right 10px center;
		    background-size: 16px;
		}
		#status-select {
		    padding: 8px 12px;
		    border: 1px solid #ccc;
		    border-radius: 6px;
		    font-size: 14px;
		    background-color: #fff;
		    color: #333;
		    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
		    outline: none;
		    appearance: none;
		    background-image: url("data:image/svg+xml;charset=UTF-8,%3Csvg width='14' height='10' viewBox='0 0 14 10' xmlns='http://www.w3.org/2000/svg'%3E%3Cpath fill='%23666' d='M7 10L0 0h14z'/%3E%3C/svg%3E");
		    background-repeat: no-repeat;
		    background-position: right 10px center;
		    background-size: 12px;
		}
    </style>
   
    <script>
		const prodNo = '${prod.prodNo}'; // 상품 번호
		const memNo = '${sessionScope.member.memNo}'; // 로그인 사용자 번호 
		const prodType = '${prod.prodType}';

	    function toggleLike() {
	        const heartIcon = document.getElementById('heartIcon');
	        if (heartIcon.classList.contains('fa-regular')) {
	            heartIcon.classList.remove('fa-regular');
	            heartIcon.classList.add('fa-solid');
	            
	            $.ajax({
	            	url: "/CarrotEasy/jjim.do",
                	method: "GET",
                	dataType: "json",
                	data: { prodJJim : "on", prodNo: prodNo, memNo: memNo},
                	success: function(res) {
                	    console.log("찜 성공", res);
                	    $('#jjimCountText').text(res.jjimCount + '명이 찜했어요');
                	},error: function(xhr, status, error) {
	                    console.error("실패:", error);
	                }
                });
	        } else {
	            heartIcon.classList.remove('fa-solid');
	            heartIcon.classList.add('fa-regular');
	            
	            $.ajax({
	            	url: "/CarrotEasy/jjim.do",
                	method: "GET",
                	dataType: "json",
                	data: { prodJJim : "off",prodNo: prodNo, memNo: memNo },
                	success: function(res) {
						console.log("찜 취소 성공",res);
						 $('#jjimCountText').text(res.jjimCount + '명이 찜했어요');
                	},error: function(xhr, status, error) {
	                    console.error("실패:", error);
	                }
                });
	        }
	        
	        
	    }		
    
    
        function changeMainImage(imagePath, thumbnail) {
            // 메인 이미지 변경
		    document.getElementById('mainImage').src = '/CarrotEasy' + imagePath;
            
            // 선택된 썸네일 강조
            const thumbnails = document.querySelectorAll('.thumbnail');
            thumbnails.forEach(item => {
                item.classList.remove('active');
            });
            thumbnail.classList.add('active');
        }
        
        function deleteProd(prodNo) {
            if (confirm('정말 이 상품을 삭제하시겠습니까?')) {
                location.href = '/CarrotEasy/prod/delete.do?prodNo=' + prodNo;
            }
        }
	
        function alertTalk() {
        	const isLoggedIn = '${member != null}';
        	
        	 if (isLoggedIn !== 'true') {
                 // 비회원인 상태 → 로그인 페이지로
                	alert("일반사용자만 사용할 수 있습니다.");
             }
		}
        
		//카카오페이 결제

		const prodName = '${prod.prodTitle}';   
	    const prodPrice = '${prod.prodPrice}';
	    var buyerNo = null;

		var IMP = window.IMP;

        function kakaoPay(prodName, prodPrice,payType) {
        	
            const isLoggedIn = '${member != null}'; 

            if (isLoggedIn !== 'true') {
                // 비회원인 상태 → 로그인 페이지로
               	alert("로그인 후 구매가 가능합니다");
                // window.location.href = '/CarrotEasy/login.do';
            }else{
            	// 회원일 때
				var today = new Date();
	        	var hours = today.getHours(); // 시
	        	var minutes = today.getMinutes();  // 분
	        	var seconds = today.getSeconds();  // 초
	        	var milliseconds = today.getMilliseconds();
	        	var makeMerchantUid = hours + "" + minutes + "" + seconds + "" + milliseconds;
	
	        	console.log("makeMerchantUid ==>", makeMerchantUid);
	    		
	        	if(confirm("구매 하시겠습니까?")) { // 구매 클릭시 한번 더 확인하기
	  				console.log("payType ==>",payType);
		
		            const buyerEmail = document.getElementById('buyerEmail').value;
		            const buyerName = document.getElementById('buyerName').value;
	
		            IMP.init("imp74712831"); // 가맹점 식별코드
		
		            IMP.request_pay({
		                pg: "kakaopay.TC0ONETIME", // 테스트용 카카오페이
		                pay_method: "card",
		                merchant_uid: "IMP" + makeMerchantUid, // 주문번호 생성
		                name: prodName,
		                amount: prodPrice,
		                buyer_email: buyerEmail,
		                buyer_name: buyerName
		            }, function (rsp) {
		                if (rsp.success) {
		                    console.log(rsp);
		                    $.ajax({
		                    	url: "/CarrotEasy/kakaopay.do",
		                    	method: "GET",
		                    	data: { prodNo: prodNo, memNo: memNo, payType: payType },
		                    	success: function(res) {
									console.log("성공",res);
									location.reload();
		                    	},error: function(xhr, status, error) {
				                    console.error("실패:", error);
				                }
		                    });
		                } else {
		                    alert("결제 실패: " + rsp.error_msg);
		                }
		            });
	            }else { // 구매 확인 알림창 취소 클릭시 돌아가기
	    	        return false;
	    	    }
            }
        }
        
        // 팝업창
        function openWindowPop() {
        	if (!buyerNo) {
                alert('구매자를 선택해주세요.');
                return;
            }
        	
        	var options = 'top=10, left=10, width=500, height=1600, status=no, menubar=no, toolbar=no, resizable=no';
        	var url = "/CarrotEasy/kakaoQuick.do?prodNo=" + prodNo;
        	window.open(url, "카카오퀵선택창", options);
        }
		// 리뷰 insert팝업창
        function openinsertPop() {
        	var options = 'top=10, left=10, width=500, height=500, status=no, menubar=no, toolbar=no, resizable=no';
        	const url = "/CarrotEasy/reivew/insertReviewForm.do?prodNo="+ prodNo + "&memNo="+ memNo;
        	window.open(url, "상품리뷰 등록창", options);
        }
		// 신고 insert팝업창
		function insertReport() {
		    var options = 'top=10,left=10,width=500,height=500,status=no,menubar=no,toolbar=no,resizable=no';
		    const url = "/CarrotEasy/ReportInsertForm.do?prodTitle="+ prodName;
		    console.log(prodName);
		    window.open(url, "상품신고 등록창", options);
		}

        function openTrackingPage(partnerId, prodNo, buyerNo) {
        	buyerNo = $('#buyer-select').val();
            const url = "/CarrotEasy/api/deliveryStatus.do?partnerOrderId=" + encodeURIComponent(partnerId) + "&prodNo=" + encodeURIComponent(prodNo) + "&buyerNo=" + encodeURIComponent(buyerNo);
            const options = "width=500,height=1600,top=50,left=100,resizable=no,scrollbars=yes";

            console.log("Opening tracking page with URL:", url);

            window.open(url, "배송조회", options);
        }
        
        function receiveDeliveryInfo(partnerOrderId) {
            const oldButton = document.querySelector("button[onclick='openWindowPop()']");
            if (oldButton) oldButton.remove();

            const newBtn = document.createElement("button");
            newBtn.className = "btn btn-info";
            newBtn.textContent = "배송조회";
            newBtn.onclick = function () {
                openTrackingPage(partnerOrderId, prodNo, buyerNo); // partnerOrderId는 배송 ID
            };

            document.querySelector(".btn-group").appendChild(newBtn);
        }
        
        $(document).ready(function() {
        	$('#buyer-select').on('change', function () {
            	buyerNo = $(this).val();
            	console.log(buyerNo);
            });
        	
        	$('#sellerTel').on('click', function() {
        		var memNo = $(this).data('memno');
        		var prodNo = $(this).data('prodno');
        		$('#main-content').load('/CarrotEasy/chattingroom.do?memNo=' + memNo + '&prodNo=' + prodNo + '&source=prodView');
        	});
        	
        	$.ajax({
                url: '/CarrotEasy/prod/getBuyersByProd.do',
                method: 'GET',
                data: { prodNo: prodNo }, // prodNo는 상단에서 전역 선언되어 있어야 함
                success: function (response) {
                    const $select = $('#buyer-select');
                    $select.empty().append('<option value=""> 선택하세요   </option>');
                    response.forEach(function (buyer) {
                        $select.append("<option value=" + buyer.memNo+ ">" + buyer.memNick + "</option>");
                    });
                },
                error: function () {
                    alert("구매자 목록을 불러오지 못했습니다.");
                }
            });
        	
            $('#status-select').on('change', function() {
                const selectedValue = $(this).val();

                if (!buyerNo) {
                    alert('구매자를 선택해주세요.');
                    return;
                }
                
                if (selectedValue === 'SOLD_OUT') {
	                	 
	                const confirmed = confirm('정말로 판매를 완료하시겠습니까?');
	                if (!confirmed) return;
	
	                // 거래 완료 처리 AJAX
	                $.ajax({
	                    url: '/CarrotEasy/prod/completeDeal.do',
	                    method: 'POST',
	                    data: {
	                        prodNo: prodNo,
	                        memNo: buyerNo,
	                        purchaseType: '대면'
	                    },
	                    success: function (response) {
	                        alert("거래가 완료되었습니다.");
	                        location.reload();
	                    },
	                    error: function () {
	                        alert("거래 완료 처리에 실패했습니다.");
	                    }
	                });
               	}
            });
        });
        
        function cancelDeal() {
            // 모달과 오버레이 숨기기
            $('#dealModal, #modalOverlay').hide();

            // 상품 상태 select 요소의 값을 'RESERVED'로 되돌리기
            $('#status-select').val(prodType);
        }
    </script>
    
</head>
<body>
    <div class="container">
        <div class="title-row">
		    <h1>${prod.prodTitle}</h1>
            <div>
	            <c:if test="${sessionScope.member.memNo != prod.memNo && sessionScope.member.memNo != null}">
		            <button type="button" onclick="insertReport()"
					        style="background: none; border: none; padding: 0; color: #007bff; text-decoration: underline; cursor: pointer; font-size: 14px;"
					        class="shop-link">🚨 신고하기</button>
				</c:if>
				<c:if test="${not empty sessionScope.member and sessionScope.member.memNo != prod.memNo}">
					<a href="/CarrotEasy/mystore/mystoreMain.do?prodNo=${prod.prodNo}" class="shop-link">🛒 판매자 상점가기</a>
				</c:if>
			</div>
		</div>
		<!-- 구매자(로그인 사용자) 정보 숨기기 -->
		<input type="hidden" id="memNo" value="${sessionScope.loginUser.memNo}">
		<input type="hidden" id="buyerEmail" value="${sessionScope.member.memEmail}">
		<input type="hidden" id="buyerName" value="${sessionScope.member.memNo}">
        
        <div class="product-meta">
            <div>
                <span>카테고리: ${prod.cateName}</span>
            </div>
            <div></div>
            <div></div>
            <div></div>
            <div>
            	<span>조회수: ${prod.prodCnt}</span>
            </div>
            <div>
                <span>등록일: ${prod.createDate}</span>
            </div>
        </div>
        
        <img id="mainImage" class="main-image" 
		     src="/CarrotEasy${fileList[0].filePath}" 
		     alt="${prod.prodTitle}">
		
		<div class="gallery-container">
		    <c:forEach items="${fileList}" var="file" varStatus="status">
		        <img class="thumbnail ${status.index == 0 ? 'active' : ''}" 
		             src="/CarrotEasy${file.filePath}" 
		             alt="상품 이미지 ${status.index + 1}"
		             onclick="changeMainImage('${file.filePath}', this)">
		    </c:forEach>
		</div>
        
        <div class="product-info">
            <div class="product-price-wrapper">
			    <div class="product-price">
			        <fmt:formatNumber value="${prod.prodPrice}" type="number" pattern="#,###"/>원
			    </div>
			    	<div class="jjim-wrapper">
			    		<c:if test="${sessionScope.member.memNo != prod.memNo && sessionScope.member.memNo != null}"> <!-- 비회원일 시 뜨지 않음 -->
					        <button id="likeBtn" onclick="toggleLike()" style="background: none; border: none; cursor: pointer;">
						        <i id="heartIcon" class="fa-${jjimCheck ? 'solid' : 'regular'} fa-heart fa-2x" style="color: red;"></i>
						    </button>
						 </c:if>   
					    <span id="jjimCountText">${jjimCount}명이 찜했어요</span>
				    </div>
			</div>
            <div>
                <span class="product-status">
                    <c:choose>
                        <c:when test="${prod.prodStatus == 'NEW'}">새상품</c:when>
                        <c:when test="${prod.prodStatus == 'ALMOST_NEW'}">거의 새것</c:when>
                        <c:when test="${prod.prodStatus == 'SLIGHTLY_USED'}">중고</c:when>
                        <c:when test="${prod.prodStatus == 'USED'}">오래됨</c:when>
                    </c:choose>
                </span>
                
                <span class="product-status">
                    <c:choose>
                        <c:when test="${prod.prodType == 'FOR_SALE'}">판매중</c:when>
                        <c:when test="${prod.prodType == 'RESERVED'}">예약중</c:when>
                        <c:when test="${prod.prodType == 'SOLD_OUT'}">판매완료</c:when>
                    </c:choose>
                </span>
     			<c:if test="${prod.prodType != 'SOLD_OUT'}">
	                <c:if test="${sessionScope.member.memNo == prod.memNo}">
		                <span id="buyer-section" style="margin-top: 20px;">
						    <label for="buyer-select">구매자 선택:</label>
						    <select id="buyer-select">
						        <option value="">-- 선택하세요 --</option>
						    </select>
						</span>
		                <span class="prod-status">
		                	<select id="status-select">
		                		<option value="FOR_SALE" ${prod.prodType == 'FOR_SALE' ? 'selected' : ''}>판매중</option>
							    <option value="RESERVED" ${prod.prodType == 'RESERVED' ? 'selected' : ''}>예약중</option>
							    <option value="SOLD_OUT" ${prod.prodType == 'SOLD_OUT' ? 'selected' : ''}>판매완료</option>
		                	</select>
		                </span>
	                </c:if>
                </c:if>
            </div>
        </div>
        
        <div class="product-location">
            <p><strong>거래 희망 장소:</strong> ${prod.prodLocation}</p>
            <p><strong>지역:</strong> ${prod.areaName}</p>
        </div>
        
        <div class="product-content">
            ${prod.prodContent}
        </div>
        
        <div class="btn-group">
            <a href="/CarrotEasy/prod/list.do" class="btn btn-back">목록으로</a>
            <div class="btn-group-right">
	            <c:if test="${sessionScope.member.memNo == prod.memNo}">
	                <a href="/CarrotEasy/prod/update.do?prodNo=${prod.prodNo}" class="btn btn-primary">수정하기</a>
	                <button type="button" class="btn btn-primary" onclick="deleteProd(${prod.prodNo})">삭제하기</button>
	            </c:if>


				<c:if test="${not empty sessionScope.admember}">
				    <!-- 광고주 경우: 클릭 시 로그인 페이지로 이동 -->
    				<button type="button" class="btn btn-primary" onclick="alert('일반회원만 사용 가능합니다.')">
    					판매자 연락하기
    				</button>
				</c:if>
	            <c:if test="${sessionScope.member == null && empty sessionScope.admember}">
    				<!-- 로그인 안 한 경우: 클릭 시 로그인 페이지로 이동 -->
<!--     				<button type="button" class="btn btn-primary" onclick="window.location.href='/CarrotEasy/login.do';"> -->
    				<button type="button" class="btn btn-primary" onclick="alert('로그인 후 이용 가능합니다.')">
    					판매자 연락하기
    				</button>
				</c:if>
				<c:if test="${sessionScope.member != null && sessionScope.member.memNo != prod.memNo && prod.prodType != 'SOLD_OUT'}">
    				<!-- 로그인 한 경우: 기존 연락 기능 -->
    				<button type="button" class="btn btn-primary" id="sellerTel" data-prodno="${prod.prodNo}" data-memno="${prod.memNo}" data-buyerno=${sessionScope.member.memNo}>
        				판매자 연락하기
    				</button>
				</c:if>

	            <c:if test="${sessionScope.member.memNo != prod.memNo && prod.prodType != 'SOLD_OUT' && prod.prodType != 'RESERVED'}">
	            	<c:if test="${not empty sessionScope.admember}">
	            		<button type="button" class="btn-good" onclick="alertTalk()">비대면 구매하기</button>
	            	</c:if>
	            	<c:if test="${empty sessionScope.admember}">
				    	<button type="button" class="btn-good" onclick="kakaoPay(prodName,prodPrice,'일반구매')">비대면 구매하기</button>
	            	</c:if>
				</c:if>
				<c:if test="${sessionScope.member.memNo == prod.memNo && prod.prodType == 'RESERVED'}">
				    <c:choose>
				        <c:when test="${empty deliveryInfo}">
				            <!-- No delivery request exists yet -->
				            <button type="button" class="btn-good" onclick="openWindowPop()">카카오퀵 배송</button>
				        </c:when>
				        <c:otherwise>
				            <!-- Delivery request exists, show tracking button -->
				            <button type="button" class="btn btn-info" onclick="openTrackingPage('${deliveryInfo}', ${prod.prodNo})">배송조회</button>
				        </c:otherwise>
				    </c:choose>
				</c:if>
				<c:if test="${sessionScope.member.memNo != null && sessionScope.member.memNo == isPurchase}">
				    <c:choose>
				        <c:when test="${isPurchase != 0 and not hasReview and prod.prodType == 'SOLD_OUT'}">
				            <button class="btn-good" onclick="openinsertPop()">리뷰 작성</button>
				        </c:when>
				
				        <c:when test="${hasReview and isPurchase != 0 and prod.prodType == 'SOLD_OUT'}">
				            <form action="/CarrotEasy/review/deleteReviewController.do" method="get">
				                <input type="hidden" name="prodNo" value="${prod.prodNo}" />
				                <input type="hidden" name="memNo" value="${sessionScope.member.memNo}" />
				                <button class="btn-good"  type="submit" onclick="return confirm('리뷰를 삭제하시겠습니까?')">리뷰 삭제</button>
				            </form>
				        </c:when>
				    </c:choose>
				</c:if>
			</div>
        </div>
    </div>

    <script>
        function changeMainImage(imagePath, thumbnail) {
            // 메인 이미지 변경
		    document.getElementById('mainImage').src = '/CarrotEasy' + imagePath;
            
            // 선택된 썸네일 강조
            const thumbnails = document.querySelectorAll('.thumbnail');
            thumbnails.forEach(item => {
                item.classList.remove('active');
            });
            thumbnail.classList.add('active');
        }
        
        function deleteProd(prodNo) {
            if (confirm('정말 이 상품을 삭제하시겠습니까?')) {
                fetch("/CarrotEasy/prod/delete.do?prodNo="+prodNo, {
                    method: 'GET' // 또는 DELETE, 백엔드에 따라 다름
                })
                .then(response => {
                    if (!response.ok) {
                        throw new Error('삭제 요청 실패');
                    }
                    // 성공 시 상품 목록 페이지로 이동
                    location.href = '/CarrotEasy/prod/list.do';
                })
                .catch(error => {
                    console.error('삭제 중 오류 발생:', error);
                    alert('상품 삭제에 실패했습니다. 다시 시도해주세요.');
                });
            }
        }
        
        $(document).ready(function() {
        	
        	$('#sellerTel').on('click', function() {
        		var memNo = $(this).data('memno');
        		var prodNo = $(this).data('prodno');
        		var buyerNo = $(this).data('buyerno'); 
        		$('#main-content').load('/CarrotEasy/chattingroom.do?memNo=' + memNo + '&prodNo=' + prodNo +'&buyerNo='+ buyerNo + '&source=prodView');
        		
        	});
        	
        });
        
    </script>
</body>

</html>