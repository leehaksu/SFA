package com.sfa.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.ChartVo;

@Repository
public class ChartDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public List<ChartVo> getSaleByYear(String id,String date)
	{
		HashMap<String,String> map= new HashMap<String,String>();
		map.put("id", id);
		map.put("date", date);
		return sqlSession.selectList("chart.getSaleByYear", map);
	}
	
	public List<ChartVo> getMileByYear(String id,String date)
	{
		HashMap<String,String> map= new HashMap<String,String>();
		map.put("id", id);
		map.put("date", date);
		return sqlSession.selectList("chart.getMileByYear", map);
	}
}
