package com.sfa.vo;

public class AffirmationVo {
	private Long no;
	private String content;
	public Long getNo() {
		return no;
	}
	public void setNo(Long no) {
		this.no = no;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	@Override
	public String toString() {
		return "AffirmationVo [no=" + no + ", content=" + content + "]";
	}
}
