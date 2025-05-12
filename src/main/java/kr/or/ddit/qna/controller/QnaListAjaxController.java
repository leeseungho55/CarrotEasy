package kr.or.ddit.qna.controller;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.qna.service.IQnaService;
import kr.or.ddit.qna.service.QnaServiceImpl;
import kr.or.ddit.qna.vo.QnaVo;

@WebServlet("/QnaListAjax.do")
public class QnaListAjaxController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    IQnaService qnaService = QnaServiceImpl.getInstance();

    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	
    	HttpSession session = req.getSession();
    	MemberVo member = (MemberVo) session.getAttribute("member");
    	
    	int memNo = member.getMemNo();
    	
        String myPostsOnlyParam = req.getParameter("myPostsOnly");

        boolean myPostsOnly = "true".equals(myPostsOnlyParam);

        List<QnaVo> list;
        if (myPostsOnly && member != null) {
            list = qnaService.qnaListByMember(memNo);
            System.out.println("qnaListByMember : " + list);
        } else {
            list = qnaService.qnaList();
        }

        req.setAttribute("qnaList", list);
        
//        req.setAttribute("contentPage", "/WEB-INF/view/qna/qnaListFragment.jsp");
        
        RequestDispatcher view = req.getRequestDispatcher("/WEB-INF/view/qna/qnaListFragment.jsp");
        view.forward(req, resp);
    }
}
