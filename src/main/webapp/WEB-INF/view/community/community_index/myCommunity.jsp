<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이 커뮤니티</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            font-family: 'Noto Sans KR', sans-serif;
            background: #f8f8f8;
            margin: 0;
            padding: 0;
        }
        .mycommunity-container {
            max-width: 1180px;
            margin: 8px auto;
            background: #fff;
            border-radius: 16px;
            box-shadow: 0 4px 24px rgba(0,0,0,0.07);
            padding: 20px;
        }
        .mycommunity-title {
            font-size: 2.1rem;
            font-weight: 700;
            color: #FF8A3D;
            margin-bottom: 30px;
            text-align: left;
        }
        .community-section {
            margin-bottom: 40px;
        }
        .section-title {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 16px;
            border-left: 6px solid #FF8A3D;
            padding-left: 10px;
        }
        .community-list, .board-list {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .community-list li, .board-list li {
            background: #f6f6f6;
            margin-bottom: 12px;
            border-radius: 10px;
            padding: 18px 20px;
            display: flex;
            align-items: center;
            transition: background 0.2s;
            border: 1px solid #eee;
        }
        .community-list li:hover, .board-list li:hover {
            background: #ffeaea;
        }
        .community-link, .board-link {
            color: #333333;
            font-size: 1.1rem;
            font-weight: 500;
            text-decoration: none;
            margin-right: 10px;
            transition: color 0.2s;
        }
        .community-link:hover, .board-link:hover {
            color: #e0423f;
            text-decoration: underline;
        }
        .community-meta, .board-meta {
            color: #888;
            font-size: 0.97rem;
            margin-left: auto;
            display: flex;
            align-items: center;
            gap: 16px;
        }
        .empty-message {
            color: #bbb;
            font-size: 1.05rem;
            padding: 18px 0 18px 8px;
        }
        @media (max-width: 600px) {
            .mycommunity-container {padding: 20px;}
            .mycommunity-title {font-size: 1.3rem;}
            .section-title {font-size: 1.1rem;}
        }
        .delete-btn {
    		background: #FF8A3D;
    		color: #fff;
    		border: none;
    		border-radius: 6px;
    		padding: 6px 14px;
    		font-size: 0.98rem;
    		cursor: pointer;
    		margin-left: 8px;
    		transition: background 0.2s;
    		display: flex;
    		align-items: center;
    		gap: 4px;
		}
		.delete-btn:hover {
    		background: #e0423f;
		}
    </style>
</head>
<body>
    <div class="mycommunity-container">
        <div class="mycommunity-title"><i class="fa-solid fa-user-group"></i> 마이 커뮤니티</div>

        <!-- 내가 만든 소모임 리스트 -->
        <div class="community-section">
            <div class="section-title"><i class="fa-solid fa-crown"></i> 나의 소모임</div>
            <ul class="community-list">
                <c:choose>
                    <c:when test="${not empty myCommunityList}">
                        <c:forEach var="commu" items="${myCommunityList}">
                            <li>
                                <a class="community-link" href="/CarrotEasy/CommunitySelectList.do?commuNo=${commu.commuNo}&commuRegion=${commu.commuRegion}">
    ${commu.commuTitle}
</a>
                                <div class="community-meta">
                                    <span><i class="fa-solid fa-location-dot"></i> ${commu.commuRegion}</span>
                                    <span><i class="fa-solid fa-comments"></i> 게시글 ${commu.commuBoardCount}개</span>
                                    <span><i class="fa-solid fa-calendar-days"></i> ${commu.createDate}</span>
                                </div> 
                                <!-- 소모임 삭제 버튼 -->
								<form method="post" action="/CarrotEasy/myCommunityDelete.do"
									style="margin-left: 16px;">
									<input type="hidden" name="commuNo" value="${commu.commuNo}">
									<button type="submit" class="delete-btn"
										onclick="return confirm('정말로 이 소모임을 삭제하시겠습니까?');">
										<i class="fa-solid fa-trash"></i> 삭제
									</button>
								</form>
							</li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-message">아직 만든 소모임이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
        
        <!-- 내가 쓴 소모임 내 게시글 리스트 -->
        <div class="community-section">
            <div class="section-title"><i class="fa-solid fa-file-lines"></i> 작성한 게시글</div>
            <ul class="board-list">
                <c:choose>
                    <c:when test="${not empty myBoardList}">
                        <c:forEach var="board" items="${myBoardList}">
                            <li>
                                <a class="board-link" href="/CarrotEasy/CommunityBoardDetail.do?commubNo=${board.commubNo}
   									&commuRegion=${param.commuRegion}&commuCatrgory=${param.commuCatrgory}&stype=${param.stype}
   									&sword=${param.sword}">${board.commubTitle}
								</a>
                                <div class="board-meta">
									<span><i class="fa-solid fa-users"></i>
										${board.commuRegion}</span> <span><i
										class="fa-solid fa-calendar-days"></i> ${board.createDate}</span>
									<!-- 게시글 삭제 버튼 -->
									<form method="post"
										action="/CarrotEasy/myCommunityBoardDelete.do"
										style="margin-left: 16px;">
										<input type="hidden" name="commubNo" value="${board.commubNo}">
										<button type="submit" class="delete-btn"
											onclick="return confirm('정말로 이 게시글을 삭제하시겠습니까?');">
											<i class="fa-solid fa-trash"></i> 삭제
										</button>
									</form>
								</div>
							</li>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="empty-message">아직 작성한 소모임 게시글이 없습니다.</div>
                    </c:otherwise>
                </c:choose>
            </ul>
        </div>
    </div>
</body>
</html>
