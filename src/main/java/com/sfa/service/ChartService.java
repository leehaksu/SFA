package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.ChartDao;
import com.sfa.repository.UserDao;
import com.sfa.vo.ChartVo;
import com.sfa.vo.UserVo;

@Service
public class ChartService {
	
	@Autowired
	private ChartDao chartDao;
	
	@Autowired
	private UserDao userDao;
	
	public List<ChartVo> getSaleByYear(String id, String date)
	{
		return chartDao.getSaleByYear(id,date);
	}
	
	public List<ChartVo> getMileByYear(String id, String date)
	{
		return chartDao.getMileByYear(id,date);
	}

	public List<ChartVo> getEstimateByYear(String id, String date) {
		// TODO Auto-generated method stub
		return chartDao.getEstiMateMileByYear(id,date);
	}

	public List<ChartVo> getEstimateSaleByYear(String id, String date) {
		// TODO Auto-generated method stub
		return chartDao.getEstimateSaleByYear(id,date);
	}

	public List<ChartVo> getSaleById(String id, String date) {
		// TODO Auto-generated method stub
		UserVo userVo= userDao.getDept(id);
		return chartDao.getSaleById(id,date,userVo.getDept());
	}

	public List<ChartVo> getSaleByDept(String date) {
		// TODO Auto-generated method stub
		return chartDao.getSaleByDept(date);
	}

	public List<ChartVo> getEstimateSaleBydept(String date) {
		// TODO Auto-generated method stub
		return chartDao.getEstimateSaleBydept(date);
	}

}
