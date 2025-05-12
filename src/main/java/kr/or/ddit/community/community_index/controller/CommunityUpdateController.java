package kr.or.ddit.community.community_index.controller;

import java.io.IOException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_index.service.CommunityServiceImpl;
import kr.or.ddit.community.community_index.service.ICommunityService;
import kr.or.ddit.community.community_index.vo.CommunityVo;

@WebServlet("/CommunityUpdate.do")
public class CommunityUpdateController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService service = CommunityServiceImpl.getInstance();
       
    public CommunityUpdateController() {
        super();
    }
    
    @Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String commuNoStr = req.getParameter("commuNo");
		int commuNo = Integer.parseInt(commuNoStr);

		// commuNo로 기존 소모임 정보 조회
		CommunityVo vo = service.communityByNo(commuNo); // 서비스에 맞게 메서드명 확인

		// 조회한 정보를 request에 담아서 JSP로 포워딩
		req.setAttribute("community", vo);
	    req.setAttribute("contentPage", "/WEB-INF/view/community/community_index/update.jsp");

	    // main.jsp로 포워딩 (main.jsp가 전체 레이아웃을 담당)
	    req.getServletContext().getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 파라미터 받기
        request.setCharacterEncoding("UTF-8");
        String commuNoStr = request.getParameter("commuNo");
        String commuTitle = request.getParameter("commuTitle");
        String commuContent = request.getParameter("commuContent");
        String commuCatrgory = request.getParameter("commuCatrgory");
        String commuRegion = request.getParameter("commuRegion"); // 필요하다면

        // 2. commuNo 파싱
        int commuNo = Integer.parseInt(commuNoStr);

        // 3. VO에 값 세팅
        CommunityVo vo = new CommunityVo();
        vo.setCommuNo(commuNo);
        vo.setCommuTitle(commuTitle);
        vo.setCommuContent(commuContent);
        vo.setCommuCatrgory(commuCatrgory);
        vo.setCommuRegion(commuRegion);

        // 4. DB 업데이트
        int cnt = service.communityUpdate(vo);

        // 5. 결과 처리 및 리다이렉트 (예: 목록으로 이동)
        // 성공/실패에 따라 메시지 처리도 가능
        String encodedRegion = URLEncoder.encode(commuRegion, "UTF-8");
        response.sendRedirect("CommunityRegion.do?commuRegion=" + encodedRegion);
	}

}
