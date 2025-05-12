package kr.or.ddit.chatting.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;


import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import kr.or.ddit.chatting.service.ChatService;
import kr.or.ddit.chatting.service.IChatService;

import kr.or.ddit.chatting.vo.ChattingRoomVo;
import kr.or.ddit.member.vo.MemberVo;
@WebServlet("/chattingroom.do")
public class ChattingRoomController extends HttpServlet {
    
	IChatService service = ChatService.getInstance();
	
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        	
    	try {
        	
            HttpSession session = req.getSession();
            MemberVo member = (MemberVo) session.getAttribute("member");
            if (member == null) {
                resp.sendRedirect("/CarrotEasy/login.do");  // 로그인 페이지로 
                return;
            }
            String memId = member.getMemId();
            
            // 채팅방 객체 생성
            ChattingRoomVo vo = new ChattingRoomVo();
            vo = (ChattingRoomVo) service.getMemData(memId);
            System.out.println("사용자 세션 ==> " + vo.getMemNo()+ " ==> 닉네임 :" + vo.getMemNick());
            int data = (int)vo.getMemNo();
            System.out.println("data==>"+data);
            String memNick = vo.getMemNick();
            // 채팅방 리스트 가져오기
            List<ChattingRoomVo> crlist = service.listChattingRoom(data);
            
            // source 파라미터를 확인하여 어떤 경로로 들어왔는지 구분
            String source = req.getParameter("source");
            
           
            if ("prodView".equals(source)) {

                System.out.println("상품 페이지에서 들어옴");
            	
            	int prodNo = Integer.parseInt( req.getParameter("prodNo"));

                vo.setProdNo(prodNo);
                int prodMemNo= service.prodMemNo(prodNo);

            	
                // 상품 페이지에서 들어온 경우
                //상품 판매자의 memNo 가져오기, prodNo랑
                req.setAttribute("source", "prodView");
                req.setAttribute("chattingList", crlist);
                req.setAttribute("memNo", data);
                req.setAttribute("memNick", memNick);
                req.setAttribute("prodNo", prodNo);
                req.setAttribute("prodMemNo", prodMemNo);

                System.out.println("vo ==>"+vo);
                if (service.isNotNull(prodNo) != 1) {
                    service.createChattingRoom(vo);
                    System.out.println("채팅방이 생성되었습니다.");
                    crlist = service.listChattingRoom(data); // 새로 조회
                    req.setAttribute("chattingList", crlist);
                }

                //상품 정보 가져오기, 판매자 정보 가져오기.
                //req.setAttribute("prodId", service);
                req.getRequestDispatcher("/WEB-INF/view/chat/chatroom.jsp").forward(req, resp);
            } else {
                // 채팅 리스트 버튼에서 들어온 경우
                System.out.println("채팅 리스트 버튼에서 들어옴");

                vo.setMemNick(memNick);                
                req.setAttribute("memNo", data);
                req.setAttribute("memNick", memNick);
                req.setAttribute("chattingList", crlist);

                req.setAttribute("contentPage", "/WEB-INF/view/chat/chatroom.jsp");
        		
        		ServletContext ctx = req.getServletContext();
        		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
            }
        } catch (Exception e) {
        	
            resp.sendRedirect("/CarrotEasy/prod.do"); // 로그인 페이지로 리다이렉트
        }
    }
}
