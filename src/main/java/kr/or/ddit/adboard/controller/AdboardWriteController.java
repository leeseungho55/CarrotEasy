package kr.or.ddit.adboard.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import org.mindrot.bcrypt.BCrypt;

import jakarta.servlet.ServletContext;
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

@WebServlet("/adboard/write.do")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024)
public class AdboardWriteController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/adboard/boardInsertForm.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String adTitle = req.getParameter("title");
		String adContent = req.getParameter("content");
		int amemNo = Integer.parseInt(req.getParameter("amemNo"));
		String adPass = req.getParameter("password");
		String adUrl = "";
        if(req.getParameter("adUrl") != null) {
        	adUrl = req.getParameter("adUrl");
        }
		
		AdboardVo vo = new AdboardVo();
		vo.setAdTitle(adTitle);
		vo.setAdContent(adContent);
		vo.setAmemNo(amemNo);
		vo.setAdUrl(adUrl);
		
		String plainPass = adPass;
		if (plainPass != null && !plainPass.isEmpty()) {
		    String hashedPass = BCrypt.hashpw(plainPass, BCrypt.gensalt());
		    vo.setAdPass(hashedPass);
		}
		
		// 파일 업로드 처리
        Part filePart = req.getPart("adFile");
        String webPath = "";
        
        if (filePart != null && filePart.getSize() > 0) {
            // FileUtil 클래스를 사용하여 파일 업로드 처리
            String contextPath = req.getServletContext().getRealPath("/");
            String uploadPath = AdboardFileUtil.getUploadPath(contextPath);
            
            // 원본 파일명 가져오기
            String originalFileName = AdboardFileUtil.getFileName(filePart);
            
            // 저장할 파일명 생성 (UUID 포함)
            String saveFileName = AdboardFileUtil.getSaveFileName(originalFileName);
            
            // 파일 확장자 가져오기
            String fileType = AdboardFileUtil.getFileType(originalFileName);
            
            // 파일 저장
            AdboardFileUtil.saveFile(filePart, uploadPath, saveFileName);
            
            // 현재 날짜 기반 경로 가져오기 (YYYY/MM/DD)
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            String datePath = sdf.format(new Date());
            
            // 웹 경로 설정 - 공유 폴더의 상대적 URL 경로로 설정
            // adboard 폴더에 저장하도록 경로 수정
            webPath = req.getContextPath() + "/uploads/adboard/" + datePath + "/" + saveFileName;
        }
        
        vo.setAdImg(webPath);
		
		IAdboardService service = AdboardServiceImpl.getInstance();
		int res = service.adboardWrite(vo);
		
		resp.sendRedirect("/CarrotEasy/adboard/list.do");
	}
}