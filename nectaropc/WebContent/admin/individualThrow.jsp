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
String MenuName="",rightname="",ischecked="",username="";
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
 username=(String)session.getValue("username");
 
 //System.out.println("username	:"+username);
 //System.out.println("rightname	:"+rightname);
 
 Statement stmtMB = con.createStatement();
 Statement stmt3 = con.createStatement();

 	String groupxid="";
 	ResultSet rs3=stmt3.executeQuery("select * from UserGroupXRef where Username=\'"+rightname+"\' ");
	while(rs3.next()){
	groupxid=rs3.getString("GroupID");}

	String groupidMB="";
	ResultSet rsMB =stmtMB.executeQuery("select * from HierMenuRights where GroupID=\'"+groupxid+"\' ORDER BY MenuID ASC");
	while(rsMB.next()){
	groupidMB=rsMB.getString("MenuID");
	//System.out.println("groupidMB	:"+groupidMB);
	}

stmt.executeUpdate("DELETE from HierMenuRights WHERE username='" +rightname+ "'");
stmt.executeUpdate("DELETE from HierMenuRights WHERE GroupID='nu'");
//after here all the values are deleated

  resultloop =stmtloop.executeQuery("select * from HierarchyMenu ORDER BY MenuID ASC");
while(resultloop.next()){
	 MenuName =resultloop.getString("MenuName");
	 ischecked=request.getParameter(MenuName);
	 //System.out.println("ischecked	:"+ischecked);

	if (ischecked!=""&&ischecked!=null){
	String sql = "INSERT INTO HierMenuRights(username,MenuID) VALUES(\'"+rightname+"\',\'"+ischecked+"\')";
	//System.out.println("sql	:"+sql);
	stmtupd.executeUpdate(sql);
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


<jsp:forward page="allotIndividual.jsp">
<jsp:param name="rightname" value="<%=rightname%>"/>
</jsp:forward>


</body>
</html>

