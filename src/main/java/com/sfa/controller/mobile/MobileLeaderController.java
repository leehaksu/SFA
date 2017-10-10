package com.sfa.controller.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.DatePlanService;
import com.sfa.service.DateReportService;
import com.sfa.service.UserService;
import com.sfa.service.WeekPlanService;
import com.sfa.vo.DateReportVo;
import com.sfa.vo.DateVo;
import com.sfa.vo.UserVo;
import com.sfa.vo.WeekVo;

@Controller
@RequestMapping(value = "/m/team")
public class MobileLeaderController {

	@Autowired
	WeekPlanService weekPlanService;

	@Autowired
	DatePlanService datePlanService;

	@Autowired
	DateReportService DateReportService;

	@Autowired
	UserService userService;

	@ResponseBody
	@RequestMapping(value = "/select/{no}", method=RequestMethod.POST)
	public JSONResult week(@PathVariable(value = "no") Long no,
			@RequestParam(value = "id", required = true, defaultValue = "") String id,
			@RequestParam(value= "date", required= true, defaultValue= "")String date) {
		if ("".equals(id) || "".equals(date)) {
			return JSONResult.error("id값이 없습니다.");
		}
		UserVo userVo = userService.getLeader(id);
		System.out.println(userVo);
		if (userVo == null) {
			return JSONResult.error("팀장이 존재하지 않습니다.");
		} else if (!id.equals(userVo.getId()) ) {
			return JSONResult.error("팀장이 아닙니다.");
		}

		if(no==1)
		{
			List<WeekVo> list= weekPlanService.selectTotalWeek(id,date);
			return JSONResult.success(list);
			
		}else if(no==2)
		{
			List<DateVo> list = datePlanService.selectTotalDate(id,date); 
			return JSONResult.success(list);
			
		}else if (no==3)
		{
			List<DateReportVo> list = DateReportService.selectTotalReport(id,date);
			return JSONResult.success(list);
		}
		return JSONResult.error("서버에 예상치 못한 오류가 발생하였습니다.");
	}

}
