package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.AdviceDao;
import com.sfa.vo.AdviceVo;

@Service
public class AdviceService {

	@Autowired
	AdviceDao adviceDao;
	
	public int insert(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return adviceDao.insert(adviceVo);
	}

	public int update(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return adviceDao.update(adviceVo);
	}

	public int delete(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return adviceDao.delete(adviceVo);
	}

	public List<AdviceVo> select(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return adviceDao.select(adviceVo);
	}

	public List<AdviceVo> selectByAdviceNo(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return adviceDao.selectByAdviceNo(adviceVo);
	}

}
