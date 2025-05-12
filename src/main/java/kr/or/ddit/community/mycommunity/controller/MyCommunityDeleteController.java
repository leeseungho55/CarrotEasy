package kr.or.ddit.community.mycommunity.controller;

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

@WebServlet("/myCommunityDelete.do")
public class MyCommunityDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService service = CommunityServiceImpl.getInstance();
       
    public MyCommunityDeleteController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String commuNoStr = request.getParameter("commuNo");

	    int commuNo = Integer.parseInt(commuNoStr);

	    // CommunityVo 객체 생성 및 commuNo 세팅
	    CommunityVo vo = new CommunityVo();
	    vo.setCommuNo(commuNo);

	    // 삭제 처리
	    int cnt = service.communityDelete(vo);

	    // 삭제 후 "나의 커뮤니티"로 이동
	    response.sendRedirect(request.getContextPath() + "/MyCommunity.do");
        
	}

}
