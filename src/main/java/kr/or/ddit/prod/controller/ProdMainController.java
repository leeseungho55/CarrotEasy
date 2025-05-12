package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.adboard.vo.SwiperAdVo;
import kr.or.ddit.admember.vo.AdmemberVo;
import kr.or.ddit.file.service.FileServiceImpl;
import kr.or.ddit.file.service.IFileService;
import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.prod.service.IProdImageService;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdImageServiceImpl;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.prod.vo.ProdVo;
@WebServlet("/prodMain.do")
public class ProdMainController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession(false);
		MemberVo member = null;
		AdmemberVo admember = null;
		
		if(session != null) {
			member = (MemberVo) session.getAttribute("member");
			admember = (AdmemberVo) session.getAttribute("admember");
		}
		
		req.setAttribute("member", member);
		req.setAttribute("admember", admember);

		IProdService prodService = ProdServiceImpl.getInstance();
		IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
		IFileService fileService = FileServiceImpl.getInstance();
		
		List<ProdVo> prodRList = prodService.prodMainRecentlyList();  // 최신
		List<ProdVo> prodBList = prodService.prodMainBestList();      // 추천
		System.out.println("prodRList ==>"+prodRList);
		System.out.println("prodBList ==>"+prodBList);
		System.out.println("추천 상품 수: " + prodBList.size());
		System.out.println("최신 상품 수: " + prodRList.size());
	
		//  최신 상품 썸네일
		List<FileVo> latestThumbnailList = getThumbnailList(prodRList, prodImageService, fileService);
		System.out.println(latestThumbnailList);
	
		//  추천 상품 썸네일
		List<FileVo> recommendThumbnailList = getThumbnailList(prodBList, prodImageService, fileService);
		System.out.println(recommendThumbnailList);
	
		//광고vo로 정보 받기
		IAdboardService iAdseService = AdboardServiceImpl.getInstance();
		List<SwiperAdVo> adVo = iAdseService.getAdForSwiper();
		req.setAttribute("adBanner", adVo);
		
		// JSP로 전달
		req.setAttribute("recommendList", prodBList); 
		req.setAttribute("latestList", prodRList);    
		req.setAttribute("latestThumbnailList", latestThumbnailList);
		req.setAttribute("recommendThumbnailList", recommendThumbnailList);
		
		req.setAttribute("contentPage", "/WEB-INF/view/main/contentMain.jsp");	
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
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
