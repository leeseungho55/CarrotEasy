package kr.or.ddit.adboard.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.util.AdboardFileUtil;

@WebServlet("/adboard/update.do")
@MultipartConfig
public class AdboardUpdateController extends HttpServlet {
    // 공유 폴더 경로 (adboard 폴더로 변경)
    private static final String SHARED_FOLDER_PATH = "\\\\192.168.145.21\\carrot\\adboard";
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int adNo = Integer.parseInt(req.getParameter("adNo"));
        String adTitle = req.getParameter("adTitle");
        String adContent = req.getParameter("adContent");
        String adUrl = req.getParameter("adUrl") != null ? req.getParameter("adUrl") : "";
        String oldAdImg = req.getParameter("oldAdImg");
        String fileUrl = null;
        
        // 파일 처리
        Part filePart = req.getPart("adFile");
        boolean hasNewFile = filePart != null && filePart.getSize() > 0;
        
        // 기존 파일 삭제 로직 수정 - 삭제할 것인지 확인
        boolean deleteOldFile = false;
        
        // 새 파일이 선택되었거나 기존 파일이 없는 경우 (oldAdImg가 비어있는 경우)
        if (hasNewFile || oldAdImg == null || oldAdImg.isEmpty()) {
            deleteOldFile = true;
        }
        
        // 새 파일 처리
        if (hasNewFile) {
            // FileUtil 클래스를 사용하여 파일 업로드 처리
            String contextPath = req.getServletContext().getRealPath("/");
            String uploadPath = AdboardFileUtil.getUploadPath(contextPath);
            
            // 원본 파일명 가져오기
            String originalFileName = AdboardFileUtil.getFileName(filePart);
            
            // 저장할 파일명 생성 (UUID 포함)
            String saveFileName = AdboardFileUtil.getSaveFileName(originalFileName);
            
            // 파일 저장
            AdboardFileUtil.saveFile(filePart, uploadPath, saveFileName);
            
            // 현재 날짜 기반 경로 가져오기 (YYYY/MM/DD)
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            String datePath = sdf.format(new Date());
            
            // 웹 경로 설정 - 공유 폴더의 상대적 URL 경로로 설정
            fileUrl = req.getContextPath() + "/uploads/adboard/" + datePath + "/" + saveFileName;
        }
        
        // 만약 기존 파일을 삭제해야 하고, 기존 파일 정보가 존재한다면
        if (deleteOldFile && oldAdImg != null && !oldAdImg.isEmpty()) {
            try {
                // 기존 파일 경로 분석 - 형식: /context/uploads/adboard/[날짜경로]/filename
                String relativePath = oldAdImg.substring(oldAdImg.indexOf("/uploads/adboard/") + 16); // 16 = "/uploads/adboard/".length()
                
                // 공유 폴더 내 경로 구성
                String oldFilePath = SHARED_FOLDER_PATH + File.separator + relativePath;
                File oldFile = new File(oldFilePath);
                
                if (oldFile.exists()) {
                    oldFile.delete();
                }
            } catch (Exception e) {
                e.printStackTrace();
                // 파일 삭제 실패해도 계속 진행
            }
        }
        
        AdboardVo vo = new AdboardVo();
        vo.setAdNo(adNo);
        vo.setAdTitle(adTitle);
        vo.setAdContent(adContent);
        vo.setAdUrl(adUrl);
        
        // 파일 URL 설정
        if (fileUrl != null) {
            // 새 파일이 있는 경우
            vo.setAdImg(fileUrl);
        } else if (oldAdImg != null && !oldAdImg.isEmpty() && !deleteOldFile) {
            // 기존 파일을 유지하는 경우
            vo.setAdImg(oldAdImg);
        } else {
            // 파일이 없는 경우
            vo.setAdImg(null);
        }
        
        IAdboardService service = AdboardServiceImpl.getInstance();
        int result = service.adboardUpdate(vo);
        resp.setContentType("application/json;charset=UTF-8");
        
        if (result > 0) {
            StringBuilder json = new StringBuilder("{\"success\": true");
            json.append(", \"title\": \"").append(adTitle).append("\"");
            json.append(", \"content\": \"").append(adContent.replace("\"", "\\\"")).append("\"");
            
            // 이미지 URL 응답
            if (vo.getAdImg() != null) {
                json.append(", \"adImg\": \"").append(vo.getAdImg()).append("\"");
            } else {
                json.append(", \"adImg\": null");
            }
            
            // URL 응답 처리
            if (adUrl != null && !adUrl.isEmpty()) {
                json.append(", \"adUrl\": \"").append(adUrl).append("\"");
            } else {
                json.append(", \"adUrl\": null");
            }
            
            json.append("}");
            resp.getWriter().write(json.toString());
        } else {
            resp.getWriter().write("{\"success\": false, \"message\": \"게시글 수정 실패\"}");
        }
    }
}