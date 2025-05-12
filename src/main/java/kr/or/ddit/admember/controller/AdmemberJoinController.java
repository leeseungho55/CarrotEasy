package kr.or.ddit.admember.controller;

import java.io.IOException;

import com.google.gson.Gson;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.admember.service.AdmemberServiceImpl;
import kr.or.ddit.admember.service.IAdmemberService;
import kr.or.ddit.admember.vo.AdmemberVo;

@WebServlet("/admemberJoin.do")
public class AdmemberJoinController extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		ServletContext ctx = req.getServletContext();
		ctx.getRequestDispatcher("/WEB-INF/view/admember/register.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String reqData = RequestDataChange.changeData(req);
		
		System.out.println("reqData ==== " + reqData);
		
		Gson gson = new Gson();
		AdmemberVo vo = gson.fromJson(reqData, AdmemberVo.class);
		
		IAdmemberService admemberService = AdmemberServiceImpl.getInstance();
		int res = admemberService.admemberJoin(vo);
		
		req.setAttribute("result", res);
		req.getRequestDispatcher("/view/result.jsp").forward(req, resp);
	}

}
