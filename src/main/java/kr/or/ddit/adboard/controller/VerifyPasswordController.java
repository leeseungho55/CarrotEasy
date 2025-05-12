package kr.or.ddit.adboard.controller;

import java.io.IOException;

import org.mindrot.bcrypt.BCrypt;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.adboard.service.AdboardServiceImpl;
import kr.or.ddit.adboard.service.IAdboardService;
import kr.or.ddit.adboard.vo.AdboardVo;

@WebServlet("/adboard/verifyPassword")
public class VerifyPasswordController extends HttpServlet {
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int adNo = Integer.parseInt(req.getParameter("adNo"));
        String inputPassword = req.getParameter("password");
        
        System.out.println("요청 파라미터 - adNo: " + req.getParameter("adNo"));
        System.out.println("요청 파라미터 - password: " + req.getParameter("password"));

        IAdboardService adboardService = AdboardServiceImpl.getInstance();
        AdboardVo board = adboardService.getBoardByNo(adNo);  // DB에서 가져오기
        HttpSession session = req.getSession();
		/*
		 * if (loginUser != null) { isAdmin = true; }
		 */

        resp.setContentType("application/json;charset=UTF-8");
        if (BCrypt.checkpw(inputPassword, board.getAdPass())) {
        	System.out.println("비밀번호 맞음");
            // 비밀번호 맞음
            session.setAttribute("viewPermission_" + adNo, true); // 권한 플래그 저장
            resp.getWriter().write("{\"success\": true, \"redirectUrl\": \"" + req.getContextPath() + "/adboard/boardView?adNo=" + adNo + "\"}");
        } else {
        	System.out.println("비밀번호 틀림");
            resp.getWriter().write("{\"success\": false, \"message\": \"비밀번호가 일치하지 않습니다.\"}");
        }
	}
}