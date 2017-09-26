package com.sfa.controller.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.ChallengeService;
import com.sfa.vo.ChallengeVo;

@Controller
@RequestMapping("/m/challenge")
public class MobileChallengeController {
	
	@Autowired
	ChallengeService challengeService;
	
	@ResponseBody
	@RequestMapping(value= {"","/"}, method=RequestMethod.POST)
	public JSONResult select(@RequestParam(value="dept", required=true, defaultValue="") String dept )
	{
		if("".equals(dept))
		{
			return JSONResult.error("정보가 정확하지 않습니다.");
		}
		List<ChallengeVo> list = challengeService.select(dept);
		
		if(list.isEmpty())
		{
			return JSONResult.fail("결과값 없음");
		}
		return JSONResult.success(list);
	}
	
	@ResponseBody
	@RequestMapping(value="/insert", method=RequestMethod.POST)
	public JSONResult insert(@ModelAttribute ChallengeVo challengeVo)
	{
		if(challengeVo==null)
		{
			JSONResult.error("정상적은 접근이 아닙니다.");
		}else if (challengeVo.getContent()==null || challengeVo.getDept()==null)
		{
			JSONResult.error("파라미터 조건이 충족되지 않았습니다.");
		}else
		{
			int no= challengeService.insert(challengeVo);
			if(no==1)
			{
				JSONResult.success("저장되었습니다.");
			}else
			{
				JSONResult.fail("저장되지 않았습니다.");
			}
		}
		return JSONResult.error("예상치 못한 오류가 발생했습니다.");
	}

}
