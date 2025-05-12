package kr.or.ddit.community.community_index.vo;

import lombok.Data;

@Data
public class Com_PageVo {
	private int start;
	private int end;
	
	private int startPage;
	private int endPage;
	private int totalPage;
	
	private static int perList = 3;
	private static int perPage = 2;
	
	
	public static int getPerList() {
		return perList;
	}
	public static void setPerList(int perList) {
		Com_PageVo.perList = perList;
	}
	public static int getPerPage() {
		return perPage;
	}
	public static void setPerPage(int perPage) {
		Com_PageVo.perPage = perPage;
	}
}
