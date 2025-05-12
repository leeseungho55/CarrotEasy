package kr.or.ddit.community.community_index.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.community.community_index.service.CommunityServiceImpl;
import kr.or.ddit.community.community_index.service.ICommunityService;
import kr.or.ddit.community.community_index.vo.CommunityVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/CommunityInsert.do")
public class CommunityInsertController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService service = CommunityServiceImpl.getInstance();
       
    public CommunityInsertController() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 	String commuRegion = request.getParameter("commuRegion");
	        String commuTitle = request.getParameter("commuTitle");
	        String commuContent = request.getParameter("commuContent");
	        String commuCatrgory = request.getParameter("commuCatrgory");

	        
	        // 1. 세션에서 로그인한 회원 정보 꺼내기
	        HttpSession session = request.getSession();
	        MemberVo loginMember = (MemberVo) session.getAttribute("member");
	        if (loginMember == null) {
	            // 로그인 안 했으면 등록 불가 처리
	            response.sendRedirect(request.getContextPath() + "/login.do?msg=needLogin");
	            return;
	        }
	        int memNo = loginMember.getMemNo();
	        
	        // 2. VO에 데이터 담기
	        CommunityVo vo = new CommunityVo();
	        vo.setCommuRegion(commuRegion);
	        vo.setCommuTitle(commuTitle);
	        vo.setCommuContent(commuContent);
	        vo.setCommuCatrgory(commuCatrgory);
	        vo.setMemNo(memNo);
	        
	        // 3. Service 호출
	        int cnt = service.communityInsert(vo);

	        // 4. 성공 시 목록페이지로 리다이렉트
	        try {
	            String encodedRegion = URLEncoder.encode(commuRegion, "UTF-8");
	            String encodedCatrgory = URLEncoder.encode(commuCatrgory != null ? commuCatrgory : "", "UTF-8");
	            if (cnt > 0) {
	                response.sendRedirect(request.getContextPath() + "/CommunityRegion.do?commuRegion=" + encodedRegion); // 해당 필터로 이동시 추가 + "&commuCatrgory=" + encodedCatrgory	
	            } else {
	                response.sendRedirect(request.getContextPath() + "/CommunityInsertForm.do?commuRegion=" + encodedRegion + "&commuCatrgory=" + encodedCatrgory);
	            }
	        } catch (UnsupportedEncodingException e) {
	            e.printStackTrace();
	        }
	}

}
