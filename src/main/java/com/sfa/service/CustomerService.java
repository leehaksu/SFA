package com.sfa.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sfa.repository.CustomerDao;
import com.sfa.util.CreateCustomerCode;
import com.sfa.vo.CustomerVo;

@Service
public class CustomerService {
	
	@Autowired
	CustomerDao customerDao;
	
	@Autowired
	UserService userService;
	
	@Autowired
	private CreateCustomerCode createCutomerCode;
	
	public List<CustomerVo> select(String id)
	{
		String dept=userService.getDept(id);
		return customerDao.select(dept);
	}

	public int insert(CustomerVo customerVo) {
		// TODO Auto-generated method stub
		customerVo.setCustomer_code(createCutomerCode.create());
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

	public CustomerVo select_last() {
		// TODO Auto-generated method stub
		return customerDao.select();
	}
	public List<CustomerVo> selectByName(String name) {
		// TODO Auto-generated method stub
		return customerDao.selectByName(name);
	}
}
