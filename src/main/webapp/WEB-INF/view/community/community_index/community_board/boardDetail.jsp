<%@page import="org.apache.ibatis.reflection.SystemMetaObject"%>
<%@page import="kr.or.ddit.member.vo.MemberVo"%>
<%@page import="kr.or.ddit.community.community_reply.vo.CommunityBoardReplyVo"%>
<%@page import="kr.or.ddit.community.community_board.vo.CommunityBoardVo"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    CommunityBoardVo board = (CommunityBoardVo) request.getAttribute("board");
    List<CommunityBoardReplyVo> replyList = (List<CommunityBoardReplyVo>) request.getAttribute("replyList");
    String commuRegion = (String) request.getAttribute("commuRegion");
    String commuCatrgory = (String) request.getAttribute("commuCatrgory");
    String commuTitle = (String) request.getAttribute("commuTitle");
    String stype = (String) request.getAttribute("stype");
    String sword = (String) request.getAttribute("sword");

    String paramStr = "";
    if(commuRegion != null && !commuRegion.trim().isEmpty()) paramStr += "&commuRegion=" + java.net.URLEncoder.encode(commuRegion.trim(), "UTF-8");
    if(commuCatrgory != null && !commuCatrgory.trim().isEmpty()) paramStr += "&commuCatrgory=" + java.net.URLEncoder.encode(commuCatrgory.trim(), "UTF-8");
    if(stype != null && !stype.trim().isEmpty()) paramStr += "&stype=" + java.net.URLEncoder.encode(stype.trim(), "UTF-8");
    if(sword != null && !sword.trim().isEmpty()) paramStr += "&sword=" + java.net.URLEncoder.encode(sword.trim(), "UTF-8");
    
    Boolean isLiked = (Boolean)request.getAttribute("isLiked");
    int goodCount = (request.getAttribute("goodCount") != null) ? (Integer)request.getAttribute("goodCount") : 0;
    
    MemberVo loginMember = (MemberVo) session.getAttribute("member");
    String loginMemId = (loginMember != null) ? loginMember.getMemId() : null;
%>

<style>
body {
    font-family: 'Noto Sans KR', sans-serif;
    background-color: #f5f5f5;
    margin: 0;
    padding: 0;
}

.container {
    max-width: 1180px;
    margin: 8px auto;
    background: #fff;
    padding: 20px;
    border-radius: 16px;
    box-shadow: 0 6px 12px rgba(0,0,0,0.08);
}

h2, h3 {
    text-align: center;
    margin-bottom: 30px;
    color: #333;
    font-weight: 700;
}

.board-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.board-title {
    font-size: 20px;
    font-weight: bold;
    color: #222;
}

.board-content {
    background: #f8f8f8;
    padding: 25px;
    border-radius: 12px;
    margin-bottom: 30px;
    line-height: 1.6;
    font-size: 16px;
    color: #444;
}

.board-btns {
    text-align: right;
    margin-bottom: 20px;
}

.board-btns a {
    display: inline-block;
    margin-left: 10px;
    padding: 10px 20px;
    background-color: #FF8A3D;
    color: white;
    border-radius: 20px;
    text-decoration: none;
    font-size: 14px;
    font-weight: 500;
}

.board-btns a:hover {
    background-color: #e0423f;
}

.board-btns a.delete {
    background-color: #FF8A3D;
}
.board-btns a.delete:hover {
    background-color: #d32f2f;
}

.good-btn {
    background-color: #ffa500;
    color: white;
    padding: 10px 20px;
    border-radius: 20px;
    font-size: 14px;
    font-weight: 500;
    cursor: pointer;
    border: none;
}
.good-btn:hover {
    background-color: #e69500;
}

.reply-section {
    margin-top: 50px;
}

.reply-list {
    list-style: none;
    padding: 0;
}

.reply-list li {
    padding: 15px;
    border-bottom: 1px solid #eee;
    display: flex;
    align-items: center;
    gap: 12px;
}

.reply-writer {
    font-weight: bold;
    color: #2196F3;
}

.reply-content {
    flex: 1;
    color: #333;
}

.reply-date {
    font-size: 13px;
    color: #888;
}

.reply-actions button,
.reply-actions form button {
    background-color: #eee;
    color: #333;
    padding: 6px 12px;
    border: none;
    border-radius: 20px;
    font-size: 13px;
    cursor: pointer;
}

.reply-actions button:hover {
    background-color: #ddd;
}

.edit-btn {
    background-color: #2196F3;
    color: white;
}
.edit-btn:hover {
    background-color: #1976D2;
}

.delete-btn {
    background-color: #f44336;
    color: white;
}
.delete-btn:hover {
    background-color: #d32f2f;
}

.reply-edit-form input[type="text"] {
    width: 200px;
    padding: 8px;
    border: 1px solid #bbb;
    border-radius: 6px;
    font-size: 14px;
}

.reply-form {
    display: flex;
    gap: 12px;
    margin-top: 20px;
}

.reply-form input[type="text"] {
    flex: 1;
    padding: 10px;
    font-size: 15px;
    border: 1px solid #ccc;
    border-radius: 10px;
}

.reply-form button {
    background-color: #FF8A3D;
    color: white;
    padding: 10px 20px;
    border-radius: 20px;
    font-weight: 500;
    border: none;
    font-size: 14px;
    cursor: pointer;
}
.reply-form button:hover {
    background-color: #e0423f;
}
/* — 댓글 수정용 저장/취소 버튼 스타일 — */
.reply-edit-form button,
.reply-edit-form form button {
    padding: 6px 14px;
    font-size: 13px;
    font-weight: 600;
    border: none;
    border-radius: 20px;
    cursor: pointer;
    transition: background-color 0.2s, transform 0.1s;
    margin-left: 8px;
    color: #fff;
}

/* 저장 버튼 (submit) */
.reply-edit-form button[type="submit"] {
    background-color: #FF8A3D;
}

.reply-edit-form button[type="submit"]:hover {
    background-color: #e0423f;
    transform: translateY(-1px);
}

/* 취소 버튼 (button) */
.reply-edit-form button[type="button"] {
    background-color: #ccc;
}

.reply-edit-form button[type="button"]:hover {
    background-color: #bbb;
    transform: translateY(-1px);
}
</style>

<div class="container">
    <h2><strong>${commuTitle}</strong></h2>
    <div class="board-header">
        <span class="board-title">제목 : <%= board.getCommubTitle() %></span>
        <form action="CommunityBoardGood.do" method="post">
            <input type="hidden" name="commubNo" value="<%= board.getCommubNo() %>" />
            <input type="hidden" name="commuRegion" value="<%= commuRegion != null ? commuRegion : "" %>"/>
            <input type="hidden" name="commuCatrgory" value="<%= commuCatrgory != null ? commuCatrgory : "" %>"/>
            <input type="hidden" name="stype" value="<%= stype != null ? stype : "" %>"/>
            <input type="hidden" name="sword" value="<%= sword != null ? sword : "" %>"/>
            <button type="submit" class="good-btn">
                <%= (isLiked != null && isLiked) ? "👍 좋아요 취소" : "👍 좋아요" %> (<%= goodCount %>)
            </button>
        </form>
    </div>
    <div class="board-content">
        <%= board.getCommubContent() == null ? "" : board.getCommubContent().replaceAll("(\r\n|\n|\r)", "<br>") %>
    </div>
    <div class="board-btns">
        <% if (loginMember != null && board.getMember() != null && loginMember.getMemNo() == board.getMember().getMemNo()) { %>
            <a href="CommunityBoardUpdate.do?commubNo=<%= board.getCommubNo() %><%= paramStr %>">수정</a>
            <a href="CommunityBoardDelete.do?commubNo=<%= board.getCommubNo() %>&commuNo=<%= board.getCommuNo() %><%= paramStr %>" class="delete" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
        <% } %>
        <a href="CommunitySelectList.do?commuNo=<%= board.getCommuNo() %><%= paramStr %>">목록</a>
    </div>

    <hr>

    <div class="reply-section">
        <h3>댓글</h3>
        <%
        if (replyList == null || replyList.isEmpty()) {
        %>
            <p style="text-align: center; color: #999;">댓글이 없습니다.</p>
        <%
        } else {
        %>
        <ul class="reply-list">
        <% for (CommunityBoardReplyVo reply : replyList) { %>
            <li id="reply-item-<%= reply.getReplyNo() %>">
                <span class="reply-writer"><%= reply.getReplyWriter() %></span>
                <span id="reply-content-<%= reply.getReplyNo() %>" class="reply-content"><%= reply.getReplyContent() %></span>
                <span class="reply-date">(<%= reply.getReplyDate() %>)</span>
                <span class="reply-actions" id="action-btns-<%= reply.getReplyNo() %>">
                    <% if (loginMemId != null && reply.getMember() != null && loginMemId.equals(reply.getMember().getMemId())) { %>
                        <button type="button" class="edit-btn" onclick="showEditForm(<%= reply.getReplyNo() %>)">수정</button>
                        <form action="CommunityBoardReplyDelete.do" method="post" style="display:inline;" onsubmit="return confirm('정말 삭제하시겠습니까?');">
                            <input type="hidden" name="replyNo" value="<%= reply.getReplyNo() %>">
                            <input type="hidden" name="commubNo" value="<%= reply.getCommubNo() %>">
                            <button type="submit" class="delete-btn">삭제</button>
                        </form>
                    <% } %>
                </span>
                <span id="edit-form-wrap-<%= reply.getReplyNo() %>" class="reply-edit-form" style="display:none;">
                    <form action="CommunityBoardReplyUpdate.do" method="post">
                        <input type="hidden" name="replyNo" value="<%= reply.getReplyNo() %>">
                        <input type="hidden" name="commubNo" value="<%= reply.getCommubNo() %>">
                        <input type="text" name="replyContent" value="<%= reply.getReplyContent() %>">
                        <button type="submit">저장</button>
                        <button type="button" onclick="hideEditForm(<%= reply.getReplyNo() %>)">취소</button>
                    </form>
                </span>
            </li>
        <% } %>
        </ul>
        <script>
            function showEditForm(replyNo) {
                document.querySelectorAll("[id^='edit-form-wrap-']").forEach(e => e.style.display = "none");
                document.querySelectorAll("[id^='action-btns-']").forEach(e => e.style.display = "");
                document.querySelectorAll("[id^='reply-content-']").forEach(e => e.style.display = "");
                document.getElementById("edit-form-wrap-" + replyNo).style.display = "inline";
                document.getElementById("action-btns-" + replyNo).style.display = "none";
                document.getElementById("reply-content-" + replyNo).style.display = "none";
            }

            function hideEditForm(replyNo) {
                document.getElementById("edit-form-wrap-" + replyNo).style.display = "none";
                document.getElementById("action-btns-" + replyNo).style.display = "";
                document.getElementById("reply-content-" + replyNo).style.display = "";
            }
        </script>
        <% } %>

        <% if (loginMember != null) { %>
        <form action="CommunityBoardReplyInsert.do" method="post" class="reply-form">
            <input type="hidden" name="commubNo" value="<%= board.getCommubNo() %>" />
            <input type="hidden" name="commuRegion" value="<%= commuRegion != null ? commuRegion : "" %>"/>
            <input type="hidden" name="commuCatrgory" value="<%= commuCatrgory != null ? commuCatrgory : "" %>"/>
            <input type="hidden" name="stype" value="<%= stype != null ? stype : "" %>"/>
            <input type="hidden" name="sword" value="<%= sword != null ? sword : "" %>"/>
            <input type="text" name="replyContent" placeholder="댓글 입력" required />
            <button type="submit">댓글 등록</button>
        </form>
        <% } else { %>
        <p style="text-align: center; color: gray;">댓글 작성은 <a href="login.do">로그인</a> 후 이용 가능합니다.</p>
        <% } %>
    </div>
</div>
