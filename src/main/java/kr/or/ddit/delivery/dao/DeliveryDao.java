package kr.or.ddit.delivery.dao;

import kr.or.ddit.delivery.vo.DeliveryVo;
import kr.or.ddit.util.MybatisDao;

public class DeliveryDao extends MybatisDao {
	private static DeliveryDao instance;

	private DeliveryDao() {

	}

	public static DeliveryDao getInstance() {
		if (instance == null) {
			instance = new DeliveryDao();
		}

		return instance;
	}
	
	public int deliverySave(DeliveryVo vo) {
		return update("delivery.deliverySave", vo);
	}
	
	public int deliveryStatusUpdate(DeliveryVo vo) {
		return update("delivery.deliveryStatusUpdate", vo);
	}
	
	public String getDeliveryStatus(String deliId) {
		return selectOne("delivery.getDeliveryStatus", deliId);
	}

	public String getDeliId(int prodNo) {
		return selectOne("delivery.getDeliId", prodNo);
	}
	
}
