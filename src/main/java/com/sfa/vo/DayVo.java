package com.sfa.vo;
//요일 계획서
public class DayVo {
	private Long day_no;// 요일 고유 번호
	private String day;//요일
	private String content;// 요일 내용
	private Long day_sale; // 요일 매출
	private String date;//요일 날짜
	private String week_no;//주간 번호
	private String id;//아이디
	private String first_date;// 월요일 날짜
	public Long getDay_no() {
		return day_no;
	}
	public void setDay_no(Long day_no) {
		this.day_no = day_no;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Long getDay_sale() {
		return day_sale;
	}
	public void setDay_sale(Long day_sale) {
		this.day_sale = day_sale;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getWeek_no() {
		return week_no;
	}
	public void setWeek_no(String week_no) {
		this.week_no = week_no;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getFirst_date() {
		return first_date;
	}
	public void setFirst_date(String first_date) {
		this.first_date = first_date;
	}
	
	@Override
	public String toString() {
		return "DayVo [day_no=" + day_no + ", day=" + day + ", content=" + content + ", day_sale=" + day_sale
				+ ", date=" + date + ", week_no=" + week_no + ", id=" + id + ", first_date=" + first_date + "]";
	}

	
}
