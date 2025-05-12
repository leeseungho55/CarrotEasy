package kr.or.ddit.member.controller;

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
import kr.or.ddit.admember.vo.AdmemberVo; 
import kr.or.ddit.area.service.AreaServiceImpl;
import kr.or.ddit.area.service.IAreaService;
import kr.or.ddit.area.vo.AreaVo;
import kr.or.ddit.cate.service.CateServiceImpl;
import kr.or.ddit.cate.service.ICateService;
import kr.or.ddit.cate.vo.CateVo;
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

@WebServlet("/main/main.do")
public class MainController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 세션에서 로그인 여부 확인
		HttpSession session = req.getSession(false);	// false는 세션 없으면 null 반환
		System.out.println("session : " + session);
		
		MemberVo member = null;
		AdmemberVo admember = null;
		if(session != null) {
			member = (MemberVo) session.getAttribute("member");
			admember = (AdmemberVo) session.getAttribute("admember");
		}
		
		req.setAttribute("member", member);
		req.setAttribute("admember", admember);
		
		// 메인 페이지에서 중고물품 리스트 보여주기
        // 서비스 객체 생성
        IProdService prodService = ProdServiceImpl.getInstance();
        IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
        IFileService fileService = FileServiceImpl.getInstance();
        
        List<ProdVo> prodList = prodService.prodList();
        
        // 5. 각 상품의 대표 이미지 조회
        List<FileVo> thumbnailList = new ArrayList<>();
        
        for (ProdVo prod : prodList) {
            boolean imageAdded = false;
            // 각 상품의 첫 번째 이미지만 가져옴
            List<ProdImageVo> prodImageList = prodImageService.getProdImagesByProdNo(prod.getProdNo());
            
            if (prodImageList != null && !prodImageList.isEmpty()) {
                FileVo fileVo = fileService.getFileByFileNo(prodImageList.get(0).getFileNo());
                
                if (fileVo != null) {
                    // 파일 경로 설정
                    String datePath = fileVo.getCreateDate().substring(0, 10).replace("-", "/");
    	            fileVo.setFilePath("/shared-files/prod/" + datePath + "/" + fileVo.getFileSave());
                    thumbnailList.add(fileVo);
                    imageAdded = true;
                }
            }
            
            if (!imageAdded) {
                thumbnailList.add(null); // 이미지가 없는 경우 null 추가
            }
        }
        
        // 6. 요청 속성에 정보 설정
        req.setAttribute("prodList", prodList);
        req.setAttribute("thumbnailList", thumbnailList);
		
		req.setAttribute("contentPage", "/WEB-INF/view/main/content.jsp");
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
		
	}
	
}
