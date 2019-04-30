package com.ngs;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class SendMailTLS {
	
	public static boolean SendMail(String host, String port,
			final String userName, final String password, String toAddress,
			String subject, String message) throws AddressException,
			MessagingException 
			{

				boolean sendmail=true;
				//final String username = userName;//"info@nectaropc.com";
				//final String pass = password;//"nectaropc@123$";
		
				Properties props = new Properties();
				props.put("mail.smtp.auth", "true");
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.port", port);
				//props.put("mail.smtp.starttls.enable", "true");
		
				Session session = Session.getInstance(props,
				  new javax.mail.Authenticator() {
					protected PasswordAuthentication getPasswordAuthentication() {
						return new PasswordAuthentication(userName, password);
					}
				  });
		
				try {
		
					Message msg = new MimeMessage(session);
					msg.setFrom(new InternetAddress("info@nectaropc.com"));
					msg.setRecipients(Message.RecipientType.TO,InternetAddress.parse("nectaropc@gmail.com"));
					msg.setSubject(subject);
					msg.setText(message);
		
					Transport.send(msg);
		
					}catch (Exception e)
					{
						sendmail=false;
						System.out.println("sendmail un Sucessfully  !!"+e.getMessage());
					    e.printStackTrace();
					}
					
					System.out.println("sendmail Sucessfully  !!");
					return sendmail;
				}
	

		public static void main(String[] args) {
			SendMailTLS objTestMail = new SendMailTLS();
			try {
				if(objTestMail.SendMail("webmail.nectaropc.com", "587", "info@nectaropc.com", "nectaropc@123$", "kmak99@gmail.com", "Welcome to nectar", "meesage"))
				{
					System.out.println("sendmail insode Sucessfully Registered here !!");
				}
				else
				{
					System.out.println("sendmail Failed !!");
				}
			} catch (AddressException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (MessagingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
}