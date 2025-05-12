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

@WebServlet("/CommunityBoardDelete.do")
public class CommunityBoardDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityBoardService boardService = CommunityBoardServiceImpl.getInstance();
       
    public CommunityBoardDeleteController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 게시글 번호 파라미터 받기
        int commubNo = Integer.parseInt(request.getParameter("commubNo"));
        String commuNo = request.getParameter("commuNo"); // 게시판 번호도 같이 받음

        // 2. 서비스 호출 (삭제)
        CommunityBoardVo vo = new CommunityBoardVo();
        vo.setCommubNo(commubNo);
        
        int result = boardService.communityBoardDelete(vo);

        // 3. 결과 처리
        if(result > 0) {
            response.sendRedirect(request.getContextPath() + "/CommunitySelectList.do?commuNo=" + commuNo);
        } else {
            request.setAttribute("msg", "게시글 삭제 실패!");
            request.getRequestDispatcher("/WEB-INF/view/community/community_index/error.jsp").forward(request, response);
        }
	}

}
