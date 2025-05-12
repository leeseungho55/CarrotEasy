package kr.or.ddit.cate.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.cate.dao.CateDaoImpl;
import kr.or.ddit.cate.dao.ICateDao;
import kr.or.ddit.cate.service.CateServiceImpl;
import kr.or.ddit.cate.service.ICateService;
import kr.or.ddit.cate.vo.CateVo;

@WebServlet("/cate/insert.do")
public class CateInsertController extends HttpServlet {
	ICateService cateService = CateServiceImpl.getInstance();
    
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		List<CateVo> topLevelCategories = cateService.selectAllCategories();
		
		req.setAttribute("cateList", topLevelCategories);
		
		ServletContext ctx = req.getServletContext();
		req.getRequestDispatcher("/WEB-INF/view/cate/cateInsertForm.jsp").forward(req, resp);
	}

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String cateName = req.getParameter("cateName");
            String cateParentNo = req.getParameter("cateParentNo");
            
            CateVo cateVo = new CateVo();
            cateVo.setCateName(cateName);
            cateVo.setCateParentNo(cateParentNo != null && !cateParentNo.isEmpty() ? Integer.parseInt(cateParentNo) : null);
            
            Integer maxCateNo = null;
            if (cateVo.getCateParentNo() == null) {
            	maxCateNo = cateService.getMaxCateNoForParentNull();
            	cateVo.setCateNo(maxCateNo == null ? 1 : maxCateNo + 1);
            } else {
            	maxCateNo = cateService.getMaxCateNoForParentNotNull(cateVo.getCateParentNo());
            	cateVo.setCateNo(maxCateNo == null ? cateVo.getCateParentNo() * 10 : maxCateNo + 1);
            }
            
            cateService.categoryInsert(cateVo);
            
            resp.sendRedirect("/CarrotEasy/cate/list.do");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("카테고리 등록 중 오류가 발생했습니다.");
        }
    }
}

