package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.DateReportDao;
import com.sfa.repository.PlanDateDao;
import com.sfa.vo.DateReportVo;
import com.sfa.vo.WeekVo;

@Service
public class DateReportService {

	@Autowired
	DateReportDao dateReportDao;

	@Autowired
	PlanDateDao planDateDao;

	// 달성률을 계산
	public double getAchive_rank(DateReportVo dateReportVo) {
		Long goal_sale = (long) 0;
		Long achive_rank = (long) 0;
		System.out.println(planDateDao.selectGoal(dateReportVo));
		// planDateDao.select(dateReportVo);
		if (goal_sale == 0) {
			achive_rank = (long) 0.0;
		} else {
			achive_rank = (100 * (dateReportVo.getReport_sale() / goal_sale));
		}
		return achive_rank;
	}

	// 작성중인 보고서가 있는지 판별
	public boolean checkReport(DateReportVo dateReportVo) {
		boolean check;

		DateReportVo temp_dateReportVo = dateReportDao.select(dateReportVo.getId(), dateReportVo.getDate(), 0);

		if (temp_dateReportVo == null) {
			check = true;
		} else {
			check = false;
		}
		return check;
	}

	public int insert(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub

		double rank = 0.0;
		dateReportVo.setAchive_rank(rank);
		return dateReportDao.insert(dateReportVo);
	}

	public int update(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub

		// 달성률을 계산
		dateReportVo.setAchive_rank(getAchive_rank(dateReportVo));

		// 작성중인 보고서가 있으면 업데이트 진행함
		return dateReportDao.update(dateReportVo);
	}

	public int delete(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub
		return dateReportDao.delete(dateReportVo);
	}

	public List<DateReportVo> select(String id) {
		// TODO Auto-generated method stub
		return dateReportDao.select(id);
	}

	public List<DateReportVo> select(String id, String date) {
		// TODO Auto-generated method stub
		return dateReportDao.select(id, date);
	}

	public List<DateReportVo> selectWeek(String id) {
		// TODO Auto-generated method stub
		return dateReportDao.selectWeek(id);
	}

	public List<DateReportVo> selectByDept(String dept) {
		// TODO Auto-generated method stub
		return dateReportDao.selectBydept(dept);
	}

	public int updateGauage(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub
		return dateReportDao.updateGauage(dateReportVo);
	}

	public int insertDateReport(DateReportVo dateReortVo) {
		// TODO Auto-generated method stub
		return 0;
	}

	public List<DateReportVo> selectByPeriod(String id, String startDate, String endDate) {
		// TODO Auto-generated method stub
		return dateReportDao.selectByPeriod(id, startDate, endDate);
	}

	public DateReportVo selectReport(Long report_no) {
		// TODO Auto-generated method stub
		return dateReportDao.selectReport(report_no);
	}

	public int updateApproval(Long report_no, Long approval) {
		// TODO Auto-generated method stub
		return dateReportDao.update(report_no,approval);
	}

	public List<DateReportVo> selectTotalReport(String id, String date) {
		// TODO Auto-generated method stub
		return dateReportDao.selectTotalReport(id, date);
	}
	public WeekVo selectReport(String start_date, String end_date, String id) {
		// TODO Auto-generated method stub
		return dateReportDao.selectReport(start_date, end_date,id);
	}

	public List<DateReportVo> selectByPeriod(String id, String startDate, String endDate, Long approval) {
		// TODO Auto-generated method stub
		return dateReportDao.selectReportByPeriodApproval(startDate, endDate,id,approval);
	}

	public List<DateReportVo> seletMainDate(String id) {
		// TODO Auto-generated method stub
		return dateReportDao.seletMainDate(id);
	}
}
