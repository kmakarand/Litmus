
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<%@ page language = "java" import = "java.sql.*,java.io.*,sun.net.smtp.SmtpClient" %>
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>
<html>
<head>
<title>Forgot Passcode ?</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
</head>

<body>
<%
pool=(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
String confirm = request.getParameter("confirm");
String Uname = request.getParameter("Username");
boolean userFound = false;

if (confirm == null || confirm == "")
{
%>
  <form name="f1" action="<%= request.getRequestURI()%>" method=POST>    
  <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
	<tr>
	<th colspan=2 valign=middle><B>FORGOT YOUR PASSCODE ?</B></th>
	</tr>
	<tr>
      <td colspan=2><p align=justify>If you have forgotten your passcode, or your passcode is not 
        working for some reason, you can check it easily by providing following information.</p></td>
	</tr>
	<tr>
	<td colspan=2>&nbsp;</td>
	</tr>
    <tr> 
      <td align="right"><b>Enter your Username :&nbsp;</b></td>
      <td><input type="text" name="Username"></b></td>
    </tr>
	<tr><td colspan=2>&nbsp;</td></tr>
    <tr> 
      <th colspan=2 align=center> 
        <input type="submit" name=confirm value="Submit">
      </th>
    </tr>
  </table>
 </form>

<%
}
else if(confirm.equals("Submit"))
{
	Connection con = null;
	con=pool.getConnection();
	try
	{
		if(con!=null)
		{
			Statement st1 = con.createStatement();
			ResultSet rs1 = st1.executeQuery("select * from CandidateMaster where Username='" + Uname+ "'");

			while(rs1.next())
			{
				userFound = true;
%>
  <form name="f1"  action="<%= request.getRequestURI()%>" method=POST>    
  <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
	<tr>
	<th colspan=2 valign=middle>Confirm your Hint Answer</th>
	</tr>
	<tr>
	<td colspan=2>Please, provide the requested information regarding the account: </td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>
    <tr> 
      <td align="right"><b>Username :&nbsp;</b></td>
      <td><%= Uname %><input type=hidden name=Username value=<%= Uname %>></td>
    </tr>
    <tr> 
      <td align="right"><b>Hint Question :&nbsp;</b></td>
      <td>
        <%= rs1.getString("HintQuestion") %>
      </td>
    </tr>
    <tr>
	  <td align=right><b>Hint Answer :&nbsp;</b>
	  </td>
      <td><input type="text" name="HintAnswer"></td>
    </tr>
	<tr><td colspan=2>&nbsp;</td></tr>
    <tr> 
      <th colspan=2>
        <input type=submit name=confirm value="Show Password">
      </th>
    </tr>
  </table>
 </form>
<%
		}	//end of while
      }//end of if
	}//end of try
	catch(SQLException sqle)
	{
	       out.println(sqle.getMessage());
	}
	catch(Exception e)
	{
		   out.println(e.getMessage());
	}
    finally
	{
	  //Release the connection
	  if(con!=null)  pool.releaseConnection(con);
	  else out.println("Connection not obtained");
	}	
	if (!userFound)
	{
				out.println("<FORM><TABLE BORDER=0 CELLSPACING='1' CELLPADDING='1' WIDTH='100%' ALIGN='CENTER'>");
				out.println("<TR><TH>ERROR</TH></TR>");
				out.println("<TR><TD align=center>No user found with this Username.<br><BR>");
				out.println("Please, Enter your correct Username.<br><br></TD></TR>");
				out.println("<TR><TH><INPUT onclick=history.back() type=submit value='Back'></TH></TR>");
				out.println("</TABLE></FORM>");
	}
}
else if (confirm.equals("Show Password"))
{
	try
	{
		String uid = request.getParameter("Username");
		Connection con = null;
		con=pool.getConnection();
		//Connection con = mysqlc.mysqlconnect();
		if(con!=null)
		{
			Statement st2 = con.createStatement();
			ResultSet rs2 = st2.executeQuery("select * from CandidateMaster where Username='" + uid+ "'");
			while(rs2.next())
			{
				if(request.getParameter("HintAnswer").equals(rs2.getString("HintAnswer")))
				{
/*
					SmtpClient smtp = new SmtpClient("202.46.200.181");
					String to = rs2.getString("Email");
					String from = "admin@zils.com";
					smtp.from(from);
					smtp.to(to);
					PrintStream msg = smtp.startMessage();
					msg.println("To: " + to);
					msg.println("From: " + from);
					msg.println("Subject: Password Reminder");
					msg.println();
					msg.println("Your UserID is : " + uid);
					msg.println("Your Password is : " + rs2.getString("Password"));
					smtp.closeServer();
*/
					out.println("<FORM><TABLE BORDER=0 CELLSPACING='1' CELLPADDING='1' WIDTH='100%' ALIGN='CENTER'>");
					out.println("<TR><TH>Success</TH></TR>");
					out.println("<TR><TD align=center><BR>Your Password is :&nbsp;<B>" +rs2.getString("Password")+ "</B><br><BR>");
					out.println("You can close this window.<br><br></TD></TR>");
					out.println("<TR><TH><INPUT onclick=window.close() type=submit value='Close Window'></TH></TR>");
					out.println("</TABLE></FORM>");

				}
				else
				{
					Statement st1 = con.createStatement();
					ResultSet rs1 = st1.executeQuery("select * from CandidateMaster where Username='" + Uname+ "'");
					while(rs1.next())
					{
%>
  <form name="f1" method=POST>    
  <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
	<tr>
	<th colspan=2 valign=middle>Confirm your Hint Answer</th>
	</tr>
	<tr>
	<td colspan=2><font color=red><B>ERROR : </font>Hint Answer is WRONG !</B>
	<BR>Please, provide the requested information regarding the account: </td>
	</tr>
	<tr><td colspan=2>&nbsp;</td></tr>
    <tr> 
      <td align="right"><b>Username :&nbsp;</b></td>
      <td><%= Uname %><input type=hidden name=Username value=<%= Uname %>></td>
    </tr>
    <tr> 
      <td align="right"><b>Hint Question :&nbsp;</b></td>
      <td>
        <%= rs1.getString("HintQuestion") %>
      </td>
    </tr>
    <tr>
	  <td align=right><b>Hint Answer :&nbsp;</b>
	  </td>
      <td><input type="text" name="HintAnswer"></td>
    </tr>
	<tr><td colspan=2>&nbsp;</td></tr>
    <tr> 
      <th colspan=2>
        <input type=submit name=confirm value="Show Password">
      </th>
    </tr>
  </table>
 </form>
<%
				}//end of while
			}//end of else
		 }//end of while
	   }//else of if(con!=null)
	}
	catch (Exception ex)
	{out.println(ex.getMessage());}
}
%> 
</body>
</html>
