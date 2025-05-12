package kr.or.ddit.community.community_board.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.community.community_board.service.CommunityBoardServiceImpl;
import kr.or.ddit.community.community_board.service.ICommunityBoardService;
import kr.or.ddit.community.community_good.service.BoardGoodServiceImpl;
import kr.or.ddit.community.community_good.service.IBoardGoodService;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/CommunityBoardGood.do")
public class CommunityBoardGoodController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityBoardService boardService = CommunityBoardServiceImpl.getInstance();
	IBoardGoodService goodService = BoardGoodServiceImpl.getInstance();
       
    public CommunityBoardGoodController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 1. 파라미터 받기
        int commubNo = Integer.parseInt(request.getParameter("commubNo").trim());

        // 2. 로그인 회원 정보 가져오기
        HttpSession session = request.getSession();
        MemberVo loginMember = (MemberVo) session.getAttribute("member");
        if (loginMember == null) {
            // 로그인 안 했으면 로그인 페이지로 이동
            response.sendRedirect(request.getContextPath() + "/login.do");
            return;
        }
        String memId = loginMember.getMemId();

        // 3. 이미 좋아요를 눌렀는지 확인
        boolean isLiked = goodService.isBoardGood(commubNo, memId) > 0;

        // 4. 토글 처리
        if (isLiked) {
            goodService.deleteBoardGood(commubNo, memId); // 좋아요 취소
        } else {
            goodService.insertBoardGood(commubNo, memId); // 좋아요 추가
        }

        // 5. 원래 상세 페이지로 리다이렉트 (파라미터 유지)
        String redirectUrl = request.getContextPath() + "/CommunityBoardDetail.do?commubNo=" + commubNo;
        // 필요하면 region, category 등 파라미터 추가
        response.sendRedirect(redirectUrl);
	}

}
