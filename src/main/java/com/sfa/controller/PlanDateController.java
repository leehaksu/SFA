package com.sfa.controller;

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
import com.sfa.service.ChallengeService;
import com.sfa.service.DatePlanService;
import com.sfa.service.UserService;
import com.sfa.util.Push;
import com.sfa.vo.CustomerVo;
import com.sfa.vo.DateVo;
import com.sfa.vo.UserVo;

@RequestMapping("/date")
@Controller
public class PlanDateController {

	@Autowired
	DatePlanService datePlanService;


	@Autowired
	ChallengeService challengeService;
	
	@Autowired
	private Push push;
	
	@Autowired
	private UserService userService;

	@Auth
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@ModelAttribute DateVo dateVo, @AuthUser UserVo authUser, UserVo userVo, Model model) {
		System.out.println(dateVo);
		if (dateVo.getDate()==null || dateVo.getTitle() == null || dateVo.getGoal_sale() == null || dateVo.getChallenge_content()==null) {
			return JSONResult.error("날짜,제목,목표액,도전과제 설정 바랍니다.");
		} else {
			dateVo.setId(authUser.getId());
			int number = challengeService.selectByContent(dateVo.getChallenge_content(),authUser.getDept());
			if (number != 0) {
				dateVo.setChallenge_no((long) number);
			}
			int no = datePlanService.insertDate(dateVo);
			if (no == 1) {
				UserVo userVo2 = userService.getLeader(authUser.getId());	
				try {
					push.Mail(userVo2.getCompany_email(), "제목 ["+dateVo.getTitle()+"]",
							"보고 사항  \n"
							+"날짜 : " + dateVo.getDate()+"\n"
							+"도전과제 : " + dateVo.getChallenge_content()+"\n"
							+"예상 주행거리 :" + dateVo.getEstimate_distance()+"\n"
							+"예상 목표 액 : " + dateVo.getGoal_sale()+"\n"
							+"내용 : " +dateVo.getContent()+"\n"
							+"<a herf='localhost:8080/sfa/date'> 내용 확인하러 가기 </a>", authUser.getId());
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
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
	public JSONResult select(@ModelAttribute DateVo dateVo, @AuthUser UserVo authUser,
			 UserVo userVo, CustomerVo customernVo) {
		System.out.println(dateVo);
		if (dateVo.getDate() == null ) {
			return JSONResult.error("날짜와 아이디가 넘어오지 않았습니다.");
		}else if("".equals(dateVo.getId()))
		{
			return JSONResult.error("아이디가 정상적이지 않습니다.");
		}
		else {
			if(authUser.getLevel().equals("팀장"))
			{
				dateVo.setId(dateVo.getId());
			}else
			{
				dateVo.setId(authUser.getId());
			}
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
				try {
					UserVo userVo2 = userService.getLeader(authUser.getId());	
					push.Mail(userVo2.getCompany_email(), "제목 ["+dateVo.getTitle()+"]",
							"보고 사항  \n"
							+"날짜 : " + dateVo.getDate()+"\n"
							+"도전과제 : " + dateVo.getChallenge_content()+"\n"
							+"예상 주행거리 :" + dateVo.getEstimate_distance()+"\n"
							+"예상 목표 액 : " + dateVo.getGoal_sale()+"\n"
							+"내용 : " +dateVo.getContent()+"\n"
							+"<a herf='localhost:8080/sfa/date'> 내용 확인하러 가기 </a>", authUser.getId());
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
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
		dateVo.setId(authUser.getId());
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
