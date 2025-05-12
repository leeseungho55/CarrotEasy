<%@page import="kr.or.ddit.member.vo.MemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>메인화면</title>
    <script src="/CarrotEasy/resource/js/jquery-3.7.1.js"></script>
    <script src="/CarrotEasy/resource/js/main.js"></script>
    <style>
		body {
    		font-family: 'Noto Sans KR', sans-serif;
    		background-color: #f7f7f7;
    		margin: 0;
    		padding: 0;
		}
		
		#top-header {
		  background: #fff;
		  font-size: 14px;
		  padding: 8px 0;
		  border-bottom: 1px solid #ddd;
		}

		.top-header-container {
		  margin: 0 auto;
		  display: flex;
		  justify-content: space-between;
		  align-items: center;
		  padding: 15px 165px;
		}

		.nav-actions {
		  display: flex;
		  gap: 16px;
		}

		.nav-text-link {
		  font-size: 13px;
		  font-weight: bold;
		  color: #333;
		  text-decoration: none;
		}

		.nav-text-link:hover {
		  text-decoration: underline;
		}

		.top-header-inner {
		  display: flex;
		  font-size: 13px;
		  gap: 10px;
		  align-items: center;
		  flex-wrap: wrap;
		}

        /* 🔥 flex 컨테이너 */
        .layout {
            display: flex;
            /* height: calc(100vh - 100px); */
            flex: 1 0 auto;
            min-height: 0;
        }

        #sidebarL, #sidebarR {
            width: 200px;
            background-color: white;
            padding: 20px;
            box-sizing: border-box;
        }

        #main-content {
            flex: 1;
            padding: 20px;
            background-color: #fff;
            box-sizing: border-box;
            /*overflow: auto;*/
        }

/*         #footer { */
/*             flex: 0 0 auto; */
/*             background-color: #ddd; */
/*             text-align: center; */
/*             padding: 10px; */
/*         } */
        
    </style>
</head>
<body>

    <!-- 헤더 -->
    <div id="top-header">
        <div class="top-header-container">
          <div class="nav-actions">
          	<c:if test="${sessionScope.member.memNo != prod.memNo and sessionScope.member.memNo != null}"> 
              <a href="/CarrotEasy/ListBoard.do" class="nav-text-link">🚨 상품신고 목록</a>
          	</c:if>
          	<c:if test="${sessionScope.member.memNo != prod.memNo and sessionScope.member.memNo != null}">
              <a href="/CarrotEasy/qnaList.do" class="nav-text-link">💬 문의하기</a>
            </c:if>   
            <c:if test="${empty admember}">
    	      <a href="/CarrotEasy/MainType.do" class="nav-text-link">👥 커뮤니티</a>
			</c:if>  
            <c:if test="${sessionScope.member.memRole eq 1}">
        	  <a href="/CarrotEasy/CommunityReportList.do" class="nav-text-link">🛠️ 커뮤니티 신고관리</a>
    		</c:if>
    		<c:if test="${sessionScope.member.memRole eq 1 or not empty sessionScope.admember}">  
    		  <a href="/CarrotEasy/adboard/list.do" class="nav-text-link" >📝광고 문의</a>
    		</c:if>
          </div>
          <div class="top-header-inner">
              <c:choose>
                <c:when test="${member == null and admember == null}">
                  <span><a href="/CarrotEasy/chooseLogin.do" style="text-decoration: none; color: #333; font-weight: bold;">로그인</a></span>
                </c:when>
                <c:otherwise>
                  <span>⏱ 세션 남은 시간: 
                    <span id="time-left" style="color:red; font-weight:bold;"></span>
                  </span> |
                  <c:choose>
                    <c:when test="${member != null}">
                      <span>${member.memNick}님, 안녕하세요</span> |
                    </c:when>
                    <c:when test="${admember != null}">
                      <span>${admember.amemCompany}님, 안녕하세요</span> |
                    </c:when>
                  </c:choose>
                  <span><a href="/CarrotEasy/mypage.do" id="mypage-link" style="text-decoration: none; color: #333; font-weight: bold;">마이페이지</a></span> |
                  <span><a href="/CarrotEasy/logout.do" style="text-decoration: none; color: #333; font-weight: bold;">로그아웃</a></span>
                </c:otherwise>
              </c:choose>
          </div>
        </div>
    </div>

    <!-- 상단 메뉴/로고 -->
    <jsp:include page="/WEB-INF/view/main/header.jsp"/>

    <!-- 🔥 사이드바 + 메인 콘텐츠 flex 박스 -->
    <div class="layout">
        <div id="sidebarL">
            <jsp:include page="/WEB-INF/view/main/sidebar.jsp"/>
        </div>

        <div id="main-content">
			<jsp:include page="${contentPage}"/>
        </div>

        <div id="sidebarR">
            <jsp:include page="/WEB-INF/view/main/sidebar.jsp"/>
        </div>
    </div>

    <!-- 푸터 -->
<!--     <div id="footer"> -->
<%--         <jsp:include page="/WEB-INF/view/main/footer.jsp"/> --%>
<!--     </div> -->
</body>
</html>