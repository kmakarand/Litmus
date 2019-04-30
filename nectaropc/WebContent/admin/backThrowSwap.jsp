<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->


<%@ page language="java" import="java.sql.*"  session="true"%>
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>

</head>
<div align="center">
  <p><br>
    <font size="3" face="Arial, Helvetica, sans-serif"><b><font size="5" color="#000099">Rights Revise Console</font></b></font></p>
  <p align="left">&nbsp;&nbsp;____________________________________________________________________________________________</p>
  <p align="left">&nbsp;</p>

<BODY bgColor=#FEF9E2>
<%

 String groupid,GroupName,rightname,rightsintodb="";
 Connection con=null;
 Statement 	stmt,stmtgroup=null;


try{

      //If the pool is not initialised
         ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");


%>
<%
  groupid=request.getParameter("GroupID");
  GroupName=request.getParameter("GroupName");


  rightname=(String) session.getValue("rightname");


   con = pool.getConnection();
   stmt = con.createStatement();

  stmt.executeUpdate("DELETE from UserGroupXRef WHERE Username='" +rightname+ "'");
  stmtgroup = con.createStatement();


  rightsintodb=request.getParameter("list2");

 String rightsintodbname[] = request.getParameterValues("list2");
 int lengtharray=rightsintodbname.length;
 out.print(lengtharray);


  if(rightsintodb!=null){
	  for (int i=0;i<lengtharray;i++){

out.print(rightsintodbname[i]);
 stmt.executeUpdate("INSERT INTO UserGroupXRef(Username,GroupID) VALUES(\'"+rightname+"\',\'"+rightsintodbname[i]+"\')");

	  }

  }

	%>

	<%

//this is for catching exceptions dont touch
        }
    catch (Exception e)
		{
		   out.print("Exception pinjo!!!!!!  "+e);
		}
		{
        if (con != null)
            pool.releaseConnection(con);
        else
            out.println ("Error while Connecting to Database.");
        }
%>

</form>


<jsp:forward page="allotRights.jsp">
<jsp:param name="employee" value="2"/>
</jsp:forward>





</body>
</html>
