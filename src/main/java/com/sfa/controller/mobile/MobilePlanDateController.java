package com.sfa.controller.mobile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;


import com.sfa.dto.JSONResult;
import com.sfa.service.ChallengeService;
import com.sfa.service.DatePlanService;
import com.sfa.service.WeekPlanService;
import com.sfa.vo.DateVo;

@RequestMapping("/m/date")
@Controller
public class MobilePlanDateController {

	@Autowired
	private DatePlanService datePlanService;
	
	@Autowired
	private ChallengeService challengeService;
	
	@Autowired
	private WeekPlanService weekPlanService;
	
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@ModelAttribute DateVo dateVo,@RequestParam("dept") String dept) {
		System.out.println("insert 들어옴");
		System.out.println(dateVo);
		if (dateVo.getTitle() == null || dateVo.getContent()==null) {
			return JSONResult.error("제목과 내용,목표액 설정 바랍니다.");
		}else if ( dateVo.getChallenge_content()==null)
		{
			return JSONResult.error("도전과제 내용이 없습니다.");
		}else {
			int number = challengeService.selectByContent(dateVo.getChallenge_content(),dept);
			dateVo.setChallenge_no((long) number);
			int no = datePlanService.insertDate(dateVo);
			if (no == 1) {
				return JSONResult.success();
			} else {
				return JSONResult.fail();
			}
		}
	}

	@ResponseBody
	@RequestMapping(value = "/select", method = RequestMethod.POST)
	public JSONResult select(@ModelAttribute DateVo dateVo) {
		if (dateVo.getDate() == null) {
			return JSONResult.error("날짜 넘어오지 않았습니다.");
		} else {
			dateVo = datePlanService.selectDate(dateVo);
			System.out.println(dateVo);
			if (dateVo == null ) {
				return JSONResult.fail();
			} else {
				Long goal_sale = weekPlanService.selectGoal_sale(dateVo.getDate(),dateVo.getId());
				dateVo.setGoal_sale(goal_sale);
				return JSONResult.success(dateVo);
			}
		}
	}

	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public JSONResult update(@ModelAttribute DateVo dateVo,@RequestParam("dept") String dept) {
	System.out.println(dateVo);
		if (dateVo.getDate() == null) {
			return JSONResult.error("날짜 넘어오지 않았습니다.");
		} else {
			int number = challengeService.selectByContent(dateVo.getChallenge_content(),dept);
			dateVo.setChallenge_no((long) number);
			int no = datePlanService.updateDate(dateVo);
			if (no == 1) {
				return JSONResult.success();
			} else {
				return JSONResult.fail();
			}
		}
	}
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public JSONResult delete(@ModelAttribute DateVo dateVo) {
		if(dateVo.getDate()==null)
		{
			return JSONResult.error("삭제할 날짜가 넘어오지 않습니다.");
		}else
		{
			int no= datePlanService.deleteDate(dateVo);
			if (no == 1) {
				return JSONResult.success();
			} else {
				return JSONResult.fail();
			}
		}
	}
}
