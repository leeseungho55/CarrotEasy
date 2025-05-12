package kr.or.ddit.delivery.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import kr.or.ddit.delivery.dao.DeliveryDao;
import kr.or.ddit.delivery.vo.DeliveryVo;

public class DeliveryService {
	private static DeliveryService instance;

	private DeliveryService() {

	}

	public static DeliveryService getInstance() {
		if (instance == null) {
			instance = new DeliveryService();
		}

		return instance;
	}
	
	DeliveryDao dao = DeliveryDao.getInstance();
	
    public int deliverySave(DeliveryVo vo) {
        return dao.deliverySave(vo);
    }
    
    /**
     * 배송 상태 업데이트
     */
    public int deliveryStatusUpdate(DeliveryVo vo) {
        return dao.deliveryStatusUpdate(vo);
    }
    
    public String getDeliveryStatus(String deliId) {
    	return dao.getDeliveryStatus(deliId);
    }

	public String getDeliId(int prodNo) {
		return dao.getDeliId(prodNo);
	}
}