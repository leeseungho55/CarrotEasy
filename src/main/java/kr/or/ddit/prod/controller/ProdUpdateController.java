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
import kr.or.ddit.prod.service.IProdImageService;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdImageServiceImpl;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.type.ProdStatus;
import kr.or.ddit.prod.type.ProdType;
import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.util.FileUtil;

@WebServlet("/prod/update.do")
@MultipartConfig(
	    fileSizeThreshold = 1024 * 1024, // 1MB
	    maxFileSize = 1024 * 1024 * 10,  // 10MB
	    maxRequestSize = 1024 * 1024 * 30 // 30MB
	)
public class ProdUpdateController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 제품 번호 가져오기
        String prodNoStr = req.getParameter("prodNo");
        if (prodNoStr == null || prodNoStr.isEmpty()) {
            resp.sendRedirect("/CarrotEasy/prod/list.do");
            return;
        }
        
        try {
            int prodNo = Integer.parseInt(prodNoStr);
            
            // 로그인 확인
            HttpSession session = req.getSession();
            MemberVo member = (MemberVo) session.getAttribute("member");
            if (member == null) {
                resp.sendRedirect("/CarrotEasy/login.do");
                return;
            }
            
            // 제품 정보 가져오기
            IProdService prodService = ProdServiceImpl.getInstance();
            ProdVo prodVo = prodService.getProdByNo(prodNo);
            
            // 제품이 존재하는지 확인
            if (prodVo == null) {
                resp.sendRedirect("/CarrotEasy/prod/list.do");
                return;
            }
            
            // 현재 로그인한 사용자가 제품 소유자인지 확인
            if (prodVo.getMemNo() != member.getMemNo()) {
                resp.sendRedirect("/CarrotEasy/prod/list.do");
                return;
            }
            
            // 제품 이미지 정보 가져오기
            IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
	        IFileService fileService = FileServiceImpl.getInstance();
            List<ProdImageVo> prodImageList = prodImageService.getProdImagesByProdNo(prodNo);
	        List<FileVo> fileList = fileService.getFilesByFileNos(prodImageList);
	        
	        // 5. 각 파일마다 웹 접근 경로 설정
	        for (FileVo file : fileList) {
	            // DB에서 가져온 날짜 문자열을 경로 형식으로 변환
	            String datePath = file.getCreateDate().substring(0, 10).replace("-", "/");
	            // 상대 경로 설정 (webapp 폴더 기준)
	            file.setFilePath("/shared-files/prod/" + datePath + "/" + file.getFileSave());
	        }
            
            // 카테고리 정보 가져와서 req에 저장
            ICateService cateService = CateServiceImpl.getInstance();
            List<CateVo> categoryList = cateService.selectAllCategories();
            
            // 현재 제품의 카테고리 정보 조회
            CateVo currentCategory = cateService.selectCategoryByCateNo(prodVo.getCateNo());
            int parentCateNo = 0;
            if (currentCategory != null && currentCategory.getCateParentNo() != 0) {
                parentCateNo = currentCategory.getCateParentNo();
            }
            
            // 현재 제품의 하위 카테고리 목록 조회
            List<CateVo> subCategoryList = cateService.selectSubcategoriesByParent(parentCateNo);
            
            // 지역(구) 정보를 가져와서 req에 저장
            IAreaService areaService = AreaServiceImpl.getInstance();
            List<AreaVo> districtList = areaService.selectAllDistricts();
            
            // 현재 제품의 지역 정보 조회
            AreaVo currentArea = areaService.selectAreaByAreaNo(prodVo.getAreaNo());
            int districtNo = 0;
            if (currentArea != null && currentArea.getAreaParentNo() != 0) {
                districtNo = currentArea.getAreaParentNo();
            }
            
            // 현재 제품의 동 목록 조회
            List<AreaVo> dongList = areaService.selectDongsByDistrict(districtNo);
            
            // 필요한 데이터를 request에 저장
            req.setAttribute("prodVo", prodVo);
            req.setAttribute("fileList", fileList);
            req.setAttribute("categoryList", categoryList);
            req.setAttribute("subCategoryList", subCategoryList);
            req.setAttribute("parentCateNo", parentCateNo);
            req.setAttribute("districtList", districtList);
            req.setAttribute("dongList", dongList);
            req.setAttribute("districtNo", districtNo);
            
            // 수정 폼 페이지로 포워딩
            req.setAttribute("contentPage", "/WEB-INF/view/prod/prodUpdateForm.jsp");
            ServletContext ctx = req.getServletContext();
            ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
            
        } catch (NumberFormatException e) {
            resp.sendRedirect("/CarrotEasy/prod/list.do");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "상품 정보를 불러오는 중 오류가 발생했습니다: " + e.getMessage());
            ServletContext ctx = req.getServletContext();
            ctx.getRequestDispatcher("/WEB-INF/view/error/error.jsp").forward(req, resp);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. 폼 데이터 파싱
            String prodNoStr = req.getParameter("prodNo");
            String memNo = req.getParameter("memNo");
            String title = req.getParameter("prodTitle");
            String content = req.getParameter("prodContent");
            String cateNo = req.getParameter("cateNo");
            String areaNo = req.getParameter("areaNo");
            String price = req.getParameter("prodPrice");
            String location = req.getParameter("prodLocation");
            String status = req.getParameter("prodStatus");
            
            // 기존 이미지 처리를 위한 파라미터
            String[] keepImageNos = req.getParameterValues("keepImageNo");
            
            // 로그인 확인 및 권한 검증
            HttpSession session = req.getSession();
            MemberVo member = (MemberVo) session.getAttribute("member");
            if (member == null || Integer.parseInt(memNo) != member.getMemNo()) {
                resp.sendRedirect("/CarrotEasy/login.do");
                return;
            }
            
            // 2. 상품 VO 객체 생성
            ProdVo vo = new ProdVo();
            vo.setProdNo(Integer.parseInt(prodNoStr));
            vo.setMemNo(Integer.parseInt(memNo));
            vo.setProdTitle(title);
            vo.setProdContent(content);
            vo.setCateNo(Integer.parseInt(cateNo));
            vo.setAreaNo(Integer.parseInt(areaNo));
            vo.setProdPrice(Integer.parseInt(price));
            vo.setProdLocation(location);
            vo.setProdType(ProdType.FOR_SALE); // 업데이트 시에도 판매 중 상태 유지
            
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
            
            // 4. 서비스 계층에 위임하여 트랜잭션 처리
            IProdService service = ProdServiceImpl.getInstance();
            
            // 유지할 이미지 번호 배열 처리
            List<Integer> keepImageNoList = new ArrayList<>();
            if (keepImageNos != null) {
                for (String imageNoStr : keepImageNos) {
                    keepImageNoList.add(Integer.parseInt(imageNoStr));
                }
            }
            
            // 상품과 이미지 업데이트 - 트랜잭션으로 처리해야 함
            int result = ((ProdServiceImpl)service).updateProductWithImages(vo, fileVoList, keepImageNoList);
            
            // 5. 결과 처리
            if (result > 0) {
                resp.sendRedirect("/CarrotEasy/prod/view.do?prodNo=" + prodNoStr);
            } else {
                throw new Exception("상품 수정에 실패했습니다.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // 에러 처리
            req.setAttribute("errorMessage", "상품 수정 중 오류가 발생했습니다: " + e.getMessage());
            ServletContext ctx = req.getServletContext();
            ctx.getRequestDispatcher("/WEB-INF/view/error/error.jsp").forward(req, resp);
        }
    }
}