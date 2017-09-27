package com.sfa.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.sfa.service.UserService;

@Component
public class PushMessage {

	@Autowired
	UserService userSerivce;
	
	final String apiKey = "AAAAOpF9q2s:APA91bGcjYFbTe1aPqTDn49vktOG-GTBbFuSgibbb3xQJ3HgJ_c2oHEolDfiSuM1eTBu3rHQJ4_C_K4YAa7Np1OQChlPZcZr8_v88fBjm_W9s7_rTmkpd3QrllY9P7WogT6qlZeF1N-O";

	public int Push(String id, String from,int no) {
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
			case 1:
				input = "{\"notification\" : {\"title\" : \" 반려 \", \"body\" : \""+id+"님이 새로운 주간 계획서가 작성하었습니다.\"}, \"to\":\"" + toK
						+ "\"}";
				break;
			case 2:
				input = "{\"notification\" : {\"title\" : \" 반려 \", \"body\" : \""+id+"님이 새로운 일일 계획서가 작성하였습니다.\"}, \"to\":\"" + toK
				+ "\"}";
				break;
			case 3:
				input = "{\"notification\" : {\"title\" : \" 반려 \", \"body\" : \""+id+"님이 새로운 보고서가 작성하었습니다.\"}, \"to\":\"" + toK
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
}
