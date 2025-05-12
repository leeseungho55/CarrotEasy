package kr.or.ddit.banner.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.banner.service.BannerServiceImpl;
import kr.or.ddit.banner.service.IBannerService;
import kr.or.ddit.banner.vo.BannerVo;
import kr.or.ddit.member.vo.MemberVo;

@WebServlet("/banner/admin.do")
public class BannerListAdminController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        IBannerService service = BannerServiceImpl.getInstance();
        // 관리자만 접근할 수 있는 페이지라서 임시로 session에서 관리자로 넣어줌
        
        HttpSession session = req.getSession();
		boolean isAdmin = true;
		MemberVo memVo = new MemberVo(); 
		memVo.setMemRole(1);
		session.setAttribute("loginUser", memVo); 
		session.setAttribute("isAdmin", isAdmin);
	 
        // 모든 배너 목록 조회 (활성/비활성 모두 포함)
        List<BannerVo> bannerList = service.bannerListAll();
        req.setAttribute("bannerList", bannerList);
        
        ServletContext ctx = req.getServletContext();
        ctx.getRequestDispatcher("/WEB-INF/view/banner/bannerAdmin.jsp").forward(req, resp);
    }
}