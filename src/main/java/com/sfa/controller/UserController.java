package com.sfa.controller;

import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.dto.JSONResult;
import com.sfa.security.Auth;
import com.sfa.security.AuthUser;
import com.sfa.service.AffirmationService;
import com.sfa.service.UserService;
import com.sfa.util.Push;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private AffirmationService affirmationService;
	
	@Autowired
	private Push push;
	
	@RequestMapping(value = { "", "/login" }, method = RequestMethod.GET)
	public String login(@AuthUser UserVo authUser, Model model) {
		// login 페이지 forward
		// 긍정의 한줄 가져오기
		String Affirmation = affirmationService.select();
		model.addAttribute("affrimation", Affirmation);

		if (authUser != null) {
			// 세션이 끝나지 않으면 main 화면으로 이동
			return "redirect:/main";
		} else {
			// 세션이 끝나면 user/login 화면으로 이동
			return "user/login";
		}
	}

	@Auth(value = Auth.Role.팀장)
	@RequestMapping(value = "/join", method = RequestMethod.GET)
	public String join() {
		// 회원가입 페이지 forward
		return "user/join";
	}

	@Auth(value = Auth.Role.팀장)
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(@ModelAttribute UserVo userVo, Model model,BindingResult result,@AuthUser UserVo authUser) {
		
		// 정상적인 접근이 아닐 경우
		if (userVo == null) {
			System.out.println("error_0x1");
			return "user/join";
		} else if (
		// 회원가입 목록에 정상적으로 들어오지 않는 경우
		userVo.getDept() == null || userVo.getGrade() == null || userVo.getId() == null || userVo.getName() == null
				|| userVo.getPasswd() == null) {
			System.out.println("error_join_0x2");
			return "user/join";
		} else {
			// 정상적으로 회원가입 되었을 경우
			if (userService.join(userVo) == true) {
				
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
				model.addAttribute("userVo", userVo);
				return "user/joinsuccess";
			} else if (userService.join(userVo) == false) {
				return "redirect:/join?result=fail";
			}
			return "user/join";
		}
	}

	@Auth(value = Auth.Role.팀장)
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public String delete(@ModelAttribute UserVo userVo, Model model) {
		if (userVo == null) {
			return "user/login";
		} else if (userVo.getClass() == null) {
			return "user/modify";
		}
		int no = userService.delete(userVo);
		if (no == 1) {
			return "redirect:/modify?result=success";
		} else {
			return "redirect:/modify?result=fail";
		}

	}

	@Auth(value = Auth.Role.팀장)
	@RequestMapping(value = "/modify", method = RequestMethod.GET)
	public String modify(@RequestParam(value = "id", required = true, defaultValue = "") String id,
			@AuthUser UserVo authUser, Model model) {
		if (authUser.getId() == null) {
			return "user/login";
		}
		UserVo userVo = userService.getId(id);
		model.addAttribute("userVo", userVo);
		return "user/modify";
	}

	@Auth(value = Auth.Role.팀장)
	@RequestMapping(value = "/modify", method = RequestMethod.POST)
	public String modify(@ModelAttribute UserVo userVo, Model model) {
		System.out.println(userVo);
		if (userVo == null) {
			return "user/modify";
		} else if (userVo.getId() == null || userVo.getName() == null || userVo.getGrade() == null
				|| userVo.getDept() == null) {
			return "user/modify";
		}

		int no = userService.modify(userVo);
		if (no == 1) {
			return "redirect:modify?result=success&id=" + userVo.getId();
		} else {
			return "redirect:modify?result=fail&id=" + userVo.getId();
		}

	}
	@Auth
	@ResponseBody
	@RequestMapping(value = "/check", method = RequestMethod.GET)
	public JSONResult search(@RequestParam(value = "id", required = true, defaultValue = "") String id) {
		if ("".equals(id)) {
			return JSONResult.error("cod_e0x1");
		}

		UserVo userVo = userService.getId(id);

		System.out.println("[Controller] : " + userVo);

		if (userVo == null) {
			return JSONResult.fail();
		}
		return JSONResult.success(id);
	}
	
	@Auth
	@ResponseBody
	@RequestMapping(value = "/checkEmail", method = RequestMethod.GET)
	public JSONResult searchEmail(@RequestParam(value = "email", required = true, defaultValue = "") String email) {
		if ("".equals(email)) {
			return JSONResult.error("cod_e0x1");
		}
		List<UserVo> list = userService.getemail(email);
		if (list == null) {
			return JSONResult.success("사용 가능한 메일입니다.");
		}
		return JSONResult.fail("중복된 메일이 존재합니다.");
	}

	@RequestMapping(value = "/joinsuccess", method = RequestMethod.GET)
	public String joinsceess(@ModelAttribute UserVo userVo, Model model) {
		model.addAttribute("userVo", userVo);
		return "user/joinsuccess";
	}

	@Auth(value = Auth.Role.팀장)
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(HttpSession authUser, Model model) {
		if (authUser.getAttribute("authUser") == null) {
			return "user/login";
		}
		String dept = ((UserVo) authUser.getAttribute("authUser")).getDept();
		List<UserVo> list = userService.getTotalMember(dept);
		model.addAttribute("list", list);
		return "user/list";
	}

	@Auth(value = Auth.Role.팀장)
	@RequestMapping(value = "/list", method = RequestMethod.POST)
	public String list(@RequestParam(value = "name", required = true, defaultValue = "") String name,
			@RequestParam(value = "grade", required = true, defaultValue = "") String grade, HttpSession authUser,
			Model model) {

		if (authUser.getAttribute("authUser") == null) {
			return "user/login";
		}

		String dept = ((UserVo) authUser.getAttribute("authUser")).getDept();

		if ("".equals(name) && "".equals(grade)) {
			return "user/list";
		} else if ("전체".equals(grade) && "".equals(name)) {
			List<UserVo> list = userService.getTotalMember(dept);
			model.addAttribute("list", list);
			return "user/list";
		} else {
			List<UserVo> list = userService.getMember(name, grade, dept);
			model.addAttribute("list", list);
			return "user/list";
		}
	}
	

	/* 기존 코드 @RequestMapping(value="/search", method=RequestMethod.GET)
	public String search(@RequestParam("email") String email, @RequestParam("name") String name)
	{
		if(email==null || name==null)
		{
			return "redirect:/search";
		}else
		{
			String id = userService.getId(email,name);
		}
		return null;
	}*/
	@RequestMapping(value="/search", method=RequestMethod.GET)
		public String search()
		{
			return "user/search";
		}
}
