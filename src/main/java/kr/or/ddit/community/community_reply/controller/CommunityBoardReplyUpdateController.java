package kr.or.ddit.community.community_reply.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_reply.service.CommunityBoardReplyServiceImpl;
import kr.or.ddit.community.community_reply.service.ICommunityBoardReplyService;
import kr.or.ddit.community.community_reply.vo.CommunityBoardReplyVo;

@WebServlet("/CommunityBoardReplyUpdate.do")
public class CommunityBoardReplyUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityBoardReplyService replyService = CommunityBoardReplyServiceImpl.getInstance();
       
    public CommunityBoardReplyUpdateController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

        // 파라미터 수집
        int replyNo = Integer.parseInt(request.getParameter("replyNo"));
        int commubNo = Integer.parseInt(request.getParameter("commubNo"));
        String replyContent = request.getParameter("replyContent");

        // VO에 담기
        CommunityBoardReplyVo vo = new CommunityBoardReplyVo();
        vo.setReplyNo(replyNo);
        vo.setReplyContent(replyContent);

        // 서비스 호출
        int result = replyService.boardUpdateReply(vo);

        // 수정 후 다시 게시글 상세로 이동
        response.sendRedirect(request.getContextPath() + "/CommunityBoardDetail.do?commubNo=" + commubNo);
	}

}
