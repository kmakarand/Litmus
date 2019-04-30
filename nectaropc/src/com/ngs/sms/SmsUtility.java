package com.ngs.sms;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
 
public class SmsUtility {
	
	public static void main(String argv[])
  	{
	  
		String test="";
		
	try {
			test = SmsUtility.sendSms("Welcome Dr. Mak","9156072032");
	  	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();}
	
	  System.out.println("test :"+test);
	}
	
	public static String sendSms(String msg, String mobile) {
		try {
			// Construct data
		
			HttpURLConnection conn;
			BufferedReader reader;
			String line;
			String result = "";
			String baseUrl = "http://mysms.exposys.in/api/send_transactional_sms.php?username=u3735&msg_token=yLnng2&sender_id=NECTAR&message="+msg+"&mobile="+mobile;
			String charset = "UTF-8";
			
			URL url = new URL(baseUrl);
			conn = (HttpURLConnection) url.openConnection();
			conn.setRequestMethod("GET");
			conn.connect();
			reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			while ((line = reader.readLine()) != null) {
			result += line;
			}
			reader.close();
			conn.disconnect();
			System.out.println(result);
			return result;
			
		} catch (Exception e) {
			System.out.println("Error SMS "+e);
			return "Error "+e;
		}
	}
}