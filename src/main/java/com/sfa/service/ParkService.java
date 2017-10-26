package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.ParkDao;
import com.sfa.vo.ParkVo;

@Service
public class ParkService {
	@Autowired
	private ParkDao parkDao;
	
	public int insert(ParkVo parkVo)
	{
		return parkDao.insert(parkVo); 
	}
	
	public List<ParkVo> select(ParkVo parkVo)
	{
		return parkDao.select(parkVo);
	}

}
