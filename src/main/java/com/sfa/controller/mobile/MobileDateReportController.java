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
import com.sfa.service.DateReportService;
import com.sfa.service.UserService;
import com.sfa.vo.DateReportVo;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/m/report")
public class MobileDateReportController {

	@Autowired
	DateReportService dateReportService;

	@Autowired
	UserService userService;

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult insertReport(@ModelAttribute DateReportVo dateReportVo) {
		if (dateReportVo.getId() == null) {
			return JSONResult.error("id값이 없습니다.");
		} else if (dateReportVo.getTitle() == null || dateReportVo.getReport_sale() == null
				|| dateReportVo.getContent() == null) {
			return JSONResult.error("파라미터값이 정상적으로 들어오지 않았습니다.");
		}
		System.out.println(dateReportVo);
		int no = dateReportService.insert(dateReportVo);

		if (no == 1) {
			return JSONResult.success(dateReportVo.getReport_no());
		} else {
			return JSONResult.fail("저장되지 않았습니다.");
		}
	}

	@ResponseBody
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public JSONResult updateReport(@ModelAttribute DateReportVo dateReportVo) {
		if (dateReportVo.getId() == null) {
			return JSONResult.error("id값이 없습니다.");
		} else if (dateReportVo.getTitle() == null || dateReportVo.getReport_sale() == null
				|| dateReportVo.getContent() == null) {
			return JSONResult.error("파라미터값이 정상적으로 들어오지 않았습니다.");
		}
		int no = dateReportService.update(dateReportVo);
		if (no == 1) {
			return JSONResult.success("정상적으로 저장되었습니다.");
		} else {
			return JSONResult.fail("정상적으로 입력되지 않았습니다.");
		}
	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public JSONResult deleteReport(@ModelAttribute DateReportVo dateReportVo) {
		if (dateReportVo.getId() == null) {
			return JSONResult.error("id값이 없습니다.");
		} else if (dateReportVo.getReport_no() == null) {
			return JSONResult.error("보고서 번호가 들어오지 않습니다.");
		}
		int no = dateReportService.delete(dateReportVo);
		System.out.println(no);

		if (no > 0) {
			return JSONResult.success("삭제에 성공했습니다.");
		} else {
			return JSONResult.fail("실패하였습니다.");
		}
	}

	@ResponseBody
	@RequestMapping(value = "/", method = RequestMethod.POST)
	public JSONResult selectReport(@ModelAttribute DateReportVo dateReportVo, UserVo userVo,
			@RequestParam(value = "no", required = true, defaultValue = "0") int no) {

		System.out.println("테스트값:" + dateReportVo);
		if (dateReportVo.getId() == null) {
			return JSONResult.error("id값이 없습니다.");
		}
		if (no == 0) {
			return JSONResult.error("select 방법 결정 안됨");
		} else if (no == 1) {
			List<DateReportVo> list = dateReportService.select(dateReportVo.getId());
			if (list == null) {
				return JSONResult.fail("결과값이 없습니다.");
			} else {
				return JSONResult.success(list);
			}
		} else if (no == 2) {
			System.out.println("no=2로 들어옴");
			List<DateReportVo> list = dateReportService.select(dateReportVo.getId(), dateReportVo.getDate());
			System.out.println(list);
			if (list == null) {
				return JSONResult.fail("결과값이 없습니다.");
			} else {
				return JSONResult.success(list);
			}

		} else if (no == 3) {
			String dept = userService.getDept(dateReportVo.getId());
			List<DateReportVo> list = dateReportService.selectByDept(dept);

			if (list == null) {
				return JSONResult.fail("결과값이 없습니다.");
			} else {
				return JSONResult.success(list);
			}

		} else {
			return JSONResult.error("예기치 못한 문제 발생함");
		}

	}
}
