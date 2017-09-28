package com.sfa.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sfa.service.UserService;

@Component
public class Push {
	
	@Autowired
	UserService userSerivce;
	// Push Message를 위한 apiKey
	final String apiKey = "AAAAOpF9q2s:APA91bGcjYFbTe1aPqTDn49vktOG-GTBbFuSgibbb3xQJ3HgJ_c2oHEolDfiSuM1eTBu3rHQJ4_C_K4YAa7Np1OQChlPZcZr8_v88fBjm_W9s7_rTmkpd3QrllY9P7WogT6qlZeF1N-O";
	
	 // Replace smtp_username with your Amazon SES SMTP user name.
    static final String SMTP_USERNAME = "AKIAJ2V2AGTFJ4AJHFUA";
    
    // Replace smtp_password with your Amazon SES SMTP password.
    static final String SMTP_PASSWORD = "AvNYAjfxbVBKQ0DlqdMctO2kTBFWJ9Ax9lAEXHIpa0Y7";
    
    // The name of the Configuration Set to use for this message.
    // If you comment out or remove this variable, you will also need to
    // comment out or remove the header on line 65.
    //static final String CONFIGSET = "ConfigSet";
    
    // Amazon SES SMTP host name. This example uses the US West (Oregon) Region.
    static final String HOST = "email-smtp.us-west-2.amazonaws.com";
    
    // The port you will connect to on the Amazon SES SMTP endpoint. 
    static final int PORT = 465;

    public int Message(String id, String from,int no) {
		int check = 0;
		String toK = userSerivce.getToken(from);
		try {
			URL url = new URL("https://fcm.googleapis.com/fcm/send");
			HttpURLConnection conn = (HttpURLConnection) url.openConnection();

			conn.setDoOutput(true);
			conn.setRequestMethod("POST");
			conn.setRequestProperty("Content-Type", "application/json");
			conn.setRequestProperty("Authorization", "key=" + apiKey);
			conn.setDoOutput(true);
			String input = null;

			switch (no) {
			case 0 : 
				input = "{\"notification\" : {\"title\" : \" 회원가입 \", \"body\" : \""+id+"님의 회원가입이 정상적으로 처리되었습니다.\"}, \"to\":\"" + toK
				+ "\"}";
				break;
			case 1:
				input = "{\"notification\" : {\"title\" : \" 주간 계획서 \", \"body\" : \""+id+"님이 새로운 주간 계획서가 작성하었습니다.\"}, \"to\":\"" + toK
						+ "\"}";
				break;
			case 2:
				input = "{\"notification\" : {\"title\" : \" 일일 계획서 \", \"body\" : \""+id+"님이 새로운 일일 계획서가 작성하였습니다.\"}, \"to\":\"" + toK
				+ "\"}";
				break;
			case 3:
				input = "{\"notification\" : {\"title\" : \" 주간 보고서 \", \"body\" : \""+id+"님이 새로운 보고서가 작성하었습니다.\"}, \"to\":\"" + toK
				+ "\"}";
				break;
			case 4: 
				input = "{\"notification\" : {\"title\" : \" 승인 요청 \", \"body\" : \""+id+"님 승인요청\"}, \"to\":\"" + toK
				+ "\"}";
				break;
			case 5 : 
				input = "{\"notification\" : {\"title\" : \" 승인 완료 \", \"body\" : \""+from+"님 승인완료\"}, \"to\":\"" + toK
				+ "\"}";
				break;
			case 6 : 
				input = "{\"notification\" : {\"title\" : \" 반려 \", \"body\" : \""+from+"님 반려\"}, \"to\":\"" + toK
				+ "\"}";
				break;
			}

			OutputStream os = conn.getOutputStream();

			// 서버에서 날려서 한글 깨지는 사람은 아래처럼 UTF-8로 인코딩해서 날려주자
			os.write(input.getBytes("UTF-8"));
			os.flush();
			os.close();

			int responseCode = conn.getResponseCode();
			check = responseCode;
			System.out.println("\nSending 'POST' request to URL : " + url);
			System.out.println("Post parameters : " + input);
			System.out.println("Response Code : " + responseCode);

			BufferedReader in = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String inputLine;
			StringBuffer response = new StringBuffer();

			while ((inputLine = in.readLine()) != null) {
				response.append(inputLine);
			}
			in.close(); // print result System.out.println(response.toString());

		} catch (MalformedURLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return check;
	}
    
    public boolean Mail(String recipient,String Subject,String message,String Sender) throws MessagingException
	{
		boolean check=false;
		 // Create a Properties object to contain connection configuration information.
    	Properties props = System.getProperties();
    	props.put("mail.transport.protocol", "smtp");
    	props.put("mail.smtp.port", PORT); 
    	props.put("mail.smtp.ssl.enable", "true");
    	props.put("mail.smtp.auth", "true");

        // Create a Session object to represent a mail session with the specified properties. 
    	Session session = Session.getDefaultInstance(props);

        // Create a message with the specified information. 
        MimeMessage msg = new MimeMessage(session);
        msg.setFrom(new InternetAddress(Sender+"@leehacksue.cafe24.com"));
        msg.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        msg.setSubject(Subject,"UTF-8");
        msg.setContent(message,"text/html; charset=UTF-8");
        
        // Add a configuration set header. Comment or delete the 
        // next line if you are not using a configuration set
        //msg.setHeader("X-SES-CONFIGURATION-SET", CONFIGSET);
            
        // Create a transport.
        Transport transport = session.getTransport();
                    
        // Send the message.
        try
        {
            System.out.println("Sending...");
            
            // Connect to Amazon SES using the SMTP username and password you specified above.
            transport.connect(HOST, SMTP_USERNAME, SMTP_PASSWORD);
        	
            // Send the email.
            transport.sendMessage(msg, msg.getAllRecipients());
            System.out.println("Email sent!");
            check=true;
        }
        catch (Exception ex) {
        	check=false;
            System.out.println("The email was not sent.");
            System.out.println("Error message: " + ex.getMessage());
        }
        finally
        {
            // Close and terminate the connection.
            transport.close();
        }
        
        return check;
    }
}
