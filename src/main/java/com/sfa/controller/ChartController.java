package com.sfa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sfa.dto.JSONResult;
import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.ChartService;
import com.sfa.vo.ChartVo;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping(value = "/chart")
public class ChartController {

	@Autowired
	private ChartService chartService;

	@Auth
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String chart(@AuthUser UserVo authUser) {
		return "chart/teamchart";
	}

	@Auth
	@RequestMapping(value = "/sale", method = RequestMethod.POST)
	public JSONResult getSaleByYear(@AuthUser UserVo authUser,
			@RequestParam(value = "date", required = true, defaultValue = "") String date) {
		if ("".equals(date)) {
			return JSONResult.error("날짜 값이 들어오지 않았습니다.");
		}
		List<ChartVo> list = chartService.getSaleByYear(authUser.getId(), date);

		if (list == null) {
			return JSONResult.fail();
		} else {
			return JSONResult.success(list);
		}

	}
	@Auth
	@RequestMapping(value = "/mile", method = RequestMethod.POST)
	public JSONResult getMileByYear(@AuthUser UserVo authUser,
			@RequestParam(value = "date", required = true, defaultValue = "") String date) {
		if ("".equals(date)) {
			return JSONResult.error("날짜 값이 들어오지 않았습니다.");
		}
		List<ChartVo> list = chartService.getMileByYear(authUser.getId(), date);

		if (list == null) {
			return JSONResult.fail();
		} else {
			return JSONResult.success(list);
		}

	}
}
