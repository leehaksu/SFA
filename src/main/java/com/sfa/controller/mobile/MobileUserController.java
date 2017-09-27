package com.sfa.controller.mobile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.UserService;
import com.sfa.util.PushMessage;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/m")
public class MobileUserController {

	@Autowired
	private UserService userService;
	
	@ResponseBody
	@RequestMapping(value = "/auth")
	public JSONResult login(@ModelAttribute UserVo vo) {
		
		if (vo.getId() == null || vo.getPasswd() == null) {
			// JSON 응답하기
			// code_0x1 : id 나 password 문제 있을 경우
			System.out.println("[web] : Json응답1");
			System.out.println(JSONResult.error("error_User_0x1"));
			return JSONResult.error("code_0x1");
		} else {
			int no = userService.insertToken(vo.getToken(),vo.getId());
			if(no==1)
			{
				UserVo userVo = userService.getUser(vo.getId(), vo.getPasswd());
				if (userVo == null) {
					// JSON 응답하기
					// code_0x2 : id password 잘못 전달 받았을시
					System.out.println("[web] :  Json응답2");
					System.out.println(userVo);
					System.out.println(JSONResult.error("code_User_0x2"));
					return JSONResult.fail();
				}else {
					// JSON 응답하기
					// 정상적으로 처리하여 JSON 응답하는 경우
					System.out.println("[web] :  Json응답3");
					System.out.println(JSONResult.success(userVo));
					return JSONResult.success(userVo);
				}
			}else {
				return JSONResult.error("토큰값을 정상적으로 입력하지 못했습니다.");
			}

			
			
		}
	}
	@ResponseBody
	@RequestMapping(value = "/join")
	public JSONResult join(@ModelAttribute UserVo userVo) {
		System.out.println("[web] 회원가입 :  mobile  접속함");
		// userVo에 하나도 담겨 있지 않을 경우
		if (userVo == null) {
			return JSONResult.error("error_join_0x1");
		} else if (
		// 넘겨 주는 파라미터가 정상적이지 않을 경우
		userVo.getId() == null || userVo.getDept() == null ||  userVo.getGrade() == null
				|| userVo.getName() == null || userVo.getPasswd() == null) {
			System.out.println(userVo);
			return JSONResult.error("error_join_0x2");
		} else {
			if (userService.join(userVo) == true) {
				// 정상적으로 파라미터 들어와 가입 진행하는 경우
				return JSONResult.success();
			} else if (userService.join(userVo) == false) {
				// 정상적으로 가입이 진행되지 않을 경우
				return JSONResult.fail("정상적인 가입이 되지 않았습니다.");
			} else {
				return JSONResult.error("서버에 문제 발생했습나다");
			}
		}
	}

	@ResponseBody
	@RequestMapping(value = "/check")
	public JSONResult join(@RequestParam(value = "id", required = true, defaultValue = "") String id) {
		System.out.println("[web] check:  mobile  접속함");
		
		if ("".equals(id)) {
			//id값이 정상적으로 들어 왔는지 체크
			JSONResult.error("error_join_0x1");
		} else {
			//id값 이용해서 
			UserVo userVo = userService.getId(id);
			if (userVo == null) {
				return JSONResult.success("아이디가 가능합니다.");
			}else
			{
				return JSONResult.fail("아이디가 존재합니다.");
			}
		}
		return JSONResult.fail("서버에 이상이 생겼습니다.");
	}

}
