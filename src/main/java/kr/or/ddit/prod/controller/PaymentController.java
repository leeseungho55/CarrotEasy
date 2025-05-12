package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.io.PrintWriter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import kr.or.ddit.prod.service.IPaymentService;
import kr.or.ddit.prod.service.PaymentService;
import kr.or.ddit.prod.vo.PaymentDataVo;
@WebServlet("/kakaopay.do")
public class PaymentController extends HttpServlet{
	
	IPaymentService service = PaymentService.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		//데이터 가져오기
		int prodNo = Integer.parseInt(req.getParameter("prodNo"));
		int memNo = Integer.parseInt(req.getParameter("memNo"));
		String payType = (String)req.getParameter("payType");
		System.out.println("memNo ==> "+memNo);
		System.out.println("prodNo ==> "+prodNo);
		System.out.println("payType ==> "+payType);
		
		// vo 저장
		PaymentDataVo vo = new PaymentDataVo();
	
		vo.setMemNo(memNo);
		vo.setProdNo(prodNo);
		vo.setPayType(payType);
		
		System.out.println("vo==>" +vo);
		//type 변경 및 결제 테이블 저장
		service.insertPay(vo); 
		if(payType.equals("일반구매")) service.changeProdType(prodNo);
		
		//반응할게 없을 때 사용하면 좋은듯
	    resp.setContentType("application/json; charset=UTF-8");
	    resp.getWriter().write("{\"status\":\"success\"}");
	}
}
