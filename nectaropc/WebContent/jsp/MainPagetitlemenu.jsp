<%@ page language="java" import="java.sql.*,java.util.Hashtable" session="true" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<%@ taglib uri="/WEB-INF/menu.tld" prefix="menu" %>
<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<link rel="stylesheet" href="../alm.css" type="text/css">
<div align="center">
<%
	int q=0;
	int rights=0;
	Connection con=null;
	Statement stmt,stmt1,stmt2,stmt3=null;
	ResultSet rs,rs1,rs2,rs3=null; 
	String username = (String) session.getValue("username");
	String groupid="",menuid="",url="",mainGroupid="",groupxid="";
 

		ServletContext context = getServletContext(); 
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		con = pool.getConnection();
 		stmt1 = con.createStatement();
 		if (username == "" || username == null)
		{
			response.sendRedirect("Login.jsp");
		}
	    rs1 = stmt1.executeQuery("select * from CandidateMaster where Username='" +username+ "'");
		
		if(rs1.next()){
		mainGroupid=rs1.getString("Username");
		}//end of if(con!=null) to get the group ID
		else
		{	
			rs1 = stmt1.executeQuery("SELECT * FROM ClientMaster WHERE Username='" + username +"'");
			 if(rs1.next()){
				mainGroupid=rs1.getString("Username");		 
		    }//end of if(con!=null) to get the group ID
		}

		stmt = con.createStatement();
		stmt3 = con.createStatement();
		//System.out.println("groupxid 1:");
		rs3=stmt3.executeQuery("select * from UserGroupXRef where Username=\'"+mainGroupid+"\' ");
		while(rs3.next()){
			groupxid=rs3.getString("GroupID");
			//System.out.println("groupxid :"+groupxid);
			}
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr align="left">
       <td width="30%" rowspan="2"><img src="simages/logoN1.jpg" width="120" height="120" align="right"></td>
       <td width="60%" height="10"><img src="simages/newlogo.jpg" width="461" height="26" hspace="40" vspace="20"></td>
 </tr>
  <tr align="center">
  <%if(groupxid.equals("00")){
    response.sendRedirect("CopyMainPageMenu.jsp");
    }else if(groupxid.equals("05")){
    	response.sendRedirect("MainPageAdminMenu.jsp");
    }else if(groupxid.equals("15")){
    	response.sendRedirect("MainPageManagerMenu.jsp");
    }else if(groupxid.equals("20")){
    	response.sendRedirect("MainPageCandidateMenu.jsp");
    }%>
  </tr>
 
 </table>
</div>
</BODY>
</HTML>