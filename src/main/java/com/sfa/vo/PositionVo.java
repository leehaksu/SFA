package com.sfa.vo;

//고객 위치
public class PositionVo {

	private String customer_code;// 고객 코드
	private double PositionX; // 고객 X좌표 위치
	private double PositionY; // 고객 Y좌표 위치
	private String id; // 아이디
	public String getCustomer_code() {
		return customer_code;
	}
	public void setCustomer_code(String customer_code) {
		this.customer_code = customer_code;
	}
	public double getPositionX() {
		return PositionX;
	}
	public void setPositionX(double positionX) {
		PositionX = positionX;
	}
	public double getPositionY() {
		return PositionY;
	}
	public void setPositionY(double positionY) {
		PositionY = positionY;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	@Override
	public String toString() {
		return "PositionVo [customer_code=" + customer_code + ", PositionX=" + PositionX + ", PositionY=" + PositionY
				+ ", id=" + id + "]";
	}	
}
