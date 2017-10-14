package com.sfa.vo;

public class ChartVo {

	private String month;// 달
	private Long total_sale;// 매출합계
	private Long total_mile;// 총 주행거리
	private Long estimate_distance;//총 예상 주행거리
	private Long estimate_sale;// 총 예상 매출액
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

	public Long getEstimate_distance() {
		return estimate_distance;
	}

	public void setEstimate_distance(Long estimate_distance) {
		this.estimate_distance = estimate_distance;
	}

	public Long getEstimate_sale() {
		return estimate_sale;
	}

	public void setEstimate_sale(Long estimate_sale) {
		this.estimate_sale = estimate_sale;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "ChartVo [month=" + month + ", total_sale=" + total_sale + ", total_mile=" + total_mile
				+ ", estimate_distance=" + estimate_distance + ", estimate_sale=" + estimate_sale + ", id=" + id + "]";
	}

}
