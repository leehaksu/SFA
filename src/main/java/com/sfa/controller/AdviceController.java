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
import com.sfa.service.AdviceService;
import com.sfa.util.Push;
import com.sfa.vo.AdviceVo;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/advice")
public class AdviceController {

	@Autowired
	AdviceService adviceService;
	
	@Autowired
	Push push;

	@Auth
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insertAdvice(@ModelAttribute AdviceVo adviceVo, @AuthUser UserVo authUser) {
	System.out.println(adviceVo);
	// 파라미터 들어오지 않은것 예외처리 필요
	adviceVo.setId(authUser.getId());
	int no = adviceService.insert(adviceVo);
		if (no == 1) {
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}
	}
	
	@Auth
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String select(@AuthUser UserVo authUser) {
		return null;
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/select", method = RequestMethod.POST)
	public JSONResult selectAdvice(@AuthUser UserVo authUser, @ModelAttribute AdviceVo adviceVo) {

		if (adviceVo == null) {
			return JSONResult.error("상담일지 내용이 없습니다.");
		} else {
			List<AdviceVo> list = adviceService.select(adviceVo);
			return JSONResult.success(list);
		}
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public JSONResult updateAdvice(@AuthUser UserVo authUser, @ModelAttribute AdviceVo adviceVo) {

		if (adviceVo == null) {
			return JSONResult.error("상담일지 내용이 없습니다.");
		}

		int no = adviceService.update(adviceVo);
		if (no == 1) {
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}

	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public JSONResult deleteAdvice(@AuthUser UserVo authUser, @ModelAttribute AdviceVo adviceVo) {
		if (adviceVo == null) {
			return JSONResult.error("상담일지 내용이 없습니다.");
		}
		int no = adviceService.delete(adviceVo);
		if (no == 1) {
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}
	}

}
