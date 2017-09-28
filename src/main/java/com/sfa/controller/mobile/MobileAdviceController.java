package com.sfa.controller.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.AdviceService;
import com.sfa.service.DateReportService;

import com.sfa.vo.AdviceVo;
import com.sfa.vo.DateReportVo;

@Controller
@RequestMapping("/m/advice")
public class MobileAdviceController {

	@Autowired
	AdviceService adviceService;

	@Autowired
	DateReportService dateReportService;

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insert(@ModelAttribute AdviceVo adviceVo, DateReportVo dateReportVo) {
		System.out.println(adviceVo);
		if (adviceVo == null) {
			return JSONResult.error("파라미터가 충족되지 않았습니다.");
		} else if (adviceVo.getId() == null) {
			return JSONResult.error("로그인이 필요합니다.");
		} else if (adviceVo.getDate() == null) {
			return JSONResult.error("날짜 입력바랍니다.");
		} else {
			int AdviceNo = adviceService.insert(adviceVo);
			if (AdviceNo == 1) {
				return JSONResult.success();
			} else {
				return JSONResult.fail();
			}
		}
	}
	@ResponseBody
	@RequestMapping("/update")
	public JSONResult update(@ModelAttribute AdviceVo adviceVo, DateReportVo dateReportVo) {
		if (adviceVo == null) {
			return JSONResult.error("잘못된 접근입니다.");
		} else if (adviceVo.getId() == null) {
			return JSONResult.error("로그인이 필요합니다.");
		} else if (adviceVo.getAdvice_no() == null) {
			return JSONResult.error("구분자 오지 않음");
		} else {
			int no = adviceService.update(adviceVo);
			if (no == 1) {
				return JSONResult.success("정상적으로 업데이트 되었습니다.");

			} else {
				return JSONResult.fail("정상적으로 업데이트 되지 않았습니다.");
			}
		}
	}
	@ResponseBody
	@RequestMapping("/delete")
	public JSONResult delete(@ModelAttribute AdviceVo adviceVo) {
		if (adviceVo == null) {
			return JSONResult.error("잘못된 접근입니다.");
		} else if (adviceVo.getAdvice_no() == null) {
			return JSONResult.error("구분자가 전달되지 않음");
		} else {
			int no = adviceService.delete(adviceVo);
			if (no == 1) {
				return JSONResult.success("정상적으로 삭제했습니다.");
			} else {
				return JSONResult.fail("정상적으로 삭제하지 못했습니다.");
			}
		}

	}
	@ResponseBody
	@RequestMapping("/")
	public JSONResult select(@ModelAttribute AdviceVo adviceVo) {
		
		if(adviceVo==null)
		{
			return JSONResult.error("정상적인 접근이 아닙니다.");
		}else if(adviceVo.getId()==null || adviceVo.getDate()==null)
		{
			return JSONResult.error("아이디랑 날짜가 빠져있습니다.");
		}else
		{
			List<AdviceVo> list = adviceService.select(adviceVo);
			return JSONResult.success(list);
		}
		
	}
}
