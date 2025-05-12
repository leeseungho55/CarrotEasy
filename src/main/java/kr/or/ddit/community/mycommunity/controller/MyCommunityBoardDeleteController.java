package kr.or.ddit.community.mycommunity.controller;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_board.service.CommunityBoardServiceImpl;
import kr.or.ddit.community.community_board.service.ICommunityBoardService;
import kr.or.ddit.community.community_board.vo.CommunityBoardVo;
import kr.or.ddit.community.community_index.service.CommunityServiceImpl;
import kr.or.ddit.community.community_index.service.ICommunityService;
import kr.or.ddit.community.community_index.vo.CommunityVo;

@WebServlet("/myCommunityBoardDelete.do")
public class MyCommunityBoardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityBoardService boardService = CommunityBoardServiceImpl.getInstance();
       
    public MyCommunityBoardDeleteController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 게시글 번호 파라미터 받기
        int commubNo = Integer.parseInt(request.getParameter("commubNo"));
        String commuNo = request.getParameter("commuNo"); // 게시판 번호도 같이 받음

        // 2. 서비스 호출 (삭제)
        CommunityBoardVo vo = new CommunityBoardVo();
        vo.setCommubNo(commubNo);
        
        int result = boardService.communityBoardDelete(vo);

	    // 삭제 후 "나의 커뮤니티"로 이동
	    response.sendRedirect(request.getContextPath() + "/MyCommunity.do");
        
	}

}
