package kr.or.ddit.adboard.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;

@WebServlet("/adboard/delete.do")
public class AdboardDeleteController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int adNo = Integer.parseInt(req.getParameter("adNo"));

        IAdboardService service = AdboardServiceImpl.getInstance();
        int result = service.adboardDelete(adNo);

        if (result > 0) {
            resp.sendRedirect(req.getContextPath() + "/adboard/list.do");
        } else {
            req.setAttribute("message", "게시글 삭제에 실패했습니다.");
            req.getRequestDispatcher("/WEB-INF/view/adboard/boardView.jsp").forward(req, resp);
        }
	}

}
