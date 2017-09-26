package com.sfa.vo;
//고객 관리
public class CustomerVo {
	
	private String code;//고객 고유 코드
	private String division_code;//고객 2차 코드
	private String name;//이름
	private String contact;//연락처
	private String human_name;//담당자 이름
	private String human_grade;// 담당자 직급
	private String human_email;// 담당자 이메일
	private String human_birth;// 담당자 생일
	private String time;// 영업 시간
	private String address;// 주소
	private String id;//아이디
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getDivision_code() {
		return division_code;
	}
	public void setDivision_code(String division_code) {
		this.division_code = division_code;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getHuman_name() {
		return human_name;
	}
	public void setHuman_name(String human_name) {
		this.human_name = human_name;
	}
	public String getHuman_grade() {
		return human_grade;
	}
	public void setHuman_grade(String human_grade) {
		this.human_grade = human_grade;
	}
	public String getHuman_email() {
		return human_email;
	}
	public void setHuman_email(String human_email) {
		this.human_email = human_email;
	}
	public String getHuman_birth() {
		return human_birth;
	}
	public void setHuman_birth(String human_birth) {
		this.human_birth = human_birth;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	
	@Override
	public String toString() {
		return "CustomerVo [code=" + code + ", division_code=" + division_code + ", name=" + name + ", contact="
				+ contact + ", human_name=" + human_name + ", human_grade=" + human_grade + ", human_email="
				+ human_email + ", human_birth=" + human_birth + ", time=" + time + ", address=" + address + ", id="
				+ id + "]";
	}
}
