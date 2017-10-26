package com.sfa.vo;

public class ParkVo {

	private String id;//아이디
	private String date;//날짜
	private String parking_code;//주차장 코드
	private String store;//지점 명
	
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
	public String getParking_code() {
		return parking_code;
	}
	public void setParking_code(String parking_code) {
		this.parking_code = parking_code;
	}
	public String getStore() {
		return store;
	}
	public void setStore(String store) {
		this.store = store;
	}
	@Override
	public String toString() {
		return "ParkVo [id=" + id + ", date=" + date + ", parking_code=" + parking_code + ", store=" + store + "]";
	}
}
