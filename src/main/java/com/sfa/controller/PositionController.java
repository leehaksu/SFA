package com.sfa.controller;

import java.util.List;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.security.AuthUser;
import com.sfa.service.PositionService;
import com.sfa.vo.PositionVo;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/position")
public class PositionController {

	@Autowired
	PositionService positionService;

	@ResponseBody
	@RequestMapping("/select")
	public JSONResult getPosition(@AuthUser UserVo authUser, PositionVo positionVo) {

		if (authUser == null) {
			return JSONResult.error("로그인 되지 않았습니다.");
		} else {
			positionVo.setId(authUser.getId());
			List<PositionVo> list = positionService.getPosition(positionVo);
			return JSONResult.success(list);
		}
	}

	@ResponseBody
	@RequestMapping(value = { "", "/" })
	public JSONResult getPosition(@AuthUser UserVo authUser) {
		List<PositionVo> list = positionService.getPosition(authUser.getId());
		return JSONResult.success(list);
	}

	@ResponseBody
	@RequestMapping("/insert")
	public JSONResult insertPosition(@ModelAttribute PositionVo positionVo, @AuthUser UserVo authUser) {
		if (authUser == null) {
			return JSONResult.error("로그인 되지 않았습니다.");
		} else if (positionVo == null) {
			return JSONResult.error("포지션 정보가 들어있지 않습니다.");
		}
		positionVo.setId(authUser.getId());
		int no = positionService.insertPosition(positionVo);
		if (no == 1) {
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}

	}
	@ResponseBody
	@RequestMapping("/delete")
	public JSONResult deletePosition(@ModelAttribute PositionVo positionVo, @AuthUser UserVo authUser)
	{
		if (authUser == null) {
			return JSONResult.error("로그인 되지 않았습니다.");
		} else if (positionVo == null) {
			return JSONResult.error("포지션 정보가 들어있지 않습니다.");
		}
		int no = positionService.deletePosition(positionVo);
		
		if(no==1)
		{
			return JSONResult.success();
		} else {
			return JSONResult.fail();
		}
	}

}
