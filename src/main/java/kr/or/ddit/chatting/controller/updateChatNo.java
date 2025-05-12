package kr.or.ddit.chatting.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.chatting.service.ChatService;
import kr.or.ddit.chatting.service.IChatService;

@WebServlet("/chat/updateChatNo.do")
public class updateChatNo extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		IChatService service = ChatService.getInstance();
		int chatNo = Integer.parseInt(req.getParameter("chatNo"));
		service.updateChatNo(chatNo);
		
		
		resp.setContentType("application/json; charset=UTF-8");
        resp.getWriter().write("성공");
	}
}
