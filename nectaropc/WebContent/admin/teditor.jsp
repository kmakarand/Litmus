<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,org.apache.commons.io.filefilter.WildcardFileFilter"%>
<%@page import="com.ngs.ReadExcelFile"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
String adminuser = (String) session.getValue("username");
String tablename="";

if (adminuser == "" || adminuser == null)
{
	response.sendRedirect("../jsp/Login.jsp");
}
%>
<html><head><title>Admin Module</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<script type="text/javascript">
function OnSubmitForm()
{
  if(document.pressed == 'Add')
  {
   
    document.myform.action ="../jsp/ExamTestDetail.jsp";
  }
  else
  if(document.pressed == 'Update')
  {
    document.myform.action ="../jsp/databasetableditor.jsp";
  }
  return true;
}
</script>
<style>p{font-family:verdana,arial;font-color:#ffffff;}
body{font-family:verdana,arial;font-color:#330099;}</style>
</head><body bgcolor="#FEF9E2">
<%
String path="../servlet/ExamTestDetail";
String databasen="nectar";
Connection con=null;
ResultSet rst=null;
PreparedStatement pstmt=null;
try{
	con = pool.getConnection();
    }
	 catch(Exception e){//System.out.println("Exception ! could not be connected" +e.getMessage());
	 }
	 Statement stmt=con.createStatement();
	 rst=stmt.executeQuery("show tables");
///nectar/jsp/databasetableditor.jsp
%>
<br><br><br>

  <form name="myform" onsubmit="return OnSubmitForm();">
  
  <% String primkey="";
  String editType = request.getParameter("editmodify");
  if(editType==null){
  %>
  <table border="0" cellspacing="0" cellpadding="0" align="center"> <tr>
  <td>Select The Name of The Table :</td><td width="56%">
        <select name="tablename">
        <%
        while(rst.next())    {
        String tables_name=rst.getString("Tables_in_"+databasen+"");
        out.println("<option value='"+tables_name+"'>"+tables_name+"</option>");
        //System.out.println("<option value='"+tables_name+"'>"+tables_name+"</option>");
     	}
     	
     	}
     	if(editType != null && !editType.isEmpty() && editType.equals("modrecords")){
		    //try	{ 
		    		//Checking the External Parameters
					//tablename=request.getParameter("tablename");	
					/*String sql = "select * from "+tablename;
					pstmt = con.prepareStatement(sql);
					System.out.println("ExamTestDetails pstmt :"+pstmt);
					ResultSet rs=pstmt.executeQuery();*/
					tablename = request.getParameter("tablename");
					System.out.println("ExamTestDetails tablename :"+tablename);
					DatabaseMetaData metad = con.getMetaData();
				    ResultSet rs = metad.getPrimaryKeys(null, null, tablename);
					String pkcolumnName ="";
				    java.util.List list = new java.util.ArrayList();
				    rs.next();
				    //while (rs.next()) 
				    {
				      pkcolumnName = rs.getString("COLUMN_NAME");
				      session.setAttribute("pkcolumnName",pkcolumnName);
				      System.out.println("getPrimaryKeys(): columnName=" + pkcolumnName);
				      System.out.println("tablename=" + tablename);
				    }%>
					<table border="0" cellspacing="0" cellpadding="10" align="center">
					<tr><td></td>
					  <td><%=pkcolumnName%></td><td>
					        <select name="pkcolumn">
					        <%
					        String sql1 = "select "+pkcolumnName+" from "+tablename;
							pstmt = con.prepareStatement(sql1);
							System.out.println("ExamTestDetails pstmt :"+pstmt);
							rst=pstmt.executeQuery();
					        while(rst.next())    {
					        String tables_name=rst.getString(1);
					        out.println("<option value='"+tables_name+"'>"+tables_name+"</option>");
					        //System.out.println("<option value='"+tables_name+"'>"+tables_name+"</option>");
					     	}
					     	%>
					</select></td></tr></table>
		<%}
     	
        %>
</select></td></tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr>
<td width="44%" height="18">&nbsp;</td>
<td width="56%" height="18"><input type='hidden' name='editmodify' value='modrecords'><input type='hidden' name='tablename' value='<%=tablename%>'></td>
</tr><tr><td>&nbsp;</td><td>&nbsp;</td></tr><tr>
<td colspan="2"><div align="center">
<%if(editType!=null){%>
<input type="submit" name="operation" onclick="document.pressed=this.value" value="Update" />
<INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'>

<!--<input type="submit" name="operation" onclick="document.pressed=this.value" value="Delete" />-->
 <%}
 else{%>
<input type="submit" name="Submit" value="Submit">&nbsp;&nbsp;&nbsp;
<input type="submit" name="operation" onclick="document.pressed=this.value" value="Add" /><%}%>
</div></td></tr></table></form><p>&nbsp;</p>
<p>&nbsp;</p></body></html>
