package com.sfa.vo;
//다중 파일 업로드 리스트
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class FileFormVo {
	
	private List<MultipartFile> files;//파일 리스트
	private String OriginalfileName;//파일 이름
	
	public List<MultipartFile> getFiles() {
		return files;
	}
	public void setFiles(List<MultipartFile> files) {
		this.files = files;
	}
	public String getOriginalfileName() {
		return OriginalfileName;
	}
	public void setOriginalfileName(String originalfileName) {
		OriginalfileName = originalfileName;
	}
	
	@Override
	public String toString() {
		return "FileFormVo [files=" + files + ", OriginalfileName=" + OriginalfileName + "]";
	}
	
	
}
