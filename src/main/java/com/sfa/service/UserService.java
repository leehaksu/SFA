package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.UserDao;
import com.sfa.vo.UserVo;

@Service
public class UserService {

	@Autowired
	private UserDao userDao;
	
	public UserVo getUser(String id, String password) {
		// TODO Auto-generated method stub
		
		System.out.println("[service] ID : " + id);
		System.out.println("[service] password : " + password);
		return userDao.get(id,password);
	}

	public boolean join(UserVo userVo) {
		// TODO Auto-generated method stub
		System.out.println("[service] 회원가입 : " + userVo);
		userVo.setCompany_email(userVo.getId()+"@leehacksue.cafe24.com");
		System.out.println("[service] 이메일 등록 후 :  " + userVo);
		
		if(userDao.insert(userVo)==1)
		{
			return true;
		}
		
		return false;
		
	}
	public UserVo getId(String id) {
		// TODO Auto-generated method stub

		System.out.println("[service] 아이디 체크 : " + id);
		UserVo userVo=userDao.get(id);
		System.out.println(userVo);
		return userVo;
	}

	public int modify(UserVo userVo) {
		// TODO Auto-generated method stub
		int no=userDao.modify(userVo);
		return no;
	}

	public List<UserVo> getMember(String name, String grade,String dept) {
		// TODO Auto-generated method stub
		return userDao.getMember(name,grade,dept);
	}

	public List<UserVo> getTotalMember(String dept) {
		// TODO Auto-generated method stub
		return userDao.getTotalMember(dept);
	}

	public int delete(UserVo userVo) {
		// TODO Auto-generated method stub
		return userDao.delete(userVo);
	}

	public String getDept(String id) {
		// TODO Auto-generated method stub
		String dept= (userDao.getDept(id)).getDept();
		return dept;
	}
	
	public UserVo getLeader(String id)
	{
	return userDao.getLeader(id);
	}

	public UserVo getId(String email, String name) {
		// TODO Auto-generated method stub
		return userDao.getId(email,name);
	}

	public int insertToken(String token, String id) {
		// TODO Auto-generated method stub
		return userDao.insertToken(token,id);
	}

	public String getToken(String id) {
		// TODO Auto-generated method stub
		return userDao.selectToken(id);
	}

	public int updateToken(String token, String id) {
		// TODO Auto-generated method stub
		return userDao.updateToken(token,id);
	}

	public List<UserVo> getemail(String email) {
		// TODO Auto-generated method stub
		return userDao.getEmail(email);
	}

	public int deleteToken(String id) {
		// TODO Auto-generated method stub
		return userDao.delteToken(id);
	}

	public UserVo getIdbyToken(String token) {
		// TODO Auto-generated method stub
		return userDao.getIdByToken(token);
	}

	public int insertKey(String user_key,String id) {
		// TODO Auto-generated method stub
		return userDao.insertKey(user_key,id);
	}

	public UserVo getKey(String user_key) {
		// TODO Auto-generated method stub
		return userDao.getKey(user_key);
	}

	public int updatePasswd(String id, String passwd) {
		// TODO Auto-generated method stub
		return userDao.updatePasswd(id,passwd);
	}

	public UserVo getUserByName(String id, String email) {
		// TODO Auto-generated method stub
		return userDao.getgetUserByName(id,email);
	}
}
