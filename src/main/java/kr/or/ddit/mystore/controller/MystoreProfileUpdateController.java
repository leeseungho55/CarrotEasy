package kr.or.ddit.mystore.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.mystore.service.IMystoreService;
import kr.or.ddit.mystore.service.MystoreServiceImpl;
import kr.or.ddit.mystore.vo.ProfileVo;
import kr.or.ddit.util.AdboardFileUtil;
import kr.or.ddit.util.MystoreFileUtil;

@WebServlet("/mystore/profileUpdate.do")
@MultipartConfig(
fileSizeThreshold = 1024 * 1024, // 1MB
maxFileSize = 1024 * 1024 * 5,   // 5MB
maxRequestSize = 1024 * 1024 * 10 // 10MB
	)
public class MystoreProfileUpdateController extends HttpServlet {
	
	IMystoreService mystoreService = MystoreServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setAttribute("contentPage", "/WEB-INF/view/mystore/profileUpdate.jsp");
		
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/main/main.jsp").forward(req, resp);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		HttpSession session = req.getSession();
		MemberVo member = (MemberVo) session.getAttribute("member");
		int memNo = member.getMemNo();
		
		// 기존 이미지 삭제
		String oldImgPath = member.getMemImg();
		System.out.println("oldImgPath : " + oldImgPath);
		
		if(oldImgPath != null && !oldImgPath.isEmpty()) {
			String fileName = oldImgPath.substring(oldImgPath.lastIndexOf("/") + 1); // 파일명만 추출
			String realPath = "D:/A_TeachingMaterial/04_Middle/workspace/CarrotEasy/src/main/webapp/resource/img/mystore/" + fileName;
			File oldFile = new File(realPath);
			if(oldFile.exists()) {
				oldFile.delete();
			}
		}
		
		// 파일 업로드
		Part filePart = req.getPart("photo");
		String webPath = "";
		/*
		 * if(filePart != null && filePart.getSize() > 0) {
		 * 
		 * // 실제 경로 String uploadDir =
		 * "D:/A_TeachingMaterial/04_Middle/workspace/CarrotEasy/src/main/webapp/resource/img/mystore/";
		 * 
		 * 
		 * File uploadFolder = new File(uploadDir); if(!uploadFolder.exists())
		 * uploadFolder.mkdirs();
		 * 
		 * String fileName = UUID.randomUUID().toString() + "_" + member.getMemNo() +
		 * "_" +filePart.getSubmittedFileName();
		 * 
		 * File saveFile = new File(uploadFolder, fileName);
		 * filePart.write(saveFile.getAbsolutePath());
		 * 
		 * //jsp에서 쓸 상대 경로 저장 webPath = "/resource/img/mystore/" + fileName; }
		 */
		
		if (filePart != null && filePart.getSize() > 0) {
            // FileUtil 클래스를 사용하여 파일 업로드 처리
            String contextPath = req.getServletContext().getRealPath("/");
            String uploadPath = MystoreFileUtil.getUploadPath(contextPath);
            
            // 원본 파일명 가져오기
            String originalFileName = MystoreFileUtil.getFileName(filePart);
            
            // 저장할 파일명 생성 (UUID 포함)
            String saveFileName = MystoreFileUtil.getSaveFileName(originalFileName);
            
            // 파일 확장자 가져오기
            String fileType = MystoreFileUtil.getFileType(originalFileName);
            
            // 파일 저장
            MystoreFileUtil.saveFile(filePart, uploadPath, saveFileName);
            
            // 현재 날짜 기반 경로 가져오기 (YYYY/MM/DD)
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
            String datePath = sdf.format(new Date());
            
            // 웹 경로 설정 - 공유 폴더의 상대적 URL 경로로 설정
            // adboard 폴더에 저장하도록 경로 수정
            webPath = req.getContextPath() + "/uploads/mystore/" + datePath + "/" + saveFileName;
        }
		
		ProfileVo vo = new ProfileVo();
		vo.setMemNo(memNo);
		vo.setMemImg(webPath);
		
		int result = mystoreService.profileUpdate(vo);
		System.out.println("프로필 업로드 result : " + result);
		System.out.println(webPath);
		
		//프로필 변경 후 세션 업데이트
		member = mystoreService.sessionUpdate(memNo);
		session.setAttribute("member", member);
		
		resp.sendRedirect("/CarrotEasy/mystore/mystoreMain.do");
		
	}

}
