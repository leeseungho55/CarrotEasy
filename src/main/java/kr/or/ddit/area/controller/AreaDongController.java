package kr.or.ddit.area.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.area.service.AreaServiceImpl;
import kr.or.ddit.area.service.IAreaService;
import kr.or.ddit.area.vo.AreaVo;

@WebServlet("/area/*")
public class AreaDongController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        IAreaService areaService = AreaServiceImpl.getInstance();
        
        if ("/dongs".equals(path)) {
            String districtNo = req.getParameter("districtNo");
            if (districtNo != null && !districtNo.isEmpty()) {
                List<AreaVo> dongList = areaService.selectDongsByDistrict(Integer.parseInt(districtNo));
                
                // JSON 응답
                resp.setContentType("application/json; charset=UTF-8");
                PrintWriter out = resp.getWriter();
                
                // JSON 배열 생성
                StringBuilder sb = new StringBuilder();
                sb.append("[");
                for (int i = 0; i < dongList.size(); i++) {
                    AreaVo dong = dongList.get(i);
                    sb.append("{\"areaNo\":").append(dong.getAreaNo())
                      .append(",\"areaName\":\"").append(dong.getAreaName()).append("\"}");
                    
                    if (i < dongList.size() - 1) {
                        sb.append(",");
                    }
                }
                sb.append("]");
                
                out.print(sb.toString());
                out.flush();
            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "District number is required");
            }
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}