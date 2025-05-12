package kr.or.ddit.chatting.dao;

import java.util.List;

import kr.or.ddit.chatting.vo.ChattingRoomVo;
import kr.or.ddit.chatting.vo.MessageVo;
import kr.or.ddit.chatting.vo.ProductVo;
import kr.or.ddit.member.vo.MemberVo;
import kr.or.ddit.util.MybatisDao;

public class ChatDao extends MybatisDao implements IChatDao {
	private static final ChatDao instance = new ChatDao();
	
	private ChatDao() {
		// private constructor
	}
	
	public static ChatDao getInstance() {
		return instance;
	}

	@Override
	public List<ChattingRoomVo> listChattingRoom(int memNo) {
		// TODO Auto-generated method stub
		return selectList("chat.chatList",memNo);
	}

	@Override
	public void createChattingRoom(ChattingRoomVo vo) {
		// TODO Auto-generated method stub
		update("chat.createChattingRoom", vo);
	}

	@Override
	public void sendMessage(MessageVo vo) {
		// TODO Auto-generated method stub
		update("chat.messageSend",vo);
	}

	@Override
	public int readMessage(int[] data) {
		// TODO Auto-generated method stub
		int returnData = 0;
		returnData=update("chat.readMessage",data);

		return returnData;
	}

	@Override
	public int isNotNull(int chatNo) {
		// TODO Auto-generated method stub
		int data=0;
		if(selectOne("chat.isNotNull",chatNo)!= null)data=1;
		return data;
	}

	@Override
	public ChattingRoomVo getMemData(String memId) {
		// TODO Auto-generated method stub
		return selectOne("chat.getMemData", memId);
	}

	@Override
	public int prodMemNo(int prodNo) {
		// TODO Auto-generated method stub
		return selectOne("chat.prodMemNo",prodNo);
	}

	@Override
	public List<MessageVo> printMessageList(int chatNo) {
		// TODO Auto-generated method stub
		return selectList("chat.printMessageList",chatNo);
	}

	@Override
	public ProductVo getProductInfo(int prodNo) {
		// TODO Auto-generated method stub
		return selectOne("chat.getProductInfo",prodNo);
	}

	@Override
	public void updateChatNo(int chatNo) {
		// TODO Auto-generated method stub
		update("chat.updateChattingRoom",chatNo);
	}

	@Override
	public List<MemberVo> selectChatMembersByProdNo(int prodNo) {
		return selectList("chat.selectChatMembersByProdNo", prodNo);
	}
	

}
