package kr.or.ddit.banner.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.banner.service.BannerServiceImpl;
import kr.or.ddit.banner.service.IBannerService;
import kr.or.ddit.banner.vo.BannerVo;

@WebServlet("/banner/list.do")
public class BannerListController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		IBannerService service = BannerServiceImpl.getInstance();
		
		List<BannerVo> banners = service.bannerList();
		req.setAttribute("bannerList", banners);
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/banner/bannerSlider.jsp").forward(req, resp);
	}
}
