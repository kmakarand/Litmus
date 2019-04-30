
<%
/*
<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->
*/
%>
<%@ page language="java" import="java.sql.*"  session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>

</head>
<BODY bgColor=#FEF5E7>
<SCRIPT LANGUAGE=JavaScript>
function checkSelection()
{
//	alert("checklatter");
	if(self.document.frmallot.rightname.selectedIndex==-1)
	{
		alert("Select atleast one Defined Group !!");
		self.document.frmallot.rightname.focus();
		return false;
	}
}
</SCRIPT>
<SCRIPT LANGUAGE=JavaScript src="..jsp/common.js"></SCRIPT>

   <br>
    <font size="3" face="Arial, Helvetica, sans-serif"><b><font size="3" color="#000099">Group Rights Revise Console</font> </font>
   ____________________________________________________________________________________________
<%

String username = (String)session.getValue("username");

if (username == "" || username == null)
{
	response.sendRedirect("../jsp/Login.jsp");
}
%>
<%
Connection conMB=null;
Statement stmtMB,stmt1MB,stmt2MB,stmt3,stmtchecked,stmtgroup=null;
ResultSet rsMB,rs1MB,rs2MB,rs3,rschecked,rsgroup=null;
int rights=0;
Connection con=null;
Statement stmt=null;
ResultSet rs=null;

try{

      //If the pool is not initialised
        ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

		con = pool.getConnection();
 		stmt = con.createStatement();
	   		stmtgroup = con.createStatement();
	%>


<%--<Form name=frmallot action=groupOptions1.jsp method=GET>--%>
<Form name=frmallot action=newgroupOptions.jsp method=GET>


<table border=0 cellspacing=2 cellpadding=2 width=100%>
<tr valign=top>

 <td align="right">Available Groups: </td>
      <td colspan="5"> &nbsp;
        <select name="rightname" size=10>
         <%
	username=(String)session.getValue("username");
	rsgroup=stmtgroup.executeQuery("Select * from UserGroupXRef where Username='" +username+ "'");
	while(rsgroup.next())
	{
		System.out.println("rsgroup.getString(\"GroupID\")	:"+rsgroup.getString("GroupID"));
		rs = stmt.executeQuery("SELECT * FROM GroupMaster where GroupId ");//>"+rsgroup.getString("GroupID")+" ORDER BY GroupName");
			while(rs.next()){
				%>

<OPTION VALUE="<%out.print(rs.getString("GroupId"));%>"><%out.print(rs.getString("GroupName"));%>
			<%
			}
				}
			%>
			</SELECT>
			</tr>

<%

        }
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
%>

</table>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input width=50 hight=50 type="image" src="../jsp/simages/Grant_Permissions.jpg" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver= "MM_swapImage('Image1','','../jsp/simages/Grant_Permissions.jpg',1)" onclick='return checkSelection();'>


</form>

</body>
</html>
