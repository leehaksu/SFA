package com.sfa.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sfa.service.UserService;
import com.sfa.vo.KeyboardVO;
import com.sfa.vo.MessageVO;
import com.sfa.vo.RequestMessageVO;
import com.sfa.vo.ResponseMessageVO;
import com.sfa.vo.UserVo;

@Controller
@RequestMapping(value = "/api")
public class ChatbotApiController {

   @Autowired
   UserService userService;

   private String register_menu="사용자 등록";
   private String auth_menu="사용자 인증";
   private String plan_menu="일일 계획서";
   private String report_menu="일일 보고서";
   private String advice_menu="상담 일지";
   
   
   
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
            KeyboardVO keyboard = new KeyboardVO(new String[] {register_menu, auth_menu});
            res_vo.setKeyboard(keyboard);
         } else {
            int no= userService.insertKey(vo.getUser_key(),id);
            mes_vo.setText("사용자가 등록되었습니다.");
            KeyboardVO keyboard = new KeyboardVO(new String[] {"사용자 인증"});
            res_vo.setKeyboard(keyboard);

         }
      } else if (vo.getContent().equals(auth_menu)) {
         UserVo userVo= userService.getKey(vo.getUser_key());
         if(userVo==null)
         {
            mes_vo.setText("사용자 인증이 되지 않았습니다. 사용자 등록부터 해주세요");
            KeyboardVO keyboard = new KeyboardVO(new String[] {register_menu, auth_menu});
            res_vo.setKeyboard(keyboard);

         }else if(userVo!=null && userVo.getId()!=null)
         {
            mes_vo.setText("반갑습니다. 원하는 메뉴를 클릭해주세요");
            KeyboardVO keyboard = new KeyboardVO(new String[] {plan_menu,report_menu,advice_menu});
            res_vo.setKeyboard(keyboard);
         }else if(vo.getContent().equals(plan_menu))
         {
        	 
         }
      }else
      {
         mes_vo.setText("처음 화면으로 돌아갑니다.");
         KeyboardVO keyboard = new KeyboardVO(new String[] {register_menu, auth_menu});
         res_vo.setKeyboard(keyboard);
      }
      res_vo.setMessage(mes_vo);
      return res_vo;
      
   }
}