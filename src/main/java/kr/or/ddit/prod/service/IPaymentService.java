package kr.or.ddit.prod.service;
import java.util.List;

import kr.or.ddit.prod.vo.PaymentDataVo;


public interface IPaymentService {
	
	public void insertPay(PaymentDataVo vo);
	public void changeProdType(int prodNo);
	public int findPayNoByProdAndMember(PaymentDataVo vo);
}
