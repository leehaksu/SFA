package com.sfa.vo;

//고객 위치
public class PositionVo {

	private String CustomerCode;// 고객 코드
	private double PositionX; // 고객 X좌표 위치
	private double PositionY; // 고객 Y좌표 위치
	private String id; // 아이디

	public String getCustomerCode() {
		return CustomerCode;
	}

	public void setCustomerCode(String customerCode) {
		CustomerCode = customerCode;
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
		return "PositionVo [CustomerCode=" + CustomerCode + ", PositionX=" + PositionX + ", PositionY=" + PositionY
				+ ", id=" + id + "]";
	}
}
