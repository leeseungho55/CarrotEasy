package kr.or.ddit.chatting.service;

import java.util.List;

import kr.or.ddit.chatting.dao.ChatDao;
import kr.or.ddit.chatting.dao.IChatDao;
import kr.or.ddit.chatting.vo.ChattingRoomVo;
import kr.or.ddit.chatting.vo.MessageVo;
import kr.or.ddit.chatting.vo.ProductVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.util.MybatisDao;

public class ChatService extends MybatisDao implements IChatService {

	private static final ChatService instance = new ChatService();

	private ChatService() {
		// private constructor
	}

	public static ChatService getInstance() {
		return instance;
	}
	IChatDao dao = ChatDao.getInstance();
	@Override
	
	public List<ChattingRoomVo> listChattingRoom(int memNo) {
		
		return dao.listChattingRoom(memNo);
	}

	@Override
	public void createChattingRoom(ChattingRoomVo vo) {
		// TODO Auto-generated method stub
		dao.createChattingRoom(vo);
	}

	@Override
	public void sendMessage(MessageVo vo) {
		// TODO Auto-generated method stub
		dao.sendMessage(vo);
	}

	@Override
	public int readMessage(int[] data) {
		// TODO Auto-generated method stub
		return dao.readMessage(data);
	}

	@Override
	public int isNotNull(int chatNo) {
		// TODO Auto-generated method stub
		return dao.isNotNull(chatNo);
	}

	@Override

	public ChattingRoomVo getMemData(String memId){
		// TODO Auto-generated method stub
		return dao.getMemData(memId);
	}

	@Override
	public int prodMemNo(int prodNo) {
		// TODO Auto-generated method stub
		return dao.prodMemNo(prodNo);
	}

	@Override
	public List<MessageVo> printMessageList(int chatNo) {
		// TODO Auto-generated method stub
		return dao.printMessageList(chatNo);
	}

	@Override
	public ProductVo getProductInfo(int prodNo) {
		// TODO Auto-generated method stub
		return dao.getProductInfo(prodNo);
	}

	@Override
	public void updateChatNo(int chatNo) {
		// TODO Auto-generated method stub
		dao.updateChatNo(chatNo);
	}

	@Override
	public List<MemberVo> selectChatMembersByProdNo(int prodNo) {
		return dao.selectChatMembersByProdNo(prodNo);
	}
	
	

}
