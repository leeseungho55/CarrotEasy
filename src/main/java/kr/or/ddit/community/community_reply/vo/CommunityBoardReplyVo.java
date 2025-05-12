package kr.or.ddit.community.community_reply.vo;

import kr.or.ddit.member.vo.MemberVo;
import lombok.Data;

@Data
public class CommunityBoardReplyVo {
	private int replyNo;
    private int commubNo;
    private String replyContent;
    private String replyWriter;
    private String replyDate;
    private String delyn;
	
	private MemberVo member;
}
