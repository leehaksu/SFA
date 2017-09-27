package com.sfa.controller.mobile;

import java.util.Calendar;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.UserService;
import com.sfa.service.WeekPlanService;
import com.sfa.util.PushMessage;
import com.sfa.vo.DayVo;
import com.sfa.vo.UserVo;
import com.sfa.vo.WeekVo;

@RequestMapping("/m/week")
@Controller
public class MobilePlanWeekController {

	@Autowired
	WeekPlanService weekPlanService;
	
	@Autowired
	PushMessage pushMessage;
	
	@Autowired
	UserService userService;

	@ResponseBody
	@RequestMapping(value = "/insert")
	public JSONResult insert(@ModelAttribute WeekVo weekVo, DayVo dayVo) {

		System.out.println("[mobile] insert 접속");
		System.out.println(weekVo);
		if (weekVo == null) {
			// weekVo의 내용이 하나도 오지 않을 경우
			return JSONResult.error("error_Plan_0x1");
		} else if (weekVo.getTitle() == null || weekVo.getTarget_figure() == null) {
			// weekVo의 내용중 일부가 오지 않을 경우
			return JSONResult.error("error_Plan_0x2");
		}
		if (weekPlanService.insertWeek(weekVo, dayVo) == true) {
			// insert 내용이 정상적으로 할때
			UserVo userVo= userService.getLeader(weekVo.getId());
			pushMessage.Push(weekVo.getId(),userVo.getId(), 1);
			return JSONResult.success();
		} else {
			// insert 내용이 실패일 경우
			return JSONResult.fail();
		}
	}

	@ResponseBody
	@RequestMapping(value = "/delete")
	public JSONResult delete(@ModelAttribute WeekVo weekVo) {
		System.out.println("[mobile] delete 접속");

		// 통신 파라미터가 하나도 존재하지 않았을 경우
		if (weekVo == null) {
			return JSONResult.error("error_Plan_0x2");
		} else if (weekVo.getId() == null || weekVo.getFirst_date() == null) {
			// 필주 소건 id랑 날짜가 존재하지 않았을 경우
			return JSONResult.error("error_plane_0x3");
		} else {
			if (weekPlanService.deleteWeek(weekVo) == true) {
				System.out.println("여기 들어왔니??");
				return JSONResult.success();
			} else {
				return JSONResult.fail();
			}
		}
	}

	@ResponseBody
	@RequestMapping(value = "/update")
	public JSONResult update(@ModelAttribute WeekVo weekVo) {
		System.out.println("[mobile] update 접속");
		// 주간계획에 정보가 하나도 오지 않았을 때
		System.out.println(weekVo);
		if (weekVo == null) {
			return JSONResult.error("error_Plan_0x3");
		} else if (weekVo != null & (weekVo.getTitle() == null || weekVo.getTarget_figure() == null)) {
			return JSONResult.error("erro_plan_0x4");
		}

		int no = 0;
		no += weekPlanService.update(weekVo);

		if (no == 20) {
			return JSONResult.success();
		} else if (no == 1) {
			return JSONResult.fail("주간계획이 존재하지 않습니다.");
		} else if (no > 1 && no < 20) {
			return JSONResult.fail("요일 업데이트가 실패하였습니다.error 번호 :" + no);
		} else {
			return JSONResult.fail("서버에 문제가 생겼습니다.");
		}
	}

	@ResponseBody
	@RequestMapping(value = "/select")
	public JSONResult select(@RequestParam(value = "id", required = true, defaultValue = "") String id,
			@RequestParam(value = "first_date", required = true, defaultValue = "") String first_date,
			HttpSession authUser, WeekVo weekVo, UserVo userVo) {
		System.out.println("[mobile] select 접속");
		weekVo.setFirst_date(first_date);
		weekVo.setId(id);
		System.out.println(weekVo.getFirst_date());
		if ("".equals(weekVo.getId())) {
			return JSONResult.error("error_Plan_0x4");
		}

		Calendar cal = Calendar.getInstance();
		if ("".equals(first_date)) {
			String calendar = String.valueOf(cal.get(Calendar.YEAR)) + "-" + String.valueOf(cal.get(Calendar.MONTH) + 1)
					+ "-" + String.valueOf(cal.get(Calendar.DATE));
			weekVo.setFirst_date(calendar);
		} else {
			weekVo.setFirst_date(first_date);
		}
		weekVo = weekPlanService.selectWeek(weekVo);
		if (weekVo == null) {
			return JSONResult.fail();
		} else if (weekVo.getWeek_no() == null) {
			return JSONResult.fail(weekVo);
		} else {
			return JSONResult.success(weekVo);
		}

	}

	@ResponseBody
	@RequestMapping("/check")
	public JSONResult check(@RequestParam(value = "id", required = true, defaultValue = "") String id,
			@RequestParam(value = "first_date", required = true, defaultValue = "") String first_date, WeekVo weekVo) {
		System.out.println("[mobile] check 접속");

		weekVo.setId(id);
		weekVo.setFirst_date(first_date);

		if ("".equals(weekVo.getId())) {
			return JSONResult.error("error_Plan_0x5i");
		}
		if ("".equals(weekVo.getFirst_date())) {
			return JSONResult.error("error_Plan_0x5d");
		}
		weekVo = weekPlanService.checkWeek(weekVo);

		if (weekVo.getTitle() == null) {
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}
	}
}
