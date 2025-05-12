<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page
	import="kr.or.ddit.community.community_report.vo.CommunityReportVo"%>
<%@ page import="java.util.List"%>
<%
    List<CommunityReportVo> reportList = (List<CommunityReportVo>) request.getAttribute("reportList");
%>
<%! 
	public String toJson(String s) {
    	if (s == null) return "\"\"";
	    return "\"" + s.replace("\\", "\\\\")
                 	   .replace("\"", "\\\"")
                  	   .replace("\r", "\\r")
                       .replace("\n", "\\n")
                       .replace("\t", "\\t") + "\"";
	}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<title>신고 내역 관리</title>
<meta charset="UTF-8">
<style>
.carroteasy-container {
	max-width: 1180px;
	margin: 8px auto;
	padding: 20px;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	font-family: 'Noto Sans KR', sans-serif;
}

body {
	background: #fafafa;
	font-family: 'Noto Sans KR', sans-serif;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 1180px;
	width: 100%;
	margin: 8px auto;
	background: #fff;
	padding: 20px 20px;
	border-radius: 14px;
	box-shadow: 0 2px 12px rgba(0, 0, 0, 0.06);
}

h2 {
	text-align: center;
	font-size: 22px;
	margin-bottom: 24px;
	font-weight: bold;
	color: #222;
	letter-spacing: -1px;
}

table {
	width: 100%;
	min-width: 900px;
	border-collapse: collapse;
	font-size: 15px;
	background-color: #fff;
	margin-bottom: 20px;
}

th, td {
	text-align: center;
	padding: 13px 8px;
	border-bottom: 1px solid #eee;
	color: #333;
}

th {
	background-color: #fafafa;
	font-weight: 700;
	color: #222;
}

tr:hover {
	background-color: #f7f7f7;
}

.btn, .btn-detail, .btn-approve, .btn-reject {
	padding: 7px 14px;
	background-color: #ff4250;
	color: #fff;
	border-radius: 8px;
	text-decoration: none;
	font-size: 14px;
	font-weight: 600;
	border: none;
	transition: background-color 0.18s, transform 0.15s;
	cursor: pointer;
	margin: 0 2px;
	display: inline-block;
}

.btn:hover, .btn-detail:hover, .btn-approve:hover, .btn-reject:hover {
	background-color: #e12c17;
	transform: translateY(-1px) scale(1.03);
}

.btn-reject {
	background-color: #FF8A3D;
	color: #fff;
}

.btn-reject:hover {
	background-color: #888;
}

.btn-approve {
	background-color: #FF8A3D;
}

.btn-approve:hover {
	background-color: #e12c17;
}

.btn-detail {
	background-color: #fff;
	color: #ff4250;
	border: 1px solid #FF8A3D;
	font-weight: 600;
}

.btn-detail:hover {
	background-color: #FF8A3D;
	color: #fff;
	border: 1px solid #FF8A3D;
}
/* 아이콘 */
.btn-detail .icon {
	margin-right: 3px;
	font-size: 16px;
	vertical-align: middle;
}
/* 모달 스타일 */
.modal {
	display: none;
	position: fixed;
	z-index: 1000;
	left: 0;
	top: 0;
	width: 100vw;
	height: 100vh;
	background-color: rgba(0, 0, 0, 0.35);
}

.modal-content {
	background-color: #fff;
	margin: 8% auto;
	padding: 30px 24px 20px 24px;
	border-radius: 20px;
	width: 350px;
	text-align: center;
	position: relative;
	box-shadow: 0 6px 24px rgba(0, 0, 0, 0.12);
}

.close {
	position: absolute;
	right: 15px;
	top: 10px;
	font-size: 22px;
	cursor: pointer;
	color: #aaa;
	transition: color 0.18s;
}

.close:hover {
	color: #ff4250;
}

.modal-title {
	font-size: 18px;
	font-weight: bold;
	color: #222;
	margin-bottom: 8px;
}

.modal-body {
	font-size: 15px;
	color: #333;
	margin-bottom: 10px;
	text-align: left;
}

.modal-btns {
	margin-top: 18px;
	text-align: center;
}

@media ( max-width : 1000px) {
	.container {
		padding: 15px 4px;
		max-width: 98vw;
	}
	table {
		min-width: 600px;
		font-size: 13px;
	}
	.modal-content {
		width: 98vw;
		min-width: 0;
		max-width: 360px;
		padding: 16px 8px 10px 8px;
	}
}

@media ( max-width : 600px) {
	.container {
		padding: 6px 0;
	}
	table {
		min-width: 0;
		font-size: 12px;
	}
	.modal-content {
		width: 98vw;
		min-width: 0;
		max-width: 98vw;
		padding: 8px 4px 8px 4px;
	}
}
/* 모임명 링크 스타일 */
.commu-title-link {
	color: #333333;
	font-weight: 600;
	text-decoration: none;
	transition: color 0.18s;
}

.commu-title-link:hover {
	color: #e0423f;
	text-decoration: underline;
}
</style>
</head>
<div class="maincontent">
	<div class="carroteasy-container">
		<h2>🛠️신고 내역 관리</h2>
		<table>
			<thead>
				<tr>
					<th>지역</th>
					<th>모임명</th>
					<th>신고자</th>
					<th>신고사유</th>
					<th>신고일시</th>
					<th>처리상태</th>
					<th>관리</th>
				</tr>
			</thead>
			<tbody>
				<%
            if(reportList == null || reportList.isEmpty()) {
        %>
				<tr>
					<td colspan="7" style="text-align: center;">신고 내역이 없습니다.</td>
				</tr>
				<%
            } else {
                for(CommunityReportVo vo : reportList) {
        %>
				<tr>
					<td><%= vo.getCommuRegion() != null ? vo.getCommuRegion() : "" %></td>
					<td><a class="commu-title-link"
						href="/CarrotEasy/CommunitySelectList.do?commuNo=<%=vo.getCommuNo()%>&commuRegion=<%=vo.getCommuRegion()%>"
						title="모임 게시글 보기"> <%= vo.getCommuTitle() %>
					</a></td>
					<td><%= vo.getMember().getMemNick() %></td>
					<td>
						<button type="button" class="btn-detail"
							onclick='showModal(
            				<%= vo.getReportNo() %>,
            				<%= toJson(vo.getCommuTitle()) %>,
            				<%= toJson(vo.getMember().getMemNick()) %>,
            				<%= toJson(vo.getReportContent()) %>,
            				<%= toJson(vo.getReportDate()) %>,
            				<%= toJson(vo.getProcessStatus()) %>
        					)'>
							<span class="icon">&#128269;</span> 상세보기
						</button>
					</td>
					<td><%= vo.getReportDate() %></td>
					<td><%= vo.getProcessStatus() %></td>
					<td>
						<form action="CommunityReportDelete.do" method="post"
							style="display: inline;"
							onsubmit="return confirm('정말 삭제하시겠습니까?');">
							<input type="hidden" name="reportNo"
								value="<%= vo.getReportNo() %>" />
							<button type="submit" class="btn btn-reject">삭제</button>
						</form>
					</td>
				</tr>
				<%
                }
            }
        %>
			</tbody>
		</table>
	</div>

	<!-- 모달 -->
	<div id="reportModal" class="modal">
		<div class="modal-content">
			<span class="close" onclick="closeModal()" aria-label="닫기">&times;</span>
			<div class="modal-title" id="modalTitle"></div>
			<div class="modal-body">
				<b>신고자:</b> <span id="modalReporter"></span><br> <b>신고일시:</b> <span
					id="modalDate"></span><br> <b>처리상태:</b> <span id="modalStatus"></span><br>
				<hr>
				<b>신고사유</b><br>
				<div id="modalContent" style="margin-top: 8px; margin-bottom: 20px;"></div>
			</div>
			<div class="modal-btns">
				<form id="processForm" action="CommunityReportProcess.do"
					method="post" style="display: inline;">
					<input type="hidden" name="reportNo" id="modalReportNo" />
					<button type="submit" name="action" value="approve"
						class="btn btn-approve">승인</button>
					<button type="submit" name="action" value="reject"
						class="btn btn-reject">반려</button>
				</form>
			</div>
		</div>
	</div>

	<script>
function showModal(reportNo, commuTitle, reporter, content, date, status) {
    document.getElementById('modalTitle').innerText = commuTitle + ' (' + reportNo + '번 신고)';
    document.getElementById('modalReporter').innerText = reporter;
    document.getElementById('modalDate').innerText = date;
    document.getElementById('modalStatus').innerText = status;
    document.getElementById('modalContent').innerHTML =  content.replace(/\n/g, "<br>");
    document.getElementById('modalReportNo').value = reportNo;
    document.getElementById('reportModal').style.display = "block";
}
function closeModal() {
    document.getElementById('reportModal').style.display = "none";
}
window.onclick = function(event) {
    var modal = document.getElementById('reportModal');
    if (event.target == modal) {
        closeModal();
    }
}
</script>
</div>
</html>
