package com.sfa.vo;


public class BoardVo {

	private Long board_no;
	private String title;
	private String content;
	private String reg_date;
	private String id;
	private Long hit;
	public Long getBoard_no() {
		return board_no;
	}
	public void setBoard_no(Long board_no) {
		this.board_no = board_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public Long getHit() {
		return hit;
	}
	public void setHit(Long hit) {
		this.hit = hit;
	}
	
	@Override
	public String toString() {
		return "BoardVo [board_no=" + board_no + ", title=" + title + ", content=" + content + ", reg_date=" + reg_date
				+ ", id=" + id + ", hit=" + hit + "]";
	}
}
