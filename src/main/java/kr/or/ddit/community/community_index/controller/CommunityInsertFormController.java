package kr.or.ddit.community.community_index.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/CommunityInsertForm.do")
public class CommunityInsertFormController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public CommunityInsertFormController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 로그인 체크 (세션에서 member 확인)
        HttpSession session = request.getSession(false);
        Object member = (session != null) ? session.getAttribute("member") : null;

        if (member == null) {
            response.sendRedirect(request.getContextPath() + "/login.do?msg=needLogin");
            return;
        }

        // 2. region 파라미터 받아서 폼에 전달
        String region = request.getParameter("commuRegion");
        request.setAttribute("region", region);

		// 1. contentPage 속성에 실제 커뮤니티 메인 JSP 경로를 저장
        request.setAttribute("contentPage", "/WEB-INF/view/community/community_index/insert.jsp");

        // 2. main.jsp로 포워딩 (main.jsp가 전체 레이아웃을 담당)
    	ServletContext ctx = request.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(request, response);
	}

}
