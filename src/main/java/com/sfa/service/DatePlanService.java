package com.sfa.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.PlanDateDao;
import com.sfa.vo.DateReportVo;
import com.sfa.vo.DateVo;

@Service
public class DatePlanService {

	@Autowired
	PlanDateDao planDateDao;
	
	public int insertDate(DateVo dateVo) {
		// TODO Auto-generated method stub
		int no=planDateDao.insert(dateVo);
		
		return no;
	}
	public DateVo selectDate(DateVo dateVo) {
		// TODO Auto-generated method stub
		return planDateDao.select(dateVo);
	}

	public int updateDate(DateVo dateVo) {
		// TODO Auto-generated method stub
		return planDateDao.update(dateVo);
	}

	public int deleteDate(DateVo dateVo) {
		// TODO Auto-generated method stub
		return planDateDao.delete(dateVo);
	}
	public Long getGoal_sale(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub
		return planDateDao.selectGoal(dateReportVo);
	}
}
