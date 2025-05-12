package kr.or.ddit.community.community_board.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_board.service.CommunityBoardServiceImpl;
import kr.or.ddit.community.community_board.service.ICommunityBoardService;
import kr.or.ddit.community.community_board.vo.CommunityBoardVo;
import kr.or.ddit.community.community_good.service.BoardGoodServiceImpl;
import kr.or.ddit.community.community_good.service.IBoardGoodService;
import kr.or.ddit.community.community_index.service.CommunityServiceImpl;
import kr.or.ddit.community.community_index.service.ICommunityService;
import kr.or.ddit.community.community_index.vo.CommunityVo;

@WebServlet("/CommunitySelectList.do")
public class CommunitySelectListController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService communityService = CommunityServiceImpl.getInstance();
	ICommunityBoardService boardService = CommunityBoardServiceImpl.getInstance();
	IBoardGoodService goodService = BoardGoodServiceImpl.getInstance();
       
    public CommunitySelectListController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
            // 1. 파라미터 처리
            int commuNo = Integer.parseInt(request.getParameter("commuNo"));
            String commuRegion = request.getParameter("commuRegion");

            // 2. 커뮤니티 상세 정보 조회
            CommunityVo community = communityService.communityByNo(commuNo);
            
            // 3. 게시글 목록 조회
            List<CommunityBoardVo> boardList = boardService.communitySelectList(commuNo);
            
            // 3-1. 좋아요 개수 최신화
            for (CommunityBoardVo board : boardList) {
                int goodCount = goodService.countBoardGood(board.getCommubNo());
                board.setCommubGood(goodCount);
            }
            // 4. JSP 전달
            request.setAttribute("community", community);
            request.setAttribute("boardList", boardList);
            request.setAttribute("commuRegion", commuRegion);
            
            // 1. contentPage 속성에 실제 커뮤니티 메인 JSP 경로를 저장
            request.setAttribute("contentPage", "/WEB-INF/view/community/community_index/community_board/boardList.jsp");

            // 2. main.jsp로 포워딩 (main.jsp가 전체 레이아웃을 담당)
        	ServletContext ctx = request.getServletContext();
    		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(request, response);

        } catch(NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "유효하지 않은 커뮤니티 번호");
        } catch(Exception e) {
            request.setAttribute("error", e.getMessage());
            request.getRequestDispatcher("/WEB-INF/view/community/community_index/error.jsp").forward(request, response);
        }
	}

}
