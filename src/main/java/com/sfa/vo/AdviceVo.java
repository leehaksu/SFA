package com.sfa.vo;
//상담일지
public class AdviceVo {
	private Long advice_no;//상담일지 고유 번호
	private String title;// 상담일지 제목
	private String content;// 상담일지 내용
	private String reg_date;//작성일
	private String manager_name;//담당자 이름
	private String customer_code; // 고객 코드
	private String name;//이름
	private String id;//아이디
	private String date;//제출일
	private String address;//주소
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
	public String getManager_name() {
		return manager_name;
	}
	public void setManager_name(String manager_name) {
		this.manager_name = manager_name;
	}
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	@Override
	public String toString() {
		return "AdviceVo [advice_no=" + advice_no + ", title=" + title + ", content=" + content + ", reg_date="
				+ reg_date + ", manager_name=" + manager_name + ", customer_code=" + customer_code + ", name=" + name
				+ ", id=" + id + ", date=" + date + ", address=" + address + "]";
	}
}
