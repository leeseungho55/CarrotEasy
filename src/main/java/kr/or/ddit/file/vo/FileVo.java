package kr.or.ddit.file.vo;

import lombok.Data;

@Data
public class FileVo {
	private int fileNo;
	private String fileOrg;
	private String fileSave;
	private String fileType;
	private String filePath;
	private String createDate;
}
