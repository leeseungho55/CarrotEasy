package kr.or.ddit.prod.controller;

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
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/prod/getBuyersByProd.do")
public class GetBuyersController extends HttpServlet {
	
	@Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. 요청 파라미터 받기
            int prodNo = Integer.parseInt(req.getParameter("prodNo"));

            // 2. 서비스 객체
            IChatService chatRoomService = ChatService.getInstance();

            // 3. 해당 상품의 채팅 참여자들(memNo + memNick) 조회
            List<MemberVo> buyers = chatRoomService.selectChatMembersByProdNo(prodNo);
            
            // 4. JSON 응답
            resp.setContentType("application/json; charset=UTF-8");
            Gson gson = new Gson();
            String json = gson.toJson(buyers);
            resp.getWriter().write(json);

        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().write("{\"error\": \"구매자 목록 조회 중 오류 발생\"}");
        }
    }
}
