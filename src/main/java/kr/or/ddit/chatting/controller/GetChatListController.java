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
import kr.or.ddit.chatting.vo.ChattingRoomVo;

@WebServlet("/chat/getChatList.do")
public class GetChatListController extends HttpServlet {
    private IChatService chatService = ChatService.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            int memNo = Integer.parseInt(req.getParameter("memNo"));

            List<ChattingRoomVo> chatList = chatService.listChattingRoom(memNo);

            
            resp.setContentType("application/json; charset=UTF-8");
            Gson gson = new Gson();
            String json = gson.toJson(chatList);
            resp.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            //서버에서 에러가 발생했다는 것을 클라이언트(jQuery, 브라우저 등)에게 알려주는 코드
            resp.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
        }
    }
}
