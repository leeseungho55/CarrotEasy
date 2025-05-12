package kr.or.ddit.prod.service;

import java.util.List;

import kr.or.ddit.prod.dao.IPaymentDao;
import kr.or.ddit.prod.dao.PaymentDao;
import kr.or.ddit.prod.vo.PaymentDataVo;
import kr.or.ddit.util.MybatisDao;

public class PaymentService extends MybatisDao implements IPaymentService {

	private static final PaymentService instance = new PaymentService();

	private PaymentService() {
		// private constructor
	}

	public static PaymentService getInstance() {
		return instance;
	}

	IPaymentDao dao = PaymentDao.getInstance();

	@Override
	public void insertPay(PaymentDataVo vo) {
		// TODO Auto-generated method stub
		dao.insertPay(vo);
	}

	@Override
	public void changeProdType(int prodNo) {
		// TODO Auto-generated method stub
		dao.changeProdType(prodNo);
	}

	@Override
	public int findPayNoByProdAndMember(PaymentDataVo vo) {
		// TODO Auto-generated method stub
		return dao.findPayNoByProdAndMember(vo);
	}
	
	



}
