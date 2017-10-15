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

	public List<ChartVo> getEstiMateMileByYear(String id, String date) {
		// TODO Auto-generated method stub
		HashMap<String,String> map= new HashMap<String,String>();
		map.put("id", id);
		map.put("date", date);
		return sqlSession.selectList("chart.getEstimateDistanceByYear", map);
	}

	public List<ChartVo> getEstimateSaleByYear(String id, String date) {
		// TODO Auto-generated method stub
		HashMap<String,String> map= new HashMap<String,String>();
		map.put("id", id);
		map.put("date", date);
		return sqlSession.selectList("chart.getEstimateSaleByYear", map);
	}

	public List<ChartVo> getSaleById(String id, String date, String dept) {
		// TODO Auto-generated method stub
		HashMap<String,String> map= new HashMap<String,String>();
		map.put("id", id);
		map.put("date", date);
		map.put("dept", dept);
		return sqlSession.selectList("chart.getSaleById", map);
	}
}
