<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>배너 관리</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
        .banner-img {
            max-width: 200px;
            max-height: 100px;
            object-fit: contain;
        }
        .status-active {
            color: #28a745;
            font-weight: bold;
        }
        .status-inactive {
            color: #dc3545;
        }
        .banner-preview {
            cursor: pointer;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row mb-4">
            <div class="col-md-8">
                <h2>배너 관리</h2>
            </div>
            <div class="col-md-4 text-right">
                <a href="${pageContext.request.contextPath}/adboard/list.do" class="btn btn-primary">광고 게시판으로</a>
            </div>
        </div>
        
        <div class="card">
            <div class="card-header bg-dark text-white">
                <div class="row">
                    <div class="col-md-6">
                        <h5 class="mb-0">배너 목록</h5>
                    </div>
                    <div class="col-md-6 text-right">
                        <button type="button" class="btn btn-sm btn-success" id="applyChanges">변경사항 적용</button>
                    </div>
                </div>
            </div>
            <div class="card-body">
                <table class="table table-striped table-hover">
                    <thead class="thead-light">
                        <tr>
                            <th width="5%">번호</th>
                            <th width="15%">이미지</th>
                            <th width="40%">URL</th>
                            <th width="15%">원본 게시글</th>
                            <th width="15%">상태</th>
                            <th width="10%">관리</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty bannerList}">
                                <tr>
                                    <td colspan="6" class="text-center">등록된 배너가 없습니다.</td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="banner" items="${bannerList}" varStatus="status">
                                    <tr>
                                        <td>${status.count}</td>
                                        <td>
                                            <img src="${banner.banImg}" class="banner-img banner-preview" 
                                                 data-toggle="modal" data-target="#imageModal" 
                                                 data-img="${banner.banImg}" alt="배너 이미지">
                                        </td>
                                        <td>
                                            <a href="${banner.banUrl}" target="_blank">${banner.banUrl}</a>
                                        </td>
                                        <td>
                                            <c:if test="${not empty banner.adNo}">
                                                <a href="${pageContext.request.contextPath}/adboard/boardView?adNo=${banner.adNo}" 
                                                   class="btn btn-sm btn-outline-info">원본 보기</a>
                                            </c:if>
                                            <c:if test="${empty banner.adNo}">
                                                <span class="text-muted">직접 등록</span>
                                            </c:if>
                                        </td>
                                        <td>                                        
                                            <c:choose>
                                                <c:when test="${banner.banDelyn eq 'N'}">
                                                    <span class="status-active">활성</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-inactive">비활성</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="form-check">
                                                <input type="checkbox" class="form-check-input banner-status" 
                                                       id="status-${banner.banNo}" 
                                                       data-banner-id="${banner.banNo}"
                                                       ${banner.banDelyn eq 'N' ? 'checked' : ''}>
                                                <label class="form-check-label" for="status-${banner.banNo}">
                                                    활성화
                                                </label>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
            <div class="card-footer text-muted">
                <small>* 활성화: 배너 슬라이드에 표시됨 / 비활성화: 배너 슬라이드에 표시되지 않음</small>
            </div>
        </div>
    </div>
    
    <!-- 이미지 미리보기 모달 -->
    <div class="modal fade" id="imageModal" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">배너 이미지 미리보기</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body text-center">
                    <img id="modalImage" src="" class="img-fluid" alt="배너 이미지 큰 보기">
                </div>
            </div>
        </div>
    </div>
    
    <script>
        $(document).ready(function() {
            // 이미지 미리보기 모달
            $('.banner-preview').on('click', function() {
                var imgSrc = $(this).data('img');
                $('#modalImage').attr('src', imgSrc);
            });
            
            // 변경사항 적용 버튼 클릭 이벤트
            $('#applyChanges').on('click', function() {
                // 상태 변경된 배너 정보 수집
                var changedBanners = [];
                
                $('.banner-status').each(function() {
                    var bannerId = $(this).data('banner-id');
                    var isActive = $(this).prop('checked');
                    var delYn = isActive ? 'N' : 'Y';
                    
                    changedBanners.push({
                        banNo: bannerId,
                        banDelyn: delYn
                    });
                });
                
                // AJAX 요청으로 상태 변경 처리
                $.ajax({
                    url: '${pageContext.request.contextPath}/banner/updateStatus.do',
                    type: 'POST',
                    contentType: 'application/json',
                    data: JSON.stringify(changedBanners),
                    success: function(response) {
                        if (response.success) {
                            alert('배너 상태가 성공적으로 업데이트되었습니다.');
                            location.reload(); // 페이지 새로고침
                        } else {
                            alert('오류가 발생했습니다: ' + response.message);
                        }
                    },
                    error: function() {
                        alert('서버 통신 중 오류가 발생했습니다.');
                    }
                });
            });
        });
    </script>
</body>
</html>