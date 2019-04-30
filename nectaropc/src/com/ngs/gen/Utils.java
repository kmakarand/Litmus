package com.ngs.gen;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.Set;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.persistence.EntityManager;
import javax.persistence.Query;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspWriter;

import com.itextpdf.text.html.simpleparser.StyleSheet;
import com.lowagie.text.html.HtmlTags;
import com.ngs.EntityManagerHelper;
import com.ngs.entity.Locationmaster;
import com.ngs.entity.Schedule;
import com.ngs.*;

public class Utils
{
	public static final int NONE		= 0;
	public static final int SUBJECT		= 1;
	public static final int CHAPTER		= 2;
	public static final int TOPIC		= 3;
	public static final int SUBTOPIC	= 4;

	
	public static String showError(String title, String errorString, String errorDescription)
	{
		String errorMessage = null;

		errorMessage = "<P><form><table border=0 cellspacing=1 cellpadding=1 width=350><tr><th>" +title+ "</th></tr>";
		errorMessage += "<tr><td><p><BR><b>" +errorString+ "</b>";
		errorMessage += "<BR><BR>" +errorDescription+ "<BR><BR></td></tr>";
		errorMessage += "<tr><th><input type=button onClick='javascript:history.back()' value='Go Back'></th></tr></table></form>";

		return errorMessage;
	}

	//////////	Following Code is for KeyGeneration, Username & Password generation.

	private static final int DEFAULT_KEY_SIZE = 4;
	private static String str = "abcdefghijkmnpqrstuvwxyz23456789ABCDEFGHIJKLMNPQRSTUVWXYZ";
	// 0 (Zero), 1 (One), l (small L), o (small O), O are removed to avoid confusion for user.

	public static String GenerateKey(int size) throws IOException
	{
		String key = null;

		key = GenerateKey(str, size);

		return key.toString();
	}

	public static String GenerateKey(String validCharsString, int size) throws IOException
	{
		int i = 0, strIndex = 0;
		StringBuffer key = new StringBuffer(size);

		for (i = 0; i < size; i++)
		{
			strIndex = (int) ( Math.random() * (validCharsString.length() - 1) + 1);
			key.append(validCharsString.charAt( strIndex ));
		}

		return key.toString();
	}

	public static String GenerateString(String srcString, int charsFromSourceString, int extraChars) throws IOException
	{
		String validChars = "abcdefghijkmnpqrstuvwxyz23456789";

		String destString = "";
		StringBuffer fn = new StringBuffer();
		char spaceChar = ' ', strChar;

		srcString = srcString.trim();
		srcString = srcString.toLowerCase();

		for (int i=0; i < srcString.length() ; i++)
		{
			strChar = srcString.charAt(i);

			if (strChar == spaceChar)
				continue;
			fn = (StringBuffer) fn.append(strChar);
		}

		srcString = fn.toString();

		if (srcString.length() < charsFromSourceString)
		{
			charsFromSourceString = srcString.length();
		}

		destString = destString.concat(srcString.substring(0, charsFromSourceString));
		destString = destString.concat(GenerateKey(validChars, extraChars));

		return destString;
	}

	public static String getDate (String date) 
	{
		String day = date.substring(8,10);
		String mth = date.substring(5,7);
		String yr = date.substring(0,4);
		date = day + "-" + mth + "-" + yr;	
		return date;
	}

	public static String getFullDate (String date) 
	{
		String day = date.substring(8,10);
		String mth = date.substring(5,7);
		String yr = date.substring(0,4);

		String Smonth="";
		if(mth.equals("01")){
		Smonth="January";
		}
		if(mth.equals("02")){
		Smonth="February";
		}
		if(mth.equals("03")){
		Smonth="March";
		}
		if(mth.equals("04")){
		Smonth="April";
		}
		if(mth.equals("05")){
		Smonth="May";
		}if(mth.equals("06")){
		Smonth="June";
		}
		if(mth.equals("07")){
		Smonth="July";
		}
		if(mth.equals("08")){
		Smonth="August";
		}
		if(mth.equals("09")){
		Smonth="September";
		}
		if(mth.equals("10")){
		Smonth="October";
		}
		if(mth.equals("11")){
		Smonth="November";
		}
		if(mth.equals("12")){
		Smonth="December";
		}
	//	date = day + "-" + mth + "-" + yr;
	date = day + "-" + Smonth + "-" + yr;
		return date;
	}
	
	public static Date ConvertStrToDate(String str)
	{
		Date fdate=null;
		try {
			SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
			fdate = sdfDest.parse(str);
			//System.out.println("fdate :"+fdate);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        return fdate;
	}
	
	public static String ConvertDateToString(Date date)
	{
		Date fdate = date;
        SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
        str = sdfDest.format(fdate);
        //System.out.println("str :"+str);
        return str;
	}
	
	public static List removeDuplicates(List list)   
	  {   
	    Set set = new HashSet();   
	    List newList = new ArrayList();   
	    for (Iterator iter = list.iterator(); iter.hasNext(); ) {   
	      Object element = iter.next();   
	      if (set.add(element))   
	        newList.add(element);   
	    }   
	    list.clear();   
	    list.addAll(newList);   
	    return list;
	  }  
	
	public static StyleSheet GenerateStyleSheet()
	{
		StyleSheet css = new StyleSheet();
		//System.out.println("clss :"+css.getClass());
	
		css.loadTagStyle("h1", "size", "30pt");
		css.loadTagStyle("h1", "style", "line-height:30pt;font-weight:bold;");
		css.loadTagStyle("h2", "size", "22pt");
		css.loadTagStyle("h2", "style", "line-height:30pt;font-weight:bold;margin-top:5pt;margin-bottom:12pt;");
		css.loadTagStyle("h3", "size", "15pt");
		css.loadTagStyle("h3", "style", "line-height:25pt;font-weight:bold;margin-top:1pt;margin-bottom:15pt;");
		css.loadTagStyle("h4", "size", "13pt");
		css.loadTagStyle("h4", "style", "line-height:23pt;margin-top:1pt;margin-bottom:15pt;");
		css.loadTagStyle("hr", "width", "100%");
		css.loadTagStyle("a", "style", "text-decoration:underline;");
		css.loadTagStyle(HtmlTags.HEADERCELL, HtmlTags.BORDERWIDTH, "0");
		//css.loadTagStyle(HtmlTags.HEADERCELL, HtmlTags.BORDERCOLOR, "#333");
		css.loadTagStyle(HtmlTags.HEADERCELL, HtmlTags.BACKGROUNDCOLOR, "#cccccc");
		css.loadTagStyle(HtmlTags.CELL, HtmlTags.BACKGROUNDCOLOR,"#EFEFEF");
		//css.loadStyle(HtmlTags.CELL, HtmlTags.FONT, "line-height:30pt;font-weight:bold;" );
		//css.loadTagStyle(HtmlTags.CELL, HtmlTags.BORDERWIDTH, "0.5");
		//css.loadTagStyle(HtmlTags.CELL, HtmlTags.BORDERCOLOR, "#333");*/
		return css;
	}
	
	public static String AddressVerify(int areaID,int stateID,int cityID,int countryID)
	{
		boolean checkFlag=true;String strlocID="";
		EntityManager em = EntityManagerHelper.getEntityManager();
		Query query=null;
		String sql = "SELECT lm FROM Locationmaster lm WHERE lm.countryId=?1 and lm.stateId=?2 and lm.cityId=?3 and lm.areaId=?4";
		query = em.createQuery(sql);
		query.setParameter(1, countryID);
		query.setParameter(2, stateID);
		query.setParameter(3, cityID);
		query.setParameter(4, areaID);
		/*System.out.println("AddressVerify sql :"+sql);
		System.out.println("AddressVerify countryID :"+countryID);
		System.out.println("AddressVerify stateID :"+stateID);
		System.out.println("AddressVerify cityID :"+cityID);
		System.out.println("AddressVerify areaID :"+areaID);*/
		Locationmaster objLocationmaster  = (Locationmaster) query.getSingleResult();
		if(null != objLocationmaster)
		{
			strlocID = String.valueOf(objLocationmaster.getLocationId());
		}
		else
			strlocID = "0";
		
		//System.out.println("AddressVerify strlocID :"+strlocID);
		
		return strlocID;
	}
	
public static int posponeDetailsData(JspWriter out, boolean isBSE,int clientId,String clientName,int slno, String fromDate) throws IOException{
		
		com.ngs.gbl.ConnectionPool pool = null;
		Connection con = null;
		//Global variables
		int cid=0,lid=0,allotedid=0,isapproved=0,scheduleid=0;
		String clientname="",firstname="",lastname="",address="",scheduledate="",actualscheduledate="",postponereqdate="",day="",mth="",yr="",phone1="",phone2="",fax="",email="",name="",namephone1="",namephone2="",nameemail="",nameemail2="",city="",timefrom="",timeto="",approved="";
		final int ZILS_USER = 1;
		final int BSE_USER = 2;
		PreparedStatement pstmt =null;
		try{
			String strCandidateList="";
			String sql="SELECT CandidateID from CandidateMaster WHERE ClientID="+clientId;
			pstmt = con.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while(rs.next()){
				strCandidateList+=rs.getInt("CandidateID")+",";
			}

			strCandidateList=strCandidateList.substring(0,strCandidateList.length()-1);
			sql = "SELECT * FROM PostponeSlotDetails where CandidateID in("+strCandidateList+") ";

			sql += isBSE?" AND PostponeRequestDate like '" + fromDate + "'" : "";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()){
				scheduleid = 0;
				cid = rs.getInt("CandidateID");

				sql = "SELECT FirstName,LastName FROM CandidateMaster WHERE CandidateID=" + cid;
				pstmt = con.prepareStatement(sql);
				ResultSet rs1 = pstmt.executeQuery();
				while (rs1.next()){
					firstname = rs1.getString("FirstName");
					lastname = rs1.getString("LastName");
				}

				int oldschid =0,newschid=0;
				String reqpostdate ="",oldscheduledate="",newscheduledate="";
				sql = "SELECT AllotedScheduleID,RequestedScheduleID,PostponeRequestDate FROM PostponeSlotDetails WHERE CandidateID=" + cid;
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				if (rs1.next()){
					oldschid = rs1.getInt("AllotedScheduleID");
					newschid = rs1.getInt("RequestedScheduleID");
					reqpostdate = rs1.getString("PostponeRequestDate");
				}

				sql = "SELECT ScheduleDate FROM Schedule WHERE ScheduleID=" + oldschid;
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				while (rs1.next()){
					oldscheduledate = rs1.getString("ScheduleDate");
				}

				sql = "SELECT ScheduleDate FROM Schedule WHERE ScheduleID=" + newschid;
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();

				while (rs1.next()){
					newscheduledate = rs1.getString("ScheduleDate");
				}

				com.ngs.gbl.RegistrationKey regkey = new com.ngs.gbl.RegistrationKey (cid);
				out.println("<TR><TD ALIGN=RIGHT>" + slno++ + "</TD>"+
					(isBSE?"<TD>"+clientName+"</TD>":"")+
					"<TD>" + regkey.getKeyCode() + "</TD><TD>" +firstname + " " + lastname + "</TD><TD ALIGN=CENTER>" +  Utils.getFullDate(newscheduledate) +"</TD><TD ALIGN=CENTER>"+ Utils.getFullDate(reqpostdate) +"</TD><TD ALIGN=CENTER>" + Utils.getFullDate(oldscheduledate) + "</TD></TR>");
			}
		}catch(Exception e){
		}finally{
			/*if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");*/
		}
		return (isBSE?slno:0);
	}
	
	public static boolean sendEmail(String firstname,String lastname,String username,String password,String recipient,String emailhost, String emailport,
			final String emailuser, final String emailpass,String welcomesubject) throws AddressException,MessagingException, IOException 
	{
		boolean sendmail=false;
		//System.out.println("sendmail start"+firstname +" "+lastname+" "+" Sucessfully Registered here !!");
		//String recipient = "kmak99@gmail.com";
		String content="Dear "+firstname+" "+lastname+",\n\nCongratulations! You have successfully registered."+
		"\nTo log on Please go to the website http://www.nectatedutech.com and Click on Demo link \n"+
		"Simply enter your User Name, and Password\n\n"+
		"UserName:"+username+"\n"+
		"Password:"+password+"\n\nThen click the Login button.\n\n"+
		"For,\nNectar Global Edutech Pvt. Ltd.\nPune";
		//System.out.println(content);
		
		sendmail = com.ngs.EmailUtility.sendEmail(emailhost, emailport, emailuser, emailpass, recipient, welcomesubject,content);
		/*----------------Mail starts----------------
		try{
			// sets SMTP server properties
			Properties properties = new Properties();
			properties.put("mail.smtp.host", emailhost);
			properties.put("mail.smtp.port", emailport);
			properties.put("mail.smtp.auth", "true");
		    //properties.put("mail.smtp.starttls.enable", "true");
			
//			Properties properties = new Properties();
	//
//			properties.setProperty("mail.smtp.auth", "true");
//			properties.setProperty("mail.smtp.starttls.enable", "true");
//			properties.setProperty("mail.smtp.host", "smtp.gmail.com");
//			properties.setProperty("mail.smtp.port", "587");
//			properties.setProperty("mail.smtp.user", "nectaropc@gmail.com");
//			properties.setProperty("mail.smtp.password","nectaropc@123$");

			// creates a new session with an authenticator
			Authenticator auth = new Authenticator() {
				public PasswordAuthentication getPasswordAuthentication() {
					return new PasswordAuthentication(emailuser, emailpass);
				}
			};

			Session session = Session.getInstance(properties, auth);

			// creates a new e-mail message
			Message msg = new MimeMessage(session);
			msg.setFrom(new InternetAddress(emailuser));
			InternetAddress[] toAddresses = { new InternetAddress(recipient) };
			msg.setRecipients(Message.RecipientType.TO, toAddresses);
			msg.setSubject(welcomesubject);
			msg.setSentDate(new Date());
			msg.setText(content);
			// sends the e-mail
			Transport.send(msg);
			}catch (Exception e){sendmail=false;
			System.out.println("sendmail un Sucessfully  !!"+e.getMessage());
			e.printStackTrace();
			}
			
			System.out.println("sendmail Sucessfully  !!");
			//----------------Mail Ends----------------*/
		
		return sendmail;
	}
	
	public static boolean sendSMS(String firstname,String lastname,String username,String password,String smshost, 
			final String smsuser, final String smspass,String smssubject,String cell) throws AddressException,MessagingException, IOException 
	{
		boolean sendsms=false;
		sendsms = SmsUtiity.sendsms(firstname,lastname,username,password,smshost,smsuser,smspass,smssubject,cell);
		return sendsms;
	}
	
	public static String pushHttpRequest(URL url,String data)
	{
		String rsp = "";
		String retval = "";
		try{
		
		URLConnection conn = url.openConnection();
		conn.setDoOutput(true);
		OutputStreamWriter wr = new OutputStreamWriter(conn.getOutputStream());
		wr.write(data);
		wr.flush();
		// Read The Response
		BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String line;
		while ((line = rd.readLine()) != null) {
			// Process line...
			retval += line;
		}
		wr.close();
		rd.close();
		// HTTP API VER 1.1
		//System.out.println(retval);
		rsp = retval;
		}catch(Exception e){e.printStackTrace();}
		return rsp;
	}
	
	public static boolean checkSendStatus(String response)
	{
		String finalresp ="";boolean sendstatus=false;
		try{
		String finalmsg="";
		String[] products = response.split("\\[");
		for (String product : products) {
		    String[] prodNameCount = product.split("\\:");
		    //System.out.println(prodNameCount[0] + "----" + prodNameCount[1]);
		    //System.out.println("-----------"+prodNameCount[1]);
		    String[] prodNameCount1 = prodNameCount[1].split("\\,");
		    //System.out.println(prodNameCount[0] + "---->" + prodNameCount[1]);
		    String[] prodNameCount2 = prodNameCount[1].split("\\,");
		    if(prodNameCount2[0].contains("-"))
		    finalmsg = prodNameCount2[0];
		    finalmsg= finalmsg.replace("\"", "");
		}
			System.out.println("finalmsg	:"+finalmsg);
		    String data = URLEncoder.encode("user", "UTF-8") + "="
			+ URLEncoder.encode("kmakarand", "UTF-8");
			data += "&" + URLEncoder.encode("password", "UTF-8") + "="
					+ URLEncoder.encode("fire76bird", "UTF-8");
			data += "&" + URLEncoder.encode("messageid", "UTF-8") + "="
					+ URLEncoder.encode(finalmsg, "UTF-8");
					
		 	URL url = new URL("http://cloud.smsindiahub.in/vendorsms/checkdelivery.aspx?");
		 	finalresp = Utils.pushHttpRequest(url,data);
			if(finalresp.equals("#DELIVRD"))
			sendstatus=true;
			//System.out.println("Finalresp DELIVRD:	---------"+finalresp);
			else if(finalresp.equals("#DND"))
			sendstatus=false;
			//System.out.println("Finalresp #DND:	---------"+finalresp);
			else
			sendstatus=false;
			//System.out.println("Finalresp:	---------"+finalresp);
		} catch (Exception e) {e.printStackTrace();
		}
			return sendstatus;
	}
	
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
	
	public static boolean checkDNDStatus(String response)
	{
		boolean checkDNDStatus=false;
		String DNDstatusname=""; String DNDstatusvalue="";
		String finalmsg="";
		String[] products = response.split("\\,");
		for (String product : products) 
		{
		    String[] prodNameCount = product.split("\\:");
		    //System.out.println(prodNameCount[0] + "----" + prodNameCount[1]);
		    DNDstatusname= prodNameCount[0].replace("\"", "");
		    DNDstatusvalue= prodNameCount[1].replace("\"", "");
		    //System.out.println(DNDstatusname + "----" + DNDstatusvalue);
		    if(DNDstatusname.equals("DND_status")&&DNDstatusvalue.equals("on"))
			    {
				    checkDNDStatus=true;
				    System.out.println(DNDstatusname + "----" + DNDstatusvalue);
				}
		 }
	
		return checkDNDStatus;
	}
	
	
	

}