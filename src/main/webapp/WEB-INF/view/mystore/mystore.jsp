<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>내 상점 페이지</title>
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <style>

        body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f7f7f7;
    margin: 0;
    padding: 0;
}

#store {
    max-width: 1180px;
    margin: 8px auto 0 auto;
    background: #fff;
    padding: 20px 30px 30px 30px;
    border-radius: 18px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.07);
    display: flex;
    gap: 32px;
    align-items: flex-start;
}

.photo-section {
    width: 180px;
    min-width: 180px;
    height: 180px;
    border-radius: 50%;
    overflow: hidden;
    background: #f3f3f3;
    display: flex;
    align-items: center;
    justify-content: center;
    box-shadow: 0 1px 6px rgba(0,0,0,0.07);
}
.photo-section img {
    width: 100%;
    height: 100%;
    object-fit: cover;
}

.info-section {
    flex: 1;
}

.top-info {
    display: flex;
    align-items: center;
    gap: 12px;
    margin-bottom: 10px;
}
.store-name {
    font-size: 24px;
    font-weight: 700;
    color: #222;
    letter-spacing: -1px;
}
#storeNameInput {
    font-size: 18px;
    padding: 4px 8px;
    border-radius: 6px;
    border: 1px solid #ddd;
}

#storeNameEditBtn {
    padding: 6px 14px;
    margin: 10px;
    background-color: #FF8A3D;
    color: #fff;
    border-radius: 8px;
    border: none;
    font-size: 18px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.18s, transform 0.15s;
}
#storeNameEditBtn:hover {
    background-color: #e12c17;
    transform: translateY(-1px) scale(1.03);
}

.stat-section {
    display: flex;
    gap: 18px;
    margin-bottom: 12px;
}
.stat-box {
    background: #fafafa;
    border-radius: 7px;
    padding: 8px 16px;
    font-size: 15px;
    color: #555;
    font-weight: 500;
    display: flex;
    align-items: center;
    gap: 4px;
}
.stat-value {
    margin-left: 5px;
    color: #FF8A3D;
    font-weight: bold;
}

.intro-text {
    font-size: 25px;
    font-weight: bold;
    color: #333;
    min-height: 40px;
    margin-bottom: 8px;
    white-space: pre-line;
}

.intro-edit {
    margin-bottom: 8px;
}
.intro-form {
    padding: 6px 14px;
    margin-right: 10px;
    background-color: #FF8A3D;
    color: #fff;
    border-radius: 7px;
    border: none;
    font-size: 18px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.18s;
}
.intro-form:hover {
    background-color: #e12c17;
}

.intro-edit-form {
    margin-bottom: 7px;
    display: none;
}
#introForm textarea {
    width: 98%;
    min-height: 60px;
    font-size: 15px;
    padding: 8px;
    border-radius: 7px;
    border: 1px solid #ddd;
    resize: vertical;
    margin-bottom: 8px;
}
.char-counter {
    font-size: 13px;
    color: #888;
}
.warning {
    color: #e12c17;
    margin-left: 8px;
    font-weight: bold;
}

.img-insert {
    margin-top: 10px;
}
.img-insert {
    padding: 6px 14px;
    background-color: #FF8A3D;
    color: #fff;
    border-radius: 7px;
    border: none;
    font-size: 18px;
    font-weight: 500;
    cursor: pointer;
    transition: background-color 0.18s;
}
.img-insert:hover {
    background-color: #e12c17;
}

.img-section {
	display: flex;
	flex-direction: column;
    align-items: center;
}

.nav-links {
		  display: flex;
		  justify-content: space-around;
		  margin: 20px auto;
		  max-width: 500px;
		  font-size: 0.95em;
		}
		.nav-links a {
		  text-decoration: none;
		  color: #333;
		  padding: 8px;
		  border-bottom: 2px solid transparent;
		}
		.nav-links a:hover {
		  border-bottom: 2px solid #007BFF;
		}
.nav-links span {
    font-size: 15px;
    color: #FF8A3D;
    margin-left: 3px;
}

.product-section {
    max-width: 1180px;
    margin: 8 auto;
    background: #fff;
    min-height: 320px;
    border-radius: 0 0 18px 18px;
    box-shadow: 0 2px 16px rgba(0,0,0,0.07);
    padding: 20px 30px 30px 30px;
    margin-bottom: 30px;
}
#contentArea .empty {
    text-align: center;
    color: #888;
    font-size: 17px;
    padding: 30px 0;
}
#mystoreCarrot {
    display: flex;
    justify-content: center;
    align-items: center;
    min-height: 300px;
}
#mystoreCarrot img {
    max-width: 220px;
    width: 100%;
    height: auto;
    margin: 0 auto;
    display: block;
}
        
    </style>
    <script>
    
        $(document).ready(function () {
        	
        	// 프로필 수정
            $("#mystoreInsert").on('click', function () {
                location.href = "${pageContext.request.contextPath}/mystore/profileUpdate.do";
            });
        	
        	function imgUpdate() {
        		location.href = "${pageContext.request.contextPath}/mystore/profileUpdate.do";
			}
        	
            
	        // 소개글 글자 수 체크
	        $('#introInput').on('input', function() {
	        	const max = 200;
	            const len = $(this).val().length;
	            $('#charCount').text(len);
	
	            if (len > max) {
	              $('#warningMsg').show();
	            } else {
	              $('#warningMsg').hide();
	            }
	        });
	        
	        $(".tab-link").click(function (e) {
	            e.preventDefault();
	            const type = $(this).data("type");

	            $.ajax({
	              url: "/CarrotEasy/mystore/mystoreList.do?prodNo=${prodmemNo}&memNo=${sessionScope.member.memNo}",  // 서블릿 경로
	              method: "GET",
	              data: { type: type },
	              success: function (res) {
	            	  console.log(res);
	                $("#contentArea").html(res);
	              },
	              error: function (xhr) {
	            	  console.error(xhr);
	            	  alert(xhr);
	                $("#contentArea").html("<div class='empty'>불러오기에 실패했습니다.</div>");
	              }
	            });
	        });
            
        });
        
    	// 상점명 수정
        function toggleStoreNameEdit() {
	        const span = document.getElementById('storeName');
	        const input = document.getElementById('storeNameInput');
	        const button = document.getElementById('storeNameEditBtn');
	
	        if(input.style.display === 'none') {
		        input.style.display = 'inline-block';
		        span.style.display = 'none';
		        button.textContent = '확인';
	        }
	        else {
	        	const newName = input.value.trim();
	        	if (newName !== '') span.textContent = newName;
	          	input.style.display = 'none';
	          	span.style.display = 'inline-block';
	          	button.textContent = '상점명 수정';
	          	
	          	$.ajax({
	    			url : "/CarrotEasy/mystore/mystoreMain.do",
	    			type: 'POST',
	                data: { title: newName, num : 0 },
	                success: function(res) {
	                	location.href = "/CarrotEasy/mystore/mystoreMain.do";
	                },
	                error: function(xhr) {
	                	console.error(xhr);
	                	alert(xhr);
	                	
	                }
	    			
	    		});
	        }
            
        }
        
    	// 상점 소개글 textarea 열기
        function toggleIntroEdit() {
			const form = document.getElementById('introForm');
       		form.style.display = (form.style.display === 'none' || form.style.display === '') ? 'block' : 'none';
       		$('#intro-form').hide();
        }
		
    	// 상점 소개글 저장
        function saveIntro() {
	  		const newText = document.getElementById('introInput').value;
	  		document.getElementById('introText').textContent = newText;
	  		
	  		
	  		$.ajax({
    			url : "/CarrotEasy/mystore/mystoreMain.do",
    			type: 'POST',
                data: { content: newText, num : 1 },
                success: function(res) {
//                 	location.href = "/CarrotEasy/mystore/mystoreMain.do";
                	document.getElementById('introForm').style.display = 'none';
        	  		$('#intro-form').show();
                },
                error: function(xhr) {
                	console.error(xhr);
                	alert(xhr);
                	
                }
    			
    		});
        }
    </script>
</head>
<body>

	<div id="store">
		<!-- 사진 영역 -->
		<div class="img-section">
			<div class="photo-section">
				<c:choose>
					<c:when test="${not empty mem.memImg}">
						<img src="${mem.memImg}" alt="프로필 이미지" />
					</c:when>
					<c:otherwise>
						<p>이미지가 없습니다.</p>
					</c:otherwise>
				</c:choose>
			</div>
			<div>
				<!-- 이미지 수정 -->
				<c:if
					test="${empty prodmemNo or sessionScope.member.memNo eq prodmemNo}">
					<button class="img-insert" id="mystoreInsert" onclick="imgUpdate()">이미지
						수정</button>
				</c:if>
			</div>
		</div>
		<!-- 정보 영역 -->
		<div class="info-section">
			<!-- 상점명 -->
			<div class="top-info">
				<span id="storeName" class="store-name"><c:out
						value="${store.storeName}" /></span> <input type="text"
					id="storeNameInput" style="display: none;"
					value="<c:out value="${store.storeName}"/>">
				<div class="intro-edit">
				<c:if
					test="${empty prodmemNo or sessionScope.member.memNo eq prodmemNo}">
					<button type="button" id="storeNameEditBtn"
						onclick="toggleStoreNameEdit()">상점명 수정</button>
				</c:if>
				<c:if
					test="${empty prodmemNo or sessionScope.member.memNo eq prodmemNo}">
					<button id="intro-form" class="intro-form"
						onclick="toggleIntroEdit()">소개글 수정</button>
				</c:if>

			</div>
			</div>
			<!-- 상점 정보 -->
			<div class="stat-section">
				<div class="stat-box">
					상점오픈일<span class="stat-value"><c:out value='${storeOpenDay}' />
						일 전</span>
				</div>
				<div class="stat-box">
					방문수<span class="stat-value"><c:out value='${storeVisitCnt}' />
						명</span>
				</div>
				<div class="stat-box">
					상품판매<span class="stat-value"><c:out
							value='${storeProdSellCnt}' /> 회</span>
				</div>
			</div>
			<!-- 소개글 -->
			<div class="intro-text" id="introText">
				<c:out value="${store.storeContent}" escapeXml="false" />
			</div>
			
			<div class="intro-edit-form" id="introForm">
				<textarea id="introInput" name="content" maxlength="200"><c:out
						value="${store.storeContent}" /></textarea>
				<button class="intro-form" onclick="saveIntro()">확인</button>
				<div class="char-counter">
					<span id="charCount">0</span>/200자 <span id="warningMsg"
						class="warning" style="display: none;">글자 수를 초과했습니다.</span>
				</div>
			</div>


		</div>
	</div>

	<!--     여기까지가 내상점 소개 박스 -->

	<div style="height: 30px;"></div>
	
	<div class="nav-links">
	    <a href="#" class="tab-link" data-type="prod">상품 <span>(<c:out value='${storeProdAllCnt}'/>)</span></a>
	    <a href="#" class="tab-link" data-type="review">상점후기 <span>(<c:out value='${storeReviewAllCnt}'/>)</span></a>
	    <c:if test="${empty prodmemNo or sessionScope.member.memNo eq prodmemNo}">
	    	<a href="#" class="tab-link" data-type="jjim">찜 <span>(<c:out value='${storeJjimAllCnt}'/>)</span></a>
	    </c:if>
  	</div>

	<div class="product-section" id="contentArea">
		<div id="mystoreCarrot"><img src="/CarrotEasy/resource/img/mystore.png" alt="mystore.png" style="height: 400px; width: 200px; text-align: center;"/></div>
	</div>

</body>
</html>
