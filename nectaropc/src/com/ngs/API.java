package com.ngs;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.StringTokenizer;

import com.ngs.gen.Utils;


public class API {

	public static String SMSSender(String user, String pwd, String to,String msg, String sid, String fl) {
		String rsp = "";
		String retval = "";
		String finalresp="";
		URL url =null;
		try {
			// Construct The Post Data
			String data = URLEncoder.encode("user", "UTF-8") + "="
					+ URLEncoder.encode(user, "UTF-8");
			data += "&" + URLEncoder.encode("password", "UTF-8") + "="
					+ URLEncoder.encode(pwd, "UTF-8");
			data += "&" + URLEncoder.encode("msisdn", "UTF-8") + "="
					+ URLEncoder.encode(to, "UTF-8");
			data += "&" + URLEncoder.encode("msg", "UTF-8") + "="
					+ URLEncoder.encode(msg, "UTF-8");
			data += "&" + URLEncoder.encode("sid", "UTF-8") + "="
					+ URLEncoder.encode(sid, "UTF-8");
			data += "&" + URLEncoder.encode("fl", "UTF-8") + "="
					+ URLEncoder.encode(fl, "UTF-8");
			// Push the HTTP Request
			url = new URL("http://cloud.smsindiahub.in/vendorsms/pushsms.aspx");
			finalresp = Utils.pushHttpRequest(url,data);
			//System.out.println("resp1:	---------"+finalresp);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return finalresp;
	}
	
	
	
	
	public static void main(String[] args) {
		try{
		
		String username="maksdrnjk";
		String userpass="mak1234sdr";
		String num="9881864520";
		
		String smsmsg="Congrats! You have successfully registered with NGEPL.\n"+"UserName:"+username+"\n"+"Password:"+userpass;
		System.out.println("smsmsg	:"+smsmsg);
		String response = SMSSender("kmakarand", "fire76bird", "919881864520",smsmsg, "WEBSMS", "0");
		System.out.println("response	:"+response);
		//String response = "{\"ErrorCode\":\"000\",\"ErrorMessage\":\"Success\",\"JobId\":\"8605a1b1-3163-469c-8a59-ebba0b795a4c\",\"MessageData\":[{\"Number\":\"919881864520\",\"MessageParts\":[{\"MsgId\":\"919881864520-1c7d673827f64875817bb8cd35421374\",\"PartId\":1,\"Text\":\"Please call me\"}]}]}";
		//System.out.println("response	:"+response);
		
		boolean sendstatus = Utils.checkSendStatus(response);
		System.out.println("sendstatus	:"+sendstatus);
		if(sendstatus)
		System.out.println("You message is successfully delivered");
		else
		SmsUtiity.sendsms("Mak","Kul","user","Pass","webmail.nectaredutech.com","info@nectaredutech.com","Nsp6p4@0",smsmsg,"9881864520");
		
		 
		
		
			
		/*
		 * http://cloud.smsindiahub.in/vendorsms/pushsms.aspx?user=abc&password=xyz
		 * &msisdn=919898xxxxxx&sid=SenderId&msg=test%20message&fl=0
		 * 
		 * http://cloud.smsindiahub.in/vendorsms/pushsms.aspx?user=kmakarand&
		 * password
		 * =fire76bird&msisdn=919881864520&sid=kmakarand&Hi+Makarand&fl=0
		 * 
		 * 
		 * http://cloud.smsindiahub.in/vendorsms/checkdelivery.aspx?user=kmakarand&password=fire76bird&messageid=919881864520-62
		 * c43cd589014ab4ac348ddc99db3c1b
		 */
		
		}catch(Exception e){e.printStackTrace();}
	}
}
