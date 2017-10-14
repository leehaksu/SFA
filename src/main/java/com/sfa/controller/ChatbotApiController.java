package com.sfa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.service.AdviceService;
import com.sfa.service.DatePlanService;
import com.sfa.service.DateReportService;
import com.sfa.service.UserService;

import com.sfa.vo.AdviceVo;
import com.sfa.vo.DateReportVo;
import com.sfa.vo.DateVo;
import com.sfa.vo.KeyboardVO;
import com.sfa.vo.MessageVO;
import com.sfa.vo.RequestMessageVO;
import com.sfa.vo.ResponseMessageVO;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping(value = "/api")
public class ChatbotApiController {

	@Autowired
	private UserService userService;

	@Autowired
	private DatePlanService datePalnservice;

	@Autowired
	private DateReportService dateReportService;

	@Autowired
	private AdviceService adviceService;

	private String register_menu = "사용자 등록";
	private String auth_menu = "사용자 인증";
	private String plan_menu = "일일 계획서";
	private String report_menu = "일일 보고서";
	private String advice_menu = "상담 일지";

	@ResponseBody
	@RequestMapping(value = "/keyboard", method = RequestMethod.GET)
	public KeyboardVO keybord() {
		KeyboardVO keyboard = new KeyboardVO(new String[] { register_menu, auth_menu });
		System.out.println(keyboard);
		return keyboard;
	}

	@ResponseBody
	@RequestMapping(value = "/message", method = RequestMethod.POST)
	public ResponseMessageVO message(@RequestBody RequestMessageVO vo) {
		ResponseMessageVO res_vo = new ResponseMessageVO();
		MessageVO mes_vo = new MessageVO();
		System.out.println(vo.getContent().substring(0, 3));
		if (vo.getContent().equals(register_menu)) {
			mes_vo.setText("이 형식에 맞춰 아이디 비밀번호를 적어주세요([인증]아이디,비밀번호) *[인증] 필히 입력");
		} else if ((vo.getContent().substring(0, 4)).equals("[인증]")) {
			String temp_message = vo.getContent().trim();
			temp_message = temp_message.substring(4);
			String[] user = temp_message.split(",");
			String id = user[0];
			String pw = user[1];
			UserVo userVo = userService.getUser(id, pw);
			if (userVo == null) {
				mes_vo.setText("인증되지 않는 사용자입니다.");
				KeyboardVO keyboard = new KeyboardVO(new String[] { register_menu, auth_menu });
				res_vo.setKeyboard(keyboard);
			} else {
				int no = userService.insertKey(vo.getUser_key(), id);
				mes_vo.setText("사용자가 등록되었습니다.");
				KeyboardVO keyboard = new KeyboardVO(new String[] { "사용자 인증" });
				res_vo.setKeyboard(keyboard);

			}
		} else if (vo.getContent().equals(auth_menu)) {
			UserVo userVo = userService.getKey(vo.getUser_key());
			if (userVo == null) {
				mes_vo.setText("사용자 인증이 되지 않았습니다. 사용자 등록부터 해주세요");
				KeyboardVO keyboard = new KeyboardVO(new String[] { register_menu, auth_menu });
				res_vo.setKeyboard(keyboard);

			} else if (userVo != null && userVo.getId() != null) {
				mes_vo.setText("반갑습니다. 원하는 메뉴를 클릭해주세요");
				KeyboardVO keyboard = new KeyboardVO(new String[] { plan_menu, report_menu, advice_menu });
				res_vo.setKeyboard(keyboard);
			} else if (vo.getContent().equals(plan_menu)) {
				mes_vo.setText("일일 계획서 입력하겠습니다. 계획서  입력 방법 : [계획] 제목/목표액/내용  양식으로 입력해주세요");
			} else if (vo.getContent().equals(report_menu)) {
				mes_vo.setText("일일 보고서를 작성하겠습니다.계획서  입력 방법 : [보고] 제목/매출액/내용  양식으로 입력해주세요");
			} else if (vo.getContent().equals(advice_menu)) {
				mes_vo.setText("상담일지를 작성하겠습니다.상담일지  입력 방법 : [상담] 고객 코드/내용  양식으로 입력해주세요");
			} else if (vo.getContent().substring(0, 4).equals("계획")) {
				String temp_message = vo.getContent().trim();
				temp_message = temp_message.substring(4);
				String[] message = temp_message.split("/");
				String title = message[0];
				String temp_goal_sale = message[1];
				Long goal_sale = Long.parseLong(temp_goal_sale);
				String content = message[2];

				DateVo dateVo = new DateVo();
				dateVo.setTitle(title);
				dateVo.setGoal_sale(goal_sale);
				dateVo.setContent(content);
				dateVo.setChallenge_no((long) 0);
				userVo = userService.getKey(vo.getUser_key());
				dateVo.setId(userVo.getId());

				int no = datePalnservice.insertDate(dateVo);
				if (no == 1) {
					mes_vo.setText("정상적으로 입력되었습니다.");
				} else {
					mes_vo.setText("입력이 되지 않았습니다.");
				}
				KeyboardVO keyboard = new KeyboardVO(new String[] { plan_menu, report_menu, advice_menu });
				res_vo.setKeyboard(keyboard);
			} else if (vo.getContent().substring(0, 4).equals("보고")) {
				String temp_message = vo.getContent().trim();
				temp_message = temp_message.substring(4);
				String[] message = temp_message.split("/");
				String title = message[0];
				String temp_report_sale = message[1];
				Long report_sale = Long.parseLong(temp_report_sale);
				String content = message[2];

				DateReportVo dateReportVo = new DateReportVo();
				dateReportVo.setTitle(title);
				dateReportVo.setReport_sale(report_sale);
				dateReportVo.setContent(content);
				userVo = userService.getKey(vo.getUser_key());
				dateReportVo.setId(userVo.getId());
				int no = dateReportService.insert(dateReportVo);
				if (no == 1) {
					mes_vo.setText("정상적으로 입력되었습니다.");
				} else {
					mes_vo.setText("입력이 되지 않았습니다.");
				}
				KeyboardVO keyboard = new KeyboardVO(new String[] { plan_menu, report_menu, advice_menu });
				res_vo.setKeyboard(keyboard);
			} else if (vo.getContent().substring(0, 4).equals("보고")) {
				String temp_message = vo.getContent().trim();
				temp_message = temp_message.substring(4);
				String[] message = temp_message.split("/");
				String customer_code = message[0];
				String content = message[2];

				AdviceVo adviceVo = new AdviceVo();
				adviceVo.setCustomer_code(customer_code);
				adviceVo.setDate(content);
				userVo = userService.getKey(vo.getUser_key());
				adviceVo.setId(userVo.getId());
				int no = adviceService.insert(adviceVo);
				if (no == 1) {
					mes_vo.setText("정상적으로 입력되었습니다.");
				} else {
					mes_vo.setText("입력이 되지 않았습니다.");
				}
				KeyboardVO keyboard = new KeyboardVO(new String[] { plan_menu, report_menu, advice_menu });
				res_vo.setKeyboard(keyboard);
			}
		} else {
			mes_vo.setText("처음 화면으로 돌아갑니다.");
			KeyboardVO keyboard = new KeyboardVO(new String[] { register_menu, auth_menu });
			res_vo.setKeyboard(keyboard);
		}
		res_vo.setMessage(mes_vo);
		return res_vo;

	}
}