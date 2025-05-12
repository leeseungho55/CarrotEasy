package kr.or.ddit.mystore.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.file.service.FileServiceImpl;
import kr.or.ddit.file.service.IFileService;
import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.mystore.service.IMystoreService;
import kr.or.ddit.mystore.service.MystoreServiceImpl;
import kr.or.ddit.prod.service.IProdImageService;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdImageServiceImpl;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.review.vo.ReviewVo;

@WebServlet("/mystore/mystoreList.do")
public class MystoreListController extends HttpServlet {
	
	IMystoreService mystoreService = MystoreServiceImpl.getInstance();
	IProdService prodService = ProdServiceImpl.getInstance();
    IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
	IFileService fileService = FileServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
//		req.setCharacterEncoding("UTF-8");
//		resp.setContentType("text/html;charset=UTF-8");
		
		String type = req.getParameter("type");
		System.out.println("type : " + type);
		
//		HttpSession session = req.getSession();
//		MemberVo member = (MemberVo) session.getAttribute("member");
//		int memNo = member.getMemNo();
		
	    String paraprodNo = req.getParameter("prodNo");
	    System.out.println("paraprodNo : " + paraprodNo);		// 판매자 memNo
	    String paramemNo = req.getParameter("memNo");
	    System.out.println("paramemNo : " + paramemNo);			// sessionScope.member.memNo
	    
	    
	    switch (type) {
	      case "prod":
	    	  if(paraprodNo != "") {	// 상품 상세보기 -> 판매자 상점보기
	    		  int prodNo = Integer.parseInt(paraprodNo);
	    		  List<ProdVo> storeProdForSale = mystoreService.storeProdForSale(prodNo);
		    	  List<ProdVo> storeProdReserved = mystoreService.storeProdReserved(prodNo);
		    	  List<ProdVo> storeProdSoldOut = mystoreService.storeProdSoldOut(prodNo);
		    	  List<ProdVo> storePurchaseList = mystoreService.storePurchaseList(prodNo);
		    	  
		    	  List<FileVo> sumnailImg1 = getThumbnailList(storeProdForSale, prodImageService, fileService);
		    	  List<FileVo> sumnailImg2 = getThumbnailList(storeProdReserved, prodImageService, fileService);
		    	  List<FileVo> sumnailImg3 = getThumbnailList(storeProdSoldOut, prodImageService, fileService);
		    	  List<FileVo> sumnailImg4 = getThumbnailList(storePurchaseList, prodImageService, fileService);
		    	  
		    	  req.setAttribute("sumnailImg1", sumnailImg1);
		    	  req.setAttribute("sumnailImg2", sumnailImg2);
		    	  req.setAttribute("sumnailImg3", sumnailImg3);
		    	  req.setAttribute("sumnailImg4", sumnailImg4);
		    	  req.setAttribute("storeProdForSale", storeProdForSale);
		    	  req.setAttribute("storeProdReserved", storeProdReserved);
		    	  req.setAttribute("storeProdSoldOut", storeProdSoldOut);
		    	  req.setAttribute("storePurchaseList", storePurchaseList);
		    	  
		    	  // 구매내역 리스트 나에게만 보이게
		    	  req.setAttribute("prodNo", prodNo);
		    	  
		    	  req.getRequestDispatcher("/WEB-INF/view/mystore/prodList.jsp").forward(req, resp);
		    	  break;
	    	  }
	    	  if(paramemNo != "") {		// 내상점 보기
	    		  int memNo = Integer.parseInt(paramemNo);
	    		  List<ProdVo> storeProdForSale = mystoreService.storeProdForSale(memNo);
		    	  List<ProdVo> storeProdReserved = mystoreService.storeProdReserved(memNo);
		    	  List<ProdVo> storeProdSoldOut = mystoreService.storeProdSoldOut(memNo);
		    	  List<ProdVo> storePurchaseList = mystoreService.storePurchaseList(memNo);
		    	  
		    	  List<FileVo> sumnailImg1 = getThumbnailList(storeProdForSale, prodImageService, fileService);
		    	  List<FileVo> sumnailImg2 = getThumbnailList(storeProdReserved, prodImageService, fileService);
		    	  List<FileVo> sumnailImg3 = getThumbnailList(storeProdSoldOut, prodImageService, fileService);
		    	  List<FileVo> sumnailImg4 = getThumbnailList(storePurchaseList, prodImageService, fileService);
		    	  
		    	  req.setAttribute("sumnailImg1", sumnailImg1);
		    	  req.setAttribute("sumnailImg2", sumnailImg2);
		    	  req.setAttribute("sumnailImg3", sumnailImg3);
		    	  req.setAttribute("sumnailImg4", sumnailImg4);
		    	  req.setAttribute("storeProdForSale", storeProdForSale);
		    	  req.setAttribute("storeProdReserved", storeProdReserved);
		    	  req.setAttribute("storeProdSoldOut", storeProdSoldOut);
		    	  req.setAttribute("storePurchaseList", storePurchaseList);
		    	  
		    	  // 구매내역 리스트 나에게만 보이게
		    	  req.setAttribute("memNo", memNo);
		    	  
		    	  req.getRequestDispatcher("/WEB-INF/view/mystore/prodList.jsp").forward(req, resp);
		    	  break;
	    	  }
	    	  
	        
	      case "review":
	    	  if(paraprodNo != "") {	// 상품 상세보기 -> 판매자 상점보기
	    		  int prodNo = Integer.parseInt(paraprodNo);
		    	  List<ReviewVo> storeReviewList = mystoreService.storeReviewList(prodNo);
		    	  
		    	  for(ReviewVo review : storeReviewList) {
		    		  String storeReviewProdTitle = mystoreService.storeReviewProdTitle(review.getProdNo());
		    		  review.setReviewProdTitle(storeReviewProdTitle);
		    		  String storeReviewBuyerNick = mystoreService.storeReviewBuyerNick(review.getMemNo());
		    		  review.setReviewMemberNick(storeReviewBuyerNick);
		    		  
		    	  }
		    	  System.out.println("paraprodNo     추가 후 storeReviewList : " + storeReviewList);
		    	  req.setAttribute("storeReviewList", storeReviewList);
		    	  
		    	  
		    	  req.getRequestDispatcher("/WEB-INF/view/mystore/reviewList.jsp").forward(req, resp);
		    	  break;
	    	  }
	    	  if(paramemNo != "") {		// 내상점 보기
	    		  int memNo = Integer.parseInt(paramemNo);
	    		  List<ReviewVo> storeReviewList = mystoreService.storeReviewList(memNo);
	    		  System.out.println("처음 storeReviewList : " + storeReviewList);
		    	  
		    	  for(ReviewVo review : storeReviewList) {
		    		  String storeReviewProdTitle = mystoreService.storeReviewProdTitle(review.getProdNo());
		    		  review.setReviewProdTitle(storeReviewProdTitle);
		    		  String storeReviewBuyerNick = mystoreService.storeReviewBuyerNick(review.getMemNo());
		    		  review.setReviewMemberNick(storeReviewBuyerNick);
		    		  
		    	  }
		    	  System.out.println("paramemNo      추가 후 storeReviewList : " + storeReviewList);
		    	  req.setAttribute("storeReviewList", storeReviewList);
		    	  
		    	  req.getRequestDispatcher("/WEB-INF/view/mystore/reviewList.jsp").forward(req, resp);
		    	  break;
	    	  }
	        
	      case "jjim":
	    	  int memNo = Integer.parseInt(paramemNo);
    		  System.out.println("memNo : ********" + memNo);
    		  List<ProdVo> storeJjimList = mystoreService.storeJjimList(memNo);
    		  System.out.println("storeJjimList : ****** " + storeJjimList);
	    	  
	    	  List<FileVo> sumnailImg = getThumbnailList(storeJjimList, prodImageService, fileService);
	    	  
	    	  req.setAttribute("sumnailImg", sumnailImg);
	    	  req.setAttribute("storeJjimList", storeJjimList);
	    	  req.getRequestDispatcher("/WEB-INF/view/mystore/jjimList.jsp").forward(req, resp);
	    	  break;
	        
	      default:
	        req.getRequestDispatcher("/WEB-INF/view/mystore/error.jsp");
	        break;
	    }
	    
		
	}
	
		//  썸네일 조회 메서드
		private List<FileVo> getThumbnailList(List<ProdVo> prodList, IProdImageService imageService, IFileService fileService) {
			List<FileVo> resultList = new ArrayList<>();
			
			for (ProdVo prod : prodList) {
				boolean found = false;

				List<ProdImageVo> imageList = imageService.getProdImagesByProdNo(prod.getProdNo());
				
				if (imageList != null && !imageList.isEmpty()) {
					FileVo fileVo = fileService.getFileByFileNo(imageList.get(0).getFileNo());
					
					if (fileVo != null) {
						String datePath = fileVo.getCreateDate().substring(0, 10).replace("-", "/");
						fileVo.setFilePath("/shared-files/prod/" + datePath + "/" + fileVo.getFileSave());
						resultList.add(fileVo);
						found = true;
					}
				}
				if (!found) {
					resultList.add(null); // 이미지 없는 경우
				}
			}
			return resultList;
		}

}
