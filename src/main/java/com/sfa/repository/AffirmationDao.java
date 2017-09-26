package com.sfa.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.AffirmationVo;

@Repository
public class AffirmationDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<AffirmationVo> select()
	{
		return sqlSession.selectList("affirmation.select"); 
	}

}
