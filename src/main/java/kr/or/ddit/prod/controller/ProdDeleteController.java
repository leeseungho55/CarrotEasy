package kr.or.ddit.prod.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import kr.or.ddit.file.service.FileServiceImpl;
import kr.or.ddit.file.service.IFileService;
import kr.or.ddit.file.vo.FileVo;
import kr.or.ddit.prod.service.IProdImageService;
import kr.or.ddit.prod.service.IProdService;
import kr.or.ddit.prod.service.ProdImageServiceImpl;
import kr.or.ddit.prod.service.ProdServiceImpl;
import kr.or.ddit.prod.vo.ProdImageVo;
import kr.or.ddit.util.MybatisUtil;

@WebServlet("/prod/delete.do")
public class ProdDeleteController extends HttpServlet {
	
	private IProdService prodService = ProdServiceImpl.getInstance();
	private IProdImageService prodImageService = ProdImageServiceImpl.getInstance();
	private IFileService fileService = FileServiceImpl.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		SqlSession session = null;
		
		try {
			session = MybatisUtil.getInstance(false);

			String prodNoStr = req.getParameter("prodNo");
			int prodNo = Integer.parseInt(prodNoStr);

			// 해당 상품의 이미지 정보 조회 (fileNo 얻기)
			List<ProdImageVo> prodImageList = prodImageService.getProdImagesByProdNo(prodNo, session);
			List<Integer> fileNos = new ArrayList<>();
			for (ProdImageVo image : prodImageList) {
				fileNos.add(image.getFileNo());
			}

			// 파일 삭제 (ON DELETE CASCADE 설정되어 있다면 이 줄만으로도 prod_images는 자동 삭제됨)
			for (int fileNo : fileNos) {
				fileService.fileDelete(fileNo, session);
			}

			// 3. 상품 삭제
			int deleteResult = prodService.deleteProd(prodNo, session);
			if (deleteResult <= 0) {
				throw new RuntimeException("상품 삭제 실패");
			}

			session.commit();

		} catch (Exception e) {
			e.printStackTrace();
			if (session != null) session.rollback();
			req.setAttribute("errorMessage", "상품 삭제 중 오류 발생: " + e.getMessage());
			req.getRequestDispatcher("/WEB-INF/view/error/error.jsp").forward(req, resp);
		} finally {
			if (session != null) session.close();
		}
	}
}
