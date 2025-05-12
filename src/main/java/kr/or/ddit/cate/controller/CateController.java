package kr.or.ddit.cate.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.cate.service.CateServiceImpl;
import kr.or.ddit.cate.service.ICateService;
import kr.or.ddit.cate.vo.CateVo;

@WebServlet("/cate/*")
public class CateController extends HttpServlet {
        
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        ICateService categoryService = CateServiceImpl.getInstance();
        
        if ("/subcategories".equals(path)) {
            String parentCateNo = req.getParameter("parentCateNo");
            if (parentCateNo != null && !parentCateNo.isEmpty()) {
                List<CateVo> subcategoryList = categoryService.selectSubcategoriesByParent(Integer.parseInt(parentCateNo));
                
                // JSON 응답
                resp.setContentType("application/json; charset=UTF-8");
                PrintWriter out = resp.getWriter();
                
                // JSON 배열 생성
                StringBuilder sb = new StringBuilder();
                sb.append("[");
                for (int i = 0; i < subcategoryList.size(); i++) {
                    CateVo subcategory = subcategoryList.get(i);
                    sb.append("{\"cateNo\":").append(subcategory.getCateNo())
                      .append(",\"cateName\":\"").append(subcategory.getCateName()).append("\"}");
                    
                    if (i < subcategoryList.size() - 1) {
                        sb.append(",");
                    }
                }
                sb.append("]");
                
                out.print(sb.toString());
                out.flush();
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Parent category number is required");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}