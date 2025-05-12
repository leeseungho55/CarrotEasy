package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.delivery.service.DeliveryService;
import kr.or.ddit.file.service.FileServiceImpl;
import kr.or.ddit.file.service.IFileService;
import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.prod.service.IJJimService;
import kr.or.ddit.prod.service.IProdImageService;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.JJimService;
import kr.or.ddit.prod.service.ProdImageServiceImpl;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.type.ProdType;
import kr.or.ddit.prod.vo.JJimVo;
import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.review.service.IReviewService;
import kr.or.ddit.review.service.ReviewServiceImpl;
import kr.or.ddit.review.vo.HasReviewVo;

@WebServlet("/prod/view.do")
public class ProdViewController extends HttpServlet {
    
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    try {
	        // 1. 상품 번호 파라미터 받기
	        String prodNoParam = req.getParameter("prodNo");
	        
	        if (prodNoParam == null || prodNoParam.isEmpty()) {
	            throw new IllegalArgumentException("상품 번호가 필요합니다.");
	        }
	        
	        int prodNo = Integer.parseInt(prodNoParam);
	        
	        // 2. 서비스 객체 생성
	        IProdService prodService = ProdServiceImpl.getInstance();
	        IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
	        IFileService fileService = FileServiceImpl.getInstance();
	        DeliveryService deliveryService = DeliveryService.getInstance();
	        IReviewService reviewService = ReviewServiceImpl.getInstance(); // 리뷰서비스
	        
	        // 3. 상품 정보 조회
	        ProdVo prodVo = prodService.getProdByNo(prodNo);
	        
	        if (prodVo == null) {
	            throw new IllegalArgumentException("존재하지 않는 상품입니다.");
	        }
	        
	        // 4. 상품 이미지 정보 조회
	        List<ProdImageVo> prodImageList = prodImageService.getProdImagesByProdNo(prodNo);
	        List<FileVo> fileList = fileService.getFilesByFileNos(prodImageList);
	        
	        // 5. 각 파일마다 웹 접근 경로 설정
	        for (FileVo file : fileList) {
	            // DB에서 가져온 날짜 문자열을 경로 형식으로 변환
	            String datePath = file.getCreateDate().substring(0, 10).replace("-", "/");
	            
	            // 공유 폴더에 매핑된 가상 경로 사용
	            file.setFilePath("/shared-files/prod/" + datePath + "/" + file.getFileSave());
	            System.out.println("File URL: " + file.getFilePath());
	        }
	        
	        if (prodVo.getProdType() != ProdType.SOLD_OUT) {
	        	// delivery 테이블에 prodNo 의 정보가 있는지 확인해서 있다면, deliveryInfo 값을 전달해줘야함
	        	String deliveryOrderId = deliveryService.getDeliId(prodNo);
	        	if(deliveryOrderId != "") req.setAttribute("deliveryInfo", deliveryOrderId);
	        }
	        
	        // 6.상품 거래상태 및 리뷰 작성 여부 파악
	        HasReviewVo hvo = new HasReviewVo();
	        int isPurchase = reviewService.isPurchase(prodNo);
	        if(isPurchase != 0) {
		        hvo.setMemNo(isPurchase);
		        hvo.setProdNo(prodNo);
		        boolean hasReview = reviewService.hasReview(hvo);
			    req.setAttribute("isPurchase", isPurchase); // 상품 구매한 memNo
		        req.setAttribute("hasReview", hasReview); // 리뷰 했는지 여부
	        }else {
	        	System.out.println("값이 없는데용?!");
	        }
	        
	        
	        // 7. 요청 속성에 정보 설정
	        req.setAttribute("prod", prodVo);
	        req.setAttribute("fileList", fileList);
	        
	        // 8. 상품 페이지 찜 등록 여부
	        HttpSession session = req.getSession();
            MemberVo member = (MemberVo) session.getAttribute("member");

	        IJJimService service = JJimService.getInstance();
            if(member != null) {
                int memNo = 0; 
                memNo = member.getMemNo();
    	        JJimVo jvo = new JJimVo();
    	        jvo.setMemNo(memNo);
    	        jvo.setProdNo(prodNo);
    	        System.out.println("memNo"+memNo);
    	        System.out.println("prodNo"+prodNo);
    	        boolean jjimCheck = service.checkJJim(jvo);
    	        req.setAttribute("jjimCheck", jjimCheck);
            }
            
	        int jjimCount = service.getJJimCount(prodNo);
	        req.setAttribute("jjimCount", jjimCount);
	        
	        // 8. JSP로 포워딩
            req.setAttribute("contentPage", "/WEB-INF/view/prod/prodView.jsp");
	        ServletContext ctx = req.getServletContext();
	        ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
	        
	    } catch (NumberFormatException e) {
	        req.setAttribute("errorMessage", "잘못된 상품 번호 형식입니다.");
	        req.getServletContext().getRequestDispatcher("/WEB-INF/view/error/error.jsp").forward(req, resp);
	    } catch (Exception e) {
	        e.printStackTrace();
	        req.setAttribute("errorMessage", "상품 조회 중 오류가 발생했습니다: " + e.getMessage());
	        req.getServletContext().getRequestDispatcher("/WEB-INF/view/error/error.jsp").forward(req, resp);
	    }
	}
}
