package com.sfa.vo;
//주간 계획
public class WeekVo {
	private String first_date;//월요일 날짜
	private String week_no;// 주차별 번호
	private String reg_date;//작성일
	private String title;//제목
	private Long target_figure;//목표액
	private Long week_sale;//주간 매출액
	private double achive_rank;//달성률
	private String id;//아이디
	private String Monday_date;//월요일 날짜
	private String Monday;//월요일 내용
	private Long Monday_money;//월요일 매출 목표액
	private String Tuesday_date;//화요일 날짜
	private String Tuesday;//화요일 내용
	private Long Tuesday_money;//화요일 매출 목표액
	private String Wednesday_date;//수요일 날짜
	private String Wednesday;//수요일 내용
	private Long Wednesday_money;//수요일 매출 목표액
	private String Thursday_date;//목요일 날짜
	private String Thursday;//목요일 내용
	private Long Thursday_money;//목요일 매출 목표액
	private String Friday_date;//금요일 날짜
	private String Friday;//금요일 내용
	private Long Friday_money;//금요일 매출 목표액
	private String day;//요일
	public String getFirst_date() {
		return first_date;
	}
	public void setFirst_date(String first_date) {
		this.first_date = first_date;
	}
	public String getWeek_no() {
		return week_no;
	}
	public void setWeek_no(String week_no) {
		this.week_no = week_no;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Long getTarget_figure() {
		return target_figure;
	}
	public void setTarget_figure(Long target_figure) {
		this.target_figure = target_figure;
	}
	public Long getWeek_sale() {
		return week_sale;
	}
	public void setWeek_sale(Long week_sale) {
		this.week_sale = week_sale;
	}
	public double getAchive_rank() {
		return achive_rank;
	}
	public void setAchive_rank(double achive_rank) {
		this.achive_rank = achive_rank;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMonday_date() {
		return Monday_date;
	}
	public void setMonday_date(String monday_date) {
		Monday_date = monday_date;
	}
	public String getMonday() {
		return Monday;
	}
	public void setMonday(String monday) {
		Monday = monday;
	}
	public Long getMonday_money() {
		return Monday_money;
	}
	public void setMonday_money(Long monday_money) {
		Monday_money = monday_money;
	}
	public String getTuesday_date() {
		return Tuesday_date;
	}
	public void setTuesday_date(String tuesday_date) {
		Tuesday_date = tuesday_date;
	}
	public String getTuesday() {
		return Tuesday;
	}
	public void setTuesday(String tuesday) {
		Tuesday = tuesday;
	}
	public Long getTuesday_money() {
		return Tuesday_money;
	}
	public void setTuesday_money(Long tuesday_money) {
		Tuesday_money = tuesday_money;
	}
	public String getWednesday_date() {
		return Wednesday_date;
	}
	public void setWednesday_date(String wednesday_date) {
		Wednesday_date = wednesday_date;
	}
	public String getWednesday() {
		return Wednesday;
	}
	public void setWednesday(String wednesday) {
		Wednesday = wednesday;
	}
	public Long getWednesday_money() {
		return Wednesday_money;
	}
	public void setWednesday_money(Long wednesday_money) {
		Wednesday_money = wednesday_money;
	}
	public String getThursday_date() {
		return Thursday_date;
	}
	public void setThursday_date(String thursday_date) {
		Thursday_date = thursday_date;
	}
	public String getThursday() {
		return Thursday;
	}
	public void setThursday(String thursday) {
		Thursday = thursday;
	}
	public Long getThursday_money() {
		return Thursday_money;
	}
	public void setThursday_money(Long thursday_money) {
		Thursday_money = thursday_money;
	}
	public String getFriday_date() {
		return Friday_date;
	}
	public void setFriday_date(String friday_date) {
		Friday_date = friday_date;
	}
	public String getFriday() {
		return Friday;
	}
	public void setFriday(String friday) {
		Friday = friday;
	}
	public Long getFriday_money() {
		return Friday_money;
	}
	public void setFriday_money(Long friday_money) {
		Friday_money = friday_money;
	}
	public String getDay() {
		return day;
	}
	public void setDay(String day) {
		this.day = day;
	}
	@Override
	public String toString() {
		return "WeekVo [first_date=" + first_date + ", week_no=" + week_no + ", reg_date=" + reg_date + ", title="
				+ title + ", target_figure=" + target_figure + ", week_sale=" + week_sale + ", achive_rank="
				+ achive_rank + ", id=" + id + ", Monday_date=" + Monday_date + ", Monday=" + Monday + ", Monday_money="
				+ Monday_money + ", Tuesday_date=" + Tuesday_date + ", Tuesday=" + Tuesday + ", Tuesday_money="
				+ Tuesday_money + ", Wednesday_date=" + Wednesday_date + ", Wednesday=" + Wednesday
				+ ", Wednesday_money=" + Wednesday_money + ", Thursday_date=" + Thursday_date + ", Thursday=" + Thursday
				+ ", Thursday_money=" + Thursday_money + ", Friday_date=" + Friday_date + ", Friday=" + Friday
				+ ", Friday_money=" + Friday_money + ", day=" + day + "]";
	}

}
