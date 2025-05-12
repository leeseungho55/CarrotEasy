package kr.or.ddit.prod.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.prod.service.IProdPurchaseService;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdPurchaseServiceImpl;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.type.ProdType;
import kr.or.ddit.prod.vo.ProdPurchaseVo;
import kr.or.ddit.prod.vo.ProdVo;

@WebServlet("/prod/completeDeal.do")
public class ProdCompleteDealController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
            int prodNo = Integer.parseInt(req.getParameter("prodNo"));
            int memNo = Integer.parseInt(req.getParameter("memNo"));
            String purchaseType = req.getParameter("purchaseType");

            // 거래 상태 변경
            IProdService prodService = ProdServiceImpl.getInstance();
            IProdPurchaseService prodPurchaseService = ProdPurchaseServiceImpl.getInstance();
            ProdVo prodVo = prodService.getProdByNo(prodNo);
            prodVo.setProdType(ProdType.SOLD_OUT);
            prodService.prodUpdate(prodVo);

            ProdPurchaseVo prodPurchaseVo = new ProdPurchaseVo();
            prodPurchaseVo.setProdNo(prodNo);
            prodPurchaseVo.setMemNo(memNo);
            prodPurchaseVo.setPurchaseType(purchaseType);
            
            // prod_purchase 저장
            prodPurchaseService.prodPurchaseInsert(prodPurchaseVo); // <-- 서비스에서 처리 (직접 INSERT)

            // 성공 응답
            resp.setContentType("application/json");
            resp.getWriter().write("{\"status\":\"success\"}");
        } catch (Exception e) {
            e.printStackTrace();
            resp.setStatus(500);
            resp.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
