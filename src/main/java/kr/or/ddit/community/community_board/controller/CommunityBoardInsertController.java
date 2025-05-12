package kr.or.ddit.community.community_board.controller;

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
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/CommunityBoardInsert.do")
public class CommunityBoardInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityBoardService boardService = CommunityBoardServiceImpl.getInstance();
       
    public CommunityBoardInsertController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	    String commuNo = request.getParameter("commuNo");
	    String commuRegion = request.getParameter("commuRegion"); // 추가
	    request.setAttribute("commuNo", commuNo);
	    request.setAttribute("commuRegion", commuRegion); // 추가
	    
	    // 핵심! contentPage 속성에 실제 폼 JSP 경로를 저장
	    request.setAttribute("contentPage", "/WEB-INF/view/community/community_index/community_board/boardInsert.jsp");

	    // main.jsp로 포워딩 (main.jsp가 전체 레이아웃을 담당)
	    request.getServletContext().getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    request.setCharacterEncoding("UTF-8"); // 한글 깨짐 방지

	    // 파라미터 꺼내기
	    int commuNo = Integer.parseInt(request.getParameter("commuNo").trim());
	    String commubTitle = request.getParameter("commubTitle");
	    String commubContent = request.getParameter("commubContent");
	    
	    // ★★★ 로그인한 회원 정보 꺼내기 ★★★
	    MemberVo loginMember = (MemberVo) request.getSession().getAttribute("member");
	    if (loginMember == null) {
	        // 로그인 안 한 경우 예외처리
	        response.sendRedirect(request.getContextPath() + "/login.do");
	        return;
	    }
	    
	    // VO 생성 및 값 세팅
	    CommunityBoardVo vo = new CommunityBoardVo();
	    vo.setCommuNo(commuNo);
	    vo.setCommubTitle(commubTitle);
	    vo.setCommubContent(commubContent);
	    vo.setMemNo(loginMember.getMemNo());

	    // 서비스 호출 (등록)
	    int result = boardService.communityBoardInsert(vo);

	    // 결과에 따라 리다이렉트 또는 메시지 처리
	    if(result > 0) {
	        // 추가: 파라미터 받아오기
	        String commuRegion = request.getParameter("commuRegion");
	        // commuNo는 이미 int commuNo로 있음 (String이 필요하면 String.valueOf(commuNo))
	        String commuNoStr = String.valueOf(commuNo);

	        // 게시글 목록으로 이동
	        String redirectUrl = request.getContextPath() + "/CommunitySelectList.do"
	            + "?commuNo=" + commuNoStr
	            + "&commuRegion=" + URLEncoder.encode(commuRegion, "UTF-8");

	        // 필요하다면 추가 파라미터도 붙여주세요 (카테고리, 검색 등)
	        // 예시:
	        String commuCatrgory = request.getParameter("commuCatrgory");
	        String stype = request.getParameter("stype");
	        String sword = request.getParameter("sword");
	        if (commuCatrgory != null && !commuCatrgory.isEmpty()) {
	            redirectUrl += "&commuCatrgory=" + URLEncoder.encode(commuCatrgory, "UTF-8");
	        }
	        if (stype != null && !stype.isEmpty()) {
	            redirectUrl += "&stype=" + URLEncoder.encode(stype, "UTF-8");
	        }
	        if (sword != null && !sword.isEmpty()) {
	            redirectUrl += "&sword=" + URLEncoder.encode(sword, "UTF-8");
	        }

	        response.sendRedirect(redirectUrl);
	    } else {
	        request.setAttribute("msg", "게시글 등록 실패!");
	        request.getRequestDispatcher("/WEB-INF/view/community/community_index/error.jsp").forward(request, response);
	    }
	}

}
