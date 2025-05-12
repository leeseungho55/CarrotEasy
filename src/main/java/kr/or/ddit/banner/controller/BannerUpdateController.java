package kr.or.ddit.banner.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.banner.service.BannerServiceImpl;
import kr.or.ddit.banner.service.IBannerService;
import kr.or.ddit.banner.vo.BannerVo;

@WebServlet("/banner/updateStatus.do")
public class BannerUpdateController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("application/json;charset=UTF-8");
        PrintWriter out = resp.getWriter();
        
        try {
            // JSON 요청 본문 읽기
            BufferedReader reader = req.getReader();
            StringBuilder sb = new StringBuilder();
            String line;
            
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
            
            // JSON 파싱
            Gson gson = new Gson();
            List<BannerVo> banners = gson.fromJson(sb.toString(), new TypeToken<List<BannerVo>>(){}.getType());
            
            // 서비스 객체를 통해 상태 업데이트
            IBannerService service = BannerServiceImpl.getInstance();
            int successCount = 0;
            
            BannerVo vo = new BannerVo();
            for (BannerVo banner : banners) {
                // 각 배너의 상태 업데이트
            	vo.setBanNo(banner.getBanNo());
            	vo.setBanDelyn(banner.getBanDelyn());
                int result = service.bannerUpdate(vo);
                if (result > 0) {
                    successCount++;
                }
            }
            
            // 결과 응답
            if (successCount == banners.size()) {
                out.write("{\"success\": true, \"message\": \"모든 배너 상태가 성공적으로 업데이트되었습니다.\"}");
            } else {
                out.write("{\"success\": true, \"message\": \"일부 배너만 업데이트되었습니다. (" + successCount + "/" + banners.size() + ")\"}");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"success\": false, \"message\": \"" + e.getMessage() + "\"}");
        }
    }
}