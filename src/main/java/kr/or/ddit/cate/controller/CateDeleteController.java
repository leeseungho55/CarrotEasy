package kr.or.ddit.cate.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.cate.service.CateServiceImpl;
import kr.or.ddit.cate.service.ICateService;

@WebServlet("/cate/delete.do")
public class CateDeleteController extends HttpServlet {
	
    private final ICateService cateService = CateServiceImpl.getInstance();
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int cateNo = Integer.parseInt(req.getParameter("cateNo"));
            
            // 실제 삭제 처리
            cateService.categoryDelete(cateNo);
            
            // 삭제 후 목록으로 리디렉션
            resp.sendRedirect("/CarrotEasy/cate/list.do");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("카테고리 삭제 중 오류가 발생했습니다.");
        }
    }
}
