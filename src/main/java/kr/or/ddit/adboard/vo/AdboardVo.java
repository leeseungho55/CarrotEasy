package kr.or.ddit.adboard.vo;

import kr.or.ddit.admember.vo.AdmemberVo;
import lombok.Data;

@Data
public class AdboardVo {
	private int adNo;
	private int amemNo;
	private String adTitle;
	private String adContent;
	private String adImg;
	private String adUrl;
	private String adComment;
	private String adPass;
	private String createDate;
	private String updateDate;
	private String adDelyn;
	private String adConfirm;
	
	private AdmemberVo admember;
}
