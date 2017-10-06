package com.sfa.vo;
//고객 관리
public class CustomerVo {
	
	private String customer_code;//고객 고유 코드
	private String name;//이름
	private String contact;//연락처
	private String manager_name;//담당자 이름
	private String manager_grade;// 담당자 직급
	private String manager_email;// 담당자 이메일
	private String manager_birth;// 담당자 생일
	private String time;// 영업 시간
	private String address;// 주소
	private String id;//아이디
	public String getCustomer_code() {
		return customer_code;
	}
	public void setCustomer_code(String customer_code) {
		this.customer_code = customer_code;
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
	public String getManager_name() {
		return manager_name;
	}
	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}
	public String getManager_grade() {
		return manager_grade;
	}
	public void setManager_grade(String manager_grade) {
		this.manager_grade = manager_grade;
	}
	public String getManager_email() {
		return manager_email;
	}
	public void setManager_email(String manager_email) {
		this.manager_email = manager_email;
	}
	public String getManager_birth() {
		return manager_birth;
	}
	public void setManager_birth(String manager_birth) {
		this.manager_birth = manager_birth;
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
		return "CustomerVo [customer_code=" + customer_code + ", name=" + name + ", contact=" + contact
				+ ", manager_name=" + manager_name + ", manager_grade=" + manager_grade + ", manager_email="
				+ manager_email + ", manager_birth=" + manager_birth + ", time=" + time + ", address=" + address
				+ ", id=" + id + "]";
	}	
}
