package com.sfa.vo;
//고객 위치
public class PositionVo {
	
	private String CustomerCode;//고객 코드
	private double PositionX; // 고객 X좌표 위치
	private double PositionY; // 고객 Y좌표 위치
	private String name; // 고객 이름
	private String id; //아이디
	private Long rpFlag; //경유지 여부
	private Long poiid;// 고객 고유 id
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
	public Long getRpFlag() {
		return rpFlag;
	}
	public void setRpFlag(Long rpFlag) {
		this.rpFlag = rpFlag;
	}
	public Long getPoiid() {
		return poiid;
	}
	public void setPoiid(Long poiid) {
		this.poiid = poiid;
	}
	
	@Override
	public String toString() {
		return "PositionVo [CustomerCode=" + CustomerCode + ", PositionX=" + PositionX + ", PositionY=" + PositionY
				+ ", name=" + name + ", id=" + id + ", rpFlag=" + rpFlag + ", poiid=" + poiid + "]";
	}
	
	
	
}
