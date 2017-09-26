package com.sfa.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public class PushMessage {

	final String apiKey = "AIzaSyB-jC74-KLX0JBrm-P6Qu66FquC9GPOr6k";

	public int Push(String toK, int no) {
		int check = 0;
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
				input = "{\"notification\" : {\"title\" : \" 승인 요청 \", \"body\" : \"승인요청되었습니다.\"}, \"to\":\"" + toK
						+ "\"}";
				break;
			case 2:
				input = "{\"notification\" : {\"title\" : \" 승인 완료 \", \"body\" : \"승인되었습니다.\"}, \"to\":\"" + toK
						+ "\"}";
				break;
			case 3:
				input = "{\"notification\" : {\"title\" : \" 반려 \", \"body\" : \"승인이 반려되었습니다.\"}, \"to\":\"" + toK
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
