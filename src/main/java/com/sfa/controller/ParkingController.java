package com.sfa.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.ParkService;
import com.sfa.util.ChangeDate;
import com.sfa.vo.ParkVo;
import com.sfa.vo.UserVo;

@RequestMapping("/parking")
public class ParkingController {

	@Autowired
	private ParkService parkService;

	@Auth
	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@ModelAttribute ParkVo parkVo, @AuthUser UserVo authUser) {
		parkVo.setId(authUser.getId());
		parkVo.setDate(ChangeDate.today());
		int no = parkService.insert(parkVo);

		if (no == 1) {
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}
	}

	@Auth
	@ResponseBody
	@RequestMapping(value = "/select", method = RequestMethod.POST)
	public JSONResult select(@AuthUser UserVo authUser, ParkVo parkVo) {
		parkVo.setId(authUser.getId());
		parkVo.setDate(ChangeDate.today());

		List<ParkVo> list = parkService.select(parkVo);

		if (list == null) {
			return JSONResult.fail();
		} else {
			return JSONResult.success(list);
		}

	}
}
