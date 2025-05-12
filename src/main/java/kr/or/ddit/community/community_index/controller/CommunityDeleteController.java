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

@WebServlet("/CommunityDelete.do")
public class CommunityDeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService service = CommunityServiceImpl.getInstance();
       
    public CommunityDeleteController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String commuNoStr = request.getParameter("commuNo");
        String commuRegion = request.getParameter("commuRegion");

        int commuNo = Integer.parseInt(commuNoStr);

        // CommunityVo 객체 생성 및 commuNo 세팅
        CommunityVo vo = new CommunityVo();
        vo.setCommuNo(commuNo);

        // 삭제 처리
        int cnt = service.communityDelete(vo);

        // 한글 파라미터 인코딩
        String encodedRegion = java.net.URLEncoder.encode(commuRegion, "UTF-8");

        // 목록으로 리다이렉트
        response.sendRedirect("CommunityRegion.do?commuRegion=" + encodedRegion);
        
	}

}
