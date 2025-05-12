package kr.or.ddit.banner.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.banner.service.BannerServiceImpl;
import kr.or.ddit.banner.service.IBannerService;
import kr.or.ddit.banner.vo.BannerVo;

@WebServlet("/banner/insert.do")
public class BannerInsertController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		PrintWriter out = resp.getWriter();
        
        try {
            // 요청에서 파라미터 추출
            String adImg = req.getParameter("adImg");
            String adUrl = req.getParameter("adUrl");
            String adNoStr = req.getParameter("adNo");
            
            int adNo = 0;
            if (adNoStr != null && !adNoStr.isEmpty()) {
                try {
                    adNo = Integer.parseInt(adNoStr);
                } catch (NumberFormatException e) {
                    // 로그 처리
                    e.printStackTrace();
                    out.print("{\"success\": false, \"message\": \"유효하지 않은 게시글 번호입니다.\"}");
                    return;
                }
            }
            
            // 1. 배너 객체 생성 및 데이터 설정
            BannerVo banner = new BannerVo();
            banner.setBanImg(adImg);
            banner.setBanUrl(adUrl);
            banner.setAdNo(adNo);
            
            // 2. 배너 서비스를 통해 배너 등록
            IBannerService bannerService = BannerServiceImpl.getInstance();
            int result = bannerService.bannerInsert(banner);
            int res = 0;
            // 3. 게시글의 채택 상태 업데이트
            if (result > 0 && adNo > 0) {
            	AdboardVo vo = new AdboardVo();
            	vo.setAdNo(adNo);
            	vo.setAdConfirm("Y");
                IAdboardService adBoardService = AdboardServiceImpl.getInstance();
                res = adBoardService.updateAdBoardConfirm(vo);
            }
            
            if(result > 0 && res > 0) {
	            // 성공 응답
	            out.print("{\"success\": true, \"message\": \"배너가 성공적으로 등록되었습니다.\"}");
	    		resp.sendRedirect("/CarrotEasy/adboard/list.do");
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.print("{\"success\": false, \"message\": \"배너 등록 중 오류가 발생했습니다.\"}");
        }
    }
}
