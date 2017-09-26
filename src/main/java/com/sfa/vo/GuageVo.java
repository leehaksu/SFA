package com.sfa.vo;

public class GuageVo {
	private Long guage_no;
	private Long report_no;
	private Long start_guage;
	private Long end_guage;
	private Long mile;
	private String id;
	public Long getGuage_no() {
		return guage_no;
	}
	public void setGuage_no(Long guage_no) {
		this.guage_no = guage_no;
	}
	public Long getReport_no() {
		return report_no;
	}
	public void setReport_no(Long report_no) {
		this.report_no = report_no;
	}
	public Long getStart_guage() {
		return start_guage;
	}
	public void setStart_guage(Long start_guage) {
		this.start_guage = start_guage;
	}
	public Long getEnd_guage() {
		return end_guage;
	}
	public void setEnd_guage(Long end_guage) {
		this.end_guage = end_guage;
	}
	public Long getMile() {
		return mile;
	}
	public void setMile(Long mile) {
		this.mile = mile;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "GuageVo [guage_no=" + guage_no + ", report_no=" + report_no + ", start_guage=" + start_guage
				+ ", end_guage=" + end_guage + ", mile=" + mile + ", id=" + id + "]";
	}
	
	
}
