package com.sfa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping(value="/chart")
public class ChartController {

	@Auth(value = Auth.Role.팀장)
	@RequestMapping(value="/",method=RequestMethod.GET)
	public String chart(@AuthUser UserVo authUser)
	{
		return "chart/teamchart";
	}
}
