package kr.or.ddit.chatting.controller;

import java.io.IOException;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import com.google.gson.Gson;

import jakarta.websocket.*;
import jakarta.websocket.server.ServerEndpoint;
import kr.or.ddit.chatting.service.ChatService;
import kr.or.ddit.chatting.service.IChatService;
import kr.or.ddit.chatting.vo.ChattingRoomVo;
import kr.or.ddit.chatting.vo.MessageVo;

@ServerEndpoint("/OtOSocket")
public class OtOSocket {

    private static final Map<String, Session> sessionMap = new ConcurrentHashMap<>();
    private static final Map<String, String> sessionFind = new ConcurrentHashMap<>();
    private static final Gson gson = new Gson();
    private static final IChatService service = ChatService.getInstance();

    @OnOpen
    public void handleOpen(Session session) {
        String memNo = "unknown";
        String query = session.getQueryString();

        if (query != null && query.startsWith("memNo=")) {
            memNo = query.split("=")[1];
        }

        sessionMap.put(memNo, session);
        sessionFind.put(session.getId(), memNo);

        System.out.println("[WebSocket 연결됨] memNo=" + memNo + ", sessionId=" + session.getId());

        try {
            session.getBasicRemote().sendText("WebSocket 연결 성공 (당신의 memNo: " + memNo + ")");
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    @OnMessage
    public void handleMessage(String jsonMessage, Session session) throws IOException {
        MessageVo mvo = gson.fromJson(jsonMessage, MessageVo.class);

        System.out.println("[수신 메시지] " + mvo.getSenderNo() + " -> " + mvo.getReceiverNo() + " : " + mvo.getChatContent());

        if (service.isNotNull(mvo.getChatNo()) == 0) {
        	System.out.println("채팅방이 유효하지 않아요");
        }

        service.sendMessage(mvo);
        String now = java.time.LocalDateTime.now().format(java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        mvo.setStartDate(now); // 이게 핵심!
        Session receiverSession = sessionMap.get(String.valueOf(mvo.getReceiverNo()));
        if (receiverSession != null && receiverSession.isOpen()) {
            
            String jsonResponse = gson.toJson(mvo); 
            receiverSession.getBasicRemote().sendText(jsonResponse);
            
        } else {
            System.out.println("[세션 없음] 수신자(" + mvo.getReceiverNo() + ") 연결되지 않음");
        }
    }

    @OnClose
    public void handleClose(Session session) {
        String memNo = sessionFind.get(session.getId());
        if (memNo != null) {
            sessionMap.remove(memNo);
            sessionFind.remove(session.getId());
            System.out.println("[세션 종료] memNo=" + memNo + ", sessionId=" + session.getId());
        } else {
            System.out.println("[세션 종료] sessionId=" + session.getId() + " (memNo 찾을 수 없음)");
        }
    }

    @OnError
    public void handleError(Session session, Throwable t) {
        System.out.println("[에러 발생] sessionId=" + session.getId());
        t.printStackTrace();
    }
}
