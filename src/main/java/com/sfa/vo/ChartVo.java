package com.sfa.vo;

public class ChartVo {
	
	private String month;
	private Long total_sale;
	private Long total_mile;
	private String id;
	public String getMonth() {
		return month;
	}
	public void setMonth(String month) {
		this.month = month;
	}
	public Long getTotal_sale() {
		return total_sale;
	}
	public void setTotal_sale(Long total_sale) {
		this.total_sale = total_sale;
	}
	public Long getTotal_mile() {
		return total_mile;
	}
	public void setTotal_mile(Long total_mile) {
		this.total_mile = total_mile;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "ChartVo [month=" + month + ", total_sale=" + total_sale + ", total_mile=" + total_mile + ", id=" + id
				+ "]";
	}
}
