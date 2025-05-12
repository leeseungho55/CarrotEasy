package kr.or.ddit.notice.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.notice.service.NoticeServiceImpl;
import kr.or.ddit.notice.vo.NoticeVo;

@WebServlet("/notice/update.do")
public class NoticeUpdateController extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int notiNo = Integer.parseInt(req.getParameter("notiNo"));
        String notiTitle = req.getParameter("notiTitle");
        String notiContent = req.getParameter("notiContent");

        NoticeVo vo = new NoticeVo();
        vo.setNotiNo(notiNo);
        vo.setNotiTitle(notiTitle);
        vo.setNotiContent(notiContent);

        INoticeService service = NoticeServiceImpl.getInstance();
        int result = service.noticeUpdate(vo);

        resp.setContentType("application/json;charset=UTF-8");
        if (result > 0) {
            resp.getWriter().write("{\"success\": true, \"title\": \"" + notiTitle + "\", \"content\": \"" + notiContent + "\"}");
        } else {
            resp.getWriter().write("{\"success\": false, \"message\": \"게시글 수정 실패\"}");
        }
	}
}
