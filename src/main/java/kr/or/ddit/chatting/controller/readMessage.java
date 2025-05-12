package kr.or.ddit.chatting.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.chatting.service.ChatService;
import kr.or.ddit.chatting.service.IChatService;

@WebServlet("/chat/markAsRead.do")
public class readMessage extends HttpServlet {
    private IChatService service = ChatService.getInstance();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int chatNo = Integer.parseInt(req.getParameter("chatNo"));
        int memNo = Integer.parseInt(req.getParameter("memNo"));

        int[] data = {chatNo,memNo};
        int updatedCount = service.readMessage(data);

        
        // ✅ 여기가 중요: JSON으로 결과만 응답하고 끝낸다.
        resp.setContentType("application/json;charset=UTF-8");
        resp.getWriter().write("{\"updatedCount\":" + updatedCount + "}");
    }
}
