package kr.or.ddit.cate.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.cate.service.CateServiceImpl;
import kr.or.ddit.cate.service.ICateService;
import kr.or.ddit.cate.vo.CateVo;

@WebServlet("/cate/update.do")
public class CateUpdateController extends HttpServlet {

    private final ICateService cateService = CateServiceImpl.getInstance();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int cateNo = Integer.parseInt(req.getParameter("cateNo"));

            CateVo cate = cateService.selectCategoryByCateNo(cateNo);
            List<CateVo> topLevelCategories = cateService.selectAllCategories(); // 상위 카테고리 선택용

            req.setAttribute("cate", cate);
            req.setAttribute("cateList", topLevelCategories);

            req.getRequestDispatcher("/WEB-INF/view/cate/cateUpdateForm.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("카테고리 조회 중 오류가 발생했습니다.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            int cateNo = Integer.parseInt(req.getParameter("cateNo"));
            String cateName = req.getParameter("cateName");
            String cateParentNo = req.getParameter("cateParentNo");

            CateVo cateVo = new CateVo();
            cateVo.setCateNo(cateNo);
            cateVo.setCateName(cateName);
            cateVo.setCateParentNo((cateParentNo != null && !cateParentNo.isEmpty()) ? Integer.parseInt(cateParentNo) : null);

            cateService.categoryUpdate(cateVo);

            resp.sendRedirect("/CarrotEasy/cate/list.do");
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("카테고리 수정 중 오류가 발생했습니다.");
        }
    }
}
