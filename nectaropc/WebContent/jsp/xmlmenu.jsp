<%@ page language="java" import="com.ngs.gbl.*,java.sql.*,java.util.Hashtable" session="true" %>
<%@ taglib uri="/WEB-INF/menu.tld" prefix="menu" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<link rel="stylesheet" href="../alm.css" type="text/css">

<%
int q=0;
int rights=0;
Connection con=null;
Statement stmt,stmt1,stmt2,stmt3=null;
ResultSet rs,rs1,rs2,rs3=null; 
String username = (String) session.getValue("username");
if (username == "" || username == null)
{
	response.sendRedirect("Login.jsp");
}
System.out.println("username	:"+username);
String groupid="",menuid="",url="",mainGroupid="",groupxid="";
 
		//ServletContext context = getServletContext(); 
		//pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Class.forName("com.mysql.jdbc.Driver");
    	con = DriverManager.getConnection("jdbc:mysql://localhost/nectar", "nectar", "nec76tar");

		//con = pool.getConnection();
 		
		stmt1 = con.createStatement();
	    rs1 = stmt1.executeQuery("select * from CandidateMaster where Username='" +username+ "'");
		if(rs1.next())
		{
			mainGroupid=rs1.getString("Username");
			//System.out.println("mainGroupid	1:"+mainGroupid);
	    }//end of if(con!=null) to get the group ID
		else
		{	
			rs1 = stmt1.executeQuery("SELECT * FROM ClientMaster WHERE Username='" + username +"'");
			if(rs1.next())
			{
				mainGroupid=rs1.getString("Username");
				System.out.println("mainGroupid	2:"+mainGroupid);		 
		    }//end of if(con!=null) to get the group ID
		}
		
		stmt = con.createStatement();
		stmt3 = con.createStatement();
		System.out.println("groupxid 1:"+mainGroupid);
		
		rs3=stmt3.executeQuery("select * from UserGroupXRef where Username=\'"+mainGroupid+"\' ");
			while(rs3.next()){
				groupxid=rs3.getString("GroupID");
				System.out.println("groupxid :"+groupxid);
				}
		
		/*rs =stmt.executeQuery("select * from MenuRights where GroupID=\'"+groupxid+"\' OR Username =\'"+username+"\' ORDER BY MenuID ASC");
				while(rs.next()){
				groupid=rs.getString("MenuID");
				 
				//SELECT * FROM MenuRights WHERE GroupID='00' ORDER BY MenuID ASC
				stmt2 = con.createStatement();
		rs2 = stmt2.executeQuery("SELECT * FROM MenuMaster WHERE MenuID=\'"+groupid+"\' ORDER BY MenuID ASC");
						while(rs2.next()){
						menuid=rs2.getString("MenuName");
						url=rs2.getString("Command");*/
%>
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
  <%if(groupxid.equals("00")){%>
   <tr align="center">
       <td align="left" width="32%">&nbsp;</td>
       <td align="left"><menu:renderMenuFromXML xmlFilename="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\jsp\xml\adminmenu.xml"/></td>
  </tr>
  <%}else if(groupxid.equals("15")){%>
  <tr align="center">
       <td align="left" width="32%">&nbsp;</td>
       <td align="left"><menu:renderMenuFromXML xmlFilename="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\jsp\xml\managermenu.xml"/></td>
  </tr>
  <%}else if(groupxid.equals("20")){%>
  <tr align="center">
       <td align="left" width="32%">&nbsp;</td>
       <td align="left"><menu:renderMenuFromXML xmlFilename="C:\Users\Makarand\NGEPL\NGS\nectar\WebRoot\jsp\xml\candidatemenu.xml"/></td>
  </tr>
  <%}%>
  <tr align="center"><BR/>
  	<td colspan=2 align="center"><br><img src="simages/sld4.jpg" width="780" height="319">  </td>
  </tr>
</table>
<BR>
<font size="4" color="#960317">
<B>Welcome to Nectar Prometric Examination.</B>
<BR>
<p>
Please click on Help, then on User Help to get help on examination.
</font>
<BR>

</div>
</BODY>
</HTML>