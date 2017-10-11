package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.PositionDao;
import com.sfa.vo.PositionVo;;

@Service
public class PositionService {

	@Autowired
	PositionDao positionDao;
		
	public List<PositionVo> getPosition(PositionVo positionVo) {
		// TODO Auto-generated method stub
		return positionDao.getPostion(positionVo);
	}


	public List<PositionVo> getPosition(String id) {
		// TODO Auto-generated method stub
		return positionDao.getPostion(id);
	}


	public int insertPosition(PositionVo positionVo) {
		// TODO Auto-generated method stub
		
		
		return positionDao.insertPosition(positionVo);
	}


	public int deletePosition(PositionVo positionVo) {
		// TODO Auto-generated method stub
		return positionDao.deletePosition(positionVo);
	}
	
	

}
