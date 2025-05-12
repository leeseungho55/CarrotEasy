<!-- 상단 JSP 설정 -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>광고 게시글 보기</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>

	<style>
		.view-wrapper {
		    max-width: 860px; 
		    margin: 80px;
		    font-family: 'Segoe UI', sans-serif;
		    padding: 60px;
		}
	
	    .board-title {
	        display: flex;
	        align-items: center;
	        font-size: 1.8rem;
	        font-weight: 700;
	        margin-bottom: 20px;
	        color: #333;
	    }
	
	    .board-title i {
	        margin-right: 10px;
	        color: #FF8A3D;
	    }
	
	    .info-bar {
	        color: #666;
	        font-size: 15px;
	        margin-bottom: 15px;
	    }
	
	    .badge-success {
	        font-size: 14px;
	        padding: 5px 10px;
	    }
	
		.action-buttons {
		    display: flex;
		    flex-wrap: wrap;
		    justify-content: flex-start;
		    align-items: center;
		    gap: 12px;
		    margin-bottom: 30px;
		}

	
	    .btn-list {
	        background-color: #5f6368;
	        color: #fff;
	        border: none;
	    }
	    .btn-edit {
	        background-color: #0d6efd;
	        color: #fff;
	        border: none;
	    }
	    .btn-delete {
	        background-color: #e63946;
	        color: white;
	        border: none;
	    }
	    .btn-adopt {
	        background: linear-gradient(45deg, #f9c80e, #f08a5d);
	        color: white;
	        font-weight: bold;
	        border: none;
	        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
	    }
	
	    .content-box {
	        background-color: #fff;
	        padding: 20px;
	        border-radius: 12px;
	        box-shadow: 0 2px 8px rgba(0,0,0,0.05);
	        border: 1px solid #eee;
	        min-height: 150px;
	        margin-bottom: 30px;
	    }
	
	    .image-preview-wrapper img {
	        max-width: 100%;
	        height: auto;
	        border-radius: 10px;
	        border: 1px solid #ddd;
	        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
	    }
	
	    .url-box {
	        background-color: #fff3e6;
	        border-left: 5px solid #FF8A3D;
	        padding: 10px 15px;
	        border-radius: 6px;
	        margin-top: 15px;
	        font-size: 15px;
	    }
	
	    .url-box a {
	        color: #d35400;
	        font-weight: bold;
	        word-break: break-all;
	    }
		    .view-wrapper {
		    max-width: 1000px;
		    margin: 0 auto;
		    font-family: 'Segoe UI', sans-serif;
		    padding: 30px 20px;
		}
		
		.board-title {
		    display: flex;
		    align-items: center;
		    font-size: 1.8rem;
		    font-weight: 700;
		    margin-bottom: 20px;
		    color: #333;
		}
		
		.board-title i {
		    margin-right: 10px;
		    color: #FF8A3D;
		}
		
		.info-bar {
		    color: #666;
		    font-size: 15px;
		    margin-bottom: 20px;
		}
		
		.action-buttons {
		    display: flex;
		    justify-content: flex-start; /* ← 좌측 정렬로 통일 */
		    flex-wrap: wrap;
		    gap: 10px;
		    margin-bottom: 30px;
		}
		.action-buttons form {
		    margin: 0;
		    padding: 0;
		    display: flex;
		}
		.action-buttons > * {
		    flex: 0 0 auto;
		}
		
		.action-buttons button,
		.action-buttons a {
		    min-width: 120px;
		    padding: 10px 16px;
		    font-size: 15px;
		    font-weight: 500;
		    border-radius: 6px;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    gap: 6px;
		}
		.action-buttons form button:hover {
		    all: unset; /* 리셋 필수 */
		    background-color: #e63946;
		    color: white;
		    border-radius: 6px;
		    padding: 10px 16px;
		    font-size: 15px;
		    font-weight: 500;
		    display: flex;
		    align-items: center;
		    justify-content: center;
		    gap: 6px;
		    cursor: pointer;
		}
		.content-box {
		    background-color: #fff;
		    padding: 20px;
		    border-radius: 12px;
		    box-shadow: 0 2px 8px rgba(0,0,0,0.05);
		    border: 1px solid #eee;
		    min-height: 150px;
		    margin-bottom: 30px;
		}
		
		.image-preview-wrapper img {
		    max-width: 100%;
		    height: auto;
		    border-radius: 10px;
		    border: 1px solid #ddd;
		    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
		}
		
		.url-box {
		    background-color: #fff3e6;
		    border-left: 5px solid #FF8A3D;
		    padding: 10px 15px;
		    border-radius: 6px;
		    font-size: 15px;
		    margin-top: 15px;
		}
	    
	</style>

</head>
<body>
    <div id="viewMode">
        <h2 class="board-title"><i class="fas fa-bullhorn"></i> <span id="viewTitle">${adboard.adTitle}</span></h2>

        <div class="info-bar">
            <i class="fas fa-user"></i> 작성자: <strong>${adboard.admember.amemId}</strong> &nbsp; | &nbsp;
            <i class="far fa-clock"></i> 작성일: <strong>${adboard.createDate}</strong>
            <c:if test="${adboard.adConfirm eq 'Y'}">
                <span class="badge badge-success ml-2">✅ 채택됨</span>
            </c:if>
        </div>

        <div class="action-buttons">
            <a href="${pageContext.request.contextPath}/adboard/list.do"class="btn btn-list"><i class="fas fa-list"></i> 목록</a>
            <button id="editBtn" class="btn btn-edit"><i class="fas fa-edit"></i> 수정</button>
            <form method="post" action="${pageContext.request.contextPath}/adboard/delete.do" onsubmit="return confirm('정말 삭제하시겠습니까?')" style="display:inline;">
                <input type="hidden" name="adNo" value="${adboard.adNo}">
                <button type="submit" class="btn btn-delete"><i class="fas fa-trash-alt"></i> 삭제</button>
            </form>
            <c:if test="${adboard.adConfirm ne 'Y' and sessionScope.member.memRole == 1}">
                <form id="adoptBannerForm" method="post" action="${pageContext.request.contextPath}/banner/insert.do">
                    <input type="hidden" name="adNo" value="${adboard.adNo}">
                    <input type="hidden" name="adImg" value="${adboard.adImg}">
                    <input type="hidden" name="adUrl" value="${adboard.adUrl}">
                    <button type="submit" class="btn btn-adopt"><i class="fas fa-check-circle"></i> 채택</button>
                </form>
            </c:if>
        </div>

        <div class="content-box" id="viewContent">
            ${adboard.adContent}
        </div>

        <c:if test="${not empty adboard.adImg}">
            <div class="image-preview-wrapper mb-4">
                <img id="viewImage" src="${adboard.adImg}" alt="광고 이미지">
            </div>
        </c:if>

        <c:if test="${not empty adboard.adUrl}">
            <div class="url-box" id="adUrlContainer">
                <i class="fas fa-link"></i> <strong>광고 링크:</strong>
                <a href="${adboard.adUrl}" target="_blank">${adboard.adUrl}</a>
            </div>
        </c:if>
    </div>

    <!-- jQuery (이미 포함된 듯 하지만 두 번 넣어도 무해) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Bootstrap JS -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>
