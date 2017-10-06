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
	public String insert() {
		return "customer/insert";
	}
	@Auth
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@ModelAttribute CustomerVo customerVo, @AuthUser UserVo authUser) {
		if(authUser==null)
		{
			return JSONResult.error("로그인 세션이 만료되었습니다.");
		}else
		{
			
		}
		return null;

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
}
