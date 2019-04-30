<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->


<%@ page language="java" import="java.sql.*"  session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>

</head>

<BODY bgColor=#FEF9E2>

<%
Connection con=null;
ResultSet resultloop=null;
Statement stmt,stmtloop,stmtupd=null;
String MenuName="",rightname="",ischecked="";
try{

      //If the pool is not initialised
        ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");



%>
<%
  con = pool.getConnection();
 stmt = con.createStatement();
 stmtloop = con.createStatement();
 stmtupd = con.createStatement();
 rightname=(String) session.getValue("rightname");

stmt.executeUpdate("DELETE from MenuRights WHERE GroupID='" +rightname+ "'");
stmt.executeUpdate("DELETE from MenuRights WHERE GroupID='nu'");
//after here all the values are deleated

  resultloop =stmtloop.executeQuery("select * from MenuMaster ORDER BY MenuID ASC");
while(resultloop.next()){
	 MenuName =resultloop.getString("MenuName");

	 ischecked=request.getParameter(MenuName);

if (ischecked!=""&&ischecked!=null){


stmtupd.executeUpdate("INSERT INTO MenuRights(GroupID,MenuID) VALUES(\'"+rightname+"\',\'"+ischecked+"\')");
			}//end of null
		}//end of result set
%>

	<%

//this is for catching exceptions dont touch
        }
    catch (Exception e)
		{
		   out.print("Exception Pinjo !!!!!"+e);
		}
		{
        if (con != null)
            pool.releaseConnection(con);
        else
            out.println ("Error while Connecting to Database.");
        }
%>


<jsp:forward page="allotGroup.jsp">
<jsp:param name="employee" value="2"/>
</jsp:forward>


</body>
</html>

