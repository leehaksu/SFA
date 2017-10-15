package com.sfa.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.AdviceVo;

@Repository
public class AdviceDao {

	@Autowired
	SqlSession sqlSession;
	
	public int insert(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("advice.insert",adviceVo);
	}
	public int update(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("advice.update",adviceVo);
	}
	public int delete(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return sqlSession.delete("advice.delete",adviceVo);
	}
	public List<AdviceVo> select(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("advice.select",adviceVo);
	}
	public List<AdviceVo> selectByAdviceNo(AdviceVo adviceVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("advice.selectByadviceNo", adviceVo);
	}

}
