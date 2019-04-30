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
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>

   <br>
    <font size="3" face="Arial, Helvetica, sans-serif"><b><font size="3" color="#000099">Preview Question Master</font> </font>
   ____________________________________________________________________________________________
   Please Select Your Question Number
<%

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

	%>


	<BODY bgColor=#FEF5E7>
<Form  action=previewProceed.jsp method=GET>


<table border=0 cellspacing=2 cellpadding=2 width=100%>
<tr valign=top>

 <td align="right">Question Numbers: </td>
      <td colspan="5"> &nbsp;
        <select name="questionumber" size=10>
         <%

rs = stmt.executeQuery("SELECT * FROM QuestionMaster ORDER BY QuestionID DESC");
			while(rs.next()){
				%>
<type value="button" name="<%out.print(rs.getString("QuestionID"));%>" value="<%out.print(rs.getString("QuestionID"));%>">
<OPTION VALUE="<%out.print(rs.getString("QuestionID"));%>"><%out.print(rs.getString("QuestionID"));%>
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
		finally
    {
        if (con != null)
            pool.releaseConnection(con);
        else
            out.println ("Error while Connecting to Database.");
    }
%>

</table>
<input type="image" src="../jsp/simages/showdetails1.gif" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver= "MM_swapImage('Image1','','../jsp/simages/showdetails2.gif',1)">


</form>

</body>
</html>
