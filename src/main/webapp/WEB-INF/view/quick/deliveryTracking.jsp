<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배송 조회</title>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 20px;
        }
        .container {
            max-width: 800px;
            margin: 0 auto;
            background-color: #fff;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #ff6b00;
            text-align: center;
            margin-bottom: 30px;
        }
        .tracking-header {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }
        .order-info {
            flex: 1;
        }
        .order-id {
            font-weight: bold;
            color: #333;
            margin-bottom: 5px;
        }
        .order-date {
            color: #666;
            font-size: 14px;
        }
        .delivery-status {
            background-color: #ff6b00;
            color: white;
            padding: 10px 15px;
            border-radius: 5px;
            align-self: flex-start;
            font-weight: bold;
        }
        .status-PENDING { background-color: #6c757d; }
        .status-ACCEPTED { background-color: #007bff; }
        .status-ASSIGNED { background-color: #17a2b8; }
        .status-PICKED_UP { background-color: #fd7e14; }
        .status-IN_PROGRESS { background-color: #28a745; }
        .status-COMPLETED { background-color: #28a745; }
        .status-CANCELED { background-color: #dc3545; }
        .status-FAILED { background-color: #dc3545; }
        .status-MATCHING { background-color: #6c757d; }
        .status-MATCHING_FAILED { background-color: #dc3545; }
        
        .tracking-timeline {
            margin: 30px 0;
            position: relative;
        }
        .tracking-timeline:before {
            content: '';
            position: absolute;
            top: 0;
            bottom: 0;
            left: 15px;
            width: 2px;
            background: #ddd;
            z-index: 0;
        }
        .timeline-item {
            position: relative;
            padding-left: 40px;
            margin-bottom: 25px;
        }
        .timeline-item:last-child {
            margin-bottom: 0;
        }
        .timeline-dot {
            position: absolute;
            left: 9px;
            width: 14px;
            height: 14px;
            border-radius: 50%;
            background: #ddd;
            border: 2px solid #fff;
            z-index: 1;
        }
        .timeline-dot.active {
            background: #ff6b00;
        }
        .timeline-content {
            padding: 15px;
            background: #f8f9fa;
            border-radius: 5px;
        }
        .timeline-time {
            color: #666;
            font-size: 14px;
            margin-bottom: 5px;
        }
        .timeline-text {
            font-weight: bold;
            color: #333;
        }
        .delivery-details {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #eee;
        }
        .detail-section {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
        }
        .detail-section h3 {
            margin-top: 0;
            color: #333;
            font-size: 18px;
            margin-bottom: 15px;
        }
        .detail-item {
            margin-bottom: 10px;
        }
        .detail-label {
            font-weight: bold;
            display: block;
            margin-bottom: 3px;
            color: #555;
        }
        .detail-value {
            color: #333;
        }
        .btn-group {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 30px;
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
            background-color: #ff6b00;
            color: white;
        }
        .loading {
            text-align: center;
            padding: 20px;
        }
        .loading i {
            color: #ff6b00;
            font-size: 24px;
        }
    </style>
    <script>
        // Partner Order ID from query parameter
        const urlParams = new URLSearchParams(window.location.search);
        const partnerOrderId = urlParams.get('partnerOrderId');
        const prodNo = urlParams.get('prodNo');
        const buyerNo = urlParams.get('buyerNo');
        
        // timeline descriptions
        const statusDescriptions = {
            'MATCHING_FAILED': '배송 기사 매칭에 실패했습니다.',
            'PENDING': '배송 요청이 접수되었습니다.',
            'MATCHED': '배송기사가 배정되었습니다.',
            'PICKUP_STARTED': '배송원이 픽업 위치로 출발헀습니다.',
            'PICKUP_COMPLETED': '상품이 픽업되었습니다.',
            'DROPOFF_STARTED': '배송 중입니다.',
            'COMPLETED': '배송이 완료되었습니다.',
            'CANCELED': '배송이 취소되었습니다.',
            'FAILED': '배송에 실패했습니다.',
            'MATCHING': '배송 매칭 중입니다.'
        };
        
     	// 상단 텍스트
        function getStatusText(status) {
            const statusMap = {
                'COMPLETED': '배송 완료',
                'MATCHING': '배송원 배정 중',
                'MATCHED': '배송원 배정 완료',
                'PICKUP_STARTED': '픽업 위치로 출발',
                'PICKUP_COMPLETED': '픽업 완료',
                'DROPOFF_STARTED': '배송 출발',
                'CANCELED': '배송 취소',
                'MATCHING_FAILED': '배송 실패',
                'ABORTED': '매칭 실패'
            };
            
            return statusMap[status] || status;
        }
        
        // When status changes to COMPLETED, update product status to SOLD_OUT
        function finishProductStatus() {
            $.ajax({
                url: '/CarrotEasy/prod/completeDeal.do',
                method: 'POST',
                data: {
                    prodNo: prodNo,
                    memNo: buyerNo,
                    purchaseType: '비대면'
                },
                success: function (response) {
                	console.log("상품 상태 업데이트 성공:", response);
                    window.opener.location.reload();
                    // 배송 완료로 바뀐 후 2초 뒤 창 닫힘
                    setTimeout(function() {
                        window.close();
                    }, 2000);
                },
                error: function () {
                    alert("거래 완료 처리에 실패했습니다.");
                }
            });
        }
       
    </script>
    <!-- 추가된 JavaScript 코드 -->
    <script>
    $(document).ready(function() {
        // Get delivery data from server (set in controller)
        const deliveryDataStr = '${deliveryData}';
        let deliveryData;
        
        try {
            deliveryData = JSON.parse(deliveryDataStr);
            console.log("배송 데이터:", deliveryData);
            
            // Update UI with delivery data
            updateUI(deliveryData);
        } catch (e) {
            console.error("배송 데이터 파싱 오류:", e);
            $('#loading-spinner').html('<i class="fas fa-exclamation-circle"></i> 배송 데이터를 불러오는데 실패했습니다.');
        }
        
        // Refresh button handler
        $('#refresh-status').click(function() {
            location.reload();
        });
        
        function updateUI(data) {
            // Hide loading spinner
            $('#loading-spinner').hide();
            
            // Update order details
            $('#order-id').text('주문번호: ' + data.receipt.orderId);
            
            // Update status badge
            const currentStatus = data.receipt.status;
            $('#status-badge').text(getStatusText(currentStatus));
            $('#status-badge').removeClass().addClass('delivery-status status-' + currentStatus);
            
            // Update timestamps
            if (data.histories && data.histories.length > 0) {
                const latestHistory = data.histories[0];
                const orderDate = new Date(latestHistory.updatedAt);
                const formattedDate = orderDate.toLocaleDateString('ko-KR') + ' ' + orderDate.toLocaleTimeString('ko-KR');
                $('#order-date').text('주문일시: ' + formattedDate);
            }
            
            // Update delivery details
            updateDeliveryDetails(data);
            
            // Update timeline
            updateTimeline(currentStatus, data.histories);
            
            // If delivery is completed, update product status
            if (currentStatus === 'COMPLETED' && prodNo) {
                finishProductStatus();
            }
        }
        
        // Update delivery details from response
        function updateDeliveryDetails(response) {
            // Pickup information
            $('#pickup-name').text(response.pickup.contact.name);
            $('#pickup-phone').text(response.pickup.contact.phone);
            $('#pickup-address').text(response.pickup.location.basicAddress + 
                (response.pickup.location.detailAddress ? ' ' + response.pickup.location.detailAddress : ''));
            
            // Dropoff information
            $('#recipient-name').text(response.dropoff.contact.name);
            $('#recipient-phone').text(response.dropoff.contact.phone);
            $('#recipient-address').text(response.dropoff.location.basicAddress + 
                (response.dropoff.location.detailAddress ? ' ' + response.dropoff.location.detailAddress : ''));
        }
        
        // Update timeline based on current status
        function updateTimeline(currentStatus, histories) {
            // Include MATCHING_FAILED in status array
            const statuses = ['MATCHING', 'MATCHED', 'PICKUP_STARTED', 'PICKUP_COMPLETED', 'DROPOFF_STARTED', 'COMPLETED'];
            
            // Clear existing timeline
            $('.tracking-timeline').empty();
            // Handle special cases: CANCELED, FAILED, MATCHING_FAILED
            if (currentStatus === 'CANCELED' || currentStatus === 'FAILED' || currentStatus === 'MATCHING_FAILED') {
                // Find the time for this status if available from histories
                let timeStr = '-';
                if (histories && histories.length > 0) {
                    const historyItem = histories.find(h => h.status === currentStatus);
                    if (historyItem) {
                        const statusTime = new Date(historyItem.updatedAt);
                        timeStr = statusTime.toLocaleTimeString('ko-KR');
                    }
                }
                
                // Description for MATCHING_FAILED
                const description = currentStatus === 'MATCHING_FAILED' ? 
                    '배송 기사 매칭에 실패했습니다.' : statusDescriptions[currentStatus];
                
                $('.tracking-timeline').append(`
                    <div class="timeline-item">
                        <div class="timeline-dot active"></div>
                        <div class="timeline-content">
                            <div class="timeline-time">${timeStr}</div>
                            <div class="timeline-text">${description}</div>
                        </div>
                    </div>
                `);
                return;
            }
            
            let reachedCurrent = false;
            statuses.forEach(status => {
              console.log("currentStatus:", currentStatus);
              console.log("status loop:", status);
              console.log("index(status):", statuses.indexOf(status));
              console.log("index(currentStatus):", statuses.indexOf(currentStatus));
              console.log(histories);
              
              // 현재 상태까지 모두 활성화 처리
              const isActive = statuses.indexOf(status) <= statuses.indexOf(currentStatus);

              if (status === currentStatus) {
                reachedCurrent = true;
              }
              
              // 활성화된 모든 상태에 대해 시간 표시
              let timeStr = '-';
              if (isActive && histories && histories.length > 0) {
                const historyItem = histories.find(h => h.status === status);
                if (historyItem) {
                  const statusTime = new Date(historyItem.updatedAt);
                  timeStr = statusTime.toLocaleTimeString('ko-KR');
                }
              }
              
              $('.tracking-timeline').append(
                '<div class="timeline-item">' +
                '<div class="timeline-dot ' + (isActive ? 'active' : '') + '"></div>' +
                '<div class="timeline-content">' +
                '<div class="timeline-time">' + timeStr + '</div>' +
                '<div class="timeline-text">' + statusDescriptions[status] + '</div>' +
                '</div>' +
                '</div>'
              );
            });
        }
    });
    </script>
</head>
<body>
    <div class="container">
        <h1>배송 조회</h1>
        
        <div class="tracking-header">
            <div class="order-info">
                <div id="order-id" class="order-id">주문번호: 로딩중...</div>
                <div id="order-date" class="order-date">주문일시: 로딩중...</div>
            </div>
            <div id="status-badge" class="delivery-status">상태 확인 중...</div>
        </div>
        
        <div id="delivery-status-display">
            <div id="loading-spinner" class="loading">
                <i class="fas fa-spinner fa-spin"></i> 배송 상태를 확인하는 중입니다...
            </div>
            
            <div class="tracking-timeline">
                <!-- Timeline items will be added by JavaScript -->
            </div>
        </div>
        
        <div class="delivery-details">
            <div class="detail-section">
                <h3>픽업 정보</h3>
                <div class="detail-item">
                    <span class="detail-label">보내는 분</span>
                    <span id="pickup-name" class="detail-value">로딩중...</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">연락처</span>
                    <span id="pickup-phone" class="detail-value">로딩중...</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">주소</span>
                    <span id="pickup-address" class="detail-value">로딩중...</span>
                </div>
            </div>
            
            <div class="detail-section">
                <h3>배송 정보</h3>
                <div class="detail-item">
                    <span class="detail-label">받는 분</span>
                    <span id="recipient-name" class="detail-value">로딩중...</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">연락처</span>
                    <span id="recipient-phone" class="detail-value">로딩중...</span>
                </div>
                <div class="detail-item">
                    <span class="detail-label">주소</span>
                    <span id="recipient-address" class="detail-value">로딩중...</span>
                </div>
            </div>
        </div>
        
        <div class="btn-group">
            <button id="refresh-status" class="btn btn-primary">상태 새로고침</button>
        </div>
    </div>
</body>
</html>