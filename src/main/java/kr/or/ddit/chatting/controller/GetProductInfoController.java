package kr.or.ddit.chatting.controller;

import java.io.IOException;
import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.chatting.service.ChatService;
import kr.or.ddit.chatting.service.IChatService;
import kr.or.ddit.chatting.vo.ProductVo;

@WebServlet("/chat/getProductInfo.do")
public class GetProductInfoController extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int prodNo = Integer.parseInt(request.getParameter("prodNo"));
        
        IChatService service = ChatService.getInstance();
        ProductVo product = service.getProductInfo(prodNo);
        if (product != null) {
            response.setContentType("application/json;charset=UTF-8");
            response.getWriter().write(new Gson().toJson(product));
        } else {
            response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

    }
}
