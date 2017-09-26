package com.sfa.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.ChallengeVo;

@Repository
public class ChallengeDao {

	@Autowired
	SqlSession sqlSession;
	
	public List<ChallengeVo> select(String dept) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("challenge.select", dept);
	}

	public int insert(ChallengeVo challengeVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("challenge.insert", challengeVo);
	}

	public int selectByContent(String content,String dept) {
		// TODO Auto-generated method stub
		HashMap<String,String> map = new HashMap<String,String> ();
		map.put("content", content);
		map.put("dept", dept);
		return sqlSession.selectOne("challenge.selectByContent", map);
	}

	public int update(ChallengeVo challengeVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("challenge.deleteByContent", challengeVo);
	}
}
