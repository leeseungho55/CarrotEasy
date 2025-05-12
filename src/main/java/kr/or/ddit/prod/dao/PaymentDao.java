package kr.or.ddit.prod.dao;

import java.util.List;

import kr.or.ddit.prod.vo.PaymentDataVo;
import kr.or.ddit.prod.vo.ProdVo;
import kr.or.ddit.util.MybatisDao;

public class PaymentDao extends MybatisDao implements IPaymentDao{

	private static final PaymentDao instance = new PaymentDao();

	private PaymentDao() {
		// private constructor
	}

	public static PaymentDao getInstance() {
		return instance;
	}

	@Override
	public void insertPay(PaymentDataVo vo) {
		// TODO Auto-generated method stub
		update("pay.insertPay",vo);
	}

	@Override
	public void changeProdType(int prodNo) {
		// TODO Auto-generated method stub
		update("pay.changeProdType",prodNo);	
	}

	@Override
	public int findPayNoByProdAndMember(PaymentDataVo vo) {
		return selectOne("pay.findPayNoByProdAndMember", vo);
	}
}
