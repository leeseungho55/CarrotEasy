package kr.or.ddit.chatting.service;

import java.util.List;
import kr.or.ddit.chatting.controller.ChattingRoomController;

import kr.or.ddit.chatting.vo.ChattingRoomVo;
import kr.or.ddit.chatting.vo.MessageVo;
import kr.or.ddit.chatting.vo.ProductVo;
import kr.or.ddit.member.vo.MemberVo;

public interface IChatService {
	public List<ChattingRoomVo> listChattingRoom(int memNo);
	public void createChattingRoom (ChattingRoomVo vo);
	public void sendMessage(MessageVo vo);
	public int readMessage(int[] data);
	public int isNotNull(int chatNo);
	public int prodMemNo(int prodNo);
	public ChattingRoomVo getMemData(String memId);
	public List<MessageVo> printMessageList(int chatNo);
	public ProductVo getProductInfo (int prodNo);
	public void updateChatNo(int chatNo);
    public List<MemberVo> selectChatMembersByProdNo(int prodNo);
}
