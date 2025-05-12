package kr.or.ddit.community.community_index.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.community.community_index.service.CommunityServiceImpl;
import kr.or.ddit.community.community_index.service.ICommunityService;
import kr.or.ddit.community.community_index.vo.CommunityVo;

@WebServlet("/CommunityRegion.do")
public class CommunityRegionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	ICommunityService service = CommunityServiceImpl.getInstance();
       
    public CommunityRegionController() {
        super();
    }
	
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	// 1. 파라미터 수집
    	String region = req.getParameter("commuRegion"); // ex) "서구"
    	String catrgory = req.getParameter("commuCatrgory"); // ex) "운동", "교육", "전체" 등
    	
    	// 1.1 검색
    	String stype = req.getParameter("stype");   // 검색 타입 (예: commuTitle, commuContent)
        String sword = req.getParameter("sword");   // 검색어
    	
    	// 2. 파라미터를 Map으로 정리
    	Map<String, Object> param = new HashMap<>();
    	param.put("commuRegion", region);
    	
    	// "전체"일 경우 type 필터 생략
    	if (catrgory != null && !"전체".equals(catrgory)) {
    		param.put("commuCatrgory", catrgory);
    	}
    	
        if (stype != null && sword != null && !sword.isEmpty()) {
            param.put("stype", stype);
            param.put("sword", sword);
        }
    	
    	// 3. 서비스 호출
    	List<CommunityVo> list = service.getRegionList(param);
    	System.out.println("list : " + list);
    	
    	// 4. 데이터 전달
    	req.setAttribute("list", list);
    	req.setAttribute("region", region);
    	req.setAttribute("catrgory", catrgory);
    	
    	req.setAttribute("stype", stype);
    	req.setAttribute("sword", sword);
    	
    	// main.jsp 내에 표시할 실제 뷰 경로 지정
    	req.setAttribute("contentPage", "/WEB-INF/view/community/community_index/region.jsp");
    	
    	// main.jsp로 포워딩
        ServletContext ctx = req.getServletContext();
        ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	doGet(req, resp);
    }
    
}
