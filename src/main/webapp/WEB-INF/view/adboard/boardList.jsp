<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>광고 문의 게시판</title>  
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    <style>
    /* CarrotEasy 전용 컨테이너 */
    .carroteasy-container {
      max-width: 1220px;
      margin: 8px auto;
      padding: 20px;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      font-family: 'Noto Sans KR', sans-serif;
      box-sizing: border-box;
    }
    /* 헤더 타이틀 */
    .carroteasy-container .abc {
      font-size: 24px;
      font-weight: 700;
      color: #222;
      display: flex;
      align-items: center;
      gap: 8px;
      margin-bottom: 20px;
    }
    /* 상단 등록 버튼 */
    .carroteasy-container .top-actions {
      text-align: right;
      margin-bottom: 16px;
    }
    .carroteasy-container .top-actions .btn-primary {
      background-color: #FF8A3D;
      border-color: #FF8A3D;
      font-weight: 600;
      padding: 10px 20px;
      border-radius: 8px;
      transition: background-color 0.2s, transform 0.1s;
    }
    .carroteasy-container .top-actions .btn-primary:hover {
      background-color: #e0423f;
      transform: translateY(-1px);
    }
    /* 문의 테이블 */
    .carroteasy-container .table {
      width: 100%;
      border-collapse: collapse;
    }
    .carroteasy-container th,
    .carroteasy-container td {
      padding: 12px 16px;
      border-bottom: 1px solid #eee;
      vertical-align: middle;
      font-size: 14px;
    }
    .carroteasy-container thead th {
      background-color: #f7f7f7;
      font-weight: 600;
      color: #333;
    }
    .carroteasy-container td a {
      color: #333333;
      text-decoration: none;
    }
    .carroteasy-container td a:hover {
      text-decoration: underline;
    }
    /* 채택 배지 */
    .badge-status {
      display: inline-flex;
      align-items: center;
      gap: 4px;
      font-size: 14px;
      font-weight: 600;
      padding: 6px 12px;
      border-radius: 12px;
    }
    .badge-success {
      background-color: #4CAF50;
      color: #fff;
    }
    .badge-danger {
      background-color: #f44336;
      color: #fff;
    }
    /* 모달 오버라이드 */
    .modal.fade.top-modal .modal-content {
      border-radius: 12px;
      overflow: hidden;
    }
    .modal.fade.top-modal .modal-header {
      background-color: #FF8A3D;
      color: #fff;
      border-bottom: none;
    }
    .modal.fade.top-modal .modal-body label {
      font-size: 15px;
      margin-bottom: 8px;
      display: block;
    }
    .modal.fade.top-modal .modal-body .form-control {
      padding: 10px;
      border-radius: 8px;
      border: 1px solid #ccc;
    }
    .modal.fade.top-modal .modal-footer .btn-primary {
      background-color: #FF8A3D;
      border-color: #FF8A3D;
    }
    .modal.fade.top-modal .modal-footer .btn-secondary {
      background-color: #ccc;
      border-color: #ccc;
    }
    .modal.fade.top-modal .modal-footer .btn-primary:hover {
      background-color: #e0423f;
    }
    .modal.fade.top-modal .modal-footer .btn-secondary:hover {
      background-color: #bbb;
    }
    /* 반응형 */
    @media (max-width: 768px) {
      .carroteasy-container { padding: 16px; }
      .carroteasy-container .abc { font-size: 20px; }
      .carroteasy-container th,
      .carroteasy-container td { padding: 8px 12px; font-size: 14px; }
      .carroteasy-container .top-actions .btn-primary { width: 100%; }
    }
    </style>
</head>
<body>
  <div class="carroteasy-container">
    <div class="abc"><i class="fas fa-bullhorn"></i> 광고 문의 게시판</div>
    <div class="top-actions">
      <a href="${pageContext.request.contextPath}/adboard/write.do" class="btn btn-primary">
        <i class="fas fa-plus-circle"></i> 등록
      </a>
    </div>
    <table class="table">
      <thead>
        <tr>
          <th>제목</th><th>내용</th><th>작성자</th><th>채택여부</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty boardList}">
            <tr><td colspan="4" class="text-muted">광고 문의글이 없습니다.</td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="adboard" items="${boardList}">
              <tr>
                <td>
                  <a href="#" class="open-password-modal" data-adno="${adboard.adNo}">
                    ${adboard.adTitle}
                  </a>
                </td>
                <td>${adboard.adContent}</td>
                <td>${adboard.admember.amemId}</td>
                <td>
                  <c:choose>
                    <c:when test="${adboard.adConfirm eq 'Y'}">
                      <span class="badge badge-status badge-success">
                        <i class="fas fa-check-circle"></i> 채택
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span class="badge badge-status badge-danger">
                        <i class="fas fa-times-circle"></i> 미채택
                      </span>
                    </c:otherwise>
                  </c:choose>
                </td>
              </tr>
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>

  <!-- 비밀번호 확인 모달 -->
  <div class="modal fade top-modal" id="passwordModal" tabindex="-1" role="dialog" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <form id="passwordForm" method="post" action="${pageContext.request.contextPath}/adboard/verifyPassword">
        <input type="hidden" name="adNo" id="modalAdNo" />
        <div class="modal-content">
          <div class="modal-header">
            <h5 class="modal-title">비밀번호 확인</h5>
            <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
              <span aria-hidden="true">&times;</span>
            </button>
          </div>
          <div class="modal-body">
            <label>비밀번호를 입력하세요</label>
            <input type="password" name="password" class="form-control" pattern="\d{4}" maxlength="4" required />
          </div>
          <div class="modal-footer">
            <button type="submit" class="btn btn-primary">확인</button>
            <button type="button" class="btn btn-secondary" data-dismiss="modal">취소</button>
          </div>
        </div>
      </form>
    </div>
  </div>

  <script>
    $(function(){
      $('.open-password-modal').click(function(e){
        e.preventDefault();
        const adNo = $(this).data('adno');
        const isAdmin = ${isAdmin != null && isAdmin ? 'true' : 'false'};
        if(isAdmin){
          window.location.href = '${pageContext.request.contextPath}/adboard/boardView?adNo='+adNo;
        } else {
          $('#modalAdNo').val(adNo);
          $('#passwordModal').modal('show');
        }
      });
      $('#passwordForm').submit(function(e){
        e.preventDefault();
        $.post('${pageContext.request.contextPath}/adboard/verifyPassword',
               $(this).serialize(), res=>{
          if(res.success){
            $('#passwordModal').on('hidden.bs.modal',()=>{
              window.location.href = res.redirectUrl;
            });
            $('#passwordModal').modal('hide');
          } else {
            alert(res.message);
          }
        }, 'json');
      });
    });
  </script>
</body>
</html>
