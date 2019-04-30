package com.ngs;

import java.util.Properties;
import java.util.Date;
import javax.mail.*;
import javax.mail.internet.*;

public class SmsUtiity {
	
	public SmsUtiity() {
	}

	public static boolean sendsms(String firstname,String lastname,String username,String userpass,String smshost, 
			final String smsuser, final String smspass,String smssubject,String cell)

	{
		
		boolean success=false;
		
		/*String hostuser = "mak@nectaredutech.com";
		String hostpass = "fire76bird";
		String smtphost = "webmail.nectaredutech.com";
		String compression = "My SMS Compression Information";
		String from = "mak@nectaredutech.com";
		String to = "9881864520@ideacellular.net";
		String body = "Hello SMS World!";*/
					
		String hostuser = smsuser;
		String hostpass = smspass;
		String smtphost = smshost;
		String compression = smssubject;
		String from = smsuser;
		String to = cell+"@ideacellular.net";
		//String to = "91"+cell+"@airtelmail.com";
		String body = "UserName:"+username+"\n"+"Password:"+userpass;
		
		System.out.println("compression:	"+compression);
		System.out.println("cell:	"+cell);
		System.out.println("username:	"+username);
		System.out.println("userpass:	"+userpass);
		System.out.println("to:	"+to);
		
		Transport myTransport = null;

		try {
				Properties props = System.getProperties();
				props.put("mail.smtp.auth", "true");
				Session mailSession = Session.getDefaultInstance(props, null);
				Message msg = new MimeMessage(mailSession);
				msg.setFrom(new InternetAddress(from));
				InternetAddress[] address = { new InternetAddress(to) };
				msg.setRecipients( Message.RecipientType.TO, address);
				msg.setSubject(compression);
				msg.setText(body);
				msg.setSentDate(new Date());
				myTransport = mailSession.getTransport("smtp");
				myTransport.connect(smtphost, hostuser, hostpass);
				msg.saveChanges();
				myTransport.sendMessage(msg, msg.getAllRecipients());
				myTransport.close();
				
		  	} catch (Exception e) {	e.printStackTrace(); }
			
			success=true;
			return success;
		
		}

	public static void main(String argv[])
	  {
		try
		{
		int num=0;boolean flag = false;
		for(num=0;num<100;num++)
		{
			flag = sendsms("Mak","Kul","user","Pass","webmail.nectaredutech.com","info@nectaredutech.com","Nsp6p4@0","Hi:"+num,"9881864520");
		}
			System.out.println("flag"+num);
		}catch(Exception e){e.printStackTrace();}
	  }
}