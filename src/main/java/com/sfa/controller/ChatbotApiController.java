package com.sfa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.security.Auth;
import com.sfa.service.UserService;
import com.sfa.vo.KeyboardVO;
import com.sfa.vo.MessageVO;
import com.sfa.vo.RequestMessageVO;
import com.sfa.vo.ResponseMessageVO;
import com.sfa.vo.UserVo;


@Controller
@RequestMapping(value="/api")
public class ChatbotApiController {
	
	@Autowired
	UserService userService;
	
	@ResponseBody
	@RequestMapping(value="/keyboard",method=RequestMethod.GET)
	public KeyboardVO keybord()
	{
		KeyboardVO keyboard=new KeyboardVO(new String[] {"사용자 등록","사용자 인증"});
		System.out.println(keyboard);
		return keyboard;
	}
	
	@ResponseBody
	@RequestMapping(value="/message",method=RequestMethod.POST)
	public ResponseMessageVO message(@RequestBody RequestMessageVO vo)
	{
		ResponseMessageVO res_vo=new ResponseMessageVO();
		MessageVO mes_vo=new MessageVO();
		
		if(vo.getContent().equals("사용자 등록"))
		{
			mes_vo.setText("이 형식에 맞춰 아이디 비밀번호를 적어주세요( [인증]아이디,비밀번호) *[인증] 필히 입력");
		}else if((vo.getContent().substring(0,3)).equals("[인증]"))
		{
			String temp_message = vo.getContent().trim();
			temp_message=temp_message.substring(3);
			String [] user = temp_message.split(",");
			String id= user[0];
			String pw= user[1];
			UserVo userVo = userService.getUser(id, pw);
			
		}
		
		
		
		
		
		
		if(vo.getUser_key().equals("SkNQVTyk3MbE"))
		{
			if(vo.getContent().equals("일일계획"))
			{
				mes_vo.setText("일일계획");
			}else if(vo.getContent().equals("일일보고"))
			{
				mes_vo.setText("일일보고");
			}else if (vo.getContent().equals("상담일지"))
			{
				mes_vo.setText("상담일지");
			}else if (vo.getContent().equals("사용자 등록"))
			{
				mes_vo.setText("사용자등록");
			}else if (vo.getContent().equals("사용자 인증"))
			{
				mes_vo.setText("사용자 인증");
			}else
			{
				mes_vo.setText("잘못된 인증");
			}
			res_vo.setMessage(mes_vo);
			return res_vo;
		}else
		{
			mes_vo.setText("사용자 등록이 필요합니다.");
			KeyboardVO keyboard=new KeyboardVO(new String [] {"사용자 등록"});
			res_vo.setKeyboard(keyboard);
			res_vo.setMessage(mes_vo);
			return res_vo;
		}
	}

}
