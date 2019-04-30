

<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->

<%@ page language="java" import="java.sql.*,java.util.Hashtable" session="true" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<meta charset="utf-8">
<title>MainPage</title>
<meta name="generator" content="WYSIWYG Web Builder 10 Trial Version - http://www.wysiwygwebbuilder.com">
<link href="Nectar.css" rel="stylesheet">
<link href="MainPage.css" rel="stylesheet">
</head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
   
   <tr align="center">
       <td align="right" width="40%"><img width="100" height="100" src="simages/logoN1.jpg"></td><td align="left">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img align="top" src="simages/newlogo.jpg"></td>
   </tr>
</table>
<%
int q=0;
int rights=0;
Connection con=null;
Statement stmt,stmt1,stmt2,stmt3=null;
ResultSet rs,rs1,rs2,rs3=null; 
String username = (String) session.getValue("username");
String groupid="",menuid="",url="",mainGroupid="",groupxid="";
 
try{
		ServletContext context = getServletContext(); 
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

		con = pool.getConnection();
 		
		stmt1 = con.createStatement();
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
		

rs =stmt.executeQuery("select * from MenuRights where GroupID=\'"+groupxid+"\' OR Username =\'"+username+"\' ORDER BY MenuID ASC");
		while(rs.next()){
		groupid=rs.getString("MenuID");
		 
		//SELECT * FROM MenuRights WHERE GroupID='00' ORDER BY MenuID ASC
		stmt2 = con.createStatement();
rs2 = stmt2.executeQuery("SELECT * FROM MenuMaster WHERE MenuID=\'"+groupid+"\' ORDER BY MenuID ASC");
				while(rs2.next()){
				menuid=rs2.getString("MenuName");
				url=rs2.getString("Command"); 
				
			}
		 }//end of if(con!=null)
    }//end of try
 }//end of user groupX ref
    catch (Exception e)   {
		   out.print("Exception pinjo!!!!!!  "+e);
		}
  finally 
    { 
        if (con != null) 
            pool.releaseConnection(con); 
        else 
            out.println ("Error while Connecting to Database."); 
    }
  
  Statement stmt11 = con.createStatement();
  ResultSet rs11 =stmt11.executeQuery("select * from MenuMaster ORDER BY MenuID");
  while(rs11.next()){
  	 String MenuID=rs11.getString("MenuID");
  	 String Command=rs11.getString("Command");
  	 String MenuName =rs11.getString("MenuName");
     int integerMenuID=Integer.parseInt(MenuID);
       /*System.out.println("MenuName	:"+MenuName);
       System.out.println("integerMenuID	1:"+integerMenuID);
       System.out.println("integerMenuID%1000000)==0	2:"+integerMenuID%1000000);
       System.out.println("integerMenuID%1000000)==0	3:"+integerMenuID%1000000);
       System.out.println("integerMenuID%10000)==0	4:"+integerMenuID%10000);
       System.out.println("integerMenuID%10000)==0	5:"+integerMenuID%10000);
       System.out.println("integerMenuID%100)==0	6:"+integerMenuID%100);*/
       %>
       <div id="PageHeader2" style="position:absolute;overflow:hidden;text-align:left;left:0px;top:0px;width:100%;height:1px;z-index:6;">
       </div>

       <iframe name="MainDisplayPage" id="InlineFrame1" style="position:absolute;left:20px;top:139px;width:1163px;height:459px;z-index:2;" src=""></iframe>
       <div id="wb_CssMenu1" style="position:absolute;left:314px;top:78px;width:787px;height:29px;z-index:3;">
       
       <%
       //out.println("MenuName	:"+MenuName);
  	 if((integerMenuID%1000000)==0){
  		System.out.println("MenuName	:"+MenuName.trim());%>
  		<ul>
  		<li class="firstmain"><a class="withsubmenu" href="#" target="_self" title="<%=MenuName %>"><%=MenuName %></a>
        <ul>
       
	   	Menu Name: <%=MenuName%>
	   <td valign="top">
	   
    	
	
	  <%
	  	 }//10000
	  	 if((integerMenuID%1000000)!=0){
	   %>
	   <li class="firstitem"><a href="<%=Command%>" target="MainDisplayPage" title="<%=MenuName %>"><%=MenuName %></a>
       </li>
        <li><a href="http://localhost:8080/nectar/jsp/DeleteUser.jsp" target="MainDisplayPage" title="Delete">Delete</a>
        </li>
	  <li><a href="http://localhost:8080/nectar/jsp/DeleteUser.jsp" target="MainDisplayPage" title="Delete">Delete</a>
        </li>
        <br>
        </div>
        
	
	  <%
	  	 }//10000
	
	   if((integerMenuID%10000)!=0){
	  %>
	  	....
	  <%
	  }if((integerMenuID%100)!=0){
	  	%>
	  	....
	  <%
	  }
	   
	  
  }
	
if (username == "" || username == null)
{
	response.sendRedirect("Login.jsp");
}
%>
<div id="wb_Image1" style="position:absolute;left:156px;top:12px;width:120px;height:120px;z-index:4;">
        <img src="simages/logoN1.jpg" id="Image1" alt=""></div>
        <div id="wb_Image2" style="position:absolute;left:458px;top:27px;width:461px;height:26px;z-index:5;">
        <img src="simages/newlogo.jpg" id="Image2" alt=""></div>
</body>
</html>
