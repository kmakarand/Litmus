<%@ page import="java.io.*,java.sql.*,java.util.*,javax.servlet.*,javax.servlet.http.*" %>
<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%	//com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	Statement stmt1 = null,stmt2=null;
	ResultSet rs1 =null, rs2=null;
	String sql1="",sql2="",strUser="",strPass="",action="";
	String user= request.getParameter("Username");
	String pass= request.getParameter("Password");
	out.println("user"+user);
	out.println("pass"+pass);
	
	if (user== null || user.equals("") || user.equals(null) || user=="")
	{
	  response.sendRedirect("../jsp/Login.htm");
	}

	action = request.getParameter("action");
    if (action == null || action == "")
	{
		try{
			
			con = pool.getConnection();
			sql1 = "SELECT userid,password FROM Test";
			try{
			    rs1 = con.createStatement().executeQuery(sql1);
			   }catch(Exception e){out.print(e.getMessage());}
			while(rs1.next())
			{
				if(!rs1.getString("userid").equals(user)){
					response.sendRedirect("Login.jsp");

				}else{
					 out.println("Hi");%> 					
					
					<!--
					<html>
					<head>
					<title>Nectar Examination</title>
					<link rel="stylesheet" href="../alm.css" type="text/css">
					<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
					<script language=javascript>
					</head>
					<body>
				    <form name="f1" method=POST>
    <table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
      <tr>
        <td align="center">&nbsp;</td>
        <!-- <td align="center"><img src="../simages/top-ZCA.gif" width="780" height="71"></td> -->
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="center"> <br>
          <table border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <th colspan="2">Login</th>
            </tr>
            <tr>
              <td align="right">Username : </td>
              <td>
                <input type="text" name="Username">
              </td>
            </tr>
            <tr>
              <td align="right">Passcode : </td>
              <td>
                <input type="password" name="Password">
              </td>
            </tr>
            <tr>
              <input type=hidden name=action value="doLogin">
              <th colspan="2" valign="top">
                <input type=submit value="Login" name="submit">
              </th>
            </tr>
          </table>
          <p><img src="../simages/Nectar_Logo.jpg" width="780" height="319"><br>
          </p>
          </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="center"></td>
      </tr>
    </table>
    </form>
</CENTER>
</body>
</html>-->


					
  					
					
				<%/*sql2="UPDATE ClientMaster SET Password ='"+newP+"' WHERE ClientName='"+rs1.getString("ClientName")+"' AND Username='"+rs1.getString("Username")+"' AND Password='"+oldP +"'";
					int i=con.createStatement().executeUpdate(sql2);*/
					sql2="select * from Test where userid='"+user+"'";
					rs2=con.createStatement().executeQuery(sql2);
					while(rs2.next())
					{
						strUser=rs2.getString("userid");
						strPass=rs2.getString("Password");
					}

					}
			}

			//response.setContentType("text/html");
			out.println("<HTML><HEAD><TITLE>Changed Password</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<FORM NAME=form1>");
			out.println("<H4>"+rs1.getString(1) +"<br>You Have Succefully Changed The Password <HR SIZE=1></H4>");%>
 <table border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <th colspan="2">Login</th>
            </tr>
            <tr>
              <td align="right">Username : </td>
              <td>
                <input type="text" value="<%=strUser%>" name="Username">
              </td>
            </tr>
            <tr>
              <td align="right">Passcode : </td>
              <td>
                <input value="<%=strPass%>" name="Password">
              </td>
            </tr>
            <tr>
              <input type=hidden name=action value="doInsert">
              <th colspan="2" valign="top">
                <input type=submit value="Login" name="submit">
              </th>
            </tr>
            <tr>
        <td align="center">&nbsp;</td>
        <td align="center"></td>
      </tr>
    </table>

			<%out.println(sql2);
			out.println("</FORM></BODY></HTML>");
		//	con.close();
		    }catch(Exception e){
			out.println("Error :"+e.getMessage());
		    } 
		}
		else
		{
			out.println("Action is :"+action);
		}
		
		
		
		
		%>
	
	

