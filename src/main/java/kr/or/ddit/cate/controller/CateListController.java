package kr.or.ddit.cate.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.cate.service.CateServiceImpl;
import kr.or.ddit.cate.service.ICateService;
import kr.or.ddit.cate.vo.CateVo;

@WebServlet("/cate/list.do")
public class CateListController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 카테고리 목록 조회
            ICateService cateService = CateServiceImpl.getInstance();
            
            // 상위 카테고리 리스트 조회
            List<CateVo> cateList = cateService.selectAllCategories();
            
            // 각 상위 카테고리에 대해 하위 카테고리들을 조회하여 cateVo에 추가
            for (CateVo cateVo : cateList) {
                // 하위 카테고리 조회
                List<CateVo> subCategoryList = cateService.selectSubcategoriesByParent(cateVo.getCateNo());
                cateVo.setSubCategoryList(subCategoryList); // CateVo에 하위 카테고리 리스트 추가
            }
            
            // 카테고리 목록을 요청 속성에 담기
            req.setAttribute("cateList", cateList);
            
            // 카테고리 리스트 화면으로 포워딩
            req.getRequestDispatcher("/WEB-INF/view/cate/cateList.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.getWriter().write("카테고리 조회 중 오류가 발생했습니다.");
        }
    }
}

