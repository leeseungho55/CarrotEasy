<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>배너 광고</title>

<!-- Swiper CSS -->
<link
rel="stylesheet"
href="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.css"
/>

<style>
body {
  margin: 0;
  padding: 0;
}

.swiper {
  width: 100%;
  height: 250px;
}

.swiper-slide {
  text-align: center;
  font-size: 18px;
  background: #fff;

  /* Center slide text vertically */
  display: flex;
  justify-content: center;
  align-items: center;
}

.swiper-slide img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}
</style>
</head>
<body>

<!-- 디버깅 정보 표시 (테스트 후 제거) -->
<div style="display: none;">
  <h3>디버깅 정보:</h3>
  <c:forEach var="banner" items="${bannerList}">
    <p>이미지 경로: ${banner.banImg}</p>
    <p>URL: ${banner.banUrl}</p>
  </c:forEach>
</div>

<!-- Swiper 배너 슬라이드 영역 -->
<div class="swiper mySwiper">
  <div class="swiper-wrapper">
    <c:forEach var="banner" items="${bannerList}">
      <div class="swiper-slide">
        <a href="${banner.banUrl}" target="_blank">
          <c:choose>
            <c:when test="${fn:startsWith(banner.banImg, '/')}">
              <!-- 경로가 /로 시작하면 그대로 사용 -->
              <img src="${banner.banImg}" alt="배너 이미지">
            </c:when>
            <c:otherwise>
              <!-- 그렇지 않으면 contextPath 추가 -->
              <img src="${pageContext.request.contextPath}/${banner.banImg}" alt="배너 이미지">
            </c:otherwise>
          </c:choose>
        </a>
      </div>
    </c:forEach>
  </div>
  <div class="swiper-pagination"></div>
  <div class="swiper-button-next"></div>
  <div class="swiper-button-prev"></div>
</div>

<!-- Swiper JS -->
<script src="https://cdn.jsdelivr.net/npm/swiper@11/swiper-bundle.min.js"></script>

<script>
const swiper = new Swiper('.mySwiper', {
  loop: true, // 무한 루프
  autoplay: {
    delay: 3000, // 3초 간격 자동 슬라이딩
    disableOnInteraction: false
  },
  pagination: {
    el: '.swiper-pagination',
    clickable: true
  },
  navigation: {
    nextEl: '.swiper-button-next',
    prevEl: '.swiper-button-prev',
  },
  speed: 700, // 슬라이드 속도
  slidesPerView: 1
});
</script>
</body>
</html>