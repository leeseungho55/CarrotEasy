<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>
/* 기본 스타일 */
/* 기본 스타일 */
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f7f7f7;
    margin: 0;
    padding: 0;
}

.region-card {
    max-width: 1180px; /* 고정된 너비 */
    margin: 8px auto; /* 중앙 정렬 */
    padding: 20px;
    background-color: #fff;
    border-radius: 12px;
    box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.region-title {
    font-size: 24px;
    font-weight: bold;
    color: #333;
    text-align: center;
    margin-bottom: 30px;
}

/* 버튼 그룹 스타일 */
.region-btns {
    display: flex;
    justify-content: space-between; /* 버튼 간 간격을 균일하게 배치 */
    flex-wrap: wrap;
    gap: 20px;
}

.region-btn {
    padding: 16px 40px; /* 버튼 크기 확대 */
    font-size: 18px; /* 글자 크기 증가 */
    background-color: #FF8A3D;
    color: white;
    border: none;
    border-radius: 8px;
    cursor: pointer;
    transition: background-color 0.3s ease, transform 0.3s ease;
    display: inline-block;
    text-align: center;
    width: calc(20% - 20px); /* 버튼 너비 고정 */
}

.region-btn:hover {
    background-color: #e0423f;
    transform: translateY(-2px);
}

/* 반응형 디자인 */
@media (max-width: 768px) {
    .region-card {
        padding: 15px; /* 모바일에서는 패딩을 약간 줄임 */
    }

    .region-title {
        font-size: 20px; /* 제목 글자 크기 조정 */
    }

    .region-btn {
        font-size: 16px; /* 모바일에서 글자 크기 감소 */
        padding: 12px 30px; /* 모바일에서 버튼 크기 약간 감소 */
        width: calc(50% - 10px); /* 모바일에서는 두 개의 버튼을 가로로 배치 */
    }
}


</style>

<div class="region-card">
    <h2 class="region-title">👥소모임 지역 선택</h2>
    <form action="CommunityRegion.do" method="post">
        <div class="region-btns">
            <button class="region-btn" name="commuRegion" value="서구">서구</button>
            <button class="region-btn" name="commuRegion" value="동구">동구</button>
            <button class="region-btn" name="commuRegion" value="중구">중구</button>
            <button class="region-btn" name="commuRegion" value="유성구">유성구</button>
            <button class="region-btn" name="commuRegion" value="대덕구">대덕구</button>
        </div>
    </form>
</div>
