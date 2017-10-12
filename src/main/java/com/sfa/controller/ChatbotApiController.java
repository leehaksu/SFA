package com.sfa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.vo.KeyboardVO;
import com.sfa.vo.MessageVO;
import com.sfa.vo.RequestMessageVO;
import com.sfa.vo.ResponseMessageVO;


@Controller
@RequestMapping(value="/api")
public class ChatbotApiController {
	
	@ResponseBody
	@RequestMapping(value="/keyboard")
	public KeyboardVO keybord()
	{
		KeyboardVO keyboard=new KeyboardVO(new String[] {"사용자 등록","사용자 인증","일일계획","일일보고","상담일지"});
		System.out.println(keyboard);
		return keyboard;
	}
	
	@ResponseBody
	@RequestMapping(value="/message")
	public ResponseMessageVO message(@RequestBody RequestMessageVO vo)
	{
		ResponseMessageVO res_vo=new ResponseMessageVO();
		MessageVO mes_vo=new MessageVO();
		
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
			}
			res_vo.setMessage(mes_vo);
			return res_vo;
		}else
		{
			mes_vo.setText("인증되지 않는 사용자입니다. ");
			return res_vo;
		}
		
	}

}
