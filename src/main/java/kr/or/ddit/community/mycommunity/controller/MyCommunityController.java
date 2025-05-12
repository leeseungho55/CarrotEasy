package kr.or.ddit.community.mycommunity.controller;

import java.io.IOException;
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
import kr.or.ddit.community.community_index.service.CommunityServiceImpl;
import kr.or.ddit.community.community_index.service.ICommunityService;
import kr.or.ddit.community.community_index.vo.CommunityVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/MyCommunity.do")
public class MyCommunityController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService service = CommunityServiceImpl.getInstance();
	ICommunityBoardService boardService = CommunityBoardServiceImpl.getInstance();
	
    public MyCommunityController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 세션에서 member 객체 꺼내기
		HttpSession session = request.getSession(false); // 세션이 없으면 null 반환

		if (session == null || session.getAttribute("member") == null) {
		    // 세션이 없거나 로그인 정보가 없으면 로그인 페이지로 리다이렉트
		    response.sendRedirect(request.getContextPath() + "/login.do");
		    return;
		}

		MemberVo member = (MemberVo) session.getAttribute("member");
	    int memNo = member.getMemNo();
	    
	    // 내가 만든 소모임 리스트 조회
	    List<CommunityVo> myCommunityList = service.communityByCreatList(memNo);

	    // 내가 쓴 소모임 내 게시글 리스트 조회
	    List<CommunityBoardVo> myBoardList = boardService.getMyBoardList(memNo);

	    // request에 데이터 저장
	    request.setAttribute("myCommunityList", myCommunityList);
	    request.setAttribute("myBoardList", myBoardList);

        // 1. contentPage 속성에 실제 커뮤니티 메인 JSP 경로를 저장
        request.setAttribute("contentPage", "/WEB-INF/view/community/community_index/myCommunity.jsp");

        // 2. main.jsp로 포워딩 (main.jsp가 전체 레이아웃을 담당)
    	ServletContext ctx = request.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(request, response);
	}

}
