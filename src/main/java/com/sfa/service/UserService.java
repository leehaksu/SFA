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
		userVo.setEmail(userVo.getId()+"@sfa.com");
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
}
