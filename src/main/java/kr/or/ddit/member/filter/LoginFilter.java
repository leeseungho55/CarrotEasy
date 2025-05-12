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

//@WebFilter("/main/*")
@WebFilter("/abc")
public class LoginFilter implements Filter {

	@Override
	public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest hsReq = (HttpServletRequest) req;
		
		HttpSession session = hsReq.getSession(false);
		if(session == null || session.getAttribute("member") == null) {
			
			HttpServletResponse hsResp = (HttpServletResponse) resp;
			hsResp.sendRedirect(hsReq.getContextPath() + "/login.do");
			
			
		}
		else chain.doFilter(req, resp);
		
	}

	

}
