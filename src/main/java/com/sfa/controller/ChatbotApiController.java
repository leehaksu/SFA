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
import com.sfa.util.ChangeDate;
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

	@ResponseBody
	@RequestMapping(value = "/keyboard", method = RequestMethod.GET)
	public KeyboardVO keybord() {
		KeyboardVO keyboard = new KeyboardVO();
		System.out.println(keyboard);
		return keyboard;
	}

	@ResponseBody
	@RequestMapping(value = "/message", method = RequestMethod.POST)
	public ResponseMessageVO message(@RequestBody RequestMessageVO vo, UserVo userVo) {
		ResponseMessageVO res_vo = new ResponseMessageVO();
		MessageVO mes_vo = new MessageVO();

		
			userVo = userService.getKey(vo.getUser_key());	
		
		if (userVo == null) {
			mes_vo.setText("사용자 인증이 되지 않았습니다. 사용자 등록부터 하겠습니다.아이디와 비밀번호를 입력해주세요(아이디,비밀번호)");

			if (vo.getContent().matches(".*,.*")) {
				String[] UserText = vo.getContent().split(",");
				String id = UserText[0];
				String pwd = UserText[1];
				UserVo temp_userVo = userService.getUser(id, pwd);
				if (temp_userVo == null) {
					mes_vo.setText("사용자가 등록되지 않은 아이디입니다.아이디 가입은 홈페이지에서 부탁드립니다.");
				} else {
					int no = userService.insertKey(vo.getUser_key(), id);
					if (no == 1) {
						mes_vo.setText("사용자 인증이 되었습니다.이제 사용자 인증이라고 입력해보세요");
					} else {
						mes_vo.setText("사용자 인증에 실패하였습니다. 계속 실패할 경우에는 홈페이지에 문의 부탁드려요");
					}
				}

			}
		} else if (userVo != null) {
			if (vo.getContent().matches(".*_.*")) {
				AdviceVo adviceVo = new AdviceVo();
				adviceVo.setCustomer_code(vo.getContent());
				adviceVo.setTitle("[카카오봇] 상담일지");
				adviceVo.setDate(ChangeDate.today());
				adviceVo.setId(userVo.getId());
				adviceVo.setContent("[임시저장]");
				int no= adviceService.insert(adviceVo);
				if(no==1)
				{
					mes_vo.setText("상담일지에 넣을 내용을 적어주세요.앞에 [상담내용]이라고 꼭 적어주세요");	
				}else
				{
					mes_vo.setText("상담일지 customer_code가 정상적으로 입력되지 않았습니다. 다시 입력 바랍니다.");		
				}
				// 상담일지를 customer_code 가져옴
			}else if (vo.getContent().matches(".*[상담내용]*")) {
				// 일일 계획서
				AdviceVo adviceVo = new AdviceVo();
				adviceVo.setDate(ChangeDate.today());
				adviceVo.setId(userVo.getId());
				adviceVo.setContent(vo.getContent());
				int no= adviceService.updateContent(adviceVo);
				if(no==1)
				{
					mes_vo.setText("상담일지가 정상적으로 입려되었습니다. 보고서를 작성하고 싶으면 보고서 작성이라고 해주세요");
				}else
				{
					mes_vo.setText("정상적으로 입력되지 않았습니다. 다시한번 확인 후 입력해 주세요");
				}
			}else if (vo.getContent().matches(".*000.*")) {
				// 일일 보고서 작성하는 부분
				mes_vo.setText("일일 보고서을 시작하겠습니다.");
			}else {
				if (vo.getContent().matches(".*상담일지.*") || vo.getContent().matches(".*상담 일지.*")
						|| vo.getContent().matches(".*상담.*")) {
					mes_vo.setText("상담일지를 원하시는군요. 그럼 상담일지 작성하겠습니다. 상담하신 고객코드를 입력하세주세요. 상담한 고객 코드를 입력해주세요 ");
				}else if (vo.getContent().matches(".*일일보고서.*") || vo.getContent().matches(".*일일 보고서.*")
						|| vo.getContent().matches(".*보고서.*")) {
					mes_vo.setText("일일 보고서를 원하시는군요. 그럼 일일 보고서 작성하겠습니다.천원 단위로 입력해주세요. 제목/날짜(형식 1987-05-25)/매출액/상담일지내용");
				} else {
					mes_vo.setText(
							userVo.getName() + "님 안녕하세요. 만나서 반갑습니다. 원하시는 메뉴를 적어주세요. 상담일지를 원하시면 상담일지라고 적어주시면 됩니다.");
				}

			}

		}
		res_vo.setMessage(mes_vo);
		return res_vo;
	}
}

/*
 * int count=0; for(int i=0;i<textArray.length;i++) {
 * if(textArray[i].matches(".*상담일지.*") || textArray[i].matches(".*상담 일지.*") ||
 * textArray[i].matches(".*상담.*")) { count+=1; }else
 * if(textArray[i].matches(".*일일계획서.*")|| textArray[i].matches(".*일일 계획서.*")
 * ||textArray[i].matches(".*계획서.*")) { count+=2; }else
 * if(textArray[i].matches(".*일일보고서.*") || textArray[i].matches(".*일일 보고서.*")
 * ||textArray[i].matches(".*보고서.*")) { count+=3; } } System.out.println(count);
 * if(count>=1) { switch(count) { case 1: mes_vo.
 * setText("상담일지를 원하시는군요. 그럼 상담일지 작성하겠습니다. 상담하신 고객코드를 입력하세주세요. 고객코드/상담일지내용" );
 * break; case 2: mes_vo.
 * setText("일일 계획서를 원하시는군요. 그럼 일일 계획서 작성하겠습니다. 제목/날짜(형식 1987-05-25)/상담일지내용" );
 * break; case 3: mes_vo.
 * setText("일일 보고서를 원하시는군요. 그럼 일일 보고서 작성하겠습니다. 제목/날짜(형식 1987-05-25)/매출액/상담일지내용"
 * ); break; }
 * 
 * }else { String [] messageArray= vo.getContent().split("/");
 * switch(messageArray.length) { case 2:
 * 
 * mes_vo.setText("입력되었습니다."); break; case 3 : mes_vo.setText("입력되었습니다.");
 * break; case 4: mes_vo.setText("입력되었습니다."); break; } } }
 */
/*
 * if (vo.getContent().equals(register_menu)) { mes_vo.
 * setText("이 형식에 맞춰 아이디 비밀번호를 적어주세요([인증]아이디,비밀번호) *[인증] 필히 입력"); } else if
 * ((vo.getContent().substring(0, 4)).equals("[인증]")) { String temp_message =
 * vo.getContent().trim(); temp_message = temp_message.substring(4); String[]
 * user = temp_message.split(","); String id = user[0]; String pw = user[1];
 * userVo = userService.getUser(id, pw); if (userVo == null) {
 * mes_vo.setText("인증되지 않는 사용자입니다."); } else {
 * mes_vo.setText("등록되었습니다. 사용자 인증을 해주세요"); } } else if
 * (vo.getContent().equals(auth_menu)) { userVo =
 * userService.getKey(vo.getUser_key()); if (userVo == null) {
 * mes_vo.setText("사용자 인증이 되지 않았습니다. 사용자 등록부터 해주세요"); } else { mes_vo.
 * setText("사용자 인증이 되었습니다. 원하시는 메뉴를 적어주세요. 상담일지면 상담일지라고 써주세요."); }
 * 
 * } else if (vo.getContent().equals(plan_menu)) { mes_vo.
 * setText("일일 계획서 입력하겠습니다. 계획서  입력 방법 : [계획] 제목/목표액/내용  양식으로 입력해주세요" ); } else
 * if (vo.getContent().equals(report_menu)) { mes_vo.
 * setText("일일 보고서를 작성하겠습니다.계획서  입력 방법 : [보고] 제목/매출액/내용  양식으로 입력해주세요" ); } else
 * if (vo.getContent().equals(advice_menu)) { mes_vo.
 * setText("상담일지를 작성하겠습니다.상담일지  입력 방법 : [상담] 고객 코드/내용  양식으로 입력해주세요" ); } else if
 * (vo.getContent().substring(0, 4).equals("[계획]")) { String temp_message =
 * vo.getContent().trim(); temp_message = temp_message.substring(4); String[]
 * message = temp_message.split("/"); String title = message[0]; String
 * temp_goal_sale = message[1]; Long goal_sale = Long.parseLong(temp_goal_sale);
 * String content = message[2];
 * 
 * DateVo dateVo = new DateVo(); dateVo.setTitle(title);
 * dateVo.setGoal_sale(goal_sale); dateVo.setContent(content);
 * dateVo.setChallenge_no((long) 1); dateVo.setDate(ChangeDate.today()); userVo
 * = userService.getKey(vo.getUser_key()); dateVo.setId(userVo.getId());
 * 
 * int no = datePalnservice.insertDate(dateVo); if (no == 1) {
 * mes_vo.setText("정상적으로 입력되었습니다."); } else { mes_vo.setText("입력이 되지 않았습니다."); }
 * } else if (vo.getContent().substring(0, 4).equals("[보고]")) { String
 * temp_message = vo.getContent().trim(); temp_message =
 * temp_message.substring(4); String[] message = temp_message.split("/"); String
 * title = message[0]; String temp_report_sale = message[1]; Long report_sale =
 * Long.parseLong(temp_report_sale); String content = message[2];
 * 
 * DateReportVo dateReportVo = new DateReportVo(); dateReportVo.setTitle(title);
 * dateReportVo.setReport_sale(report_sale); dateReportVo.setContent(content);
 * dateReportVo.setDate(ChangeDate.today()); userVo =
 * userService.getKey(vo.getUser_key()); dateReportVo.setId(userVo.getId()); int
 * no = dateReportService.insert(dateReportVo); if (no == 1) {
 * mes_vo.setText("정상적으로 입력되었습니다."); } else { mes_vo.setText("입력이 되지 않았습니다."); }
 * } else if (vo.getContent().substring(0, 4).equals("[상담]")) { String
 * temp_message = vo.getContent().trim(); temp_message =
 * temp_message.substring(4); String[] message = temp_message.split("/"); String
 * customer_code = message[0]; String content = message[1];
 * 
 * AdviceVo adviceVo = new AdviceVo(); adviceVo.setCustomer_code(customer_code);
 * adviceVo.setContent(content); adviceVo.setDate(ChangeDate.today());
 * adviceVo.setTitle("상담일지"); userVo = userService.getKey(vo.getUser_key());
 * adviceVo.setId(userVo.getId()); adviceVo.setManager_name(""); int no =
 * adviceService.insert(adviceVo); if (no == 1) {
 * mes_vo.setText("정상적으로 입력되었습니다."); } else { mes_vo.setText("입력이 되지 않았습니다."); }
 * } else { mes_vo.setText("안녕하세요. "); }
 */