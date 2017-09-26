package com.sfa.util;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Component;


@Component
public class PushMail {

	public PushMail(String recipient,String Subject,String body,String Sender)
	{	// 네이버일 경우 smtp.naver.com 을 입력합니다.
		// Google일 경우 smtp.gmail.com 을 입력합니다.
		String host = "smtp.naver.com";
		
		final String username = "leehacksue";       //네이버 아이디를 입력해주세요. @nave.com은 입력하지 마시구요.
		final String password = "dlgkrtn280a";   //네이버 이메일 비밀번호를 입력해주세요.
		int port=465; //포트번호
		 
		// 메일 내용
		/*String recipient = "leehacksue@gmail.com";*/    //받는 사람의 메일주소를 입력해주세요.
		/*String subject = "메일테스트";*/ 					  //메일 제목 입력해주세요.
		/*String body = username+"님으로 부터 메일을 받았습니다.";*/ //메일 내용 입력해주세요.
		 
		Properties props = System.getProperties(); // 정보를 담기 위한 객체 생성
		 
		// SMTP 서버 정보 설정
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", port);
		props.put("mail.smtp.auth", "true");
		props.put("mail.smtp.ssl.enable", "true");
		props.put("mail.smtp.ssl.trust", host);
		   
		//Session 생성
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			String un=username;
			String pw=password;
			protected javax.mail.PasswordAuthentication getPasswordAuthentication() {
				return new javax.mail.PasswordAuthentication(un, pw);
			}
		});
		session.setDebug(true); //for debug
		   
		Message mimeMessage = new MimeMessage(session); //MimeMessage 생성
		try {
			mimeMessage.setFrom(new InternetAddress(Sender+"@sfa.com"));
			mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient)); //수신자셋팅 //.TO 외에 .CC(참조) .BCC(숨은참조) 도 있음
			mimeMessage.setSubject(Subject);  //제목셋팅
			mimeMessage.setText(body);//내용셋팅
			Transport.send(mimeMessage); //javax.mail.Transport.send() 이용
		} catch (AddressException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (MessagingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
	}

}
