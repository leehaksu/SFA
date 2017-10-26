package com.sfa.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.ParkVo;

@Repository
public class ParkDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public int insert(ParkVo parkVo)
	{
		return sqlSession.insert("park.insert",parkVo);
	}
	
	public List<ParkVo> select(ParkVo parkVo)
	{
		return sqlSession.selectList("park.select",parkVo);
	}

}
