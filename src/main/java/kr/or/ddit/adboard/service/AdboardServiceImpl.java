package kr.or.ddit.adboard.service;

import java.util.ArrayList;
import java.util.List;

import kr.or.ddit.adboard.dao.AdboardDaoImpl;
import kr.or.ddit.adboard.dao.IAdboardDao;
import kr.or.ddit.adboard.vo.AdboardVo;
import kr.or.ddit.adboard.vo.SwiperAdVo;
import kr.or.ddit.admember.service.AdmemberServiceImpl;
import kr.or.ddit.admember.service.IAdmemberService;
import kr.or.ddit.admember.vo.AdmemberVo;

public class AdboardServiceImpl implements IAdboardService {
	private static AdboardServiceImpl instance;

	private AdboardServiceImpl() {

	}

	public static AdboardServiceImpl getInstance() {
		if (instance == null) {
			instance = new AdboardServiceImpl();
		}

		return instance;
	}

	IAdboardDao adboardDao = AdboardDaoImpl.getInstance();
	IAdmemberService admemberService = AdmemberServiceImpl.getInstance();

	@Override
	public List<AdboardVo> adboardList() {
		List<AdboardVo> boardList = adboardDao.adboardList();
		
		for(AdboardVo board : boardList) {
			AdmemberVo admember = admemberService.getAdmemberByNo(board.getAmemNo());
			board.setAdmember(admember);
		}
		
		return boardList;
	}

	@Override
	public int adboardWrite(AdboardVo vo) {
		return adboardDao.adboardWrite(vo);
	}

	@Override
	public AdboardVo getBoardByNo(int adNo) {
		AdboardVo board = adboardDao.getBoardByNo(adNo);
		board.setAdmember(admemberService.getAdmemberByNo(board.getAmemNo()));
		return board;
	}

	@Override
	public int adboardUpdate(AdboardVo vo) {
		return adboardDao.adboardUpdate(vo);
	}

	@Override
	public int adboardDelete(int adNo) {
		return adboardDao.adboardDelete(adNo);
	}

	@Override
	public int updateAdBoardConfirm(AdboardVo vo) {
		return adboardDao.updateAdBoardConfirm(vo);
	}

	@Override
	public void updateAdConfirm(int adNo) {
		// TODO Auto-generated method stub
		adboardDao.updateAdConfirm(adNo);
	}

	@Override
	public List<SwiperAdVo> getAdForSwiper() {
		// TODO Auto-generated method stub
		return adboardDao.getAdForSwiper();
	}
	
	
}
