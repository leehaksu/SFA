package com.sfa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
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
	public String insert(@ModelAttribute CustomerVo customerVo) {
		return "customer/insert";
	}
	
	//TEST detail
	@Auth
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public String detail(@ModelAttribute CustomerVo customerVo) {
		return "customer/customer_detail";
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@ModelAttribute CustomerVo customerVo, @AuthUser UserVo authUser) {
		if (authUser == null) {
			return JSONResult.error("로그인 세션이 만료되었습니다.");
		} else if (customerVo == null) {
			return JSONResult.error("고객정보가 들어오지 않았습니다.");
		} else {
			int no = customerService.insert(customerVo);
			if (no == 1) {
				return JSONResult.success();
			} else {
				return JSONResult.fail("저장에 실패하였습니다.");
			}
		}

	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/select", method = RequestMethod.GET)
	public JSONResult select(CustomerVo customerVo, @AuthUser UserVo authUser) {
		if (authUser == null) {
			return JSONResult.error("id 세션이 끝났습니다.");
		}
		List<CustomerVo> list = customerService.select(authUser.getId());
		return JSONResult.success(list);
	}
	@Auth
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute CustomerVo customerVo, @AuthUser UserVo authUser) {
		if (customerVo == null || authUser == null) {
			return "customer/update";
		}
		customerVo.setId(authUser.getId());
		int no = customerService.update(customerVo);
		if (no == 1) {
			return "redirect:/customer/search";
		} else {
			return "customer/update?result=fail";
		}
	}
	@Auth
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public JSONResult delete(@ModelAttribute CustomerVo customerVo, @AuthUser UserVo authUser) {
		if (customerVo == null || authUser == null) {
			return JSONResult.error("정상적인 접근이 아닙니다.");
		}
		return null;
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/position", method = RequestMethod.POST)
	public JSONResult getPosition(@AuthUser UserVo authUser, PositionVo positionVo) {
		if (authUser == null) {
			return JSONResult.error("로그인 되지 않았습니다.");
		} else {
			positionVo.setId(authUser.getId());
			List<PositionVo> list = positionService.getPosition(positionVo);
			return JSONResult.success(list);
		}
	}

	@Auth
	@RequestMapping(value = "/search", method = RequestMethod.GET)
	public String search(@AuthUser UserVo authUser, Model model) {
		List<CustomerVo> list = customerService.select(authUser.getId());
		model.addAttribute("list", list);
		System.out.println(list);
		return "customer/search";
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/search/name", method = RequestMethod.GET)
	public JSONResult searchByName(@AuthUser UserVo authUser,
			@RequestParam(value = "name", required = true, defaultValue = "") String name) {
		if ("".equals(name)) {
			return JSONResult.error("고객 이름을 넣어주세요");
		}
		List<CustomerVo> list = customerService.selectByName(name);
		if(list==null)
		{
			return JSONResult.fail();
		}
		return JSONResult.success(list);
	}
}
