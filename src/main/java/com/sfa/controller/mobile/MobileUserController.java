package com.sfa.controller.mobile;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.service.UserService;
import com.sfa.util.Push;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/m")
public class MobileUserController {

	@Autowired
	private UserService userService;

	@Autowired
	private Push push;
	
	@ResponseBody
	@RequestMapping(value = "/auth")
	public JSONResult login(@ModelAttribute UserVo vo) {

		if (vo.getId() == null || vo.getPasswd() == null) {
			// JSON 응답하기
			// code_0x1 : id 나 password 문제 있을 경우
			return JSONResult.error("code_0x1");
		} else{
			//token값이 있을 경우
			if (vo.getToken()!=null) {
				UserVo userVo=userService.getIdbyToken(vo.getToken());
				if(userVo!=null)
				{
					userService.deleteToken(userVo.getId());	
				}
				userVo = userService.getUser(vo.getId(), vo.getPasswd());
				if (userVo == null) {
					// JSON 응답하기
					// code_0x2 : id password 잘못 전달 받았을시
					return JSONResult.fail("등록된 회원이 없습니다.");
				} else {
					// JSON 응답하기
					// 정상적으로 처리하여 JSON 응답하는 경우
					int no = userService.insertToken(vo.getToken(), vo.getId());
					if(no==1)
					{
						System.out.println(JSONResult.success(userVo));
						return JSONResult.success(userVo);
					}else
					{
						return JSONResult.fail("Token값을 저장하지 못했습니다.");
					}
				}
			} else {
				return JSONResult.error("토큰값이 없습니다.");
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
		userVo.getId() == null || userVo.getDept() == null || userVo.getGrade() == null || userVo.getName() == null
				|| userVo.getPasswd() == null) {
			System.out.println(userVo);
			return JSONResult.error("error_join_0x2");
		} else {
			if (userService.join(userVo) == true) {
				// 정상적으로 파라미터 들어와 가입 진행하는 경우
				
				try {
					push.Mail(userVo.getCompany_email(), "["+userVo.getId()+"]님 회원가입을 축하합니다.", 
					"사원 아이디 : " +userVo.getId()+"\n"
					+"사원 이름 : "+userVo.getName()+"\n"
					+"사원 부서 : "+userVo.getDept()+"\n"
					+"사원 이메일 : " + userVo.getCompany_email()+"\n"
					+ "사원 직급 :" +userVo.getGrade()+"\n"
					+ "회원 가입을 진심으로 축하합니다.\n", "admin");
					
					UserVo userVo2= userService.getLeader(userVo.getId());
					push.Message(userVo.getId(), userVo2.getId(), 0);
					
				} catch (MessagingException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
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
	public JSONResult check(@RequestParam(value = "id", required = true, defaultValue = "") String id) {
		System.out.println("[web] check:  mobile  접속함");

		if ("".equals(id)) {
			// id값이 정상적으로 들어 왔는지 체크
			JSONResult.error("error_join_0x1");
		} else {
			// id값 이용해서
			UserVo userVo = userService.getId(id);
			if (userVo == null) {
				return JSONResult.success("아이디가 가능합니다.");
			} else {
				return JSONResult.fail("아이디가 존재합니다.");
			}
		}
		return JSONResult.fail("서버에 이상이 생겼습니다.");
	}
	
	@ResponseBody
	@RequestMapping(value="/checkEmail")
	public JSONResult checkEmail(@RequestParam(value = "email", required = true, defaultValue = "") String email) {
		System.out.println("[web] check:  mobile  접속함");

		if ("".equals(email)) {
			// id값이 정상적으로 들어 왔는지 체크
			JSONResult.error("error_join_0x1");
		} else {
			// id값 이용해서
			List<UserVo> list = userService.getemail(email);
			System.out.println(list);
			if (list.isEmpty()) {
				return JSONResult.success("이메일 가입  가능합니다.");
			} else {
				return JSONResult.fail("중복된 이메일이  존재합니다.");
			}
		}
		return JSONResult.fail("서버에 이상이 생겼습니다.");
	}
	@ResponseBody
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public JSONResult list(@RequestParam(value="dept", required=true, defaultValue="") String dept ) {
		
		List<UserVo> list = userService.getTotalMember(dept);
		return JSONResult.success(list);
	}
	
	@ResponseBody
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public JSONResult list(@RequestParam(value = "name", required = true, defaultValue = "") String name,
			@RequestParam(value = "grade", required = true, defaultValue = "") String grade,
			@RequestParam(value="dept", required= true, defaultValue="")String dept) {

		if ("".equals(name) && "".equals(grade)) {
			return JSONResult.error("이름과  직책이 없습니다.");
		} else if ("전체".equals(grade) && "".equals(name)) {
			List<UserVo> list = userService.getTotalMember(dept);
			return JSONResult.success(list);
		} else {
			List<UserVo> list = userService.getMember(name, grade, dept);
			return JSONResult.success(list);
		}
	}
	@RequestMapping(value="/download", method=RequestMethod.POST)
	public void download(HttpServletResponse response) throws IOException
	{

	}	


}
