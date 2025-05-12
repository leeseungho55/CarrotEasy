package kr.or.ddit.member.vo;

import lombok.Data;

@Data
public class MemberVo {
	
	private int memNo;
	private String memId;
	private String memPass;
	private String memNick;
	private String memEmail;
	private String memTel;
	private String memAddr;
	private String memAddr1;
	private String memAddr2;
	private String memImg;
	private int memCnt;
	private String memDelyn;
	private int memRole;
	private String memKakao;
	private int memCash;
	private String memRank;
	private int memMile;
	private String createDate;
	private String updateDate;
	private boolean emailVerified;
	
}
