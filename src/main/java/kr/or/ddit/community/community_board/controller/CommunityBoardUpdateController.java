package kr.or.ddit.community.community_board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_board.service.CommunityBoardServiceImpl;
import kr.or.ddit.community.community_board.service.ICommunityBoardService;
import kr.or.ddit.community.community_board.vo.CommunityBoardVo;

@WebServlet("/CommunityBoardUpdate.do")
public class CommunityBoardUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityBoardService boardService = CommunityBoardServiceImpl.getInstance();
       
    public CommunityBoardUpdateController() {
        super();
    }
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int commubNo = Integer.parseInt(req.getParameter("commubNo"));
        CommunityBoardVo board = boardService.communityBoardByNo(commubNo);
        
        req.setAttribute("board", board);
        
	    // 핵심! contentPage 속성에 실제 폼 JSP 경로를 저장
	    req.setAttribute("contentPage", "/WEB-INF/view/community/community_index/community_board/boardUpdate.jsp");

	    // main.jsp로 포워딩 (main.jsp가 전체 레이아웃을 담당)
	    req.getServletContext().getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        // 1. 파라미터 받기
        int commubNo = Integer.parseInt(request.getParameter("commubNo"));
        String commubTitle = request.getParameter("commubTitle");
        String commubContent = request.getParameter("commubContent");

        // 2. VO에 값 세팅
        CommunityBoardVo vo = new CommunityBoardVo();
        vo.setCommubNo(commubNo);
        vo.setCommubTitle(commubTitle);
        vo.setCommubContent(commubContent);

        // 3. 서비스 호출 (수정)
        int result = boardService.communityBoardUpdate(vo);

        // 4. 결과 처리
        if(result > 0) {
            // 수정 성공 시 상세보기로 이동
            response.sendRedirect(request.getContextPath() + "/CommunityBoardDetail.do?commubNo=" + commubNo);
        } else {
            // 실패 시 에러 페이지로 포워딩
            request.setAttribute("msg", "게시글 수정 실패!");
            request.getRequestDispatcher("/WEB-INF/view/community/community_index/error.jsp").forward(request, response);
        }
	}

}
