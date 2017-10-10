package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.CustomerDao;
import com.sfa.vo.CustomerVo;

@Service
public class CustomerService {
	
	@Autowired
	CustomerDao customerDao;
	
	public List<CustomerVo> select(String id)
	{
		return customerDao.select(id);
	}

	public int insert(CustomerVo customerVo) {
		// TODO Auto-generated method stub
		return customerDao.insert(customerVo);
	}

	public int update(CustomerVo customerVo) {
		// TODO Auto-generated method stub
		return customerDao.update(customerVo);
	}

	public int delete(String customer_code) {
		// TODO Auto-generated method stub
		return customerDao.delete(customer_code);
	}

}
