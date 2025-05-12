package kr.or.ddit.member.filter;

import java.io.IOException;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

//@WebFilter("/login.do")
public class LoginCheckFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);

        // 로그인 상태일 경우 로그인 페이지로 진입 못 하도록 차단
        if (session != null && session.getAttribute("member") != null) {
            resp.sendRedirect(req.getContextPath() + "/main/main.do");
        } else {
            // 로그인 안 한 사용자만 로그인 페이지 접근 허용
            chain.doFilter(request, response);
        }
    }
}
