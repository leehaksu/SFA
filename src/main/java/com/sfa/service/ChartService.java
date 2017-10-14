package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.ChartDao;
import com.sfa.vo.ChartVo;

@Service
public class ChartService {
	
	@Autowired
	private ChartDao chartDao;
	
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

}
