package com.sfa.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.PositionVo;

@Repository
public class PositionDao {

	@Autowired
	SqlSession sqlSession;
	
	public List<PositionVo> getPostion(PositionVo positionVo) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("position.getPositionById",positionVo);
	}

	public List<PositionVo> getPostion() {
		// TODO Auto-generated method stub
		return sqlSession.selectList("position.getPosition");
	}

	public int insertPosition(PositionVo positionVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("position.insertPosition", positionVo);
	}

	public int deletePosition(PositionVo positionVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("position.deletePosition", positionVo);
	}

}
