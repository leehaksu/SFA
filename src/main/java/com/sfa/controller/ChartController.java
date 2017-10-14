package com.sfa.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.ChartService;
import com.sfa.util.ChangeListMap;
import com.sfa.vo.ChartVo;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping(value = "/chart")
public class ChartController {

	@Autowired
	private ChartService chartService;
	
	@Autowired
	private ChangeListMap changeListMap;

	@Auth
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String chart(@AuthUser UserVo authUser) {
		return "chart/teamchart";
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/sale", method = RequestMethod.POST)
	public JSONResult getSaleByYear(@AuthUser UserVo authUser,
			@RequestParam(value = "date", required = true, defaultValue = "") String date) {
		if ("".equals(date)) {
			return JSONResult.error("날짜 값이 들어오지 않았습니다.");
		}
		List<ChartVo> list = chartService.getSaleByYear(authUser.getId(), date);
		HashMap <String,Long> map =changeListMap.change(list);
		if (list == null) {
			return JSONResult.fail();
		} else {
			return JSONResult.success(map);
		}

	}
	@Auth
	@ResponseBody
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
