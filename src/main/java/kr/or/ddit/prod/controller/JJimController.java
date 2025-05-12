package kr.or.ddit.prod.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.prod.service.IJJimService;
import kr.or.ddit.prod.service.JJimService;
import kr.or.ddit.prod.vo.JJimVo;
@WebServlet("/jjim.do")
public class JJimController extends HttpServlet{
	IJJimService service = JJimService.getInstance();
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String jjim = req.getParameter("prodJJim");
		System.out.println("jjim ==>"+jjim);
		
		int memNo = Integer.parseInt(req.getParameter("memNo"));
		int prodNo = Integer.parseInt(req.getParameter("prodNo"));
		
		JJimVo jvo = new JJimVo();
		jvo.setMemNo(memNo);
		jvo.setProdNo(prodNo);
		
		//서비스로 해야할 내용 ==> 찜 상품 등록 삭제 
		if(jjim.equals("on")) {
			service.jjimOn(jvo);
		}else if(jjim.equals("off")) {
			service.jjimOut(jvo);
		}
		
		int jjimCount = service.getJJimCount(prodNo);
		
		req.setAttribute("jjimCount", jjimCount);
		resp.setContentType("application/json; charset=UTF-8");
		resp.getWriter().write("{\"jjimCount\": " + jjimCount + "}");
	}
}
