package kr.or.ddit.report.controller;

import java.io.IOException;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/ReportInsertForm.do")
public class ReportInsertForm extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String prodTitle = (String)req.getParameter("prodTitle");
		System.out.println(prodTitle);
		System.out.println(prodTitle);
		System.out.println(prodTitle);
		System.out.println(prodTitle);
		System.out.println(prodTitle);
		System.out.println("/reportInsert.do 실행");
        
		req.setAttribute("prodTitle", prodTitle);
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/report/ReportInsertForm.jsp").forward(req, resp);
	}
}
