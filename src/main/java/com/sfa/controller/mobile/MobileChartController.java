package com.sfa.controller.mobile;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;

@Controller
@RequestMapping(value="/chart")
public class MobileChartController {
	
	@RequestMapping(value="/chart")
	@ResponseBody
	public JSONResult SaleByYear(@RequestParam(value="id", required=true, defaultValue="")String id )
	{
		if("".equals(id))
		{
			return JSONResult.error("아이디값이 들어오지 않았습니다.");
		}
		
		
		
		
		
		
		return null;
	}

}
