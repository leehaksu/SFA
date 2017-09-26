package com.sfa.vo;
//파일 업로드
public class FileVo {
	private String originalFileName;//처음 파일 이름
	private String fileName;//새로 지정된 파일 이름
	private Long file_no;//파일 번호
	public String getOriginalFileName() {
		return originalFileName;
	}
	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}
	public String getFileName() {
		return fileName;
	}
	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	public Long getFile_no() {
		return file_no;
	}
	public void setFile_no(Long file_no) {
		this.file_no = file_no;
	}
	
	@Override
	public String toString() {
		return "FileVo [originalFileName=" + originalFileName + ", fileName=" + fileName + ", file_no=" + file_no + "]";
	}
	
	

}
