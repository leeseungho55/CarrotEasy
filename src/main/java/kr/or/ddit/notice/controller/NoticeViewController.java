package kr.or.ddit.notice.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.admember.vo.AdmemberVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.notice.service.NoticeServiceImpl;
import kr.or.ddit.notice.vo.NoticeVo;

@WebServlet("/notice/noticeView.do")
public class NoticeViewController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int notiNo = Integer.parseInt(req.getParameter("noticeNo"));
        
        INoticeService service = NoticeServiceImpl.getInstance();
        NoticeVo vo = service.getNoticeByNo(notiNo);

        req.setAttribute("notice", vo);
        req.getRequestDispatcher("/WEB-INF/view/notice/noticeView.jsp").forward(req, resp);
	}
}
