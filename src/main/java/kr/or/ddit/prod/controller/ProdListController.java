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
import kr.or.ddit.area.service.AreaServiceImpl;
import kr.or.ddit.area.service.IAreaService;
import kr.or.ddit.area.vo.AreaVo;
import kr.or.ddit.cate.service.CateServiceImpl;
import kr.or.ddit.cate.service.ICateService;
import kr.or.ddit.cate.vo.CateVo;
import kr.or.ddit.file.service.FileServiceImpl;
import kr.or.ddit.file.service.IFileService;
import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.prod.service.IProdImageService;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdImageServiceImpl;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.prod.vo.ProdVo;

@WebServlet("/prod/list.do")
public class ProdListController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. 필터링 파라미터 처리
            String cateNoParam = req.getParameter("cateNo");
            String areaNoParam = req.getParameter("areaNo");
            String parentCateNoParam = req.getParameter("parentCateNo");
            String districtNoParam = req.getParameter("districtNo");
            String keyword = req.getParameter("keyword");
            
            int cateNo = 0;
            int areaNo = 0;
            int parentCateNo = 0;
            int districtNo = 0;
            
            if (cateNoParam != null && !cateNoParam.isEmpty() && !"0".equals(cateNoParam)) {
                cateNo = Integer.parseInt(cateNoParam);
            }
            
            if (areaNoParam != null && !areaNoParam.isEmpty() && !"0".equals(areaNoParam)) {
                areaNo = Integer.parseInt(areaNoParam);
            }
            
            if (parentCateNoParam != null && !parentCateNoParam.isEmpty() && !"0".equals(parentCateNoParam)) {
                parentCateNo = Integer.parseInt(parentCateNoParam);
            }
            
            if (districtNoParam != null && !districtNoParam.isEmpty() && !"0".equals(districtNoParam)) {
                districtNo = Integer.parseInt(districtNoParam);
            }
            
            // 2. 서비스 객체 생성
            IProdService prodService = ProdServiceImpl.getInstance();
            IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
            IFileService fileService = FileServiceImpl.getInstance();
            ICateService cateService = CateServiceImpl.getInstance();
            IAreaService areaService = AreaServiceImpl.getInstance();
            
            // 3. 카테고리 및 지역 정보 조회 (필터링용)
            List<CateVo> categoryList = cateService.selectAllCategories(); // 모든 카테고리(상위)
            List<CateVo> subCategoryList = new ArrayList<>();
            
            if (parentCateNo > 0) {
                // 선택된 상위 카테고리에 속한 하위 카테고리 목록 조회
                subCategoryList = cateService.selectSubcategoriesByParent(parentCateNo);
            }
            
            List<AreaVo> districtList = areaService.selectAllDistricts(); // 모든 구
            List<AreaVo> dongList = new ArrayList<>();
            
            if (districtNo > 0) {
                // 선택된 구에 속한 동 목록 조회
                dongList = areaService.selectDongsByDistrict(districtNo);
            }
            
            // 4. 상품 목록 조회 (필터링 조건 적용)
            // 필터링 매개변수 결정
            int filterCateNo = cateNo > 0 ? cateNo : parentCateNo;
            int filterAreaNo = areaNo > 0 ? areaNo : districtNo;
            
            List<ProdVo> prodList = prodService.getProdListWithFilters(filterCateNo, filterAreaNo,keyword);
            
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
        	            System.out.println("File URL: " + fileVo.getFilePath());

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
            req.setAttribute("categoryList", categoryList); // 상위 카테고리
            req.setAttribute("subCategoryList", subCategoryList); // 하위 카테고리
            req.setAttribute("districtList", districtList); // 구 목록
            req.setAttribute("dongList", dongList); // 동 목록
            req.setAttribute("selectedCateNo", cateNo);
            req.setAttribute("selectedParentCateNo", parentCateNo);
            req.setAttribute("selectedAreaNo", areaNo);
            req.setAttribute("selectedDistrictNo", districtNo);
            req.setAttribute("keyword", keyword);
            
            // 7. JSP로 포워딩
            req.setAttribute("contentPage", "/WEB-INF/view/prod/prodList.jsp");
            ServletContext ctx = req.getServletContext();
            ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
            
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "상품 목록 조회 중 오류가 발생했습니다: " + e.getMessage());
            req.getServletContext().getRequestDispatcher("/WEB-INF/view/error/error.jsp").forward(req, resp);
        }
    }
}