package com.sfa.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sfa.service.CustomerService;
import com.sfa.vo.CustomerVo;

@Component
public class CreateCustomerCode {

	@Autowired
	private CustomerService customerService;

	public String create() {
		String temp_code;
		CustomerVo customerVo = customerService.select_last();
		if (customerVo == null) {
			return "A_001";
		} else {
			String temp_customer_code = customerVo.getCustomer_code().substring(2);
			int code = Integer.parseInt(temp_customer_code);
			code += 1;
			if (code < 10) {
				temp_code = "00" + String.valueOf(code);
			} else if (code >= 10 && code < 100) {
				temp_code = "0" + String.valueOf(code);
			} else {
				temp_code = String.valueOf(code);
			}
			String customer_code = "A_" + temp_code;
			System.out.println(customer_code);
			return customer_code;
		}

	}

}
