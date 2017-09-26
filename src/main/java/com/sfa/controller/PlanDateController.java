package com.sfa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.ChallengeService;
import com.sfa.service.DatePlanService;
import com.sfa.service.PositionService;
import com.sfa.vo.DateVo;
import com.sfa.vo.PositionVo;
import com.sfa.vo.UserVo;

@RequestMapping("/date")
@Controller
public class PlanDateController {

	@Autowired
	DatePlanService datePlanService;

	@Autowired
	PositionService positionService;

	@Autowired
	ChallengeService challengeService;

	@Auth
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@ModelAttribute DateVo dateVo, @AuthUser UserVo authUser, UserVo userVo, Model model) {
		
		if (dateVo.getDate()==null || dateVo.getTitle() == null || dateVo.getGoal_sale() == -1 || dateVo.getChallenge_content()==null) {
			return JSONResult.error("날짜,제목,목표액,도전과제 설정 바랍니다.");
		} else {
			dateVo.setId(authUser.getId());
			int number = challengeService.selectByContent(dateVo.getChallenge_content(),authUser.getDept());
			if (number != 0) {
				dateVo.setChallenge_no((long) number);
			}
			int no = datePlanService.insertDate(dateVo);
			if (no == 1) {
				model.addAttribute("DateVo", dateVo);
				return JSONResult.success(dateVo);
			} else {
				return JSONResult.fail();
			}
		}
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/select", method = RequestMethod.POST)
	public JSONResult select(@ModelAttribute DateVo dateVo, @AuthUser UserVo authUser, UserVo userVo, PositionVo postionVo) {
		if (dateVo.getDate() == null) {
			return JSONResult.error("날짜 넘어오지 않았습니다.");
		} else {
			dateVo.setId(authUser.getId());
			System.out.println(dateVo);
			dateVo = datePlanService.selectDate(dateVo);
			if (dateVo == null) {
				return JSONResult.fail();
			} else {
				return JSONResult.success(dateVo);
			}
		}
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public JSONResult update(@ModelAttribute DateVo dateVo,@AuthUser UserVo authUser, UserVo userVo) {
		if (dateVo.getDate()==null || dateVo.getTitle() == null || dateVo.getGoal_sale() == -1 || dateVo.getChallenge_content()==null) {
			return JSONResult.error("날짜,제목,목표액,도전과제 설정 바랍니다.");
		} else {
			dateVo.setId(authUser.getId());
			
			int number = challengeService.selectByContent(dateVo.getChallenge_content(),authUser.getDept());
			if (number != 0) {
				dateVo.setChallenge_no((long) number);
			}
			int no = datePlanService.updateDate(dateVo);

			if (no == 1) {
				return JSONResult.success();
			} else {
				return JSONResult.fail();
			}
		}

	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public JSONResult delete(@ModelAttribute DateVo dateVo, @AuthUser UserVo authUser, UserVo userVo) {
		if (dateVo.getDate() == null) {
			return JSONResult.error("날짜 넘어오지 않았습니다.");
		} else {
			int no = datePlanService.deleteDate(dateVo);
			if (no == 1) {
				return JSONResult.success();
			} else {
				return JSONResult.fail();
			}
		}
	}
}
