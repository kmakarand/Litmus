package com.ngs;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;

import com.ngs.gen.Utils;



public class SMSdemo {

	public static String sendMySMS(String url)
	{
	    StringBuilder output = new StringBuilder();
	    try
	    {
	    	String head = "xEJzlyqdEtmshsUdrjAegw8ZrmRDp1Mw685jsnv95WbdHd6FV6";
	        URL hp = new URL(url);
	        //System.out.println(url);
	        URLConnection hpCon = hp.openConnection();
	        hpCon.setRequestProperty("X-Mashape-Authorization", head);
	        BufferedReader in = new BufferedReader(new InputStreamReader(hpCon.getInputStream()));
	        String inputLine;
	        while ((inputLine = in.readLine()) != null)
	            output.append(inputLine);
	        in.close();
	    }
	    catch (Exception e)
	    {
	        e.printStackTrace();
	    }
	    return output.toString();
	}
  
  public static void sendSMS()
  {
	  try {
  		
  		//String smsmsg="Congrats! You have successfully registered with Nectar Global Edutech Pvt Ltd.";
		String smsmsg="Please visit to my business website http://www.nectaredutech.com - Dr. Makarand Kulkarni";
		String mobile=URLEncoder.encode("9922929213","UTF-8");
		String msg=URLEncoder.encode(smsmsg,"UTF-8");
		//String SMSApi1 = "https://site2sms.p.mashape.com/index.php?uid=9881864520&pwd=fire76bird&phone="+mobile+"&msg="+msg;
        String SMSApi2 = "https://freesms8.p.mashape.com/index.php?msg="+msg+"&phone="+mobile+"&pwd=7110&uid=9881864520";
        //String url1 = SMSApi1;
        //String response1 = sendMySMS(url1);
        String url2 = SMSApi2;
        String response2 = sendMySMS(url2);
        //System.out.println("sendsms response1:"+response1);
        System.out.println("sendsms response2:"+response2);
        System.out.println("</B> Sucessfully SMS Sent !!");
	  } catch (Exception e) {
			e.printStackTrace();
		}
			
  }

  public static void main(String argv[])
  {
	  SMSdemo.sendSMS();
  }
}