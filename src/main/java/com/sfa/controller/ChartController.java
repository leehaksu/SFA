package com.sfa.controller;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.security.Auth;
import com.sfa.security.Auth.Role;
import com.sfa.security.AuthUser;
import com.sfa.service.ChartService;
import com.sfa.util.ChangeDate;
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
	public String chart(@AuthUser UserVo authUser,Model model) {
		String date=((ChangeDate.today()).substring(0, 4));
		model.addAttribute("date", date);
		return "chart/teamchart";
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/sale", method = RequestMethod.POST)
	public JSONResult getSaleByYear(@AuthUser UserVo authUser,
			@RequestParam(value = "date", required = true, defaultValue = "") String date) {
		if ("".equals(date)) {
			date=((ChangeDate.today()).substring(0, 4));
			System.out.println(date);
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
		@RequestMapping(value = "/sale/estimate", method = RequestMethod.POST)
		public JSONResult getEstimateSaleByYear(@AuthUser UserVo authUser,
				@RequestParam(value = "date", required = true, defaultValue = "") String date) {
			if ("".equals(date)) {
				date=((ChangeDate.today()).substring(0, 4));
			}
			List<ChartVo> list = chartService.getEstimateSaleByYear(authUser.getId(), date);
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
			date=((ChangeDate.today()).substring(0, 4));
		}
		List<ChartVo> list = chartService.getMileByYear(authUser.getId(), date);
		HashMap <String,Long> map =changeListMap.change(list);
		
		if (list == null) {
			return JSONResult.fail();
		} else {
			return JSONResult.success(map);
		}
	}
	
	@Auth
	@ResponseBody
	@RequestMapping(value = "/mile/estimate", method = RequestMethod.POST)
	public JSONResult getEstimateMileByYear(@AuthUser UserVo authUser,
			@RequestParam(value = "date", required = true, defaultValue = "") String date) {
		if ("".equals(date)) {
			date=((ChangeDate.today()).substring(0, 4));
		}
		List<ChartVo> list = chartService.getEstimateByYear(authUser.getId(), date);
		HashMap <String,Long> map =changeListMap.change(list);
		System.out.println("estimate"+map);
		if (list == null) {
			return JSONResult.fail();
		} else {
			return JSONResult.success(map);
		}
	}
	
	@Auth(value = Auth.Role.팀장)
	@ResponseBody
	@RequestMapping(value="/sale/id", method=RequestMethod.POST)
	public JSONResult getSaleById (@AuthUser UserVo authUser,@RequestParam(value="date",required=true, defaultValue="")String date,
			@RequestParam(value="id",required=true, defaultValue="")String id)
	{
		if ("".equals(date)) {
			date=((ChangeDate.today()).substring(0, 4));
		}
		List<ChartVo> list = chartService.getSaleById(id, date);
		System.out.println(list);
		return JSONResult.success(list);
	}
	
	@Auth(value = Auth.Role.팀장)
	@ResponseBody
	@RequestMapping(value="/sale/dept", method=RequestMethod.POST)
	public JSONResult getSaleBydept (@AuthUser UserVo authUser,@RequestParam(value="date",required=true, defaultValue="")String date)
	{
		if ("".equals(date)) {
			date=((ChangeDate.today()).substring(0, 4));
		}
		List<ChartVo> list = chartService.getSaleByDept(date);
		System.out.println(list);
		return JSONResult.success(list);
	}
	
	@Auth(value = Auth.Role.팀장)
	@ResponseBody
	@RequestMapping(value="/sale/dept/estimate", method=RequestMethod.POST)
	public JSONResult getEstimateSaleBydept (@AuthUser UserVo authUser,@RequestParam(value="date",required=true, defaultValue="")String date)
	{
		if ("".equals(date)) {
			date=((ChangeDate.today()).substring(0, 4));
		}
		List<ChartVo> list = chartService.getEstimateSaleBydept(date);
		System.out.println(list);
		return JSONResult.success(list);
	}
	
	@Auth(value = Auth.Role.팀장)
	@ResponseBody
	@RequestMapping(value="/mile/dept", method=RequestMethod.POST)
	public JSONResult getMileBydept (@AuthUser UserVo authUser,@RequestParam(value="date",required=true, defaultValue="")String date)
	{
		if ("".equals(date)) {
			date=((ChangeDate.today()).substring(0, 4));
		}
		List<ChartVo> list = chartService.getMileBydept(date);
		System.out.println(list);
		return JSONResult.success(list);
	}
	
	@Auth(value = Auth.Role.팀장)
	@ResponseBody
	@RequestMapping(value="/mile/dept/estimate", method=RequestMethod.POST)
	public JSONResult getEstimateMileBydept (@AuthUser UserVo authUser,@RequestParam(value="date",required=true, defaultValue="")String date)
	{
		if ("".equals(date)) {
			date=((ChangeDate.today()).substring(0, 4));
		}
		List<ChartVo> list = chartService.getEstimateMileBydept(date);
		System.out.println(list);
		return JSONResult.success(list);
	}
	
}
