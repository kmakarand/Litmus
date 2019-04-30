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
<SCRIPT LANGUAGE=JavaScript>
function checkSelection()
{
//	alert("checklatter");
	if(self.document.frmallot.right.selectedIndex==-1)
	{
		alert("Select atleast one Defined User !!");
		self.document.frmallot.right.focus();
		return false;
	}
}
</SCRIPT>
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>


    <font size="3" face="Arial, Helvetica, sans-serif"><b><font size="3" color="#000099">Rights Revise Console</font></b></font></p>
  ____________________________________________________________________________________________

<%

String adminuser = (String) session.getValue("username");

if (adminuser == "" || adminuser == null)
{
	response.sendRedirect("../admin/zeealmadmin.htm");
}


int rights=0;
Connection con=null;
Statement stmt=null;
ResultSet rs=null;

try{

      //If the pool is not initialised
         if(pool.getDriver()==null)	     {
           ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

          }
		con = pool.getConnection();
 		stmt = con.createStatement();

	%>

	<BODY bgColor=#FEF5E7>
<Form  action=rightsOptions1.jsp method=POST name=frmallot>


<table border=0 cellspacing=2 cellpadding=2 width=100%>
<tr valign=top>
 <td align="right">Select User </td>
      <td colspan="5">
        <select name="right" size=10>
         <%
rs = stmt.executeQuery("SELECT * FROM CandidateMaster ORDER BY Username");
			while(rs.next()){
				%>

<OPTION VALUE="<%out.print(rs.getString("Username"));%>"><%out.print(rs.getString("Username"));%>
			<%
				}
			%>
			</SELECT>
 </tr>
<%

        }
    catch (Exception e)   {
		   out.print("Exception pinjo!!!!!!  "+e);
		}
		{
        if (con != null)
            pool.releaseConnection(con);
        else
            out.println ("Error while Connecting to Database.");
        }
%>

</table>

 <input type="image" src="../jsp/simages/remove1.gif" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver = "MM_swapImage('Image1','','../jsp/simages/remove1.gif',1)" onclick='return checkSelection();'>

</form>

</body>
</html>
