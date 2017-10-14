package com.sfa.repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.UserVo;

@Repository
public class UserDao {
	
	@Autowired
	SqlSession sqlSession;
	
	public UserVo get(String id, String password) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		System.out.println("[Dao] ID : " + id);
		System.out.println("[Dao] password : " + password);
		
		map.put( "id", id );
		map.put( "password", password );
		return sqlSession.selectOne( "user.getByIdAndPassword", map );
	}
	
	public UserVo get(String id) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		System.out.println("[Dao] Check_ID : " + id);
		
		map.put( "id", id );
		return sqlSession.selectOne( "user.getById", map );
	}
	public int insert(UserVo userVo) {
		// TODO Auto-generated method stub
		System.out.println("[Dao] 회원가입 : " + userVo);
		
		return sqlSession.insert("user.insert",userVo);
	}

	public int modify(UserVo userVo) {
		// TODO Auto-generated method stub
		
		System.out.println(userVo);
		return sqlSession.update("user.updatePasswd", userVo);
	}

	public List<UserVo> getMember(String name,String grade,String dept) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put( "dept", dept );
		if("".equals(name))
		{
			map.put( "grade", grade );
			return sqlSession.selectList("user.selectMember", map);
			
		}else if("전체".equals(grade))
		{
			map.put( "name", name );
			return sqlSession.selectList("user.selectMember", map);
		}else
		{
			map.put( "name", name );
			map.put( "grade", grade );
			return sqlSession.selectList("user.selectMember", map);
		}
	}

	public List<UserVo> getTotalMember(String dept) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put( "dept", dept );
		return sqlSession.selectList("user.selectTotalMember", map);
	}
	public int delete(UserVo userVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("user.delete",userVo);
	}

	public UserVo getDept(String id) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put( "id", id );
		return sqlSession.selectOne("user.selectDept", map);
	}

	public UserVo getLeader(String id) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put( "id", id );
		map.put("level", "팀장");
		return sqlSession.selectOne("user.selectLeader", map);
	}

	public UserVo getId(String email, String name) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put( "email", email );
		map.put("name", name);
		return sqlSession.selectOne("user.getUserByName", map);
	}

	public int insertToken(String token, String id) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put( "token", token );
		map.put("id", id);
		return sqlSession.update("user.insertToken", map);
	}

	public String selectToken(String id) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.getToken", id);
	}

	public int updateToken(String token, String id) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put( "token", token );
		map.put("id", id);
		return sqlSession.update("user.updateToken",map);
	}

	public List<UserVo> getEmail(String email) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("email", email);
		return sqlSession.selectList("user.getEmail", map);
	}

	public int delteToken(String id) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		return sqlSession.delete("user.deleteToken", map);
	}

	public UserVo getIdByToken(String token) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("token", token);
		return sqlSession.selectOne("user.getIdbyToken",map);
	}

	public int insertKey(String user_key, String id) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_key", user_key);
		map.put("id", id);
		return sqlSession.insert("user.insertKey", map);
	}

	public UserVo getKey(String user_key) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("user_key", user_key);
		return sqlSession.selectOne("user.getKey", map);
	}

	public int updatePasswd(String id, String passwd) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("passwd", passwd);
		return sqlSession.update("user.updatePasswd",map);
	}

	public UserVo getgetUserByName(String id, String email) {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("id", id);
		map.put("email", email);
		return sqlSession.selectOne("user.getUserByEmail", map);
	}
}
