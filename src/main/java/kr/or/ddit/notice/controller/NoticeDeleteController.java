package kr.or.ddit.notice.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.notice.service.NoticeServiceImpl;

@WebServlet("/notice/delete.do")
public class NoticeDeleteController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int notiNo = Integer.parseInt(req.getParameter("notiNo"));

        INoticeService service = NoticeServiceImpl.getInstance();
        int result = service.noticeDelete(notiNo);

        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/notice/list.do");
        } else {
            req.setAttribute("message", "게시글 삭제에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/notice/noticeView.jsp").forward(req, resp);
        }
	}

}
