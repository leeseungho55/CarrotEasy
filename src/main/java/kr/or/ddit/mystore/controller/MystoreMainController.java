package kr.or.ddit.mystore.controller;

import java.io.IOException;
import java.nio.file.Paths;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.service.IMystoreService;
import kr.or.ddit.mystore.service.MystoreServiceImpl;
import kr.or.ddit.mystore.vo.StoreVo;
import kr.or.ddit.prod.vo.ProdVo;

@WebServlet("/mystore/mystoreMain.do")
public class MystoreMainController extends HttpServlet {
	
	IMystoreService mystoreService = MystoreServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String prodNoStr = req.getParameter("prodNo");
		if(prodNoStr != null) {
			int prodNo = Integer.parseInt(prodNoStr);
			ProdVo prod = mystoreService.prodmemNo(prodNo);
			int prodmemNo = prod.getMemNo();
			req.setAttribute("prodmemNo", prodmemNo);
			MemberVo mem = mystoreService.appendProfile(prodmemNo);
			String img = mem.getMemImg();
			if(img != null) {
				String fileName = Paths.get(img).getFileName().toString();
				System.out.println("fileName : " + fileName);
				
				req.setAttribute("fileName", fileName);
			}
			
			// 내상점 정보 가져오기(상점명, 상점소개)
			StoreVo store = new StoreVo();
			store = mystoreService.storeInfo(prodmemNo);
			
			// 상점 오픈일
			int storeOpenDay = mystoreService.storeOpenDay(prodmemNo);
			
			// 상점 방문수
			int storeVisitCnt = mystoreService.storeVisitCnt(prodmemNo);
			
			// 상점 상품판매
			int storeProdSellCnt = mystoreService.storeProdSellCnt(prodmemNo);
			
			// 상점 상품 총 개수
			int storeProdAllCnt = mystoreService.storeProdAllCnt(prodmemNo);
			
			// 상점 후기 총 개수
			int storeReviewAllCnt = mystoreService.storeReviewAllCnt(prodmemNo);
			
			// 상점 찜 총 개수
			int storeJjimAllCnt = mystoreService.storeJjimAllCnt(prodmemNo);
			
			
			req.setAttribute("store", store);
			req.setAttribute("storeOpenDay", storeOpenDay);
			req.setAttribute("storeVisitCnt", storeVisitCnt);
			req.setAttribute("storeProdSellCnt", storeProdSellCnt);
			req.setAttribute("storeProdAllCnt", storeProdAllCnt);
			req.setAttribute("storeJjimAllCnt", storeJjimAllCnt);
			req.setAttribute("storeReviewAllCnt", storeReviewAllCnt);
			req.setAttribute("mem", mem);
		}
		else {
			HttpSession session = req.getSession();
			MemberVo member = (MemberVo) session.getAttribute("member");
			int memNo = member.getMemNo();
			
			// 내상점 프로필 이미지 가져오기
			MemberVo mem = mystoreService.appendProfile(memNo);
			String img = mem.getMemImg();
			if(img != null) {
				String fileName = Paths.get(img).getFileName().toString();
				System.out.println("fileName : " + fileName);
				
				req.setAttribute("fileName", fileName);
			}
			
			// 내상점 정보 가져오기(상점명, 상점소개)
			StoreVo store = new StoreVo();
			store = mystoreService.storeInfo(memNo);
			
			// 상점 오픈일
			int storeOpenDay = mystoreService.storeOpenDay(memNo);
			
			// 상점 방문수
			int storeVisitCnt = mystoreService.storeVisitCnt(memNo);
			
			// 상점 상품판매
			int storeProdSellCnt = mystoreService.storeProdSellCnt(memNo);
			
			// 상점 상품 총 개수
			int storeProdAllCnt = mystoreService.storeProdAllCnt(memNo);
			
			// 상점 후기 총 개수
			int storeReviewAllCnt = mystoreService.storeReviewAllCnt(memNo);
			
			// 상점 찜 총 개수
			int storeJjimAllCnt = mystoreService.storeJjimAllCnt(memNo);
			
			
			req.setAttribute("store", store);
			req.setAttribute("storeOpenDay", storeOpenDay);
			req.setAttribute("storeVisitCnt", storeVisitCnt);
			req.setAttribute("storeProdSellCnt", storeProdSellCnt);
			req.setAttribute("storeProdAllCnt", storeProdAllCnt);
			req.setAttribute("storeJjimAllCnt", storeJjimAllCnt);
			req.setAttribute("storeReviewAllCnt", storeReviewAllCnt);
			req.setAttribute("member", member);
			req.setAttribute("mem", mem);
		
		}
		
		req.setAttribute("contentPage", "/WEB-INF/view/mystore/mystore.jsp");
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		MemberVo member = (MemberVo) session.getAttribute("member");
		int memNo = member.getMemNo();
		
		String title = req.getParameter("title");
		String content = req.getParameter("content");
		
		//구분값 num
		int num = Integer.parseInt(req.getParameter("num"));
		
		if(num == 0) {
			StoreVo store = new StoreVo();
			store.setMemNo(memNo);
			store.setStoreName(title);
			
			mystoreService.storeNameUpdate(store);
			
		}
		else {
			StoreVo store = new StoreVo();
			store.setMemNo(memNo);
			store.setStoreContent(content);
			
			mystoreService.storeContentUpdate(store);
		}
		
		
	}

}
