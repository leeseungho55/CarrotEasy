package kr.or.ddit.adboard.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/uploads/adboard/*")
public class FileDownloadController extends HttpServlet {
    // 공유 폴더 경로 - adboard 폴더로 지정
    private static final String SHARED_FOLDER_PATH = "\\\\192.168.145.21\\carrot\\adboard";
    
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String pathInfo = req.getPathInfo(); // /YYYY/MM/DD/filename
        if (pathInfo == null || pathInfo.equals("/")) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST);
            return;
        }
        
        // 요청 경로에서 파일 경로 구성 (날짜 포함)
        String filePath = pathInfo;
        File file = new File(SHARED_FOLDER_PATH + filePath);
        
        if (!file.exists()) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        String mime = getServletContext().getMimeType(file.getName());
        if (mime == null) {
            mime = "application/octet-stream";
        }
        
        resp.setContentType(mime);
        resp.setContentLengthLong(file.length());
        
        try (InputStream in = new FileInputStream(file);
             OutputStream out = resp.getOutputStream()) {
            byte[] buffer = new byte[4096];
            int length;
            while ((length = in.read(buffer)) > 0) {
                out.write(buffer, 0, length);
            }
        }
    }
}