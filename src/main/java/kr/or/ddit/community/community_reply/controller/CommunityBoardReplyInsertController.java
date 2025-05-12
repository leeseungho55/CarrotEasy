package kr.or.ddit.community.community_reply.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.community.community_reply.service.CommunityBoardReplyServiceImpl;
import kr.or.ddit.community.community_reply.service.ICommunityBoardReplyService;
import kr.or.ddit.community.community_reply.vo.CommunityBoardReplyVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/CommunityBoardReplyInsert.do")
public class CommunityBoardReplyInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityBoardReplyService boardReplyService = CommunityBoardReplyServiceImpl.getInstance();
       
    public CommunityBoardReplyInsertController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    int commubNo = Integer.parseInt(request.getParameter("commubNo"));
	    String replyContent = request.getParameter("replyContent");

	    HttpSession session = request.getSession();
	    MemberVo loginMember = (MemberVo) session.getAttribute("member");
	    if (loginMember == null) {
	        response.sendRedirect(request.getContextPath() + "/login.do");
	        return;
	    }
	    System.out.println("loginMember ====================================== "+loginMember);
	    
	    CommunityBoardReplyVo vo = new CommunityBoardReplyVo();
	    vo.setCommubNo(commubNo);
	    vo.setReplyContent(replyContent);
	    vo.setReplyWriter(loginMember.getMemNick()); // 닉네임 저장
	    vo.setMember(loginMember); // member 객체 통째로 저장 (DB insert 시에는 필요 없을 수 있음)
	    
	    int result = boardReplyService.boardInsertReply(vo);

	    // 댓글 등록 후 다시 상세로 이동
	    response.sendRedirect(request.getContextPath() + "/CommunityBoardDetail.do?commubNo=" + commubNo);
	}

}
