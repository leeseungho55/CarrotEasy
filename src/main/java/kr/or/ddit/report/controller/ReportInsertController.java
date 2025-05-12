package kr.or.ddit.report.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.report.service.ReportService;
import kr.or.ddit.report.vo.ReportVo;
import kr.or.ddit.member.vo.MemberVo; // 로그인 정보 객체

@WebServlet("/ReportInsert.do")
public class ReportInsertController extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 세션에서 로그인한 사용자 정보 꺼내기
        HttpSession session = req.getSession();
        MemberVo loginUser = (MemberVo) session.getAttribute("member");

        if (loginUser == null) {
            // 로그인 정보가 없으면 로그인 페이지로 리다이렉트
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        // 파라미터 수집
        int memNo = loginUser.getMemNo();
        String memId = loginUser.getMemId();
        String prodTitle = (String)req.getParameter("prodTitle");
        String repTitle = req.getParameter("repTitle"); // input name="repTitle"
        String repContent = req.getParameter("repContent"); // input name="repContent"

        // VO에 데이터 세팅
        ReportVo vo = new ReportVo();
        vo.setMemNo(memNo);
        vo.setMemId(memId);
        vo.setProdTitle(prodTitle);
        vo.setRepTitle(repTitle);
        vo.setRepContent(repContent);
        System.out.println("vo==>"+vo);
        System.out.println("vo==>"+vo);
        System.out.println("vo==>"+vo);
        System.out.println("vo==>"+vo);
        System.out.println("vo==>"+vo);
        // 서비스 호출
        ReportService service = ReportService.getInstance();
        service.insertReport(vo);

		req.getRequestDispatcher("/WEB-INF/view/review/insertSuccess.jsp").forward(req, resp);
    }
}
