package com.sfa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.AffirmationService;
import com.sfa.service.WeekPlanService;
import com.sfa.util.PushMessage;
import com.sfa.vo.UserVo;
import com.sfa.vo.WeekVo;

@Controller
public class MainController {
	
	@Autowired
	WeekPlanService weekPlanService;
	
	@Autowired
	AffirmationService affirmationService;
	
	@Auth
	@RequestMapping(value="/main")
	public String main(Model model,WeekVo weekVo,@AuthUser UserVo authUser)
	{
		String Affirmation = affirmationService.select();
		System.out.println("Controller"+Affirmation);
		
		model.addAttribute("affrimation", Affirmation);
		
		//처음 들어왔을 때 화면
			return "main/main";	
	}
}
