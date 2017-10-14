package com.sfa.controller.mobile;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.sfa.dto.JSONResult;
import com.sfa.service.DateReportService;
import com.sfa.service.FileUploadService;
import com.sfa.util.DefaultReport;
import com.sfa.vo.DateReportVo;
import com.sfa.vo.FileFormVo;


@Controller
@RequestMapping("/m/upload")
public class MobileFileUploadController {

	@Autowired
	private FileUploadService fileUploadService;

	@Autowired
	DateReportService dateReportService;

	@ResponseBody
	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public JSONResult upload(@ModelAttribute("file") FileFormVo multipartFile,
			@ModelAttribute DateReportVo dateReportVo) {
		DefaultReport defaultReport = new DefaultReport();
		System.out.println("dateRportVo"+dateReportVo);
		// 파일 업로드의 URL주소를 가지고 온다.
		int file_number = 0;
		int check_no = 0;
		int file_no = 0;
		int insert_no=0;
		Long report_no = (long) 0;
		List<MultipartFile> files = multipartFile.getFiles();
		System.out.println(files);
		if (files.size() == 0) {
			return JSONResult.error("첨부된 파일이 없습니다.");
		}
		// 작성중인 결과 보고서가 있는지 확인
		List<DateReportVo> list = dateReportService.select(dateReportVo.getId(), dateReportVo.getDate());

		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getApproval() == 0) {
				check_no += 1;
				report_no = list.get(i).getReport_no();
			}
		}

		if (check_no == 0) {
			dateReportVo = defaultReport.insertDefaultDateReport(dateReportVo);
			System.out.println(dateReportVo);
			int no = dateReportService.insert(dateReportVo);
			if (no == 1) {
				report_no = dateReportVo.getReport_no();
			} else {
				return JSONResult.error("결과보고서 생성에 실패하였습니다.");
			}
		} else if (check_no == 1) {
			
			if (dateReportVo.getStart_gauge() != null || dateReportVo.getEnd_gauge() != null) {
				insert_no= dateReportService.updateGauage(dateReportVo);
			}
			while (file_number < files.size()) {
				String url = fileUploadService.restore(files.get(file_number), dateReportVo.getId());
				String originalFileName = files.get(file_number).getOriginalFilename();
				file_no += fileUploadService.insert(report_no, url, originalFileName);
				file_number++;

			}
			if (file_no == files.size() || insert_no==1) {
				return JSONResult.success("저장에 성공하였습니다..");
			} else {
				return JSONResult.fail("저장에 실패하였습니다.");
			}
		}
		return JSONResult.error("알수 없는 오류가 발생함");
	}

	@ResponseBody
	@RequestMapping(value = "/picture", method = RequestMethod.POST)
	public JSONResult picture(@ModelAttribute("file") FileFormVo multipartFile, @RequestParam("id") String id,
			DateReportVo dateReportVo) {

		return null;
	}

	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public JSONResult delete(@RequestParam(value = "file_no", defaultValue = "") Long file_no,
			@RequestParam("id") String id, DateReportVo dateReportVo) {

		if (file_no == null) {
			// 파일번호를 보내주지 않는 경우
			return JSONResult.error("파일 번호가 존재하지 않습니다.");
		} else if (id == null) {
			// 아이디가 일치하지 않는 경우
			return JSONResult.error("아이디가 존재하지 않습니다.");
		}

		int no = fileUploadService.delete(file_no);

		if (no == 1) {
			return JSONResult.success("정상적으로 삭제되었습니다.");
		} else {
			return JSONResult.success("정상적으로 삭제되었습니다.");
		}
	}

}
