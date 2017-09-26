package com.sfa.controller;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import com.sfa.service.ChallengeService;
import com.sfa.service.WeekPlanService;

import com.sfa.vo.DayVo;
import com.sfa.vo.UserVo;
import com.sfa.vo.WeekVo;

@RequestMapping("/week")
@Controller
public class PlanWeekController {

	@Autowired
	WeekPlanService weekPlanService;

	@Autowired
	ChallengeService challengeService;

	@Auth
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertWeek(@ModelAttribute WeekVo weekVo, HttpSession authUser, @ModelAttribute DayVo dayVo) {
		UserVo userVo = (UserVo) authUser.getAttribute("authUser");
		if (userVo.getId() == null) {
			return "user/login";
		} else {
			weekVo.setId(userVo.getId());
			System.out.println(weekVo);
			boolean check = weekPlanService.insertWeek(weekVo, dayVo);
			if (check) {
				return "plan/plan";
			}
			return "plan/plan";
		}
	}

	@Auth
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String deleteWeek(@ModelAttribute WeekVo weekVo, HttpSession authUser) {
		UserVo userVo = (UserVo) authUser.getAttribute("authUser");
		if (userVo == null) {
			return "user/login";
		} else if (weekVo == null) {
			return "/week";
		}
		boolean check = weekPlanService.deleteWeek(weekVo);
		if (check == false) {
			return "plan/plan";
		}
		return "plan/plan";
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute WeekVo weekVo, Model model, HttpSession authUser) {
		UserVo userVo = (UserVo) authUser.getAttribute("authUser");
		weekVo.setId(userVo.getId());

		int no = weekPlanService.update(weekVo);
		if (no == 6) {
			return "plan/plan";
		}
		return "plan/plan";

	}

	@Auth
	@RequestMapping(value = { "/", "" }, method = RequestMethod.GET)
	public String main(@AuthUser UserVo authUser, Model model, DayVo dayVo) {

		if (authUser == null) {
			return "user/login";
		} else {
			return "plan/plan";
		}

	}

	@Auth
	@ResponseBody
	@RequestMapping(value = { "/select" }, method = RequestMethod.GET)
	public JSONResult selectMonth(@RequestParam(value = "date", required = true, defaultValue = "") String date,
			HttpSession authUser, Model model, DayVo dayVo) {
		UserVo userVo = (UserVo) authUser.getAttribute("authUser");
		if (userVo == null) {
			return JSONResult.error("로그인 되지 않았습니다.");
		}
		dayVo.setId(userVo.getId());

		if ("".equals(date)) {
			Calendar cal = Calendar.getInstance();
			String calendar = String.valueOf(cal.get(Calendar.YEAR)) + "-" + String.valueOf(cal.get(Calendar.MONTH) + 1)
					+ "-" + String.valueOf(cal.get(Calendar.DATE));
			dayVo.setFirst_date(calendar);
		} else {
			dayVo.setFirst_date(date);
		}

		List<DayVo> list = weekPlanService.selectMonth(dayVo);
		if (list == null) {
			return JSONResult.fail("제대로 불러오지 못햇습니다.");
		} else {
			return JSONResult.success(list);
		}
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = { "/select" }, method = RequestMethod.POST)
	public JSONResult selectWeek(HttpSession authUser,
			@RequestParam(value = "date", required = true, defaultValue = "") String Date, WeekVo weekVo,
			UserVo userVo) {
		System.out.println("[Controller]" + Date);
		userVo = (UserVo) authUser.getAttribute("authUser");
		weekVo.setId(userVo.getId());
		Calendar cal = Calendar.getInstance();
		if ("".equals(Date)) {
			String calendar = String.valueOf(cal.get(Calendar.YEAR)) + "-" + String.valueOf(cal.get(Calendar.MONTH) + 1)
					+ "-" + String.valueOf(cal.get(Calendar.DATE));
			weekVo.setFirst_date(calendar);
		} else {
			weekVo.setFirst_date(Date);
		}
		weekVo = weekPlanService.selectWeek(weekVo);

		if (weekVo == null) {
			JSONResult.error("서버에 error 발생");
		} else if (weekVo.getMonday() == null) {
			JSONResult.fail(weekVo);
		}
		return JSONResult.success(weekVo);
	}
}
