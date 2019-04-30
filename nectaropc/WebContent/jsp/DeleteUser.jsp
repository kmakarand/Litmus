
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<%@ page language = "java" import = "java.sql.*,java.util.*" session="true" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<%
	String s="../jsp/DeleteUser.jsp";
	//System.out.println("s....."+s);
	String c1 = (String)session.getValue("username");
	//System.out.println("c1....."+c1);
	if (c1 == null || c1.equals(null) || c1=="") response.sendRedirect("../jsp/SessionExpiry.jsp");
	Connection con=null;
	Statement  st1=null,st2=null,st3=null,st4=null,st5=null,st6=null,st7=null,st8=null;
	pool=(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
	con = pool.getConnection();
	String Action=request.getParameter("ButtonAction");
	//System.out.println("Action"+Action);
%>
<html>
<head>
<title>Registration</title>
<META HTTP-EQUIV="Cache-control" CONTENT="no-cache">
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<META HTTP-EQUIV="Expires" CONTENT="0">
<link rel="stylesheet" href="../alm.css" type="text/css">
</head>

<body bgcolor="#FEF9E2" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">


<form name=f1 method="post" action="<%=s%>">
<%

if(Action=="" || Action==null){
%>
<br><br><table border=0 align="center"><tr><td>Username and Name of Candidate</td><td>
 <select name="CandidateID">
            <%
	try     { 			
	        if(con==null) out.println("Connection not obtained");
			if(con!=null)				{	
				st1 = con.createStatement();
				ResultSet rs1 = st1.executeQuery("select * from CandidateMaster ORDER BY FirstName");
				while(rs1.next())		{
				out.println("<option value=" + rs1.getInt("CandidateID") + ">"+rs1.getString("Username")+" -> " + rs1.getString("FirstName") +" " + rs1.getString("LastName") + "</option>");
				}
			}
		}catch(Exception ex){out.println(ex.getMessage());}
%> 
  </select></td></tr><tr><td>&nbsp;</td><td>
<input type="hidden" value="Delete" name="ButtonAction">
<input type="submit" value="Delete User"></td></tr></table>

 <%
}
 else if(Action.equals("Delete")){
//==============

int CandidateID=Integer.parseInt(request.getParameter("CandidateID"));
String Username=null;
st1 = con.createStatement();
				ResultSet rs1 = st1.executeQuery("select Username from CandidateMaster where CandidateID="+CandidateID+"");
				while(rs1.next())		{
				Username=rs1.getString("Username");				
				}
	try     { 			
	        if(con==null) out.println("Connection not obtained");
			if(con!=null)				{	
				st2 = con.createStatement();
				st3 = con.createStatement();
				st4 = con.createStatement();
				st5 = con.createStatement();
				st6 = con.createStatement();
				st7 = con.createStatement();
				st8 = con.createStatement();
				try{
				st2.executeUpdate("delete from CandidateMaster where CandidateID="+CandidateID+"");				
				}catch(Exception e){out.print("Could not Delete the Data from CandidateMaster<br>");}

				try{
				st2.executeUpdate("delete from AddressDetails where CandidateID="+CandidateID+"");				
				}catch(Exception e){out.print("Could not Delete the Data from AddressDetails<br>");}

				try{
				st2.executeUpdate("delete from NewTestStatusDetails where CandidateID="+CandidateID+"");				
				}catch(Exception e){out.print("Could not Delete the Data from NewTestStatusDetails<br>");}

				try{
				st2.executeUpdate("delete from PaymentDetails where CandidateID="+CandidateID+"");				
				}catch(Exception e){out.print("Could not Delete the Data from NewTestStatusDetails<br>");}

				try{
				st2.executeUpdate("delete from NewPerformanceMaster where CandidateID="+CandidateID+"");				
				}catch(Exception e){out.print("Could not Delete the Data from NewTestStatusDetails<br>");}

				try{
				st2.executeUpdate("delete from PostponeSlotDetails where CandidateID="+CandidateID+"");				
				}catch(Exception e){out.print("Could not Delete the Data from NewTestStatusDetails<br>");}

				try{
				st2.executeUpdate("delete from CandidateDetails where CandidateID="+CandidateID+"");				
				}catch(Exception e){out.print("Could not Delete the Data from CandidateDetails<br>");}

				try{
				st2.executeUpdate("delete from UserGroupXRef where Username='"+Username+"'");				
				}catch(Exception e){out.print("Could not Delete the Data from UserGroupXRef<br>");}

				try{
				st2.executeUpdate("delete from RegistrationDetails where CandidateID="+CandidateID+"");				
				}catch(Exception e){out.print("Could not Delete the Data from RegistrationDetails<br>");}

				try{
				st2.executeUpdate("delete from SlotRegisteration where CandidateID="+CandidateID+"");
				out.print("<META HTTP-EQUIV=REFRESH CONTENT=\"1;URL=" + s + "\">");
				}catch(Exception e){out.print("Could not Delete the Data from SlotRegisteration<br>");}

				
			}
		}catch(Exception ex){out.println(ex.getMessage());}

//==============
 }
 %>

	 </form></body></html>
