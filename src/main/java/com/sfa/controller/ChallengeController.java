package com.sfa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.ChallengeService;
import com.sfa.vo.ChallengeVo;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/week/challenge")
public class ChallengeController {

	@Autowired
	ChallengeService challengeService;

	@Auth
	@ResponseBody
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public JSONResult select(@AuthUser UserVo authUser) {

		if ("".equals(authUser.getDept())) {
			return JSONResult.error("정보가 정확하지 않습니다.");
		}
		List<ChallengeVo> list = challengeService.select(authUser.getDept());
		
		return JSONResult.success(list);
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@AuthUser UserVo authUser, @ModelAttribute ChallengeVo challengeVo) {
		if ("".equals(authUser.getDept())) {
			return JSONResult.error("정보가 정확하지 않습니다.");
		} else if (challengeVo == null) {
			return JSONResult.error("도전과제 내용이 정상적으로 오지 않았습니다.");
		}

		int no = challengeService.insert(challengeVo);

		if (no == 1) {
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public JSONResult delete(@AuthUser UserVo authUser, @ModelAttribute ChallengeVo challengeVo) {

		if ("".equals(authUser.getDept())) {
			return JSONResult.error("정보가 정확하지 않습니다.");
		} else if (challengeVo == null) {
			return JSONResult.error("도전과제 내용이 정상적으로 오지 않았습니다.");
		}
		int challenge_no = challengeService.selectByContent(challengeVo.getContent(), authUser.getDept());
		challengeVo.setChallenge_no((long) challenge_no);
		int no = challengeService.delete(challengeVo);
	
		if (no == 1) {
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}
	}

}
