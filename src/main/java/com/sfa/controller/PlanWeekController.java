package com.sfa.controller;

import java.util.Calendar;
import java.util.List;

import javax.mail.MessagingException;

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
import com.sfa.service.DateReportService;
import com.sfa.service.UserService;
import com.sfa.service.WeekPlanService;
import com.sfa.util.ChangeDate;
import com.sfa.util.Push;
import com.sfa.vo.DayVo;
import com.sfa.vo.UserVo;
import com.sfa.vo.WeekVo;

@RequestMapping("/week")
@Controller
public class PlanWeekController {

	@Autowired
	private WeekPlanService weekPlanService;

	@Autowired
	private UserService userService;

	@Autowired
	private DateReportService dateReportService;

	@Autowired
	private Push push;

	@Auth
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertWeek(@ModelAttribute WeekVo weekVo, @AuthUser UserVo authUser, @ModelAttribute DayVo dayVo) {
		System.out.println("[controller]" + weekVo);
		if (authUser == null) {
			return "redirect:/user/login";
		} else {
			System.out.println("[controller] insert부분 들어옴");
			weekVo.setId(authUser.getId());
			boolean check = weekPlanService.insertWeek(weekVo, dayVo);
			System.out.println("[controller]" + check);
			if (check) {
				UserVo userVo = userService.getLeader(authUser.getId());

				try {
					push.Mail(userVo.getCompany_email(), weekVo.getTitle(),
							authUser.getName() + "[" + authUser.getGrade() + "]" + "님이 새로운 주간 계획이 등록되었습니다.\n"
									+ "<a herf='localhost:8080/sfa/week'> 내용 확인하러 가기 </a>",
							authUser.getId());
					UserVo userVo2 = userService.getLeader(userVo.getId());
					push.Message(weekVo.getId(), userVo2.getId(), 1);
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

				UserVo userVo2 = userService.getLeader(weekVo.getId());
				int no = push.Message(weekVo.getId(), userVo2.getId(), 1);
				if (no == 200) {
					System.out.println("정상적으로 발송되었습니다.");
				} else {
					System.out.println("정상적으로 발송되지 않았습니다.");
				}

				return "redirect:/week/";
			}
			return "plan/plan";
		}
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute WeekVo weekVo, Model model, @AuthUser UserVo authUser) {
		if (authUser == null) {
			return "redirect:/user/login";
		}
		weekVo.setId(authUser.getId());
		WeekVo temp_weekVo = weekPlanService.selectWeek(weekVo);
		if (weekVo.getTarget_figure() == temp_weekVo.getTarget_figure()) {

		}
		int no = weekPlanService.update(weekVo);
		if (no == 6) {
			UserVo userVo = userService.getLeader(authUser.getId());
			System.out.println("[controlloer]" + userVo);
			try {
				push.Mail(userVo.getCompany_email(), weekVo.getTitle(), authUser.getName() + "[" + authUser.getGrade()
						+ "]" + "님이 주간 계획을 업데이트 하였습니다.\n" + "<a herf='localhost:8080/sfa/week'> 내용 확인하러 가기 </a>",
						authUser.getId());
				UserVo userVo2 = userService.getLeader(userVo.getId());
				push.Message(weekVo.getId(), userVo2.getId(), 2);
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			return "plan/plan";
		}
		return "plan/plan";

	}

	@Auth
	@RequestMapping(value = { "/", "" }, method = RequestMethod.GET)
	public String main(@AuthUser UserVo authUser, Model model, DayVo dayVo) {

		if (authUser == null) {
			return "redirect:/user/login";
		} else {
			if (authUser.getLevel().equals("팀장")) {
				List<UserVo> members = userService.getTotalMember(authUser.getDept());
				model.addAttribute("members", members);
				return "plan/plan";
			} else {
				return "plan/plan";
			}
		}
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = { "/select" }, method = RequestMethod.GET)
	public JSONResult selectMonth(@RequestParam(value = "date", required = true, defaultValue = "") String date,
			@RequestParam(value = "id", required = true, defaultValue = "") String id, @AuthUser UserVo authUser,
			Model model, DayVo dayVo) {
		if (authUser == null) {
			return JSONResult.error("로그인 되지 않았습니다.");
		} else if ("".equals(id)) {
			return JSONResult.error("아이디값이 없습니다.");
		}
		if ((authUser.getLevel()).equals("팀장")) {
			dayVo.setId(id);
		} else {
			dayVo.setId(authUser.getId());
		}

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
		}

		else {
			return JSONResult.success(list);
		}
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = { "/select" }, method = RequestMethod.POST)
	public JSONResult selectWeek(@AuthUser UserVo authUser,
			@RequestParam(value = "date", required = true, defaultValue = "") String Date,
			@RequestParam(value = "id", required = true, defaultValue = "") String id, WeekVo weekVo, UserVo userVo) {
		
		if (authUser == null) {
			return JSONResult.error("로그인 되지 않았습니다.");
		} else if ("".equals(id)) {
			return JSONResult.error("아이디값이 없습니다.");
		}
		if ((authUser.getLevel()).equals("팀장")) {
			weekVo.setId(id);
		} else {
			weekVo.setId(authUser.getId());
		}
		Calendar cal = Calendar.getInstance();
		if ("".equals(Date)) {
			String calendar = String.valueOf(cal.get(Calendar.YEAR)) + "-" + String.valueOf(cal.get(Calendar.MONTH) + 1)
					+ "-" + String.valueOf(cal.get(Calendar.DATE));
			weekVo.setFirst_date(calendar);
		} else {
			weekVo.setFirst_date(Date);
		}
		String [] dateArray = ChangeDate.five_date(weekVo.getFirst_date());
		
		WeekVo temp_weekVo = dateReportService.selectReport(dateArray[0],dateArray[4], weekVo.getId());
		System.out.println("[controller_temp_weekVo2]" + temp_weekVo);

		weekVo = weekPlanService.selectWeek(weekVo);
		System.out.println(weekVo);
		if (weekVo == null) {
			JSONResult.fail();
		}

		if (temp_weekVo == null) {
			weekVo.setAchive_rank(0.0);
			weekVo.setWeek_sale((long) 0);
		} else {
			System.out.println("여기는 들어와??!!!!!");
			weekVo.setWeek_sale(temp_weekVo.getWeek_sale());
			if (weekVo.getTarget_figure()==null || weekVo.getTarget_figure() == 0) {
				if (temp_weekVo.getWeek_sale() == 0) {
					weekVo.setAchive_rank(0.0);
				} else {
					weekVo.setAchive_rank(100);
				}

			} else {
				weekVo.setAchive_rank((temp_weekVo.getWeek_sale() / weekVo.getTarget_figure()) * 100);
			}
		}
		return JSONResult.success(weekVo);
	}
}
