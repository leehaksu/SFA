package com.sfa.controller.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.PositionService;
import com.sfa.vo.PositionVo;

@Controller
@RequestMapping("/m/position")
public class MobilePositionController {
	
	@Autowired
	PositionService positionService;

	@ResponseBody
	@RequestMapping("/select")
	public JSONResult getPosition(@RequestParam(value="id", required=true, defaultValue="") String id,PositionVo positionVo)
	{
		if("".equals(id))
		{
			return JSONResult.error("아이디 없습니다.");
		}
		positionVo.setId(id);
		List<PositionVo> list = positionService.getPosition(positionVo);
		if(list==null)
		{
			return JSONResult.fail("업체 좌표가 없습니다.");
		}else
		{
			return JSONResult.success(list);	
		}
		
	}
	@ResponseBody
	@RequestMapping("/")
	public JSONResult getPosition()
	{
		List<PositionVo> list = positionService.getPosition();
		if(list==null)
		{
			return JSONResult.fail("업체 좌표가 없습니다.");
		}else
		{
			return JSONResult.success(list);	
		}
		
	}
}
