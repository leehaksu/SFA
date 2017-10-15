package com.sfa.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.DateReportVo;
import com.sfa.vo.DateVo;

@Repository
public class PlanDateDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public int insert(DateVo dateVo)
	{
		return sqlSession.insert("dateplan.insert_date",dateVo);
	}
	
	public DateVo select(DateVo dateVo)
	{
		return sqlSession.selectOne("dateplan.select_date", dateVo);
	}

	public int update(DateVo dateVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("dateplan.update_date",dateVo);
	}

	public int delete(DateVo dateVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("dateplan.delete_date",dateVo);
	}

	public Long selectGoal(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub
		dateReportVo=sqlSession.selectOne("dateplan.selctSale",dateReportVo);
		Long goal_sale;
		if(dateReportVo==null || dateReportVo.getGoal_sale()==null)
		{
			goal_sale=(long) 0;
		}else
		{
			 goal_sale= dateReportVo.getGoal_sale();	
		}
		
		return goal_sale;
	}
	public int updateBychallenge(Long challenge_no) {
		// TODO Auto-generated method stub
		HashMap<String , Object> map = new HashMap<String,Object>();
		map.put("challenge_no", challenge_no);
		
		return sqlSession.update("dateplan.updateByChallenge", map);
		
	}

	public DateVo select(String date, String id) {
		// TODO Auto-generated method stub
		HashMap<String , Object> map = new HashMap<String,Object>();
		map.put("date", date);
		map.put("id", id);
		return sqlSession.selectOne("dateplan.selectGoalSale",map);
	}

	public List<DateVo> selectTotalDate(String id, String date) {
		// TODO Auto-generated method stub
		HashMap<String , Object> map = new HashMap<String,Object>();
		map.put("date", date);
		map.put("id", id);
		return sqlSession.selectList("dateplan.selectTotalDate", map);
	}

	public List<DateVo> selectMainDate(String id) {
		// TODO Auto-generated method stub
		HashMap<String , Object> map = new HashMap<String,Object>();
		map.put("id", id);
		return sqlSession.selectList("dateplan.selectMainDate", map);
	}
}
