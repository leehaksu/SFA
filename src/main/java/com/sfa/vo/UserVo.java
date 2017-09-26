package com.sfa.vo;


// 회원가입
public class UserVo {
	private String id;//아이디
	private String passwd;//비밀번호
	private String dept;//부서
	private String name;//이름
	private String grade;//계급
	private String email;//이메일
	private String level;//팀원 여부
	private String date;//가입 날짜
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	
	@Override
	public String toString() {
		return "UserVo [id=" + id + ", passwd=" + passwd + ", dept=" + dept + ", name=" + name + ", email=" + email
				+ ", grade=" + grade + ", level=" + level + ", date=" + date + "]";
	}
	
	
}
