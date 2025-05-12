<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    
<head>
    <meta charset="UTF-8">
    <script src="/CarrotEasy/resource/js/jquery-3.7.1.js"></script>
            <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<!-- 포트원 결제 -->
	<script src="https://cdn.iamport.kr/v1/iamport.js"></script>
	
	<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
	<!-- iamport.payment.js -->
	<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
	<!-- 포트원 결제 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <title>카카오퀵 배송 선택</title>
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 450px;
            margin: 0 auto;
            background-color: #fff;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            color: #ff6b00;
            margin-bottom: 20px;
            text-align: center;
            border-bottom: 1px solid #eee;
            padding-bottom: 15px;
        }
        h3 {
            color: #333;
            margin-top: 20px;
            margin-bottom: 15px;
            font-size: 18px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            color: #333;
            font-weight: bold;
        }
        input[type="text"], 
        input[type="tel"],
        input[type="number"],
        select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
            font-size: 14px;
        }
        .btn-group {
            margin-top: 25px;
            display: flex;
            gap: 10px;
            justify-content: center;
        }
        .btn {
            padding: 10px 20px;
            font-size: 16px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-align: center;
        }
        .btn-cancel {
            background-color: #6c757d;
            color: white;
        }
        .btn-request {
            background-color: #ff6b00;
            color: white;
        }
        .btn-request:disabled {
        	background-color: #d3d3d3;
        	color: #808080;
        	border: 1px solid #b0b0b0;
        }
        
        .delivery-option {
            display: flex;
            margin-bottom: 15px;
            padding: 15px;
            border: 1px solid #eee;
            border-radius: 5px;
            cursor: pointer;
        }
        .delivery-option:hover {
            background-color: #f9f9f9;
        }
        .delivery-option.selected {
            border-color: #ff6b00;
            background-color: #fff4ee;
        }
        .delivery-icon {
            flex: 0 0 50px;
            text-align: center;
            font-size: 24px;
            color: #ff6b00;
        }
        .delivery-info {
            flex: 1;
        }
        .delivery-name {
            font-weight: bold;
            margin-bottom: 5px;
        }
        .delivery-details {
            font-size: 14px;
            color: #666;
        }
        .delivery-price {
            font-weight: bold;
            color: #ff6b00;
        }
        .section {
            margin-bottom: 25px;
        }
        .grid-2 {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 10px;
        }
        .location-group {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 15px;
        }
        .required:after {
            content: " *";
            color: #ff6b00;
        }
    </style>
    <script>
    
        $(document).ready(function() {
            // 배송 요청 버튼 클릭 이벤트
            $('#requestDelivery').click(function() {
                // 기본 배송 정보
                const deliveryPrice = $('#deliveryPrice').val();
                const orderType = $('#orderType').val();
                
                // 픽업 정보
                const pickupName = $('#pickupName').val();
                const pickupPhone = $('#pickupPhone').val();
                const pickupAddress = $('#pickupAddress').val();
                const pickupDetailAddress = $('#pickupDetailAddress').val();
                const pickupLatitude = $('#pickupLatitude').val();
                const pickupLongitude = $('#pickupLongitude').val();
                
                // 배송지 정보
                const recipientName = $('#recipientName').val();
                const recipientTel = $('#recipientTel').val();
                const deliveryAddress = $('#deliveryAddress').val();
                const deliveryDetailAddress = $('#deliveryDetailAddress').val();
                const deliveryLatitude = $('#deliveryLatitude').val();
                const deliveryLongitude = $('#deliveryLongitude').val();
                const deliveryMessage = $('#deliveryMessage').val();
                
                // 결제 정보
                const paymentType = $('input[name="paymentType"]:checked').val();
                
                // 상품 정보
                const productName = $('#productName').val();
                const productQuantity = $('#productQuantity').val();
                const productPrice = $('#productPrice').val();
                const productDetail = $('#productDetail').val();
                const productSize = $('#productSize').val();
                const trayCount = $('#trayCount').val();
                
                // 주문 ID
                const partnerOrderId = $('#partnerOrderId').val() || 'ORDER_' + new Date().getTime();
                const prodNo = new URLSearchParams(window.location.search).get('prodNo');
                
                
                if (!pickupName || !pickupPhone || !pickupAddress) {
                    alert('픽업 정보를 모두 입력해주세요.');
                    return;
                }
                
                if (!recipientName || !recipientTel || !deliveryAddress) {
                    alert('배송지 정보를 모두 입력해주세요.');
                    return;
                }
                
                if (!productName || !productQuantity || !productPrice || !productSize) {
                    alert('상품 정보를 모두 입력해주세요.');
                    return;
                }
                                
                // 카카오퀵 API 호출 및 배송 정보 저장
                $.ajax({
                    url: '/CarrotEasy/api/kakaoQuick.do',
                    method: 'POST',
                    data: {
                        // 주문 기본 정보
                        partnerOrderId: partnerOrderId,
                        orderType: orderType,
                        
                        // 픽업 정보
                        pickupName: pickupName, 
                        pickupPhone: pickupPhone,
                        pickupAddress: pickupAddress,
                        pickupDetailAddress: pickupDetailAddress,
                        pickupLatitude: pickupLatitude,
                        pickupLongitude: pickupLongitude,
                        
                        // 배송지 정보
                        recipientName: recipientName,
                        recipientTel: recipientTel,
                        deliveryAddress: deliveryAddress,
                        deliveryDetailAddress: deliveryDetailAddress,
                        deliveryLatitude: deliveryLatitude,
                        deliveryLongitude: deliveryLongitude,
                        deliveryMessage: deliveryMessage,
                        
                        // 결제 정보
                        paymentType: paymentType,
                        
                        // 상품 정보
                        productName: productName,
                        productQuantity: productQuantity,
                        productPrice: productPrice,
                        productDetail: productDetail,
                        productSize: productSize,
                        
                        // 부가 정보
                        deliveryPrice: deliveryPrice,
                        prodNo: prodNo,
                        
                        // 추가된 부분: createRequestBody 메소드에 필요한 파라미터
                        createJsonRequest: true
                    },
                    success: function(response) {
                        if (response.success) {
                            alert('카카오퀵 배송이 요청되었습니다.');
                            // 부모 창에 배송 정보 전달
                            if (window.opener && !window.opener.closed) {
                                window.opener.receiveDeliveryInfo(partnerOrderId);
                            }
                            window.close();
                        } else {
                            alert('배송 요청 실패: ' + response.message);
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error('Error details:', xhr.responseText);
                        alert('배송 요청 중 오류가 발생했습니다.');
                    }
                });
            });
            
            $('#checkPriceBtn').click(function() {
                const prodNo = new URLSearchParams(window.location.search).get('prodNo');

                const params = {
                   orderType: 'QUICK',
                   pickupAddress: $('#pickupAddress').val(),
                   pickupDetailAddress: $('#pickupDetailAddress').val(),
                   pickupLatitude: $('#pickupLatitude').val(),
                   pickupLongitude: $('#pickupLongitude').val(),
                   deliveryAddress: $('#deliveryAddress').val(),
                   deliveryDetailAddress: $('#deliveryDetailAddress').val(),
                   deliveryLatitude: $('#deliveryLatitude').val(),
                   deliveryLongitude: $('#deliveryLongitude').val(),
                   productSize: $('#productSize').val()
               };

                $.ajax({
                    url: '/CarrotEasy/api/priceCheck.do',
                    method: 'POST',
                    data: params,
                    success: function (response) {
                        if (response.success) {
                            const totalPrice = response.totalPrice;

                            // 버튼 텍스트 변경
                            $('#checkPriceBtn')
                                .text('예상 가격: ' + totalPrice.toLocaleString() + '원')
                                .prop('disabled', true)           // 버튼 비활성화
                                .css({
                                    backgroundColor: '#ccc',       // 비활성화 시 색상 변경 (선택)
                                    cursor: 'not-allowed'
                                });

                            // 가격을 hidden input에도 저장해서 추후 배송 신청 시 사용 가능
                            $('#deliveryPrice').val(totalPrice);
                            
                        } else {
                            alert('가격 조회 실패: ' + response.message);
                        }
                    },
                    error: function () {
                        alert('가격 조회 중 오류가 발생했습니다.');
                    }
                });
            });
            
            // 취소 버튼 클릭 이벤트
            $('#cancelDelivery').click(function() {
                window.close();
            });
            
            // 전화번호 입력 형식 처리
            $('.phone-input').on('input', function() {
                let phoneNumber = $(this).val().replace(/[^0-9]/g, '');
                
                if (phoneNumber.length > 3 && phoneNumber.length <= 7) {
                    phoneNumber = phoneNumber.slice(0, 3) + '-' + phoneNumber.slice(3);
                } else if (phoneNumber.length > 7) {
                    phoneNumber = phoneNumber.slice(0, 3) + '-' + phoneNumber.slice(3, 7) + '-' + phoneNumber.slice(7, 11);
                }
                
                $(this).val(phoneNumber);
            });
            
            // 초기값 설정 (필요한 경우 서버에서 가져올 수 있음)
            $('#partnerOrderId').val('ORDER_' + new Date().getTime());
            $('#orderType').val('QUICK');
        });
        
        $(document).on('change', 'input[name="paymentType"]', function () {
            const selected = $(this).val();
            const price = $('#deliveryPrice').val();
            
            if (selected === '선불' && price) {
                $('#kakaoPaySection').show();
                $('#requestDelivery').prop('disabled', true)
            } else {
                $('#kakaoPaySection').hide();
                $('#requestDelivery').prop('disabled', false)
            }
        });
        
        $(document).on('click', '#kakaoPayBtn', function () {
            const productName = "퀵결제비용";
            const deliveryPrice = $('#deliveryPrice').val();
            const payType = '카카오퀵';
            
            // 히든 필드로 주입되었거나 서버에서 내려준 memNo, prodNo 활용
            const memNo = '${member.memNo}';
            const prodNo = new URLSearchParams(window.location.search).get('prodNo');

            kakaoPayWithParams(productName, deliveryPrice, payType, prodNo, memNo);
        });
        
        var IMP = window.IMP;
        
        function kakaoPayWithParams(prodName, prodPrice, payType, prodNo, memNo) {
            var today = new Date();
            var makeMerchantUid = today.getHours() + "" + today.getMinutes() + "" + today.getSeconds() + "" + today.getMilliseconds();

            if (confirm("카카오페이로 결제하시겠습니까?")) {
                IMP.init("imp74712831"); // 가맹점 식별코드

                IMP.request_pay({
                    pg: "kakaopay.TC0ONETIME",
                    pay_method: "card",
                    merchant_uid: "IMP" + makeMerchantUid,
                    name: prodName,
                    amount: prodPrice,
                    buyer_email: "test@example.com",
                    buyer_name: "홍길동"
                }, function (rsp) {
                    if (rsp.success) {
                        $.ajax({
                            url: "/CarrotEasy/kakaopay.do",
                            method: "GET",
                            data: { prodNo: prodNo, memNo: memNo, payType: payType },
                            success: function (res) {
                                alert("결제가 완료되었습니다!");
                                $('input[type="radio"][name="paymentType"]').prop('disabled', true);
                                $('input[type="radio"][name="paymentType"][value="선불"]').text('선불로 결제완료');
                                $('#kakaoPaySection').hide();
                                $('#requestDelivery').prop('disabled', false)
                            },
                            error: function (xhr, status, error) {
                                console.error("결제 처리 실패:", error);
                            }
                        });
                    } else {
                        alert("결제 실패: " + rsp.error_msg);
                    }
                });
            }
        }
    </script>
</head>
<body>
    <div class="container">
        <h2>카카오퀵 배송 신청</h2>
        <div class="section">
            <h3>픽업 정보</h3>
            <div class="location-group">
                <div class="form-group">
                    <label for="pickupName" class="required">보내는 분 이름</label>
                    <input type="text" id="pickupName" name="pickupName" required>
                </div>
                
                <div class="form-group">
                    <label for="pickupPhone" class="required">보내는 분 연락처</label>
                    <input type="tel" id="pickupPhone" name="pickupPhone" class="phone-input" placeholder="010-0000-0000" required>
                </div>
                
                <div class="form-group">
                    <label for="pickupAddress" class="required">픽업 주소</label>
                    <input type="text" id="pickupAddress" name="pickupAddress" placeholder="예: 대전시 중구 오류동" required>
                </div>
                
                <div class="form-group">
                    <label for="pickupDetailAddress">상세 주소</label>
                    <input type="text" id="pickupDetailAddress" name="pickupDetailAddress" placeholder="예: 101동 1001호">
                </div>
            </div>
        </div>
        
        <div class="section">
            <h3>배송지 정보</h3>
            <div class="location-group">
                <div class="form-group">
                    <label for="recipientName" class="required">받는 분 이름</label>
                    <input type="text" id="recipientName" name="recipientName" required>
                </div>
                
                <div class="form-group">
                    <label for="recipientTel" class="required">받는 분 연락처</label>
                    <input type="tel" id="recipientTel" name="recipientTel" class="phone-input" placeholder="010-0000-0000" required>
                </div>
                
                <div class="form-group">
                    <label for="deliveryAddress" class="required">배송 주소</label>
                    <input type="text" id="deliveryAddress" name="deliveryAddress" placeholder="예: 대전시 유성구 봉명동" required>
                </div>
                
                <div class="form-group">
                    <label for="deliveryDetailAddress">상세 주소</label>
                    <input type="text" id="deliveryDetailAddress" name="deliveryDetailAddress" placeholder="예: XX아파트 101동 1001호">
                </div>
                <div class="form-group">
                    <label for="deliveryMessage">배송 요청사항 (선택)</label>
                    <input type="text" id="deliveryMessage" name="deliveryMessage" placeholder="예: 문 앞에 놓아주세요">
                </div>
            </div>
        </div>
       
        <div class="section">
            <h3>상품 정보</h3>
            <div class="form-group">
                <label for="productName" class="required">상품명</label>
                <input type="text" id="productName" name="productName" required>
            </div>
            
            <div class="grid-2">
                <div class="form-group">
                    <label for="productQuantity" class="required">수량</label>
                    <input type="number" id="productQuantity" name="productQuantity" min="1" required>
                </div>
                
                <div class="form-group">
                    <label for="productPrice" class="required">상품 가격</label>
                    <input type="number" id="productPrice" name="productPrice" min="0" required>
                </div>
            </div>
            
            <div class="section">
                <div class="form-group">
                    <label for="productSize" class="required">상품 크기</label>
                    <select id="productSize" name="productSize" required>
                        <option value="XS">XS (초소형)</option>
                        <option value="S">S (소형)</option>
                        <option value="M">M (중형)</option>
                        <option value="L">L (대형)</option>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="productDetail">상품 상세</label>
                <input type="text" id="productDetail" name="productDetail" placeholder="조심히 배송해주세요">
            </div>
            
            <div class="form-group">
			    <button type="button" id="checkPriceBtn" class="btn btn-request" style="width: 100%;">예상 가격</button>
			</div>
                    
	        <div class="section">
	            <h3>결제 방법</h3>
	            <div class="form-group">
	                <label for="paymentType">
	                    <input type="radio" name="paymentType" value="선불"> 선불
	                </label>
	            </div>
	            <div class="form-group">
	                <label>
	                    <input type="radio" name="paymentType" value="착불"> 착불 (배송비 현장결제)
	                </label>
	            </div>
	        </div>
	        
	        <div id="kakaoPaySection" style="display: none; margin-top: 15px;">
			    <button type="button" id="kakaoPayBtn" class="btn btn-request" style="width: 100%;">
			        카카오페이로 결제하시겠습니까?
			    </button>
			</div>
        </div>
        
        <!-- 히든 필드 -->
        <input type="hidden" id="deliveryPrice" name="deliveryPrice">
        <input type="hidden" id="orderType" name="orderType" value="QUICK">
        <input type="hidden" id="partnerOrderId" name="partnerOrderId">
        
        <div class="btn-group">
            <button type="button" id="cancelDelivery" class="btn btn-cancel">취소</button>
            <button type="button" id="requestDelivery" class="btn btn-request" disabled>배송 신청</button>
        </div>
    </div>
</body>
</html>