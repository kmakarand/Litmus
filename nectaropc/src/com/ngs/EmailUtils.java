package com.ngs;

import java.io.IOException;
import java.util.Date;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 * A utility class for sending e-mail messages
 * @author www.codejava.net
 *
 */
public class EmailUtils {
	public static boolean sendEmail(String host, String port,
			final String userName, final String password, String toAddress,
			String subject, String message) throws AddressException,
			MessagingException {

		boolean sendmail=true;
		try{
		// sets SMTP server properties
		Properties properties = new Properties();
		properties.put("mail.smtp.host", host);
		properties.put("mail.smtp.port", port);
		properties.put("mail.smtp.auth", "true");
	    //properties.put("mail.smtp.starttls.enable", "true");
		
//		Properties properties = new Properties();
//
//		properties.setProperty("mail.smtp.auth", "true");
//		properties.setProperty("mail.smtp.starttls.enable", "true");
//		properties.setProperty("mail.smtp.host", "smtp.gmail.com");
//		properties.setProperty("mail.smtp.port", "587");
//		properties.setProperty("mail.smtp.user", "nectaropc@gmail.com");
//		properties.setProperty("mail.smtp.password","nectaropc@123$");

		// creates a new session with an authenticator
		Authenticator auth = new Authenticator() {
			public PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication(userName, password);
			}
		};

		Session session = Session.getInstance(properties, auth);

		// creates a new e-mail message
		Message msg = new MimeMessage(session);
		msg.setFrom(new InternetAddress(userName));
		InternetAddress[] toAddresses = { new InternetAddress(toAddress) };
		msg.setRecipients(Message.RecipientType.TO, toAddresses);
		msg.setSubject(subject);
		msg.setSentDate(new Date());
		msg.setText(message);
		// sends the e-mail
		Transport.send(msg);
		}catch (Exception e){sendmail=false;
		System.out.println("sendmail un Sucessfully  !!"+e.getMessage());
		e.printStackTrace();
		}
		
		System.out.println("sendmail Sucessfully  !!");
		return sendmail;

	}
	
public static void main(String[] args) throws AddressException, MessagingException, IOException {
		
		EmailUtils objTestMail = new EmailUtils();
		if(objTestMail.sendEmail("webmail.nectaropc.com", "587", "info@nectaropc.com", "nectaropc@123$", "kmak99@gmail.com", "Welcome to nectar", "meesage"))
		{
			System.out.println("sendmail insode Sucessfully Registered here !!");
		}
		else
		{
			System.out.println("sendmail Failed !!");
		}
		
	
	}
}
