package com.sfa.repository;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.sfa.vo.CustomerVo;

@Repository
public class CustomerDao {

	@Autowired
	SqlSession sqlSession;
	public List<CustomerVo> select(String dept) {
		// TODO Auto-generated method stub
		HashMap <String,String> map= new HashMap<String,String>();
		map.put("dept", dept);
		return sqlSession.selectList("customer.selectbyDept", map);
	}
	public int insert(CustomerVo customerVo) {
		// TODO Auto-generated method stub
		return sqlSession.insert("customer.insert", customerVo);
	}
	public int update(CustomerVo customerVo) {
		// TODO Auto-generated method stub
		return sqlSession.update("customer.update",customerVo);
	}
	public int delete(String customer_code) {
		// TODO Auto-generated method stub
		return sqlSession.update("customer.delete",customer_code);
	}

}
