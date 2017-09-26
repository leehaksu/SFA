package com.sfa.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.DateReportVo;

@Repository
public class DateReportDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public int insert(DateReportVo dateReportVo)
	{
		return sqlSession.insert("datereport.insert",dateReportVo);
	}

	public int update(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("datereport.update",dateReportVo);
	}

	public int delete(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("datereport.delete",dateReportVo);
	}
	public DateReportVo select(String id, String date, int approval) {
		// TODO Auto-generated method stub
		Map<String, Object> map =new HashMap<String,Object>();
		map.put("id", id);
		map.put("date", date);
		map.put("approval",approval);
		
		return sqlSession.selectOne("datereport.getApproval",map);
	}
	
	public List<DateReportVo> select(String id) {
		// TODO Auto-generated method stub
		Map<String, String> map =new HashMap<String,String>();
		map.put("id", id);
		return sqlSession.selectList("datereport.getById",map);
	}
	public List<DateReportVo> select(String id,String date) {
		// TODO Auto-generated method stub
		Map<String, String> map =new HashMap<String,String>();
		map.put("id", id);
		map.put("date", date);
		return sqlSession.selectList("datereport.getByDate",map);
	}
	
	public List<DateReportVo> selectWeek(String id) {
		// TODO Auto-generated method stub
		Map<String, String> map =new HashMap<String,String>();
		map.put("id", id);
		return sqlSession.selectList("datereport.getByWeek",map);
	}
	
	public List<DateReportVo> selectBydept(String dept) {
		// TODO Auto-generated method stub
		Map<String, String> map =new HashMap<String,String>();
		map.put("dept", dept);
		return sqlSession.selectList("datereport.getByDept",map);
	}

	public int updateGauage(DateReportVo dateReportVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("datereport.updateGuage",dateReportVo);
	}

	public List<DateReportVo> selectByPeriod(String id, String startDate, String endDate) {
		// TODO Auto-generated method stub
		HashMap<String, String> map = new HashMap<String,String>();
		map.put("id", id);
		map.put("startDate", startDate);
		map.put("endDate", endDate);
		System.out.println(map);
		return sqlSession.selectList("datereport.getByPeriod", map);
	}

	public DateReportVo selectReport(Long report_no) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("datereport.selectByNo",report_no);
	}

	public int update(Long report_no, Long approval) {
		// TODO Auto-generated method stub
		HashMap<String, Object> map = new HashMap<String,Object>();
		map.put("report_no", report_no);
		map.put("approval", approval);
		return sqlSession.update("datereport.updateApproval",map);
	}

}
