package com.sfa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.CustomerService;
import com.sfa.service.PositionService;
import com.sfa.util.CreateCustomerCode;
import com.sfa.vo.CustomerVo;
import com.sfa.vo.PositionVo;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/customer")
public class CustomerController {

	@Autowired
	CustomerService customerService;
	
	@Autowired
	PositionService positionService;


	
	@Auth
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insert(@ModelAttribute CustomerVo customerVo) {
		return "customer/insert";
	}
	
	@Auth
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@ModelAttribute CustomerVo customerVo, @AuthUser UserVo authUser) {
		if(authUser==null)
		{
			return JSONResult.error("로그인 세션이 만료되었습니다.");
		}else if (customerVo==null)
		{
			return JSONResult.error("고객정보가 들어오지 않았습니다.");
		}else
		{
			int no=customerService.insert(customerVo);
			if(no==1)
			{
				return JSONResult.success();
			}else
			{
				return JSONResult.fail("저장에 실패하였습니다.");
			}
		}

	}
	@Auth
	@ResponseBody
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	public JSONResult select(CustomerVo customerVo, @AuthUser UserVo authUser) {
		if(authUser==null)
		{
			return JSONResult.error("id 세션이 끝났습니다.");
		}
		List<CustomerVo> list = customerService.select(authUser.getId());
		return JSONResult.success(list);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute CustomerVo customerVo, @AuthUser UserVo authUser) {
		return null;
	}

	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@ModelAttribute CustomerVo customerVo, @AuthUser UserVo authUser) {
		return null;
	}
	@Auth
	@ResponseBody
	@RequestMapping(value = "/position", method = RequestMethod.POST)
	public JSONResult getPosition(@AuthUser UserVo authUser,PositionVo positionVo) {
		if (authUser == null) {
			return JSONResult.error("로그인 되지 않았습니다.");
		} else {
			positionVo.setId(authUser.getId());
			List<PositionVo> list = positionService.getPosition(positionVo);
			return JSONResult.success(list);
		}
	}
	
	// test를 위한 코드
	@Auth
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search() {
		return "customer/search";
	}
}
