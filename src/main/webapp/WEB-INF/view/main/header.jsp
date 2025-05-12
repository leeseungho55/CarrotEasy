<%@page import="kr.or.ddit.admember.vo.AdmemberVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="kr.or.ddit.member.vo.MemberVo" %>
<%
    MemberVo member = (MemberVo) session.getAttribute("member");
	AdmemberVo admember = (AdmemberVo) session.getAttribute("admember");
    boolean isAdmin = (member != null && member.getMemRole() == 1);
%>
<%
    int remainingTime = session.getMaxInactiveInterval();
%>

<!-- 판매하기, 내상점, 번개톡 세션 체크 -->
<c:set var="member" value="${not empty sessionScope.member}" />

<c:set var="remainingTime" value="<%= remainingTime %>" />
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<!-- 헤더 영역 -->
<div id="session-timer" style="position: absolute; right: 10px; top: 10px;"></div>

<div id="nav-bar">
  <div class="nav-inner">
    <div class="left-block">
      <div class="logo-area">
        <a href="/CarrotEasy/prodMain.do"><img src="/CarrotEasy/resource/img/누끼제거logo.png" alt="로고" /></a>
      </div>
      <div class="category-area">
        <button class="menu-icon" onclick="toggleCategoryDropdown()">
          <i class="fas fa-bars"></i>
        </button>
       <ul id="category-dropdown" class="dropdown-list">
		  <li onclick="handleCategory(0)">전체 카테고리</li>
		
		  <li onmouseover="this.querySelector('ul').style.display='block'" onmouseout="this.querySelector('ul').style.display='none'">
		    <span onclick="handleCategory(1)">가전제품</span>
		    <ul class="sub-category">
		      <li onclick="handleChildCategory(1,10)">생활가전</li>
		      <li onclick="handleChildCategory(1,11)">주방가전</li>
		    </ul>
		  </li>
		
		  <li onmouseover="this.querySelector('ul').style.display='block'" onmouseout="this.querySelector('ul').style.display='none'">
		    <span onclick="handleCategory(2)">스포츠/레저</span>
		    <ul class="sub-category">
		      <li onclick="handleChildCategory(2,20)">골프</li>
		      <li onclick="handleChildCategory(2,21)">캠핑</li>
		      <li onclick="handleChildCategory(2,22)">스포츠</li>
		    </ul>
		  </li>
		
		  <li onmouseover="this.querySelector('ul').style.display='block'" onmouseout="this.querySelector('ul').style.display='none'">
		    <span onclick="handleCategory(3)">디지털</span>
		    <ul class="sub-category">
		      <li onclick="handleChildCategory(3,30)">휴대폰</li>
		      <li onclick="handleChildCategory(3,31)">전자기기</li>
		    </ul>
		  </li>
		
		  <li onmouseover="this.querySelector('ul').style.display='block'" onmouseout="this.querySelector('ul').style.display='none'">
		    <span onclick="handleCategory(4)">가구/인테리어</span>
		    <ul class="sub-category">
		      <li onclick="handleChildCategory(4,40)">생활가구</li>
		    </ul>
		  </li>
		
		  <li onmouseover="this.querySelector('ul').style.display='block'" onmouseout="this.querySelector('ul').style.display='none'">
		    <span onclick="handleCategory(5)">생활/주방</span>
		    <ul class="sub-category">
		      <li onclick="handleChildCategory(5,50)">생활용품</li>
		      <li onclick="handleChildCategory(5,51)">주방용품</li>
		    </ul>
		  </li>
		
		  <li onmouseover="this.querySelector('ul').style.display='block'" onmouseout="this.querySelector('ul').style.display='none'">
		    <span onclick="handleCategory(6)">의류/잡화</span>
		    <ul class="sub-category">
		      <li onclick="handleChildCategory(6,60)">남성의류</li>
		      <li onclick="handleChildCategory(6,61)">여성의류</li>
		      <li onclick="handleChildCategory(6,62)">가방/신발</li>
		    </ul>
		  </li>
		
		  <li onmouseover="this.querySelector('ul').style.display='block'" onmouseout="this.querySelector('ul').style.display='none'">
		    <span onclick="handleCategory(7)">기타</span>
		    <ul class="sub-category">
		      <li onclick="handleChildCategory(7,70)">기타 중고물품</li>
		    </ul>
		  </li>
		</ul>
      </div>
    </div>

    <div class="carroteasy-search">
      <form action="/CarrotEasy/prod/list.do" method="get">
        <input type="text" id="keywordInput" name="keyword" placeholder="상품명">
	    <!-- 필터링이 없을 경우 기본값 0으로 강제 지정 -->
	    <input type="hidden" name="cateNo" value="0" />
	    <input type="hidden" name="areaNo" value="0" />
	    <input type="hidden" name="parentCateNo" value="0" />
	    <input type="hidden" name="districtNo" value="0" />
        <button type="submit">검색</button>
      </form>
    </div>

    <div class="right-block">
    	<div class="nav-icons">
			<!-- 판매하기 -->
			<c:choose>
			    <c:when test="${not empty sessionScope.admember}">
			        <a href="#" onclick="alert('일반사용자만 이용이 가능합니다.')">
			            <img src="/CarrotEasy/resource/img/CarrotEasy.png" alt="판매하기" /> 판매하기
			        </a>
			    </c:when>
			    <c:otherwise>
			        <a href="javascript:void(0)" onclick="goToPage('/CarrotEasy/prod/insert.do')">
			            <img src="/CarrotEasy/resource/img/CarrotEasy.png" alt="판매하기" /> 판매하기
			        </a>
			    </c:otherwise>
			</c:choose>
			
			<!-- 내상점 -->
			<c:choose>
			    <c:when test="${not empty sessionScope.admember}">
			        <a href="#" onclick="alert('일반사용자만 이용이 가능합니다.')">
			            <img src="/CarrotEasy/resource/img/CarrotEasy.png" alt="내상점" /> 내상점
			        </a>
			    </c:when>
			    <c:otherwise>
			        <a href="javascript:void(0)" onclick="goToPage('/CarrotEasy/mystore/mystoreMain.do')">
			            <img src="/CarrotEasy/resource/img/CarrotEasy.png" alt="내상점" /> 내상점
			        </a>
			    </c:otherwise>
			</c:choose>
			
			<!-- 당근톡 -->
			<c:choose>
			    <c:when test="${not empty sessionScope.admember}">
			        <a href="#" onclick="alert('일반사용자만 이용이 가능합니다.')">
			            <img src="/CarrotEasy/resource/img/CarrotEasy.png" alt="당근톡" /> 당근톡
			        </a>
			    </c:when>
			    <c:otherwise>
			        <a href="javascript:void(0)" onclick="goToPage('/CarrotEasy/chattingroom.do')">
			            <img src="/CarrotEasy/resource/img/CarrotEasy.png" alt="당근톡" /> 당근톡
			        </a>
			    </c:otherwise>
			</c:choose>
    	</div>
  	</div>
  </div>
</div>

<style>
	.report-link, .qna-link {
	  display: inline-block;
	  background-color: #ff4e50;
	  color: white;
	  padding: 8px 15px;
	  border-radius: 20px;
	  font-size: 13px;
	  font-weight: bold;
	  text-decoration: none;
	  line-height: 1;
	  transition: background-color 0.3s;
	}
	
	.qna-link {
	  background-color: #ffa500;
	}
	
	.report-link:hover {
	  background-color: #e0423f;
	}
	
	.qna-link:hover {
	  background-color: #e69500;
	}
		
	#nav-bar {
	  background-color: white;
	  padding: 15px 165px;
	  font-family: 'Noto Sans KR', sans-serif;
	  border-bottom: 1px solid #ddd;
	  position: relative;
	}
	.nav-icons {
	  display: flex;
	  align-items: center;
	  gap: 20px; /* 원하는 간격 */
	}
	.nav-inner {
	  display: flex;
	  align-items: center;
	  justify-content: space-between;
	  margin: 0 auto;     /* 가운데 정렬 */
	  z-index: 99999;
	}
	
	.left-block {
	  display: flex;
	  align-items: center;
	  gap: 20px;
	}
	
	.logo-area img {
	  height: 120px;
	}
	
	.menu-icon {
	  background: none;
	  border: none;
	  font-size: 20px;
	  cursor: pointer;
	}
	
	#nav-bar, .dropdown-list, .sub-category {
	  z-index: 10; /* swiper 위에 오도록 */
	}
	
	.carroteasy-search {
	  flex: 1;
	  margin: 10px 40px 0 40px;
	  align-items: center;
	}
	
	.carroteasy-search form {
	  display: flex;
	}
	
	.carroteasy-search input {
	  flex: 1;
	  padding: 10px 15px;
	  border: 2px solid #ff4e50;
	  border-radius: 4px 0 0 4px;
	  font-size: 14px;
	  outline: none;
	}
	
	.carroteasy-search button {
	  background-color: #ff4e50;
	  color: white;
	  border: none;
	  padding: 10px 15px;
	  border-radius: 0 4px 4px 0;
	  font-weight: bold;
	  cursor: pointer;
	}
	
	.nav-btn-group {
 	   display: flex;
    	gap: 10px; /* 버튼 사이 간격 조절 */
    	align-items: center;
	}
	
	.right-block {
	  display: flex;
	  align-items: center;
	  gap: 20px;
	}
	
	.right-block a {
	  display: flex;
	  align-items: center;
	  gap: 6px;
	  text-decoration: none;
	  color: #333;
	  font-weight: 500;
	  font-size: 20px;
	}
	
	.right-block img {
	  height: 20px;
	}
	
	.category-area {
 		position: relative;
  		z-index: 99999;
	}

	/* 카테고리 버튼 (메뉴 아이콘) */
	.menu-icon {
  		background: transparent;   /* 또는 background: none; */
  		color: #333333;            /* 아이콘만 빨간색으로 */
  		border: none;
  		border-radius: 0;          /* 필요시 */
  		font-size: 24px;
  		width: auto;               /* 원래 크기로 */
  		height: auto;
  		box-shadow: none;          /* 그림자도 필요 없으면 */
  		transition: color 0.2s;    /* 색상만 부드럽게 */
	}
	
	.menu-icon:hover {
  		color: #ff784e;            /* 호버시 색상만 변경 */
  		background: transparent;   /* 호버시에도 배경 없음 */
	}

	/* 카테고리 드롭다운 */
	.dropdown-list {
  		list-style: none;
  		padding: 8px 0;
  		margin: 0;
  		width: 220px;
  		background: #fff;
  		border: 1.5px solid #ff4e50;
  		border-radius: 12px;
  		box-shadow: 0 8px 32px rgba(255, 78, 80, 0.08);
  		font-family: 'Noto Sans KR', sans-serif;
  		position: absolute;
  		top: 48px;
  		left: 0;
  		display: none;
  		transition: box-shadow 0.2s;
  		z-index: 100;
	}

	/* 메인 카테고리 항목 */
	.dropdown-list > li {
  		position: relative;
  		padding: 14px 24px 14px 20px;
  		background: transparent;
  		cursor: pointer;
  		font-size: 17px;
  		font-weight: 500;
  		color: #333;
  		border: none;
  		transition: background 0.18s, color 0.18s;
  		display: flex;
  		align-items: center;
	}
	
	.dropdown-list > li:hover {
  		background: #fff3f2;
  		color: #ff4e50;
	}

	/* 화살표(▶) 표시 */
	.dropdown-list > li > span:after {
  		content: '▶';
  		font-size: 13px;
  		color: #bbb;
  		margin-left: auto;
  		transition: color 0.2s;
	}
	
	.dropdown-list > li:hover > span:after {
  		color: #ff4e50;
	}

	/* 서브카테고리(2차 메뉴) */
	.sub-category {
	  	display: none;
	  	list-style: none;
	  	padding: 8px 0;
	  	margin: 0;
	  	position: absolute;
	  	top: 0;
	  	left: 220px;
	  	width: 180px;
	  	background: #fff;
	  	border: 1.5px solid #ff4e50;
	  	border-radius: 12px;
	  	box-shadow: 0 8px 32px rgba(255, 78, 80, 0.08);
	  	z-index: 101;
	}
	
	.dropdown-list > li:hover > .sub-category {
  		display: block;
	}

	/* 서브카테고리 항목 */
	.sub-category li {
  		padding: 12px 20px;
  		font-size: 15px;
  		color: #555;
  		background: transparent;
  		cursor: pointer;
  		border: none;
  		transition: background 0.18s, color 0.18s;
	}

	.sub-category li:hover {
  		background: #fff3f2;
  		color: #ff4e50;
	}

	/* 전체 카테고리만 아이콘 추가(예시) */
	.dropdown-list > li:first-child:before {
  		content: '\f07c';
  		font-family: "Font Awesome 6 Free";
  		font-weight: 900;
  		color: #ff4e50;
  		margin-right: 10px;
  		font-size: 16px;
	}
	
</style>

<script>
	const member = ${member};
	// 판매, 내상점, 번개톡 세션체크
	function goToPage(url) {
		if(!member) {
			alert("로그인이 필요합니다.");
			// location.href = "/CarrotEasy/login.do";
		}
		else {
			location.href = url;
		}
	}

	function toggleCategoryDropdown() {
	  const dropdown = document.getElementById("category-dropdown");
	  dropdown.style.display = dropdown.style.display === "block" ? "none" : "block";
	}
	
	function handleCategory(value) {
	  if (value !== "") {
	    location.href = "/CarrotEasy/prod/list.do?parentCateNo=" + value + "&cateNo=0&districtNo=0&areaNo=0&keyword=";
	  }
	}
	
	function handleChildCategory(parentCategory, childeCategory) {
	  location.href = "/CarrotEasy/prod/list.do?parentCateNo=" + parentCategory + "&cateNo=" + childeCategory + "&districtNo=0&areaNo=0&keyword=";
	}
	
	function handleSearch() {
	  const keyword = $("#keywordInput").val();
	  location.href = "/CarrotEasy/prod/list.do?parentCateNo=0&cateNo=0&districtNo=0&areaNo=0&keyword=" + encodeURIComponent(keyword);
	}
	
	var timeLeft = <%= remainingTime %>;
	function formatTime(seconds) {
	  var min = Math.floor(seconds / 60);
	  var sec = seconds % 60;
	  return min + "분 " + (sec < 10 ? "0" : "") + sec + "초";
	}
	
	function extendSession() {
	  $.ajax({
	    url: "/CarrotEasy/sessionExtend.do",
	    method: "POST",
	    success: function (res) {
	      if (res === "extended") {
	        timeLeft = 1800;
	      } else {
	        window.location.href = "login.do";
	      }
	    }
	  });
	}
	
	var timeLeft = <%= remainingTime %>;	// JSP 스크립틀릿에서 바로 값 전달

    function formatTime(seconds) {
        var min = Math.floor(seconds / 60);
        var sec = seconds % 60;
        return min + "분 " + (sec < 10 ? "0" : "") + sec + "초";
    }

    function extendSession() {
        $.ajax({
            url: "/CarrotEasy/sessionExtend.do",
            method: "POST",
            success: function (res) {
            	console.log("서버 응답 : ", res);
                if (res === "extended") {
                    timeLeft = 1800;	// 타이머 초기화(30분)
                } else {
                    window.location.href = "login.do";
                }
            }
        });
    }

    function startTimer() {
        $('#time-left').text(formatTime(timeLeft));

        var asked = false;

        var timer = setInterval(function () {
            timeLeft--;

            if (timeLeft <= 600 && !asked) { // 10분 남을 때
                asked = true;
                if (confirm("로그아웃까지 10분 남았습니다. 연장하시겠습니까?")) {
                    extendSession();
                }
            }

            if (timeLeft <= 0) {
                clearInterval(timer);
                window.location.href = "login.do";
            } else {
                $('#time-left').text(formatTime(timeLeft));
            }
        }, 1000);
    }
	
	$(document).ready(function () {
	  startTimer();
	});
</script>
