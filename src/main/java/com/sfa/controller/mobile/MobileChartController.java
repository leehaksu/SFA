package com.sfa.controller.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.ChartService;
import com.sfa.vo.ChartVo;

@Controller
@RequestMapping(value = "/m/chart")
public class MobileChartController {

	@Autowired
	private ChartService chartService;

	@RequestMapping(value = "/sale", method = RequestMethod.POST)
	@ResponseBody
	public JSONResult SaleByYear(@RequestParam(value = "id", required = true, defaultValue = "") String id,
			@RequestParam(value = "date", required = true, defaultValue = "") String date) {
		if ("".equals(id) || "".equals(date)) {
			return JSONResult.error("아이디,날짜값이 들어오지 않았습니다.");
		}

		List<ChartVo> list = chartService.getSaleByYear(id, date);

		System.out.println(list);
		if (list.isEmpty()) {
			return JSONResult.fail();
		} else {
			return JSONResult.success(list);
		}

	}
	@RequestMapping(value = "/mile", method = RequestMethod.POST)
	@ResponseBody
	public JSONResult SaleBymile(@RequestParam(value = "id", required = true, defaultValue = "") String id,
			@RequestParam(value = "date", required = true, defaultValue = "") String date) {
		if ("".equals(id) || "".equals(date)) {
			return JSONResult.error("아이디,날짜값이 들어오지 않았습니다.");
		}

		List<ChartVo> list = chartService.getMileByYear(id, date);

		System.out.println(list);
		if (list.isEmpty()) {
			return JSONResult.fail();
		} else {
			return JSONResult.success(list);
		}

	}

}
