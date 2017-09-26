package com.sfa.controller;

import java.util.List;

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
import com.sfa.vo.DateReportVo;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/report")
public class DateReportController {

	@Autowired
	DateReportService dateReprotService;

	@Auth
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insert() {
		return "plan/report";
	}

	@Auth
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public String insertDateReport(@ModelAttribute DateReportVo dateReortVo, @AuthUser UserVo authUser) {

		if (authUser == null) {
			return "user/login";
		} else if (dateReortVo == null) {
			return "plan/report";
		} else {
			dateReortVo.setId(authUser.getId());
			int no = dateReprotService.insert(dateReortVo);

			if (no == 1) {
				return "redirect:/report/";
			} else {
				return "plan/report";
			}
		}
	}

	@Auth
	@RequestMapping(value = {"","/"}, method = RequestMethod.GET)
	public String select(@AuthUser UserVo authUser, Model model) {
		List<DateReportVo> list = dateReprotService.selectWeek(authUser.getId());
		model.addAttribute("list", list);
		return "plan/report_search";
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/search", method = RequestMethod.POST)
	public JSONResult select(@AuthUser UserVo authUser,
			@RequestParam(value = "startDate", required = true, defaultValue = "") String startDate,
			@RequestParam(value = "endDate", required = true, defaultValue = "") String endDate) {
		if ("".equals(startDate) || "".equals(endDate)) {
			return JSONResult.error("기간 설정이 정상적으로 되지 않았습니다.");
		} else {
			List<DateReportVo> list = dateReprotService.selectByPeriod(authUser.getId(), startDate, endDate);
			return JSONResult.success(list);
		}
	}
	@Auth
	@ResponseBody
	@RequestMapping(value="/select", method=RequestMethod.GET)
	public JSONResult select(@RequestParam(value="report_no", required=true, defaultValue="") Long report_no,Model model)
	{
		DateReportVo dateReportVo = dateReprotService.selectReport(report_no);
		model.addAttribute("dateReportVo", dateReportVo);
		
		return null;//report_detail로 넘겨줄 예정 ->파일 생성되지 않음.
		
	}

	@Auth
	@ResponseBody
	@RequestMapping(value="/select", method=RequestMethod.POST)
	public JSONResult selectVo(@AuthUser UserVo authUser,@RequestParam(value = "Date", required = true, defaultValue = "") String Date)
	{
		List<DateReportVo> list= dateReprotService.select(authUser.getId(), Date);
		return JSONResult.success(list);
	}

	@Auth
	@RequestMapping(value = "/update", method = RequestMethod.GET)
	public String update(@RequestParam(value = "report_no", required = true, defaultValue = "0") Long report_no,
			@AuthUser UserVo authUser, Model model) {
		if (report_no == 0) {
			return "redirect:/report/";
		} else {
			DateReportVo dateReportVo = dateReprotService.selectReport(report_no);
			model.addAttribute("dateReport", dateReportVo);
			return "plan/report";
		}
	}

	@Auth
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(@ModelAttribute DateReportVo dateReportVo, @AuthUser UserVo authUser) {
		if (dateReportVo == null) {
			return "plan/report";
		} else {
			int no = dateReprotService.update(dateReportVo);

			if (no == 1) {
				return "redirect:/report/?result=succeess";
			} else {
				return "redirect:/report/?result=fail";
			}
		}
	}

	@Auth
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@RequestParam(value = "report_no", required = true, defaultValue = "0") Long report_no,
			@AuthUser UserVo authUser, DateReportVo dateReportVo) {
		if (report_no == 0) {
			return "redirect:/report/";
		} else {
			dateReportVo.setReport_no(report_no);
			int no = dateReprotService.delete(dateReportVo);

			if (no == 1) {
				return "redirect:/report/?result=succeess";
			} else {
				return "redirect:/report/?result=fail";
			}
		}
	}
	
	@Auth
	@RequestMapping(value="/submit", method=RequestMethod.POST)
	public String submit(@RequestParam(value = "report_no", required = true, defaultValue = "0") Long report_no,
			@RequestParam(value = "approval", required = true, defaultValue = "0") Long approval,
			@AuthUser UserVo authUser)
	{
		if(report_no==0)
		{
			return "/report/";
		}else
		{
			int no = dateReprotService.updateApproval(report_no,approval);
			
			if( no==1)
			{
				return "redirect:/report?result=success";
			}else
			{
				return "/report?result=fail";
			}
		}
	}

}
