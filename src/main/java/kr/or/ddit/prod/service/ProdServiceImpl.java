package kr.or.ddit.prod.service;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.area.service.AreaServiceImpl;
import kr.or.ddit.area.service.IAreaService;
import kr.or.ddit.area.vo.AreaVo;
import kr.or.ddit.cate.service.CateServiceImpl;
import kr.or.ddit.cate.service.ICateService;
import kr.or.ddit.cate.vo.CateVo;
import kr.or.ddit.file.service.FileServiceImpl;
import kr.or.ddit.file.service.IFileService;
import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.prod.dao.IProdDao;
import kr.or.ddit.prod.dao.ProdDaoImpl;
import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.util.MybatisUtil;

public class ProdServiceImpl implements IProdService {
    private static ProdServiceImpl instance;
    
    private ProdServiceImpl() {
    }
    
    public static ProdServiceImpl getInstance() {
        if (instance == null) {
            instance = new ProdServiceImpl();
        }
        return instance;
    }
    
    IProdDao dao = ProdDaoImpl.getInstance();
    
    @Override
    public List<ProdVo> prodList() {
        return dao.prodList();
    }

    @Override
    public ProdVo getProdByNo(int prodNo) {
    	// 상세보기 화면에 들어갈 때 조회수 올려주기
    	dao.prodCntUpdate(prodNo);
        return dao.getProdByNo(prodNo);
    }
    
    @Override
    public int prodInsert(ProdVo vo) {
        return dao.prodInsert(vo);
    }
    
    @Override
    public int prodUpdate(ProdVo vo) {
        return dao.prodUpdate(vo);
    }
    
    @Override
    public int prodDelete(int prodNo) {
        return dao.prodDelete(prodNo);
    }
    
    @Override
    public int registerProductWithImages(ProdVo prodVo, List<FileVo> fileVoList) {
        SqlSession session = null;
        int result = 0;
        
        try {
            // SqlSession 생성 (autoCommit = false)
            session = MybatisUtil.getInstance(false);
            
            // 1. 상품 정보 저장
            int prodNo = dao.prodInsert(prodVo, session);
            if (prodNo <= 0) {
                throw new SQLException("상품 정보 저장 실패");
            }
            
            // 2. 파일 정보 저장 및 상품 이미지 매핑
            IFileService fileService = FileServiceImpl.getInstance();
            IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
            
            for (FileVo fileVo : fileVoList) {
                // 파일 정보 저장
                int fileResult = fileService.fileInsert(fileVo, session);
                if (fileResult <= 0) {
                    throw new SQLException("파일 정보 저장 실패");
                }
                
                // 파일 번호 조회
                int fileNo = fileService.getLastFileNo(session);
                
                // 상품 이미지 매핑 정보 저장
                ProdImageVo prodImageVo = new ProdImageVo();
                prodImageVo.setProdNo(prodNo);
                prodImageVo.setFileNo(fileNo);
                
                int imageResult = prodImageService.prodImageInsert(prodImageVo, session);
                if (imageResult <= 0) {
                    throw new SQLException("상품 이미지 매핑 정보 저장 실패");
                }
            }
            
            // 모든 작업 성공 시 커밋
            session.commit();
            result = prodNo;
            
        } catch (Exception e) {
            e.printStackTrace();
            // 오류 발생 시 롤백
            if (session != null) {
                session.rollback();
            }
        } finally {
            // 세션 종료
            if (session != null) {
                session.close();
            }
        }
        
        return result;
    }

    public int updateProductWithImages(ProdVo prodVo, List<FileVo> fileVoList, List<Integer> keepImageNoList) {
        SqlSession session = null;
        int result = 0;

        try {
            // Create SqlSession with autoCommit = false to manage transaction
            session = MybatisUtil.getInstance(false);

            // 1. Update product information
            int updateResult = dao.prodUpdate(prodVo, session);
            if (updateResult <= 0) {
                throw new SQLException("상품 정보 업데이트 실패");
            }

            // 2. Delete images that are not in keepImageNoList
            IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
            List<ProdImageVo> existingImages = prodImageService.getProdImagesByProdNo(prodVo.getProdNo(), session);
            
            for (ProdImageVo image : existingImages) {
                // If this image is not in the keep list, delete it
                if (!keepImageNoList.contains(image.getFileNo())) {
                    try {
	                    // Delete the mapping first
	                    int deleteImageResult = prodImageService.prodImageDelete(image.getFileNo(), session);
	                    if (deleteImageResult <= 0) {
	                        throw new SQLException("상품 이미지 매핑 정보 삭제 실패");
	                    }
	                    
	                    // Delete the file entry (and physical file if needed)
	                    IFileService fileService = FileServiceImpl.getInstance();
	                    int deleteFileResult = fileService.fileDelete(image.getFileNo(), session);
	                    if (deleteFileResult <= 0) {
	                        throw new SQLException("파일 정보 삭제 실패");
	                    }
                    } catch (SQLException e) {
                    	e.printStackTrace();
                    }
                }
            }

            // 3. Add new files and image mappings
            if (fileVoList != null && !fileVoList.isEmpty()) {
                IFileService fileService = FileServiceImpl.getInstance();
                
                for (FileVo fileVo : fileVoList) {
                	try {
		                // Save file information
		                int fileResult = fileService.fileInsert(fileVo, session);
		                if (fileResult <= 0) {
		                    throw new SQLException("파일 정보 저장 실패");
		                }
		                
		                // Get the latest file number
		                int fileNo = fileService.getLastFileNo(session);
		                
		                // Save product-image mapping
		                ProdImageVo prodImageVo = new ProdImageVo();
		                prodImageVo.setProdNo(prodVo.getProdNo());
		                prodImageVo.setFileNo(fileNo);
		                
		                int imageResult = prodImageService.prodImageInsert(prodImageVo, session);
		                if (imageResult <= 0) {
		                    throw new SQLException("상품 이미지 매핑 정보 저장 실패");
		                }
	                } catch (SQLException e) {
	                	e.printStackTrace();
					}
                }
            }
            
            // All operations successful, commit transaction
            session.commit();
            result = prodVo.getProdNo();
            
        } catch (Exception e) {
            e.printStackTrace();
            // Rollback on error
            if (session != null) {
                session.rollback();
            }
        } finally {
            // Close session
            if (session != null) {
                session.close();
            }
        }
        
        return result;
    }

    @Override
    public List<ProdVo> getProdListWithFilters(int cateNo, int areaNo, String keyword) { 
        List<Integer> cateNoList = new ArrayList<>();
        List<Integer> areaNoList = new ArrayList<>();
        
        // 카테고리 필터링 로직
        if (cateNo > 0) {
            try {
                ICateService cateService = CateServiceImpl.getInstance();
                CateVo category = cateService.selectCategoryByCateNo(cateNo);
                
                if (category != null) {
                    Integer parentCateNo = category.getCateParentNo();
                    
                    // 선택한 카테고리가 상위 카테고리인 경우 (parentCateNo가 null 또는 0)
                    if (parentCateNo == null || parentCateNo == 0) {
                        // 해당 상위 카테고리에 속한 모든 하위 카테고리 조회
                        List<CateVo> subCategories = cateService.selectSubcategoriesByParent(cateNo);
                        if (subCategories != null) {
                            for (CateVo subCate : subCategories) {
                                cateNoList.add(subCate.getCateNo());
                            }
                        } else {
                            // 하위 카테고리가 없는 경우 현재 카테고리만 추가
                            cateNoList.add(cateNo);
                        }
                    } else {
                        // 선택한 카테고리가 하위 카테고리인 경우, 해당 카테고리만 추가
                        cateNoList.add(cateNo);
                    }
                } else {
                    // 카테고리 정보가 없는 경우 선택한 카테고리 번호 사용
                    cateNoList.add(cateNo);
                }
            } catch (Exception e) {
                e.printStackTrace();
                if (cateNo > 0) {
                    cateNoList.add(cateNo);
                }
            }
        }
        
        // 지역 필터링 로직
        if (areaNo > 0) {
            try {
                IAreaService areaService = AreaServiceImpl.getInstance();
                AreaVo area = areaService.selectAreaByAreaNo(areaNo);
                
                if (area != null) {
                    Integer parentAreaNo = area.getAreaParentNo();
                    
                    // 선택한 지역이 구인 경우 (parentAreaNo가 null 또는 0)
                    if (parentAreaNo == null || parentAreaNo == 0) {
                        // 해당 구에 속한 모든 동 조회
                        List<AreaVo> dongs = areaService.selectDongsByDistrict(areaNo);
                        if (dongs != null) {
                            for (AreaVo dong : dongs) {
                                areaNoList.add(dong.getAreaNo());
                            }
                        } else {
                            // 동이 없는 경우 현재 지역만 추가
                            areaNoList.add(areaNo);
                        }
                    } else {
                        // 선택한 지역이 동인 경우, 해당 동만 추가
                        areaNoList.add(areaNo);
                    }
                } else {
                    // 지역 정보가 없는 경우 선택한 지역 번호 사용
                    areaNoList.add(areaNo);
                }
            } catch (Exception e) {
                e.printStackTrace();
                if (areaNo > 0) {
                    areaNoList.add(areaNo);
                }
            }
        }
        
        // 리스트가 비어있는 경우 원래 값 추가
        if (cateNoList.isEmpty() && cateNo > 0) {
            cateNoList.add(cateNo);
        }
        
        if (areaNoList.isEmpty() && areaNo > 0) {
            areaNoList.add(areaNo);
        }
        
        return dao.getProdListWithFilters(cateNoList, areaNoList, keyword); 
    }

	@Override
	public int deleteProd(int prodNo, SqlSession session) {
		return dao.prodDelete(prodNo, session);
	}

	@Override
	public List<ProdVo> prodMainRecentlyList() {
		// TODO Auto-generated method stub
		return dao.prodMainRecentlyList();
	}

	@Override
	public List<ProdVo> prodMainBestList() {
		// TODO Auto-generated method stub
		return dao.prodMainBestList();
	}
}