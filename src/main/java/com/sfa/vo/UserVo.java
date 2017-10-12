package com.sfa.vo;


// 회원가입
public class UserVo {
	private String id;//아이디
	private String passwd;//비밀번호
	private String dept;//부서
	private String name;//이름
	private String grade;//계급
	private String company_email;//회사 이메일
	private String email;//개인 이메일
	private String level;//팀원 여부
	private String date;//가입 날짜
	private String Token;//토큰
	private String status;//상태
	private String user_key;// 카카오톡 user_key
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
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getCompany_email() {
		return company_email;
	}
	public void setCompany_email(String company_email) {
		this.company_email = company_email;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
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
	public String getToken() {
		return Token;
	}
	public void setToken(String token) {
		Token = token;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUser_key() {
		return user_key;
	}
	public void setUser_key(String user_key) {
		this.user_key = user_key;
	}
	@Override
	public String toString() {
		return "UserVo [id=" + id + ", passwd=" + passwd + ", dept=" + dept + ", name=" + name + ", grade=" + grade
				+ ", company_email=" + company_email + ", email=" + email + ", level=" + level + ", date=" + date
				+ ", Token=" + Token + ", status=" + status + ", user_key=" + user_key + "]";
	}
}
