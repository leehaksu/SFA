package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.ChallengeDao;
import com.sfa.repository.PlanDateDao;
import com.sfa.repository.UserDao;
import com.sfa.vo.ChallengeVo;

@Service
public class ChallengeService {

	@Autowired
	ChallengeDao challengeDao;
	
	@Autowired
	UserDao userDao;
	
	@Autowired
	PlanDateDao planDateDao;
	
	public List<ChallengeVo> select(String dept) {
		// TODO Auto-generated method stub
		
		return challengeDao.select(dept);
	}

	public int insert(ChallengeVo challengeVo) {
		// TODO Auto-generated method stub
		return challengeDao.insert(challengeVo);
	}
	
	public int selectByContent(String Content,String dept) {
		// TODO Auto-generated method stub
		return challengeDao.selectByContent(Content,dept);
	}

	public int delete(ChallengeVo challengeVo) {
		// TODO Auto-generated method stub
		return challengeDao.update(challengeVo);
	}

}
