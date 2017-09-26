package com.sfa.util;

import com.sfa.vo.DateReportVo;

public class DefaultReport {

	public DateReportVo insertDefaultDateReport(DateReportVo dateReportVo) {

		dateReportVo.setTitle("[일일보고]");
		dateReportVo.setReport_sale(Long.parseLong("0"));
		dateReportVo.setContent("내용없음");
		// 날짜를 받아오지 않는 경우 오늘 날짜로 세팅한다.
		if (dateReportVo.getDate() == null) {
			dateReportVo.setDate(ChangeDate.today());
		} else {
			dateReportVo.setDate(dateReportVo.getDate());
		}

		if (dateReportVo.getStart_gauge() == null) {
			dateReportVo.setStart_gauge((long) 0);
		} else {
			dateReportVo.setStart_gauge(dateReportVo.getStart_gauge());
		}

		if (dateReportVo.getEnd_gauge() == null) {
			dateReportVo.setEnd_gauge((long) 0);
		} else {
			dateReportVo.setEnd_gauge(dateReportVo.getEnd_gauge());
		}

		return dateReportVo;

	}

}
