package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
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
import kr.or.ddit.prod.dao.IProdImageDao;
import kr.or.ddit.prod.dao.ProdImageDaoImpl;
import kr.or.ddit.prod.service.IProdImageService;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdImageServiceImpl;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.type.ProdStatus;
import kr.or.ddit.prod.type.ProdType;
import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.util.FileUtil;

@WebServlet("/prod/insert.do")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1MB
    maxFileSize = 1024 * 1024 * 10,  // 10MB
    maxRequestSize = 1024 * 1024 * 30 // 30MB
)
public class ProdInsertController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// 카테고리 정보 가져와서 req에 저장
		ICateService cateService = CateServiceImpl.getInstance();
		List<CateVo> categoryList = cateService.selectAllCategories();
		req.setAttribute("categoryList", categoryList);
		
		// 지역(구) 정보를 가져와서 req에 저장
		IAreaService areaService = AreaServiceImpl.getInstance();
        List<AreaVo> districtList = areaService.selectAllDistricts();
        req.setAttribute("districtList", districtList);
        req.setAttribute("contentPage", "/WEB-INF/view/prod/prodInsertForm.jsp");
        
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	    try {
	        // 1. 폼 데이터 파싱
	        String memNo = req.getParameter("memNo"); 
	        String title = req.getParameter("prodTitle");
	        String content = req.getParameter("prodContent");
	        String cateNo = req.getParameter("cateNo");
	        String areaNo = req.getParameter("areaNo");
	        String price = req.getParameter("prodPrice");
	        String location = req.getParameter("prodLocation");
	        String status = req.getParameter("prodStatus");
	                
	        // 2. 상품 VO 객체 생성
	        ProdVo vo = new ProdVo();
	        vo.setMemNo(Integer.parseInt(memNo));
	        vo.setProdTitle(title);
	        vo.setProdContent(content);
	        vo.setCateNo(Integer.parseInt(cateNo));
	        vo.setAreaNo(Integer.parseInt(areaNo));
	        vo.setProdPrice(Integer.parseInt(price));
	        vo.setProdLocation(location);
	        vo.setProdType(ProdType.FOR_SALE); // 판매등록 시 무조건 판매 중
	        
	        if ("new".equals(status)) {
	            vo.setProdStatus(ProdStatus.NEW);
	        } else if ("almost".equals(status)) {
	            vo.setProdStatus(ProdStatus.ALMOST_NEW);
	        } else if ("slightly".equals(status)) {
	            vo.setProdStatus(ProdStatus.SLIGHTLY_USED);
	        } else if ("used".equals(status)) {
	            vo.setProdStatus(ProdStatus.USED);
	        }
	        
	        // 3. 이미지 파일 처리
	        String contextRealPath = req.getServletContext().getRealPath("/");
	        String uploadPath = FileUtil.getUploadPath(contextRealPath);
	        
	        List<FileVo> fileVoList = new ArrayList<>();
	        
	        for (Part part : req.getParts()) {
	            if (part.getName().equals("prodImage") && part.getSize() > 0) {
	                String fileName = FileUtil.getFileName(part);
	                if (fileName == null || fileName.isEmpty()) {
	                    continue;
	                }
	                
	                String saveFileName = FileUtil.getSaveFileName(fileName);
	                String fileType = FileUtil.getFileType(fileName);
	                
	                // 파일 저장
	                FileUtil.saveFile(part, uploadPath, saveFileName);
	                
	                FileVo fileVo = new FileVo();
	                fileVo.setFileOrg(fileName);
	                fileVo.setFileSave(saveFileName);
	                fileVo.setFileType(fileType);
	                
	                fileVoList.add(fileVo);
	            }
	        }
	        
	        // 최소 1개 이상의 이미지가 있는지 확인
	        if (fileVoList.isEmpty()) {
	            throw new IllegalArgumentException("최소 1개 이상의 상품 이미지가 필요합니다.");
	        }
	        
	        // 4. 서비스 계층에 위임하여 트랜잭션 처리
	        IProdService service = ProdServiceImpl.getInstance();
	        int result = ((ProdServiceImpl)service).registerProductWithImages(vo, fileVoList);
	        
	        // 5. 결과 처리
	        if (result > 0) {
	            resp.sendRedirect("/CarrotEasy/prod/list.do");
	        } else {
	            throw new Exception("상품 등록에 실패했습니다.");
	        }
	        
	    } catch (Exception e) {
	        e.printStackTrace();
	        // 에러 처리
	        req.setAttribute("errorMessage", "상품 등록 중 오류가 발생했습니다: " + e.getMessage());
	        ServletContext ctx = req.getServletContext();
	        ctx.getRequestDispatcher("/WEB-INF/view/error/error.jsp").forward(req, resp);
	    }
	}
}
