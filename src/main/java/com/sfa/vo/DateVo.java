package com.sfa.vo;
//일일 계획서
public class DateVo {
	private String title;// 제목
	private Long goal_sale; // 목표액
	private String opinion; // 팀장 의견
	private String content; // 내용
	private String reg_date; // 작성일
	private String id; // 아이디
	private String date; //날짜
	private Long estimate_distance; // 예상거리
	private String estimate_course; // 예상 코스
	private Long challenge_no; // 도전과제 번호
	private String challenge_content; // 도전과제 내용
	private String route;//경로 
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Long getGoal_sale() {
		return goal_sale;
	}
	public void setGoal_sale(Long goal_sale) {
		this.goal_sale = goal_sale;
	}
	public String getOpinion() {
		return opinion;
	}
	public void setOpinion(String opinion) {
		this.opinion = opinion;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public Long getEstimate_distance() {
		return estimate_distance;
	}
	public void setEstimate_distance(Long estimate_distance) {
		this.estimate_distance = estimate_distance;
	}
	public String getEstimate_course() {
		return estimate_course;
	}
	public void setEstimate_course(String estimate_course) {
		this.estimate_course = estimate_course;
	}
	public Long getChallenge_no() {
		return challenge_no;
	}
	public void setChallenge_no(Long challenge_no) {
		this.challenge_no = challenge_no;
	}
	public String getChallenge_content() {
		return challenge_content;
	}
	public void setChallenge_content(String challenge_content) {
		this.challenge_content = challenge_content;
	}
	public String getRoute() {
		return route;
	}
	public void setRoute(String route) {
		this.route = route;
	}
	@Override
	public String toString() {
		return "DateVo [title=" + title + ", goal_sale=" + goal_sale + ", opinion=" + opinion + ", content=" + content
				+ ", reg_date=" + reg_date + ", id=" + id + ", date=" + date + ", estimate_distance="
				+ estimate_distance + ", estimate_course=" + estimate_course + ", challenge_no=" + challenge_no
				+ ", challenge_content=" + challenge_content + ", route=" + route + "]";
	}
}
