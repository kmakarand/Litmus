<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->


<%@ page language="java" import="java.sql.*,org.apache.commons.lang3.*"  session="true"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>

</head>
<script language='JavaScript' src='../jsp/almscript.js'></script>
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>
 <div align="left">
  <p>
    <font size="3" face="Arial, Helvetica, sans-serif"><b><font size="3" color="#000099">Group Rights Revise Console</font>
   ______________________________________________________________________________________

 <BODY bgColor=#FEF9E2>

 Sample Menu Displayed
 <%
Connection con=null;
String username =null;
username=(String)session.getValue("username");

if (username == "" || username == null)
{
	response.sendRedirect("../jsp/Login.jsp");
}
%>
<%
int q=0;
int chkctr=1;
int rights=0;

Connection conMB=null;
Statement stmtMB,stmt1MB,stmt2MB,stmt3,stmtchecked=null;
ResultSet rsMB,rs1MB,rs2MB,rs3,rschecked=null;
String rightname="";




 if(rightname==null || rightname==""){
     rightname = request.getParameter("rightname");
     System.out.println("rightname	:"+rightname);
	 session.putValue("rightname",rightname);
		}else{
		 rightname = (String) session.getValue("rightname");
		}

//String rightname=request.getParameter("right");
String groupidMB="",menuidMB="",url="",mainGroupid="",groupxid="";
int targetFrame=0;
try{

      //If the pool is not initialised
        ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
		
		/*conMB = pool.getConnection();
		stmt1MB = conMB.createStatement();
	    rs1MB = stmt1MB.executeQuery("select * from CandidateMaster where Username='" +rightname+ "'");

		 while(rs1MB.next()){
		mainGroupid=rs1MB.getString("Username");

	    }*///end of if(conMB!=null) to get the group ID
%>
<script language="javascript">

function NewWindow(url)
{

var anil = window.open(url,"HelpWindow","width=750,height=450,resizable=no,scrollbars=yes, left=20, top=20");

}


menuArray = new Array();
<%
		stmtMB = conMB.createStatement();
		stmt3 = conMB.createStatement();
/*
rs3=stmt3.executeQuery("select * from UserGroupXRef where Username=\'"+rightname+"\' ");
	while(rs3.next()){
		groupxid=rs3.getString("GroupID");
*/

rsMB =stmtMB.executeQuery("select * from HierMenuRights where GroupID=\'"+rightname+"\' ORDER BY MenuID ASC");
		while(rsMB.next()){
		groupidMB=rsMB.getString("MenuID");


		stmt2MB = conMB.createStatement();
		rs2MB = stmt2MB.executeQuery("SELECT * FROM HierarchyMenu WHERE MenuID=\'"+groupidMB+"\' ORDER BY MenuID ASC");
				while(rs2MB.next()){
				menuidMB=rs2MB.getString("MenuName");
				url=rs2MB.getString("Command");

			}
		 }//end of if(conMB!=null)
    }//end of try
// }//end of user groupX ref
    catch (Exception e)   {
		   out.print("Exception pinjo!!!!!!  "+e);
		}%>


</script><br><br><br>

<%
String MenuName =null;
String GroupName=null;
String groupid=null;
String Username=null;
String CandidateID=null;
String menuid=null;
String MenuID=null;
String Command=null;
%>
<table width="100%" cellspacing="0">
<tr bgcolor="#FACFAE">
<td>
User Group
</td><td>
<%
out.print(rightname);
%>
</td>
</table>

<script language='JavaScript'>
   function chngfocus(myobj,obj) {
		var isParentChecked = false;

		switch(obj){

		 case 1:
			if ( document.f1.PROFILE1.checked != false )
				isParentChecked = true;
			break;
		 case 2:
			if ( document.f1.PROFILE2.checked != false )
				isParentChecked = true;
			break;
		}

		 if ( isParentChecked ) {

		 }else{
				alert("Parent element not checked");
					myobj.blur();

	    	 }

		 }

</script>

<Form name="f1" action=newgroupThrowCheck.jsp method=GET>
<%

try{

      //If the pool is not initialised
         ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
        con = pool.getConnection();
 		Statement stmt2 = con.createStatement();

		ResultSet rs2 = stmt2.executeQuery("SELECT * FROM HierarchyMenu where MenuId='"+rightname+"'");
			while(rs2.next()){
				%>
					<table width="100%" cellspacing="0">
					<tr bgcolor="#FACFAE">
<td>
UserName
</td><td>
<%
			out.print(rs2.getString("GroupName"));
%>
</td>
</table>
<%
		}
%>
	<table width="100%" cellspacing="0">
	<tr bgcolor=#FACFAE><td>
<%
out.print("Alloted Rights :");
%>
	</td><td>


		  </table>


<table border="1" width="1200" cellspacing="0" cellpadding="0" align="right" >

<%
int integerMenuID=0;
Statement stmt1 = con.createStatement();
ResultSet rs1 =stmt1.executeQuery("select * from HierarchyMenu ORDER BY MenuID");
while(rs1.next()){
	 MenuID=rs1.getString("MenuID");
	 Command=rs1.getString("url");
	 MenuName =rs1.getString("MenuName");
     //integerMenuID=Integer.parseInt(MenuID);
     int count = StringUtils.countMatches(MenuID, ".");
     System.out.println("MenuID	:"+MenuID);
     System.out.println("integerMenuID	:"+count);


	 if((count==0)){
 %>

 <td valign="top">

<%
	 }//10000
	 if((count)==1){
 %>

....

<%
	 }//10000

 if((count==2)){
%>
	....
<%
}
%>
<input type="checkbox" name="<%out.print(MenuName);%>" value="<%out.print(MenuID);%>"
<%
 stmtchecked = con.createStatement();
 rschecked =stmtchecked.executeQuery("SELECT * FROM HierMenuRights WHERE GroupID='"+rightname+"' AND MenuID='"+MenuID+"'");
chkctr++;
if (rschecked.next()){
out.print("CHECKED");
}else{
out.print("");
}

%>
		>

 <%out.print(MenuName);%><br>
	<%

	//}// end of for((integerMenuID%1000000)==0)
	%>


	<%
}// end of while(rs1.next())
	%></table>


</tr>

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

 <br><br><br><br><br><br><br><br><br><br><br><br><br><br>&nbsp;&nbsp;&nbsp;&nbsp;
   <input type="image" width=50 hight=50 src="../jsp/simages/Grant_Permissions.jpg" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver = "MM_swapImage('Image1','','../jsp/simages/grant2.gif',1)">
   <input width=100 hight=100 name="Image2" type=image src="../jsp/simages/reset.jpg" onMouseOut="MM_swapImgRestore()" onMouseOver = "MM_swapImage('Image2','','../jsp/simages/reset.jpg',1)" OnClick="javascript:return ResetForm();">
   <!--input type='button' name='editmodify' value='Try The Option' onClick='klick("+ckvalue+")'>
   <input name="Image3" type=image src="../jsp/simages/tryit1.gif" onMouseOut="MM_swapImgRestore()" onMouseOver = "MM_swapImage('Image3','','../jsp/simages/tryit2.gif',1)" OnClick='klick(<%=chkctr%>)'-->
<%//out.print(chkctr);%>

</BODY>
</html>

