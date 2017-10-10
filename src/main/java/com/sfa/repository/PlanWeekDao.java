package com.sfa.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.DayVo;
import com.sfa.vo.WeekVo;

@Repository
public class PlanWeekDao {

	@Autowired
	SqlSession sqlSession;
	
	public int insertWeek(WeekVo weekVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("weekplan.insertWeek", weekVo);
	}
	
	public int deleteWeek(WeekVo weekVo)
	{
		System.out.println("[DAO]weekVo" + weekVo);
		return sqlSession.delete("weekplan.deleteWeek",weekVo);
	}
	public int insertDay(DayVo dayVo)
	{
		return sqlSession.insert("weekplan.insertDay", dayVo);
	}

	public int deletetotalDay(WeekVo weekVo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("weekplan.deletetotalDay",weekVo);
	}
	public int update(DayVo dayVo)
	{
		System.out.println("Dao"+dayVo);
		return sqlSession.update("weekplan.update",dayVo);
	}

	public int updateMonday(WeekVo weekVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("weekplan.updateMonday",weekVo);
	}

	public int updateTuesday(WeekVo weekVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("weekplan.updateTuesday",weekVo);
		
	}

	public int updatewednesday(WeekVo weekVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("weekplan.updateWednesday",weekVo);
	}

	public int updateThursday(WeekVo weekVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("weekplan.updateThursday",weekVo);
	}

	public int updateFriday(WeekVo weekVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("weekplan.updateFriday",weekVo);
	}

	public WeekVo selectWeek(WeekVo weekVo) {
		// TODO Auto-generated method stub
		System.out.println("[planDao]" + weekVo);
		
		return sqlSession.selectOne("weekplan.getWeek", weekVo);
	}
	public List<DayVo> selectDay(WeekVo weekVo) {
		// TODO Auto-generated method stub
	
		return sqlSession.selectList("weekplan.getWeek_Day", weekVo);
	}

	public WeekVo checkWeek(WeekVo weekVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("weekplan.checkWeek",weekVo);
	}

	public int update(WeekVo weekVo) {
		// TODO Auto-generated method stub
		System.out.println("[dao]" + weekVo);
		return sqlSession.update("weekplan.updateWeek",weekVo);
	}

	public List<DayVo> selectMonth(String id,String Date1,String Date2, String Date3) {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("Date1",Date1);
		map.put("Date2",Date2);
		map.put("Date3",Date3);
		map.put("id",id);
		return sqlSession.selectList("weekplan.selectMonth",map);
	}

	public List<WeekVo> selectTotalWeek(String id,String week_no) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("week_no", week_no);
		map.put("id", id);
		return sqlSession.selectList("weekplan.selectTotalWeek", map);
	}

	public List<DayVo> selectTotalDay(String id,String week_no) {
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("week_no", week_no);
		map.put("id", id);
		return sqlSession.selectList("weekplan.selectTotalDay", map);
		// TODO Auto-generated method stub
	}
}
