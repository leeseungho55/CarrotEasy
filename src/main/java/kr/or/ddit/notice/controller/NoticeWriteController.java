package kr.or.ddit.notice.controller;

import java.io.IOException;

import org.mindrot.bcrypt.BCrypt;

import com.google.gson.Gson;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.admember.controller.RequestDataChange;
import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.notice.service.NoticeServiceImpl;
import kr.or.ddit.notice.vo.NoticeVo;

@WebServlet("/notice/write.do")
public class NoticeWriteController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/notice/noticeInsertForm.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String adTitle = req.getParameter("title");
		String adContent = req.getParameter("content");
		
		NoticeVo vo = new NoticeVo();
		vo.setNotiTitle(adTitle);
		vo.setNotiContent(adContent);
				
		INoticeService service = NoticeServiceImpl.getInstance();
		int res = service.noticeWrite(vo);
		
		if(res > 0)	resp.sendRedirect("/CarrotEasy/notice/list.do");
	}
}
