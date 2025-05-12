package kr.or.ddit.notice.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.notice.service.INoticeService;
import kr.or.ddit.notice.service.NoticeServiceImpl;
import kr.or.ddit.notice.vo.NoticeVo;

@WebServlet("/notice/list.do")
public class NoticeListController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		INoticeService service = NoticeServiceImpl.getInstance();
		List<NoticeVo> boardList = service.noticeList(); 
		
		// 테스트 코드 (관리자인지 아닌지에 따라서 등록, 수정, 삭제 버튼 on off)
		HttpSession session = req.getSession();
		MemberVo member = new MemberVo();
		member.setMemRole(1);
        session.setAttribute("loginUser", member);
        MemberVo loginUser = (MemberVo) session.getAttribute("loginUser");
        
		req.setAttribute("boardList", boardList);
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/notice/noticeList.jsp").forward(req, resp);
	}
}
