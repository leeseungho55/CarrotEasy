package kr.or.ddit.community.community_board.controller;

import java.io.IOException;
import java.security.Provider.Service;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.community.community_board.service.CommunityBoardServiceImpl;
import kr.or.ddit.community.community_board.service.ICommunityBoardService;
import kr.or.ddit.community.community_board.vo.CommunityBoardVo;
import kr.or.ddit.community.community_good.service.BoardGoodServiceImpl;
import kr.or.ddit.community.community_good.service.IBoardGoodService;
import kr.or.ddit.community.community_index.service.CommunityServiceImpl;
import kr.or.ddit.community.community_index.service.ICommunityService;
import kr.or.ddit.community.community_index.vo.CommunityVo;
import kr.or.ddit.community.community_reply.service.CommunityBoardReplyServiceImpl;
import kr.or.ddit.community.community_reply.service.ICommunityBoardReplyService;
import kr.or.ddit.community.community_reply.vo.CommunityBoardReplyVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/CommunityBoardDetail.do")
public class CommunityBoardDetailController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService service = CommunityServiceImpl.getInstance();
	ICommunityBoardService boardService = CommunityBoardServiceImpl.getInstance();
	ICommunityBoardReplyService boardReplyService = CommunityBoardReplyServiceImpl.getInstance();
	IBoardGoodService goodService = BoardGoodServiceImpl.getInstance();
       
    public CommunityBoardDetailController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		 // 1. 세션에서 로그인한 회원 정보 꺼내기
	    HttpSession session = request.getSession();
	    MemberVo loginMember = (MemberVo) session.getAttribute("member");
	    if (loginMember == null) {
	        // 로그인 안 했으면 로그인 페이지로 리다이렉트 (메시지 파라미터는 선택)
	        response.sendRedirect(request.getContextPath() + "/login.do?msg=needLogin");
	        return;
	    }
	    
		int commubNo = Integer.parseInt(request.getParameter("commubNo").trim());
		String noCount = request.getParameter("noCount");
		
		// 좋아요 후 리다이렉트 시에는 조회수 증가 X
	    if (noCount == null) {
	        boardService.communityBoardCnt(commubNo);
	    }
		
		// 서비스 호출하여 게시글 정보 가져오기
		CommunityBoardVo board = boardService.communityBoardByNo(commubNo);
		request.setAttribute("board", board);
		
		// 소모임명 조회 추가
	    String commuTitle = "";
	    if (board != null) {
	        int commuNo = board.getCommuNo();
	        CommunityVo commuVo = service.communityByNo(commuNo);
	        if (commuVo != null) {
	            commuTitle = commuVo.getCommuTitle();
	        }
	    }
	    
		 // 댓글 리스트 가져오기
        List<CommunityBoardReplyVo> replyList = boardReplyService.boardReplyList(commubNo);
        request.setAttribute("replyList", replyList);
        
        // 좋아요 상태/개수 추가
        String memId = loginMember != null ? loginMember.getMemId() : null;

        boolean isLiked = false;
        if (memId != null) {
            isLiked = goodService.isBoardGood(commubNo, memId) > 0;
        }
        int goodCount = goodService.countBoardGood(commubNo);
        
        request.setAttribute("isLiked", isLiked);
        request.setAttribute("goodCount", goodCount);
        
        
        // **추가: 목록 페이지에서 받은 파라미터도 넘겨주기**
        request.setAttribute("commuRegion", request.getParameter("commuRegion"));
        request.setAttribute("commuCatrgory", request.getParameter("commuCatrgory"));
        request.setAttribute("commuTitle", commuTitle);
        request.setAttribute("stype", request.getParameter("stype"));
        request.setAttribute("sword", request.getParameter("sword"));

        // 1. contentPage 속성에 실제 커뮤니티 메인 JSP 경로를 저장
        request.setAttribute("contentPage", "/WEB-INF/view/community/community_index/community_board/boardDetail.jsp");

        // 2. main.jsp로 포워딩 (main.jsp가 전체 레이아웃을 담당)
    	ServletContext ctx = request.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(request, response);
	}

}
