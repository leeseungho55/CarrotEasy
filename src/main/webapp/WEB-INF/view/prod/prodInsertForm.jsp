<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c5f0aecfeefdc035027e9363d88272b0&libraries=services"></script>
<head>

    <meta charset="UTF-8">
    <title>중고물품 판매 등록</title>
    <style>
        .container {
            max-width: 1180px;
            margin: 8 auto;
            background-color: #fff;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        h1 {
            color: #333;
            text-align: center;
            margin-bottom: 30px;
        }
       .btn-group {
		    display: flex;
		    justify-content: space-between;
		    margin-top: 30px;
		}
		
		.btn-cancel {
		    background-color: #ff8a3d;
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    font-size: 16px;
		    cursor: pointer;
		    border-radius: 5px;
		}
		
		.btn[type="submit"] {
		    background-color: #ff8a3d;
		    color: white;
		    border: none;
		    padding: 10px 20px;
		    font-size: 16px;
		    cursor: pointer;
		    border-radius: 5px;
		}
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .insert-input,
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-sizing: border-box;
        }
        textarea {
            height: 150px;
            resize: vertical;
        }
        .btn-group {
            text-align: center;
            margin-top: 30px;
        }
        .btn {
            background-color: #FF8A3D;
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
        .image-upload {
            display: flex;
            flex-wrap: wrap;
            gap: 15px;
            margin-top: 10px;
        }
        .image-preview {
            width: 150px;
            height: 150px;
            border: 2px dashed #ddd;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
            position: relative;
            overflow: hidden;
        }
        .image-preview img {
            max-width: 100%;
            max-height: 100%;
            object-fit: cover;
        }
        .image-preview input[type="file"] {
            position: absolute;
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        .preview-text {
            color: #999;
        }
        .remove-btn {
            position: absolute;
            top: 5px;
            right: 5px;
            background: rgba(255, 0, 0, 0.7);
            color: white;
            border: none;
            border-radius: 50%;
            width: 20px;
            height: 20px;
            font-size: 12px;
            cursor: pointer;
            display: none;
        }
        .location-input-group {
	        display: flex;
	        gap: 10px;
	    }
	    
	    .btn-map {
	        background-color: #ff8a3d;
	        flex-shrink: 0;
	    }
	    .modal {
	        display: none;
	        position: fixed;
	        z-index: 1000;
	        left: 0;
	        top: 0;
	        width: 100%;
	        height: 100%;
	        background-color: rgba(0,0,0,0.4);
	    }
	    
	    .modal-content {
	        background-color: #fefefe;
	        margin: 5% auto;
	        padding: 20px;
	        border: 1px solid #888;
	        width: 80%;
	        max-width: 800px;
	        border-radius: 10px;
	    }
	    
	    .modal-header {
	        display: flex;
	        justify-content: space-between;
	        align-items: center;
	        margin-bottom: 15px;
	    }
	    .prod-search-container {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
	    .close {
	        color: #aaa;
	        font-size: 28px;
	        font-weight: bold;
	        cursor: pointer;
	    }
	    
	    #searchAddress {
	        flex-grow: 1;
	    }
	    
	    .map-footer {
	        margin-top: 15px;
	    }
	    
	    #selectedAddress {
	        margin-bottom: 10px;
	    }
    </style>
</head>
<body>
    <div class="container">
        <h1>중고물품 판매 등록</h1>
        <form action="/CarrotEasy/prod/insert.do" method="post" enctype="multipart/form-data" id="productForm">
            <input type="hidden" name="memNo" value="${sessionScope.member.memNo}" />
            
            <div class="form-group">
			    <label>카테고리</label>
			    <div class="category-select-group">
			        <select id="parentCateSelect" required>
			            <option value="">상위 카테고리 선택</option>
			            <c:forEach items="${categoryList}" var="category">
			                <option value="${category.cateNo}">${category.cateName}</option>
			            </c:forEach>
			        </select>
			        <select id="subCateSelect" name="cateNo" required>
			            <option value="">하위 카테고리 선택</option>
			        </select>
			    </div>
			</div>
            
            <div class="form-group">
			    <label>지역</label>
			    <div class="area-select-group">
			        <select id="districtSelect" required>
			            <option value="">구 선택</option>
			            <c:forEach items="${districtList}" var="district">
			                <option value="${district.areaNo}">${district.areaName}</option>
			            </c:forEach>
			        </select>
			        <select id="dongSelect" name="areaNo" required>
			            <option value="">동 선택</option>
			        </select>
			    </div>
			</div>
            
            <div class="form-group">
                <label for="prodTitle">제목</label>
                <input type="text" class="insert-input" id="prodTitle" name="prodTitle" maxlength="100" required>
            </div>
            
            <div class="form-group">
                <label for="prodContent">상세 설명</label>
                <textarea id="prodContent" name="prodContent" maxlength="4000" required></textarea>
            </div>
            
            <div class="form-group">
                <label for="prodPrice">가격</label>
                <input type="text" class="insert-input" id="prodPrice" name="prodPrice" min="0" required>
            </div>
            
            <div class="form-group">
			    <label for="prodLocation">거래 희망 장소</label>
			    <div class="location-input-group">
			        <input type="text" class="insert-input" id="prodLocation" name="prodLocation" maxlength="200" required readonly>
			        <button type="button" id="searchMapBtn" class="btn btn-map">지도에서 선택</button>
			    </div>
			    <!-- 위도/경도 값을 저장할 히든 필드 추가 -->
			    <input type="hidden" id="prodLatitude" name="prodLatitude">
			    <input type="hidden" id="prodLongitude" name="prodLongitude">
			    
			    <!-- 모달 다이얼로그 추가 -->
			    <div id="mapModal" class="modal">
			        <div class="modal-content">
			            <div class="modal-header">
			                <h3>거래 희망 장소 선택</h3>
			                <span class="close">&times;</span>
			            </div>
			            <div class="modal-body">
			                <div class="prod-search-container">
			                    <input type="text" id="searchAddress" placeholder="주소 검색">
			                    <button type="button" id="searchBtn">검색</button>
			                </div>
			                <div id="map" style="width:100%;height:400px;"></div>
			                <div class="map-footer">
			                    <p id="selectedAddress">선택된 주소: </p>
			                    <button type="button" id="confirmLocation" class="btn">위치 확정</button>
			                </div>
			            </div>
			        </div>
			    </div>
			</div>
                        
            <div class="form-group">
                <label for="prodStatus">상품 상태</label>
                <select id="prodStatus" name="prodStatus" required>
                    <option value="">상품 상태 선택</option>
                    <option value="new">새상품</option>
                    <option value="almost">거의 새것</option>
                    <option value="slightly">중고</option>
                    <option value="used">오래됨</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>상품 이미지 (최대 3개)</label>
                <div class="image-upload">
                    <div class="image-preview">
                        <span class="preview-text">+ 이미지 추가</span>
                        <input type="file" name="prodImage" accept="image/*" onchange="previewImage(this, 0)">
                        <button type="button" class="remove-btn" onclick="removeImage(0)">X</button>
                    </div>
                    <div class="image-preview">
                        <span class="preview-text">+ 이미지 추가</span>
                        <input type="file" name="prodImage" accept="image/*" onchange="previewImage(this, 1)">
                        <button type="button" class="remove-btn" onclick="removeImage(1)">X</button>
                    </div>
                    <div class="image-preview">
                        <span class="preview-text">+ 이미지 추가</span>
                        <input type="file" name="prodImage" accept="image/*" onchange="previewImage(this, 2)">
                        <button type="button" class="remove-btn" onclick="removeImage(2)">X</button>
                    </div>
                </div>
            </div>
            
            <div class="btn-group">
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소하기</button>
                <button type="submit" class="btn">등록하기</button>
            </div>
        </form>
    </div>
    
    <script>
    
	 // 상위 카테고리 선택 시 이벤트 처리
	    document.getElementById('parentCateSelect').addEventListener('change', function() {
	        const parentCateNo = this.value;
	        if (parentCateNo) {
	            // 선택된 상위 카테고리 번호가 있으면 해당 하위 카테고리 목록 가져오기
	            loadSubcategories(parentCateNo);
	        } else {
	            // 상위 카테고리가 선택되지 않은 경우 하위 카테고리 선택 초기화
	            const subCateSelect = document.getElementById('subCateSelect');
	            subCateSelect.innerHTML = '<option value="">하위 카테고리 선택</option>';
	            subCateSelect.disabled = true;
	        }
	    });
	
	    // 하위 카테고리 목록 로드 함수
	    function loadSubcategories(parentCateNo) {
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
	                subCateSelect.innerHTML = '<option value="">하위 카테고리 선택</option>';
	                
	                // 하위 카테고리 선택 활성화
	                subCateSelect.disabled = false;
	                
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
	                alert('카테고리 정보를 불러오는데 실패했습니다.');
	            });
	    }
    
	 	// 구 선택 시 이벤트 처리
	    document.getElementById('districtSelect').addEventListener('change', function() {
	        const districtNo = this.value;
	        if (districtNo) {
	            // 선택된 구 번호가 있으면 해당 구의 동 목록 가져오기
	            loadDongs(districtNo);
	        } else {
	            // 구가 선택되지 않은 경우 동 선택 초기화
	            const dongSelect = document.getElementById('dongSelect');
	            dongSelect.innerHTML = '<option value="">동 선택</option>';
	            dongSelect.disabled = true;
	        }
	    });
	
	    // 동 목록 로드 함수
	    function loadDongs(districtNo) {
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
	                dongSelect.innerHTML = '<option value="">동 선택</option>';
	                
	                // 동 선택 활성화
	                dongSelect.disabled = false;
	                
	                // 받아온 동 목록으로 옵션 추가
	                data.forEach(dong => {
	                    const option = document.createElement('option');
	                    option.value = dong.areaNo;
	                    option.textContent = dong.areaName;
	                    dongSelect.appendChild(option);
	                });
	            })
	            .catch(error => {
	                console.error('동 목록을 불러오는 중 오류 발생:', error);
	                alert('지역 상세 정보를 불러오는데 실패했습니다.');
	            });
	    }

	    function previewImage(input, index) {
            const preview = input.parentElement;
            const previewText = preview.querySelector('.preview-text');
            const removeBtn = preview.querySelector('.remove-btn');
            
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                
                reader.onload = function(e) {
                    // 기존 텍스트 제거
                    if (previewText) {
                        previewText.style.display = 'none';
                    }
                    
                    // 기존 이미지가 있으면 제거
                    const existingImg = preview.querySelector('img');
                    if (existingImg) {
                        existingImg.remove();
                    }
                    
                    // 새 이미지 추가
                    const img = document.createElement('img');
                    img.src = e.target.result;
                    preview.appendChild(img);
                    
                    // 삭제 버튼 표시
                    removeBtn.style.display = 'block';
                };
                
                reader.readAsDataURL(input.files[0]);
            }
        }
        
        function removeImage(index) {
            const preview = document.querySelectorAll('.image-preview')[index];
            const input = preview.querySelector('input[type="file"]');
            const previewText = preview.querySelector('.preview-text');
            const img = preview.querySelector('img');
            const removeBtn = preview.querySelector('.remove-btn');
            
            // 이미지 제거
            if (img) {
                img.remove();
            }
            
            // 파일 입력 초기화
            input.value = '';
            
            // 텍스트 표시
            previewText.style.display = 'block';
            
            // 삭제 버튼 숨기기
            removeBtn.style.display = 'none';
        }
        
        document.getElementById('productForm').addEventListener('submit', function(e) {
            // 최소 1개 이상의 이미지가 업로드되었는지 확인
            const fileInputs = document.querySelectorAll('input[type="file"]');
            let hasImage = false;
            let filesCount = 0;
            
            for (let i = 0; i < fileInputs.length; i++) {
                if (fileInputs[i].files.length > 0) {
                    hasImage = true;
                    filesCount++;
                    // 비어있는 input:file을 비활성화하여 서버로 전송되지 않도록 함
                } else {
                    fileInputs[i].disabled = true; // 중요: 선택되지 않은 파일 입력은 비활성화
                }
            }
            
            if (!hasImage) {
                e.preventDefault();
                alert('최소 1개 이상의 상품 이미지를 등록해주세요.');
                return false;
            }
            
            // 폼 제출 전 disabled된 input 요소들을 다시 활성화
            // 이렇게 해야 사용자가 back 버튼을 눌렀을 때 문제가 없음
            window.addEventListener('pageshow', function(event) {
                if (event.persisted) {
                    const disabledInputs = document.querySelectorAll('input[disabled]');
                    disabledInputs.forEach(input => input.disabled = false);
                }
            });
        });
        
     	// 모달 관련 요소
        const mapModal = document.getElementById('mapModal');
        const searchMapBtn = document.getElementById('searchMapBtn');
        const closeBtn = document.querySelector('.close');
        const confirmLocationBtn = document.getElementById('confirmLocation');
        
        // 지도 관련 변수
        let map;
        let marker;
        let geocoder;
        let selectedPosition;
        let selectedAddress = '';
        
        // 지도 버튼 클릭 시 모달 열기
        searchMapBtn.addEventListener('click', function() {
            mapModal.style.display = 'block';
            
            if (typeof kakao === 'undefined') {
                alert('카카오맵 API가 로드되지 않았습니다. 페이지를 새로고침하거나 API 키를 확인해주세요.');
                return;
            }
            
            // 지도가 이미 초기화되어 있지 않으면 초기화
            if (!map) {
                initMap();
                console.log("initMap");
            } else {
                // 모달이 열릴 때 지도 크기 업데이트 (카카오맵 버그 방지)
                setTimeout(function() {
                    map.relayout();
                }, 300);
            }
        });
        
        // 모달 닫기
        closeBtn.addEventListener('click', function() {
            mapModal.style.display = 'none';
        });
        
        // 모달 바깥 클릭 시 닫기
        window.addEventListener('click', function(event) {
            if (event.target == mapModal) {
                mapModal.style.display = 'none';
            }
        });
        
        // 위치 확정 버튼 클릭
        confirmLocationBtn.addEventListener('click', function() {
            if (selectedAddress) {
                document.getElementById('prodLocation').value = selectedAddress;
                document.getElementById('prodLatitude').value = selectedPosition.getLat();
                document.getElementById('prodLongitude').value = selectedPosition.getLng();
                mapModal.style.display = 'none';
            } else {
                alert('위치를 선택해주세요.');
            }
        });
        
        // 지도 초기화 함수
        function initMap() {
		    // 카카오맵 지도 생성
		    const container = document.getElementById('map');
		    const options = {
		        center: new kakao.maps.LatLng(36.3504119, 127.3845475),
		        level: 5
		    };
		    
		    map = new kakao.maps.Map(container, options);
		    
		    // 주소-좌표 변환 객체 생성
		    geocoder = new kakao.maps.services.Geocoder();
		    
		    // 지도 초기화 후 선택된 동이 있으면 해당 위치로 이동
		    const dongSelect = document.getElementById('dongSelect');
		    const districtSelect = document.getElementById('districtSelect');
		    
		    if (dongSelect.value && districtSelect.value) {
		        const dongName = dongSelect.options[dongSelect.selectedIndex].text;
		        const districtName = districtSelect.options[districtSelect.selectedIndex].text;
                const fullAddress = "대전 "+districtName+" "+dongName;
		        moveMapToAddress(fullAddress);
		    }
		    
		    // 지도 클릭 이벤트 등록
		    kakao.maps.event.addListener(map, 'click', function(mouseEvent) {
		        // 클릭한 위치의 좌표 정보
		        selectedPosition = mouseEvent.latLng;
		        
		        // 마커가 이미 있으면 위치 변경, 없으면 새로 생성
		        if (marker) {
		            marker.setPosition(selectedPosition);
		        } else {
		            marker = new kakao.maps.Marker({
		                position: selectedPosition,
		                map: map
		            });
		        }
		        
		        // 좌표를 주소로 변환
		        searchDetailAddrFromCoords(selectedPosition, function(result, status) {
		            if (status === kakao.maps.services.Status.OK) {
		                let detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
		                selectedAddress = detailAddr;
		                document.getElementById('selectedAddress').textContent = '선택된 주소: ' + detailAddr;
		            }
		        });
		    });
		    
		    // 주소 검색 버튼 클릭 이벤트
		    document.getElementById('searchBtn').addEventListener('click', function() {
		        const address = document.getElementById('searchAddress').value;
		        if (address.trim() !== '') {
		            searchAddressToCoordinate(address);
		        }
		    });
		    
		    // 주소 검색 입력 필드에서 엔터키 이벤트
		    document.getElementById('searchAddress').addEventListener('keypress', function(e) {
		        if (e.key === 'Enter') {
		            e.preventDefault();
		            document.getElementById('searchBtn').click();
		        }
		    });
		}
        
        // 좌표로 상세 주소 정보 요청 함수
        function searchDetailAddrFromCoords(coords, callback) {
            geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
        }
        
        // 주소로 좌표 검색 함수
        function searchAddressToCoordinate(address) {
            geocoder.addressSearch(address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    
                    // 지도 중심을 이동
                    map.setCenter(coords);
                    
                    // 마커가 이미 있으면 위치 변경, 없으면 새로 생성
                    if (marker) {
                        marker.setPosition(coords);
                    } else {
                        marker = new kakao.maps.Marker({
                            position: coords,
                            map: map
                        });
                    }
                    
                    selectedPosition = coords;
                    selectedAddress = result[0].address_name;
                    document.getElementById('selectedAddress').textContent = '선택된 주소: ' + selectedAddress;
                } else {
                    alert('주소 검색 결과가 없습니다.');
                }
            });
        }
        
     	// 주소로 지도 이동 함수 추가
        function moveMapToAddress(address) {
            geocoder.addressSearch(address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    const coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    
                    // 지도 중심을 이동
                    map.setCenter(coords);
                    
                    // 지도 레벨 조정 (동 단위로 더 확대)
                    map.setLevel(4);
                    
                    // 마커가 이미 있으면 위치 변경, 없으면 새로 생성
                    if (marker) {
                        marker.setPosition(coords);
                    } else {
                        marker = new kakao.maps.Marker({
                            position: coords,
                            map: map
                        });
                    }
                    
                    selectedPosition = coords;
                    selectedAddress = result[0].address.address_name || address;
                    document.getElementById('selectedAddress').textContent = '선택된 주소: ' + selectedAddress;
                } else {
                	console.error("주소 검색 실패:", address, "상태:", status);
                }
            });
        }
        
	    // 동 선택 시 이벤트 처리
        document.getElementById('dongSelect').addEventListener('change', function() {
            const dongNo = this.value;
            const dongName = this.options[this.selectedIndex].text.trim();
            const districtSelect = document.getElementById('districtSelect');
            const districtName = districtSelect.options[districtSelect.selectedIndex].text.trim();
            
            if (dongNo) {
                // 선택된 동이 있으면 해당 동의 지도 중심으로 이동
                const fullAddress = "대전 "+districtName+" "+dongName;
                console.log(fullAddress);
                // 이미 지도가 초기화되어 있으면 선택된 동으로 지도 중심 이동
                if (map && geocoder) {
                    moveMapToAddress(fullAddress);
                }
            }
        });
    </script>
</body>
</html>