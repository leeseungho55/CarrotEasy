<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=c5f0aecfeefdc035027e9363d88272b0&libraries=services"></script>
<script type="text/javascript">

const MAX_IMAGES = 3;
let currentImageCount = 0;
let existingImages = []; // 기존 이미지 정보를 저장할 배열
</script>
<head>
    <meta charset="UTF-8">
    <title>중고물품 판매 수정</title>
    <style>
        .container {
            max-width: 800px;
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
        .form-group {
            margin-bottom: 20px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .update-input,
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
            background-color: #4CAF50;
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
        .btn-cancel {
            background-color: #f44336;
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
            z-index: 10;
        }
        .existing-image {
            position: relative;
            width: 150px;
            height: 150px;
            border: 2px solid #ddd;
            margin-right: 15px;
            margin-bottom: 15px;
            display: inline-block;
            overflow: hidden;
        }
        .existing-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .existing-image .remove-btn {
            display: block;
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
        .close {
            color: #aaa;
            font-size: 28px;
            font-weight: bold;
            cursor: pointer;
        }
        .prod-search-container {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
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
        <h1>중고물품 판매 수정</h1>
        <form action="/CarrotEasy/prod/update.do" method="post" enctype="multipart/form-data" id="productForm">
            <input type="hidden" name="prodNo" value="${prodVo.prodNo}" />
            <input type="hidden" name="memNo" value="${sessionScope.member.memNo}" />
            
            <div class="form-group">
                <label>카테고리</label>
                <div class="category-select-group">
                    <select id="parentCateSelect" required>
                        <option value="">상위 카테고리 선택</option>
                        <c:forEach items="${categoryList}" var="category">
                            <option value="${category.cateNo}" ${category.cateNo eq parentCateNo ? 'selected' : ''}>${category.cateName}</option>
                        </c:forEach>
                    </select>
                    <select id="subCateSelect" name="cateNo" required>
                        <option value="">하위 카테고리 선택</option>
                        <c:forEach items="${subCategoryList}" var="subCategory">
                            <option value="${subCategory.cateNo}" ${subCategory.cateNo eq prodVo.cateNo ? 'selected' : ''}>${subCategory.cateName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label>지역</label>
                <div class="area-select-group">
                    <select id="districtSelect" required>
                        <option value="">구 선택</option>
                        <c:forEach items="${districtList}" var="district">
                            <option value="${district.areaNo}" ${district.areaNo eq districtNo ? 'selected' : ''}>${district.areaName}</option>
                        </c:forEach>
                    </select>
                    <select id="dongSelect" name="areaNo" required>
                        <option value="">동 선택</option>
                        <c:forEach items="${dongList}" var="dong">
                            <option value="${dong.areaNo}" ${dong.areaNo eq prodVo.areaNo ? 'selected' : ''}>${dong.areaName}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            
            <div class="form-group">
                <label for="prodTitle">제목</label>
                <input type="text" class="update-input" id="prodTitle" name="prodTitle" maxlength="100" value="${prodVo.prodTitle}" required>
            </div>
            
            <div class="form-group">
                <label for="prodContent">상세 설명</label>
                <textarea id="prodContent" name="prodContent" maxlength="4000" required>${prodVo.prodContent}</textarea>
            </div>
            
            <div class="form-group">
                <label for="prodPrice">가격</label>
                <input type="text" class="update-input" id="prodPrice" name="prodPrice" min="0" value="${prodVo.prodPrice}" required>
            </div>
            
            <div class="form-group">
                <label for="prodLocation">거래 희망 장소</label>
                <div class="location-input-group">
                    <input type="text" class="update-input" id="prodLocation" name="prodLocation" maxlength="200" value="${prodVo.prodLocation}" required readonly>
                    <button type="button" id="searchMapBtn" class="btn btn-map">지도에서 선택</button>
                </div>
                
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
                                <p id="selectedAddress">선택된 주소: ${prodVo.prodLocation}</p>
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
                    <option value="new" ${prodVo.prodStatus eq 'NEW' ? 'selected' : ''}>새상품</option>
                    <option value="almost" ${prodVo.prodStatus eq 'ALMOST_NEW' ? 'selected' : ''}>거의 새것</option>
                    <option value="slightly" ${prodVo.prodStatus eq 'SLIGHTLY_USED' ? 'selected' : ''}>중고</option>
                    <option value="used" ${prodVo.prodStatus eq 'USED' ? 'selected' : ''}>오래됨</option>
                </select>
            </div>
            
            <div class="form-group">
                <label>기존 상품 이미지</label>
                <div class="image-upload">
                    <c:forEach items="${fileList}" var="file" varStatus="status">
                        <div class="existing-image" id="existing-image-${file.fileNo}">
                            <img class="thumbnail ${status.index == 0 ? 'active' : ''}" 
					             src="/CarrotEasy${file.filePath}" 
					             alt="상품 이미지 ${status.index + 1}"
					             onclick="changeMainImage('${file.filePath}', this)">
                            <button type="button" class="remove-btn" onclick="removeExistingImage(${file.fileNo})">X</button>
                            <input type="hidden" id="keepImage-${file.fileNo}" name="keepImageNo" value="${file.fileNo}">
                        </div>
                    </c:forEach>
                </div>
            </div>

            <div class="form-group">
                <label>상품 이미지 (최대 3개)</label>
                <div class="image-upload" id="imageContainer">
                    <!-- 기존 이미지들은 자바스크립트로 여기에 추가됩니다 -->
                    
                    <!-- 항상 보이는 이미지 추가 버튼 -->
                    <div class="image-preview" id="addImageBtn">
                        <span class="preview-text">+ 이미지 추가</span>
                        <input type="file" name="prodImage" accept="image/*" onchange="handleImageChange(this)">
                    </div>
                </div>
                <!-- 삭제된 이미지 번호를 저장할 히든 필드들 -->
                <div id="removedImagesContainer"></div>
            </div>
            
            <div class="btn-group">
                <button type="submit" class="btn">수정하기</button>
                <button type="button" class="btn btn-cancel" onclick="history.back()">취소하기</button>
            </div>
        </form>
    </div>
    
    <script>

    window.addEventListener('DOMContentLoaded', function() {
        // 기존 이미지 목록 가져오기
        const fileListContainer = document.querySelector('.existing-image')?.parentElement;
        // 기존 이미지가 있는지 확인
        if (fileListContainer) {
            const existingImageElements = fileListContainer.querySelectorAll('.existing-image');
            
            // 기존 이미지가 있으면 전역 변수에 추가
            existingImageElements.forEach(imgElement => {
                const fileNo = imgElement.id.split('-')[2];
                const imgSrc = imgElement.querySelector('img').src;
                const isMain = imgElement.querySelector('img').classList.contains('active');
                
                // existingImages 배열에 정보 추가
                existingImages.push({
                    fileNo: fileNo,
                    imgSrc: imgSrc,
                    isMain: isMain
                });
            });
            
            // 현재 이미지 개수 업데이트
            currentImageCount = existingImages.length;
            
            // 기존 이미지 섹션을 DOM에서 제거 (통합 UI로 대체)
            if (fileListContainer.parentElement) {
                fileListContainer.parentElement.remove();
            }
        }
        
        // 새 이미지 추가 섹션 제거 (통합 UI로 대체)
        const newImageSection = document.querySelector('.image-preview')?.parentElement?.parentElement;
        if (newImageSection && newImageSection.querySelector('label')?.textContent.includes('새 상품 이미지')) {
            newImageSection.remove();
        }
        
        // 통합된 이미지 UI 초기화
        initializeImageUI();
        
        // 폼 제출 처리
        setupFormSubmitHandler();
    });

    // 통합된 이미지 UI 초기화 함수
    function initializeImageUI() {
        const imageContainer = document.getElementById('imageContainer');
        
        // 이미지 컨테이너가 존재하는지 확인
        if (!imageContainer) {
            console.error("이미지 컨테이너를 찾을 수 없습니다.");
            return;
        }
        
        // 먼저 기존 컨텐츠 제거 (추가 버튼 포함)
        imageContainer.innerHTML = '';
        
        // 기존 이미지가 있으면 UI에 추가
        existingImages.forEach((img, index) => {
            const imagePreview = createImagePreviewElement(img.fileNo, true);
            
            // 이미지 요소 설정
            const imgElement = document.createElement('img');
            imgElement.src = img.imgSrc;
            imgElement.alt = '상품 이미지 ' + (index + 1);
            if (img.isMain) {
                imgElement.classList.add('active');
            }
            
            // 기존 텍스트 제거 및 이미지 추가
            const previewText = imagePreview.querySelector('.preview-text');
            if (previewText) {
                previewText.remove();
            }
            imagePreview.appendChild(imgElement);

            const keepImageInput = document.createElement('input');
            keepImageInput.type = 'hidden';
            keepImageInput.name = 'keepImageNo';
            keepImageInput.value = img.fileNo;
            keepImageInput.id = 'keepImage-' + img.fileNo;
            imagePreview.appendChild(keepImageInput);
            
            // 삭제 버튼 표시
            const removeBtn = imagePreview.querySelector('.remove-btn');
            if (removeBtn) {
                removeBtn.style.display = 'block';
            }
            
            // 이미지 프리뷰를 컨테이너에 추가
            imageContainer.appendChild(imagePreview);
        });
        
        // 최대 이미지 개수에 도달하지 않았을 때만 추가 버튼 생성
        if (currentImageCount < MAX_IMAGES) {
            const addImageBtn = createAddImageButton();
            imageContainer.appendChild(addImageBtn);
        } else {
            console.log("최대 이미지 개수(" + MAX_IMAGES + ")에 도달했습니다. 추가 버튼이 표시되지 않습니다.");
        }
    }

    // 이미지 프리뷰 요소 생성 함수
    function createImagePreviewElement(fileNo, isExisting = false) {
        const imagePreview = document.createElement('div');
        imagePreview.className = 'image-preview';
        
        if (isExisting) {
            // 기존 이미지인 경우
            imagePreview.dataset.fileNo = fileNo;
            imagePreview.dataset.isExisting = 'true';
            
            // 기존 이미지 변경을 위한 파일 입력
            const fileInput = document.createElement('input');
            fileInput.type = 'file';
            fileInput.name = `updateImage_${fileNo}`;
            fileInput.accept = 'image/*';
            fileInput.onchange = function() { handleExistingImageChange(this); };
            imagePreview.appendChild(fileInput);
        } else {
            // 새 이미지인 경우
            const fileInput = document.createElement('input');
            fileInput.type = 'file';
            fileInput.name = 'prodImage';
            fileInput.accept = 'image/*';
            fileInput.onchange = function() { handleImageChange(this); };
            imagePreview.appendChild(fileInput);
        }
        
        // 삭제 버튼 추가
        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.className = 'remove-btn';
        removeBtn.textContent = 'X';
        removeBtn.onclick = function() { removeImagePreview(this.parentElement); };
        removeBtn.style.display = 'none'; // 초기에는 숨김
        imagePreview.appendChild(removeBtn);
        
        // 기본 텍스트 추가
        const previewText = document.createElement('span');
        previewText.className = 'preview-text';
        previewText.textContent = 'Click to upload';
        imagePreview.appendChild(previewText);
        
        return imagePreview;
    }

    // 새 이미지 추가 처리 함수
    function handleImageChange(input) {
        if (input.files && input.files[0]) {
            const preview = input.parentElement;
            const reader = new FileReader();
            
            reader.onload = function(e) {
                // 이미 이미지가 있다면 제거
                const existingImg = preview.querySelector('img');
                if (existingImg) {
                    existingImg.remove();
                }
                
                // 텍스트 제거
                const previewText = preview.querySelector('.preview-text');
                if (previewText) {
                    previewText.remove();
                }
                
                // 새 이미지 추가
                const img = document.createElement('img');
                img.src = e.target.result;
                img.alt = '상품 이미지';
                preview.appendChild(img);
                
                // 삭제 버튼 표시
                const removeBtn = preview.querySelector('.remove-btn');
                if (removeBtn) {
                    removeBtn.style.display = 'block';
                }
                
                // 이 요소가 추가 버튼이었다면
                if (preview.id === 'addImageBtn') {
                    preview.id = ''; // ID 제거
                    currentImageCount++; // 이미지 개수 증가
                    
                    // 최대 이미지 개수에 도달하지 않았다면 새 추가 버튼 생성
                    if (currentImageCount < MAX_IMAGES) {
                        const newAddBtn = createAddImageButton();
                        document.getElementById('imageContainer').appendChild(newAddBtn);
                    }
                }
            };
            
            reader.readAsDataURL(input.files[0]);
        }
    }

    // 기존 이미지 변경 처리 함수
    function handleExistingImageChange(input) {
        if (input.files && input.files[0]) {
            const preview = input.parentElement;
            const reader = new FileReader();
            
            reader.onload = function(e) {
                // 이미 이미지가 있다면 제거
                const existingImg = preview.querySelector('img');
                if (existingImg) {
                    existingImg.remove();
                }
                
                // 텍스트 제거
                const previewText = preview.querySelector('.preview-text');
                if (previewText) {
                    previewText.remove();
                }
                
                // 새 이미지 추가
                const img = document.createElement('img');
                img.src = e.target.result;
                img.alt = '상품 이미지';
                preview.appendChild(img);
                
                // 필드 이름 변경 - 기존 이미지를 업데이트하는 것으로 표시
                input.name = `updateImage_${preview.dataset.fileNo}`;
            };
            
            reader.readAsDataURL(input.files[0]);
        }
    }

    // 이미지 추가 버튼 생성 함수
    function createAddImageButton() {
        const addBtn = document.createElement('div');
        addBtn.className = 'image-preview';
        addBtn.id = 'addImageBtn';
        
        const previewText = document.createElement('span');
        previewText.className = 'preview-text';
        previewText.textContent = '+ 이미지 추가';
        addBtn.appendChild(previewText);
        
        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.name = 'prodImage';
        fileInput.accept = 'image/*';
        fileInput.onchange = function() { handleImageChange(this); };
        addBtn.appendChild(fileInput);
        
        const removeBtn = document.createElement('button');
        removeBtn.type = 'button';
        removeBtn.className = 'remove-btn';
        removeBtn.textContent = 'X';
        removeBtn.style.display = 'none';
        removeBtn.onclick = function() { removeImagePreview(this.parentElement); };
        addBtn.appendChild(removeBtn);
        
        return addBtn;
    }

    // 이미지 삭제 처리 함수
    function removeImagePreview(preview) {
        // 기존 이미지인 경우, 삭제 표시를 위한 히든 필드 추가
        if (preview.dataset.isExisting === 'true') {
            const fileNo = preview.dataset.fileNo;

            const keepInput = preview.querySelector('input[name="keepImageNo"]');
            if (keepInput) {
                // keepImageNo를 removedImageNo로 변경
                keepInput.name = 'removedImageNo';
                // ID도 변경해서 나중에 쉽게 찾을 수 있게
                keepInput.id = 'removedImage-' + fileNo;
            } else {
                // keepImageNo가 없는 경우 새로 만들기
                const removedField = document.createElement('input');
                removedField.type = 'hidden';
                removedField.name = 'removedImageNo';
                removedField.id = 'removedImage-' + fileNo;
                removedField.value = fileNo;
                document.getElementById('removedImagesContainer').appendChild(removedField);
            }
        }
        
        // DOM에서 제거
        preview.remove();
        currentImageCount--; // 이미지 개수 감소
        
        // 추가 버튼 표시 업데이트
        updateAddImageBtnVisibility();
    }

    // 추가 버튼 표시 상태 업데이트 함수
    function updateAddImageBtnVisibility() {
        const imageContainer = document.getElementById('imageContainer');
        
        // 추가 버튼이 이미 있는지 확인
        let addBtn = document.getElementById('addImageBtn');
        
        // 최대 이미지 개수 이내이고 추가 버튼이 없으면 생성
        if (currentImageCount < MAX_IMAGES) {
            addBtn = createAddImageButton();
            imageContainer.appendChild(addBtn);
        }
        // 최대 이미지 개수에 도달했고 추가 버튼이 있으면 제거
        else if (currentImageCount >= MAX_IMAGES && addBtn) {
            addBtn.remove();
        }
    }

    // 폼 제출 전 처리 함수
    function setupFormSubmitHandler() {
        const form = document.getElementById('productForm');
        if (!form) {
            console.error("상품 폼을 찾을 수 없습니다.");
            return;
        }
        
        form.addEventListener('submit', function(e) {
            // 이미지가 하나라도 있는지 확인
            const imagePreviews = document.querySelectorAll('.image-upload .image-preview');
            let validImageCount = 0;
            
            // 유효한 이미지 개수 계산
            imagePreviews.forEach(preview => {
                const img = preview.querySelector('img');
                const fileInput = preview.querySelector('input[type="file"]');
                const keepInput = preview.querySelector('input[name="keepImageNo"]');
                
                // 이미지가 있거나, 파일이 선택되었거나, keepImageNo가 있으면 유효한 이미지로 카운트
                if (img || (fileInput && fileInput.files && fileInput.files.length > 0) || keepInput) {
                    validImageCount++;
                }
            });
            
            console.log("유효 이미지 개수:", validImageCount);
            
            if (validImageCount === 0) {
                e.preventDefault();
                alert('최소 1개 이상의 상품 이미지가 필요합니다.');
                return false;
            }
            
            // 빈 파일 입력은 비활성화하여 서버로 전송되지 않도록 함
            const fileInputs = document.querySelectorAll('input[type="file"]');
            fileInputs.forEach(input => {
                if (!input.files || input.files.length === 0) {
                    input.disabled = true;
                }
            });
            
            // 기존 keepImageNo 필드 디버깅
            const keepInputs = document.querySelectorAll('input[name="keepImageNo"]');
            console.log("제출 시 keepImageNo 수:", keepInputs.length);
            keepInputs.forEach(input => console.log("keepImageNo 값:", input.value));
            
            // 폼 제출 전 disabled된 input 요소들을 다시 활성화
            window.addEventListener('pageshow', function(event) {
                if (event.persisted) {
                    const disabledInputs = document.querySelectorAll('input[disabled]');
                    disabledInputs.forEach(input => input.disabled = false);
                }
            });
        });
    }

    // 메인 이미지 설정 함수
    function setMainImage(imgElement) {
        // 모든 이미지에서 active 클래스 제거
        document.querySelectorAll('.image-preview img').forEach(img => {
            img.classList.remove('active');
        });
        
        // 선택된 이미지에 active 클래스 추가
        imgElement.classList.add('active');
        
        // 메인 이미지 설정을 위한 히든 필드 추가 또는 업데이트
        let mainImageInput = document.getElementById('mainImageInput');
        if (!mainImageInput) {
            mainImageInput = document.createElement('input');
            mainImageInput.type = 'hidden';
            mainImageInput.id = 'mainImageInput';
            mainImageInput.name = 'mainImageNo';
            document.getElementById('productForm').appendChild(mainImageInput);
        }
        
        // 이미지가 기존 이미지인 경우 fileNo 값 설정
        const imagePreview = imgElement.closest('.image-preview');
        if (imagePreview.dataset.isExisting === 'true') {
            mainImageInput.value = imagePreview.dataset.fileNo;
        }
    }

    // 초기 설정 - 이미지 클릭 이벤트와 드래그 앤 드롭 설정
    document.addEventListener('click', function(e) {
        if (e.target.tagName === 'IMG' && e.target.closest('.image-preview')) {
            setMainImage(e.target);
        }
    });

    
    
    //
    // 카테고리 및 구/동 선택 관련 함수
    //
    
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
                const currentCateNo = '${prodVo.cateNo}';
                
                // 기존 옵션 초기화 (첫 번째 옵션은 유지)
                subCateSelect.innerHTML = '<option value="">하위 카테고리 선택</option>';
                
                // 하위 카테고리 선택 활성화
                subCateSelect.disabled = false;
                
                // 받아온 하위 카테고리 목록으로 옵션 추가
                data.forEach(subcategory => {
                    const option = document.createElement('option');
                    option.value = subcategory.cateNo;
                    option.textContent = subcategory.cateName;
                    if (subcategory.cateNo == currentCateNo) {
                        option.selected = true;
                    }
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
    
    /*document.getElementById('productForm').addEventListener('submit', function(e) {
        const fileInputs = document.querySelectorAll('input[type="file"]');
        const existingImages = document.querySelectorAll('.existing-image');
        
        let hasNewFile = false;

        const keeps = document.querySelectorAll('input[name="keepImageNo"]');
        console.log("남아 있는 keepImageNo input 수:", keeps.length);
        keeps.forEach(input => console.log(input.value));

        // 실제 파일이 선택된 input 있는지 확인
        fileInputs.forEach(input => {
            if (input.files && input.files.length > 0) {
                hasValidFile = true;
            } else {
                input.disabled = true; // 전송 안 되게
            }
        });
		
        const hasExistingImages = existingImages.length > 0;
		
        if (!hasExistingImages && !hasNewFile) {
            e.preventDefault();
            alert('최소 1개 이상의 상품 이미지를 등록해주세요.');
            return false;
        }

        // 뒤로가기 시 disabled 복구
        window.addEventListener('pageshow', function(event) {
            if (event.persisted) {
                const disabledInputs = document.querySelectorAll('input[disabled]');
                disabledInputs.forEach(input => input.disabled = false);
            }
        });
    });*/


    // 
    //  카카오 맵 api 관련 부분
    //
    
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
    
 	// 기존 이미지 제거 함수
    function removeExistingImage(fileNo) {
        // 화면에서 이미지 요소 제거
        const imageDiv = document.getElementById('existing-image-' + fileNo);
        if (imageDiv) {
            // 이미지 유지 input의 name 속성을 변경하여 서버로 전송되지 않도록 함
            const keepInput = document.getElementById('keepImage-' + fileNo);
            if (keepInput) {
                keepInput.name = 'removedImageNo'; // 또는 keepInput.remove(); 로 완전히 제거 가능
            }
            imageDiv.style.display = 'none'; // 화면에서 숨김
        }
    }
</script>
</body>
</html>