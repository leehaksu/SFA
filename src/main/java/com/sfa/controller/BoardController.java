package com.sfa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping(value="/board")
public class BoardController {
	
	@Auth
	@RequestMapping(value="/", method=RequestMethod.GET)
	public String board(@AuthUser UserVo authUser)
	{
		return "board/notice";
	}

}
