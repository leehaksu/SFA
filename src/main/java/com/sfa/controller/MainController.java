package com.sfa.controller;



import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.AffirmationService;
import com.sfa.service.DatePlanService;
import com.sfa.service.DateReportService;
import com.sfa.service.WeekPlanService;
import com.sfa.util.ChangeDate;
import com.sfa.vo.DateReportVo;
import com.sfa.vo.DateVo;
import com.sfa.vo.UserVo;
import com.sfa.vo.WeekVo;

@Controller
public class MainController {
	
	@Autowired
	WeekPlanService weekPlanService;
	
	@Autowired
	AffirmationService affirmationService;
	
	@Autowired
	DatePlanService datePlanService;
	
	@Autowired
	DateReportService dateReportService;
	@Auth
	@RequestMapping(value="/main")
	public String main(Model model,WeekVo weekVo,@AuthUser UserVo authUser)
	{
		List<DateVo> date_list= datePlanService.selectMainDate(authUser.getId());
		List<DateReportVo>report_list =dateReportService.seletMainDate(authUser.getId());
		
		
		
		model.addAttribute("date_list", date_list);
		model.addAttribute("report_list", report_list);
		
		System.out.println(date_list+""+report_list);
		//처음 들어왔을 때 화면
			return "main/main";	
	}
}
