package com.sfa.vo;
//결과 보고서
public class DateReportVo {
	private Long report_no;//결과 보고서 번호
	private String title;//이름
	private Long report_sale;//오늘 매출
	private String content;//내용
	private double achive_rank;//달성률
	private Long approval;//승인여부(0-승인대기,1-승인,2-반려)
	private String opinion;//팀장 의견
	private String reg_date;//작성일
	private String id;//아이디
	private String date;//결과 보고서 날짜
	private Long goal_sale;// 요일 목표 금액
	private Long start_gauge;//출발 계기판
	private Long end_gauge;// 도착 계기판
	private Long mile;//주행거리 

	public Long getReport_no() {
		return report_no;
	}
	public void setReport_no(Long report_no) {
		this.report_no = report_no;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Long getReport_sale() {
		return report_sale;
	}
	public void setReport_sale(Long report_sale) {
		this.report_sale = report_sale;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public double getAchive_rank() {
		return achive_rank;
	}
	public void setAchive_rank(double achive_rank) {
		this.achive_rank = achive_rank;
	}
	public Long getApproval() {
		return approval;
	}
	public void setApproval(Long approval) {
		this.approval = approval;
	}
	public String getOpinion() {
		return opinion;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public Long getGoal_sale() {
		return goal_sale;
	}
	public void setGoal_sale(Long goal_sale) {
		this.goal_sale = goal_sale;
	}
	public Long getStart_gauge() {
		return start_gauge;
	}
	public void setStart_gauge(Long start_gauge) {
		this.start_gauge = start_gauge;
	}
	public Long getEnd_gauge() {
		return end_gauge;
	}
	public void setEnd_gauge(Long end_gauge) {
		this.end_gauge = end_gauge;
	}
	public Long getMile() {
		return mile;
	}
	public void setMile(Long mile) {
		this.mile = mile;
	}
	
	@Override
	public String toString() {
		return "DateReportVo [report_no=" + report_no + ", title=" + title + ", report_sale=" + report_sale
				+ ", content=" + content + ", achive_rank=" + achive_rank + ", approval=" + approval + ", opinion="
				+ opinion + ", reg_date=" + reg_date + ", id=" + id + ", date=" + date + ", goal_sale=" + goal_sale
				+ ", start_gauge=" + start_gauge + ", end_gauge=" + end_gauge + ", mile=" + mile + "]";
	}
	
}
