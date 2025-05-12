package kr.or.ddit.util;

import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import jakarta.servlet.http.Part;

public class FileUtil {
//     private static final String UPLOAD_DIR = "/upload/prod";
	// 공유 폴더
    private static final String SHARED_FOLDER_PATH = "\\\\192.168.145.21\\carrot\\prod";
    // 실제 저장 위치
    // [workspace경로]/.metadata/.plugins/org.eclipse.wst.server.core/tmp0/wtpwebapps/[프로젝트명]/upload
    
    public static String getUploadPath(String contextPath) {
    	try {
    		// 현재 날짜 기반의 디렉토리 구조 생성 (YYYY/MM/DD)
	        SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
	        String datePath = sdf.format(new Date());
	        
	        // String uploadPath = contextPath + File.separator + UPLOAD_DIR + 
	        //        File.separator + datePath;
            String uploadPath = SHARED_FOLDER_PATH + File.separator + datePath;
	        
	        // 경로 출력
			System.out.println("uploadPath : " + uploadPath);
	        
	        File uploadDir = new File(uploadPath);
	        if (!uploadDir.exists()) {
	            uploadDir.mkdirs();
	        }
	        
	        return uploadPath;
        } catch (Exception e) {
        	e.printStackTrace();
        	return null;
        }
    }
    
    public static String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        
        for (String item : items) {
            if (item.trim().startsWith("filename")) {
                return item.substring(item.indexOf("=") + 2, item.length() - 1);
            }
        }
        return "";
    }
    
    public static String getSaveFileName(String fileName) {
        if (fileName == null || fileName.isEmpty()) {
            return null;
        }
        
        String uuid = UUID.randomUUID().toString();
        return uuid + "_" + fileName;
    }
    
    public static String getFileType(String fileName) {
        if (fileName == null || fileName.isEmpty() || !fileName.contains(".")) {
            return "";
        }
        
        return fileName.substring(fileName.lastIndexOf(".") + 1);
    }
    
    public static void saveFile(Part part, String savePath, String saveFileName) throws IOException {
        part.write(savePath + File.separator + saveFileName);
    }

}
