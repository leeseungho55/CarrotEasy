<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>채팅방</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

    .layout {
        flex: 1;
        display: flex;
        justify-content: center;
        align-items: stretch;
        background-color: #f5f5f5;
    }

    .chat-wrapper {
        display: flex;
        flex: 1;
        width: 100%;
        height 95%;
        background-color: #f5f5f5;
        min-height: calc(100vh - 100px);
    	border-right: 2px solid #ddd;
        border-left: 2px solid #ddd;
        border-top: 2px solid #ddd;
        border-bottom: 2px solid #ddd;
    }

    .chat-list {
        width: 320px;
        background-color: #fff;
        padding: 10px;
        overflow-y: auto;
        border-right: 1px solid #ccc;
    }

    .chat-room {
        flex: 1;
        display: flex;
        flex-direction: column;
        background-color: #fff;
        border-left: 1px solid #eee;
        overflow: hidden;
    }

	.chat-messages {
		    flex: none; /* flex-grow 끄기 */
		    height: 700px; /* 원하는 높이로 고정 */
		    overflow-y: auto; /* 넘칠 때만 스크롤 */
		    background-color: #f7f7f7;
		    display: flex;
		    flex-direction: column;
	}

    .chat-input {
        display: none;
        gap: 10px;
        padding: 15px;
        background-color: #fff;
        height: 70px;
        border-top: 1px solid #ddd;
        box-sizing: border-box;
    }

    .message-sender, .message-receiver {
        max-width: 60%;
        font-size: 16px;
        line-height: 1.5;
        padding: 12px 18px;
        margin: 8px 0;
        border-radius: 20px;
        box-shadow: 0px 2px 5px rgba(0,0,0,0.1);
        word-break: break-word;
        display: inline-block;
    }

    .message-sender {
        background-color: #cce7ff;
        align-self: flex-end;
        text-align: left;
    }

    .message-receiver {
        background-color: #ffebcc;
        align-self: flex-start;
        text-align: left;
    }

    #sendBtn {
        background-color: #FF8A3D;
        color: white;
        border: none;
        padding: 8px 20px;
        font-size: 16px;
        border-radius: 10px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    #sendBtn:hover {
        background-color: #0056b3;
    }

    #textMessage {
        flex: 1;
        padding: 12px;
        font-size: 16px;
        border: 1px solid #ccc;
        border-radius: 10px;
    }

    .chat-item.active {
        background-color: #d9eaff;
        font-weight: bold;
        border-left: 5px solid #007bff;
    }

    .chat-item {
        padding: 15px;
        margin-bottom: 10px;
        border: 1px solid #e1e1e1;
        border-radius: 10px;
        background-color: #fff;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    .chat-item:hover {
        background-color: #f9f9f9;
        box-shadow: 0px 3px 6px rgba(0, 0, 0, 0.08);
    }

    .chat-item div:nth-child(2) {
        color: #666;
        font-size: 14px;
        margin-top: 4px;
    }

    .chat-item div:nth-child(3) {
        font-size: 12px;
        color: #aaa;
        margin-top: 6px;
    }

    .chat-list::-webkit-scrollbar {
        width: 6px;
    }

    .chat-list::-webkit-scrollbar-thumb {
        background-color: #ccc;
        border-radius: 3px;
    }

    .chat-list::-webkit-scrollbar-track {
        background-color: #f0f0f0;
    }
</style>
<script>
    let webSocket = null;
    let currentChatNo = null;
    let receiverMemNo = null;
    let senderMemNo = null;

    function updateChatList() {
        $.ajax({
            url: "/CarrotEasy/chat/getChatList.do",
            method: "GET",
            data: { memNo: senderMemNo },
            success: function(data) {
                $(".chat-list").html("<h3 style='margin: 10px 0; font-size: 18px; font-weight: bold; color: #333;'>💬 내 채팅 목록</h3>");
                if (!data || data.length === 0) {
                    $("#emptyChatList").show();
                } else {
                    $("#emptyChatList").hide();
                    data.forEach(function(room) {
                        let opponentNick = (String(senderMemNo) === String(room.sellerMemNo)) 
                            ? room.buyerNick 
                            : room.sellerNick;

                        let roomHtml = "<div class='chat-item' data-chatno='" + room.chatNo +
                            "' onclick='openChat(" + room.chatNo + ", " + room.prodNo + ", " + room.sellerMemNo + ", " + room.buyerMemNo + ")'>" +
                            "<div><strong>" + opponentNick + "</strong></div>" +
                            "<div>" + (room.lastChatContent || "메시지 없음") + "</div>" +
                            "<div style='text-align: right; font-size: 12px; color: gray;'>" + (room.updateDate || room.createDate) + "</div>" +
                            "</div>";
                        $(".chat-list").append(roomHtml);
                    });
                }
                checkInitialChatList();
            },
            error: function(xhr, status, error) {
                console.error("채팅방 리스트 갱신 실패", error);
            }
        });
    }

    function openChat(chatNo, prodNo, sellerMemNo, buyerMemNo) {
        currentChatNo = chatNo;
        receiverMemNo = (senderMemNo == sellerMemNo) ? buyerMemNo : sellerMemNo;

        $.ajax({
            url: "/CarrotEasy/chat/getProductInfo.do",
            method: "GET",
            data: { prodNo: prodNo },
            success: function(product) {
                $("#productInfo").html(
                    "<h3>" + (product.prodTitle || "상품명 없음") + "</h3>" +
                    "<p>가격: " + (product.prodPrice ? product.prodPrice.toLocaleString() + "원" : "가격 정보 없음") + "</p>" +
                    "<p>지역: " + (product.prodLocation || "지역 정보 없음") + "</p>"
                ).show();
            },
            error: function(xhr, status, error) {
                console.error("상품 정보 로드 실패:", error);
            }
        });

        $(".chat-item").removeClass("active");
        $(`.chat-item[data-chatno='${chatNo}']`).addClass("active");
        $("#currentProdNo").val(prodNo);
        $(".chat-room").show();
        $("#noChatSelected").remove();
        $("#chatInputForm").show();
        $("#chat-messages").html("").show();
        $("#emptyChatRoom").hide();
        $(".chat-input").css("display", "flex");
        $("#newBadge_" + chatNo).remove();
        loadMessages(chatNo);
    }

    function loadMessages(chatNo) {
        if (!chatNo) return;
        $.ajax({
            url: "/CarrotEasy/chat/getMessages.do",
            method: "GET",
            data: { chatNo: chatNo },
            success: function(data) {
                $("#chat-messages").empty().show();
                if (data && data.length > 0) {
                    data.forEach(function(message) {
                        let messageClass = (String(message.senderNo) === String(senderMemNo)) ? "message-sender" : "message-receiver";
                        let messageHtml = "<div class='chat-message " + messageClass + "'>" +
                            "<p>" + message.chatContent + "</p>" +
                            "</div>";
                        $("#chat-messages").append(messageHtml);
                    });
                    $('#chat-messages').scrollTop($('#chat-messages')[0].scrollHeight);
                } else {
                    $("#chat-messages").append("<p>메시지가 없습니다.</p>");
                }
            },
            error: function(xhr, status, error) {
                console.error("메시지 로드 실패:", error);
            }
        });
    }

    function sendMessage(event) {
        event.preventDefault();
        let messageContent = $("#textMessage").val().trim();
        if (messageContent === "") return;

        const message = {
            chatNo: currentChatNo,
            chatContent: messageContent,
            senderNo: senderMemNo,
            receiverNo: receiverMemNo,
            prodNo: $("#currentProdNo").val(),
			startDate: new Date().toISOString() // ← 이거 추가했냐?
        };

        webSocket.send(JSON.stringify(message));

        $("#chat-messages").find("p:contains('메시지가 없습니다.')").remove();

        let messageHtml = "<div class='chat-message message-sender'><p>" + messageContent + "</p></div>";
        $("#chat-messages").append(messageHtml);
        $('#chat-messages').scrollTop($('#chat-messages')[0].scrollHeight);
        $("#textMessage").val("");

        $.ajax({
            url: "/CarrotEasy/chat/updateChatNo.do",
            method: "POST",
            data: { chatNo: currentChatNo },
            dataType: "text", // ← 이거 넣으면 그냥 문자열로 받아서 파싱 안함
            success: function(response) {
                console.log("서버 응답:", response); // 기대: "성공"
                updateChatList();
            },
            error: function(xhr, status, error) {
                console.error("채팅방 시간 업데이트 실패", error);
            }
        });

    }

    function checkInitialChatList() {
        const chatCount = $(".chat-item").length;
        $("#emptyChatList").toggle(chatCount === 0);
    }

    $(document).ready(function() {
        senderMemNo = document.getElementById("sessionMemNo").value;
        updateChatList();
        checkInitialChatList();
        $("#emptyChatRoom").show();
        $("#chat-messages").hide();
        setInterval(updateChatList, 1000);

        webSocket = new WebSocket("wss://yearly-up-raven.ngrok-free.app/CarrotEasy/OtOSocket?memNo=" + senderMemNo);

        webSocket.onopen = () => console.log("📡 WebSocket 연결됨");

        webSocket.onmessage = function(event) {
            try {
                if (event.data.startsWith("WebSocket")) {
                    console.log("WebSocket 연결 메시지 수신됨:", event.data);
                    return;
                }

                const message = JSON.parse(event.data);
                
                console.log("📩 수신된 메시지", message);
                
                if (!message.chatContent) return;

                const messageClass = (String(message.senderNo) === String(senderMemNo)) ? "message-sender" : "message-receiver";
                const messageHtml = "<div class='chat-message " + messageClass + "'>" +
                "<p>" + message.chatContent + "</p>"+
                "</div>";

                $("#chat-messages").append(messageHtml);
                $('#chat-messages').scrollTop($('#chat-messages')[0].scrollHeight);
            } catch (e) {
                console.error("WebSocket 메시지 파싱 오류:", e);
            }
        };

        webSocket.onerror = () => console.log("⚠️ WebSocket 오류");
        webSocket.onclose = () => console.log("❌ WebSocket 종료됨");
    });
</script>

</head>
<body>

<input type="hidden" id="sessionMemNo" value="${memNo}" />
<input type="hidden" id="currentProdNo" />

<div class="layout">
    <div class="chat-wrapper">

        <div class="chat-list">
            <h3 style="margin: 10px 0; font-size: 18px; font-weight: bold; color: #333; padding-left: 10px; border-left: 3px solid #ccc;">
                💬 내 채팅 목록
            </h3>
            <!-- 채팅 리스트는 JS로 동적 삽입 -->
        </div>

        <div class="chat-room">
            <div id="productInfo" style="padding: 20px; background: #fff; border-bottom: 1px solid #ddd; display: none;">
            </div>

            <div id="emptyChatRoom" style="display: none; text-align: center; margin-top: 80px;">
                <img src="/CarrotEasy/resource/img/chatlogo.png" alt="채팅 없음" style="width: 440px; opacity: 0.99;" />
                <p style="color: #888; font-size: 20px; margin-top: 18px; font-weight: 500;">
                    채팅방을 선택하거나<br>채팅을 시작해보세요!
                </p>
            </div>

            <div id="chat-messages" class="chat-messages">
            </div>

            <form class="chat-input" onsubmit="sendMessage(event)">
                <input type="text" id="textMessage" placeholder="메시지를 입력하세요" />
                <button type="submit" id="sendBtn">보내기</button>
            </form>
        </div>
    </div>
</div>

</body>
</html>
