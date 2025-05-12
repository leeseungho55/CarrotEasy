package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

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

@WebServlet("/chattingroom2.do") 
public class prodDetailChattingroom extends HttpServlet {
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
            System.out.println("memid==>"+ memId);
            
            // 채팅방 객체 생성
            ChattingRoomVo vo = new ChattingRoomVo();
            vo = (ChattingRoomVo) service.getMemData(memId);
            System.out.println("사용자 세션 ==> " + vo.getMemNo()+ " ==> 닉네임 :" + vo.getMemNick());
            int data = (int)vo.getMemNo();
            System.out.println("data==>"+data);
            String memNick = vo.getMemNick();

            
            // source 파라미터를 확인하여 어떤 경로로 들어왔는지 구분
            String source = req.getParameter("source");
            
           
            if ("prodView".equals(source)) {

                System.out.println("상품 페이지에서 들어옴");
            	
            	int prodNo = Integer.parseInt( req.getParameter("prodNo"));
                System.out.println("prodNo==>" +prodNo);
                vo.setProdNo(prodNo);
                int prodMemNo= service.prodMemNo(prodNo);
            	System.out.println("prodMemNo==>"+prodMemNo);
            	
                System.out.println("vo ==>"+vo);
                if(service.isNotNull(prodNo)!=1) {
                service.createChattingRoom(vo);
                
                // 채팅방 리스트 가져오기
                List<ChattingRoomVo> crlist = service.listChattingRoom(data);
                
                System.out.println("채팅방이 생성되었스니다.");
                // 상품 페이지에서 들어온 경우
                //상품 판매자의 memNo 가져오기, prodNo랑
                req.setAttribute("source", "prodView");
                req.setAttribute("chattingList", crlist);
                req.setAttribute("memNo", data);
                req.setAttribute("memNick", memNick);
                req.setAttribute("prodNo", prodNo);
                req.setAttribute("prodMemNo", prodMemNo);
                
                crlist = service.listChattingRoom(data);
                }
                //상품 정보 가져오기, 판매자 정보 가져오기.
                //req.setAttribute("prodId", service);
                req.getRequestDispatcher("/WEB-INF/view/chat/chatroom.jsp").forward(req, resp);
            }
            } catch (Exception e) {
            	System.out.println("세션이 만료되었거나 로그인되지 않았습니다.");
                resp.sendRedirect("/CarrotEasy/login.do"); // 로그인 페이지로 리다이렉트
            }
	}
}
