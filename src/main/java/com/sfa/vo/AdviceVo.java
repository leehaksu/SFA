package com.sfa.vo;
//상담일지
public class AdviceVo {
	private Long advice_no;//상담일지 고유 번호
	private String title;// 상담일지 제목
	private String content;// 상담일지 내용
	private String reg_date;//작성일
	private String human_name;//담당자 이름
	private String name;//이름
	private String id;//아이디
	private String date;//제출일
	private Long report_no;//결과 보고서 번호
	public Long getAdvice_no() {
		return advice_no;
	}
	public void setAdvice_no(Long advice_no) {
		this.advice_no = advice_no;
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
	public String getHuman_name() {
		return human_name;
	}
	public void setHuman_name(String human_name) {
		this.human_name = human_name;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public Long getReport_no() {
		return report_no;
	}
	public void setReport_no(Long report_no) {
		this.report_no = report_no;
	}
	
	@Override
	public String toString() {
		return "AdviceVo [advice_no=" + advice_no + ", title=" + title + ", content=" + content + ", reg_date="
				+ reg_date + ", human_name=" + human_name + ", name=" + name + ", id=" + id + ", date=" + date
				+ ", report_no=" + report_no + "]";
	}
	
}
