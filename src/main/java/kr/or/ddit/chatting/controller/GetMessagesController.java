package kr.or.ddit.chatting.controller;

import java.io.IOException;
import java.util.List;

import com.google.gson.Gson;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.chatting.service.ChatService;
import kr.or.ddit.chatting.service.IChatService;
import kr.or.ddit.chatting.vo.MessageVo;

@WebServlet("/chat/getMessages.do")
public class GetMessagesController extends HttpServlet {

    private IChatService chatService = ChatService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // chatNo를 파라미터로 받아오기
            String chatNoStr = req.getParameter("chatNo");
            System.out.println(chatNoStr);
            if (chatNoStr == null || chatNoStr.isEmpty()) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "chatNo parameter is missing");
                return;
            }
            
            int chatNo = Integer.parseInt(chatNoStr);
            System.out.println(chatNo);
            // 해당 chatNo에 대한 메시지 목록을 가져옴
            List<MessageVo> messages = chatService.printMessageList(chatNo);

            // 메시지 목록을 JSON 형식으로 변환
            Gson gson = new Gson();
            String jsonResponse = gson.toJson(messages);

            // 응답 설정
            resp.setContentType("application/json; charset=UTF-8");
            resp.getWriter().write(jsonResponse);
        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid chat number format");
        }
    }
}
