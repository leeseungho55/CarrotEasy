package kr.or.ddit.mystore.vo;

import kr.or.ddit.member.vo.MemberVo;
import lombok.Data;

@Data
public class ProfileVo {
	
	private int memNo;
	private String memImg;
	
	private MemberVo member;
}
