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
<style>p{font-family:verdana,arial;font-color:#ffffff;}
body{font-family:verdana,arial;font-color:#330099;}</style>
<script language='javascript' src='../js/validatefunction.js'></script>
<script type="text/javascript">
function checkVal()
{
    alert("welcome to check val function !!");
	var a="document.myform1.FirstName";
	
	if (!isnulls(a)){
		alert("First Name Field cannot be Empty !!");
		eval(a).focus();
		return false;
		}
return false;
</script>
<script type="text/javascript">
		function OnSubmitForm()
		{
		  if(document.pressed == 'Submit')
		  {
		   
		    document.myform.action ="../jsp/displayImage.jsp";
		  }
		  if(document.pressed == 'View Profile')
		  {
		    var a="document.myform1.FirstName";
		    var b="document.myform1.LastName";
		    var c="document.myform1.Mobile";
			
			if (!isnulls(a) && !isnulls(b) && !isnulls(c)){
				alert("All Fields cannot be Empty !!");
				eval(a).focus();
				return false;
				}
			
			document.myform.action ="../jsp/displayImage.jsp";
		  }
		  else
		  if(document.pressed == 'Update')
		  {
		    document.myform.action ="../jsp/databasetableditor.jsp";
		  }
		  return true;
		}
</script>
</head><body bgcolor="#FEF9E2">
<%
String resultMessage="";
Connection con=null;
ResultSet rst=null;
PreparedStatement pstmt=null;
String action = request.getParameter("action");
System.out.println("action :"+action);
EntityManager em = EntityManagerHelper.getEntityManager();
QuestionmasterDAO objQuestionmasterDAO = new QuestionmasterDAO();
try{
	con = pool.getConnection();
    }
	 catch(Exception e){//System.out.println("Exception ! could not be connected" +e.getMessage());
	 }

if(null == request.getParameter("resultMessage"))
{
}else
{
resultMessage = request.getParameter("resultMessage");
}
System.err.println("*** Requested By : " + request.getRequestURI() + " *** Action : " + action+resultMessage);

if (action == null || action == "")
{
%>
<CENTER>
   <FORM name="myform1" action="" onsubmit="return OnSubmitForm();">
    <table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
        <tr>
        <td align="center">&nbsp;</td>
        <td align="center"> <br>
          <table border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <th colspan="2">Search in Question Database</th>
            </tr>
            <tr>
              <td width="150" align="right">First Name : </td>
              <td width="100" height="10"><input name="FirstName" type="text" size="25"></td>
            </tr>
            <tr>
              <td width="150" align="right">Last Name : </td>
              <td width="100" height="10"><input name="LastName" type="text" size="25"></td>
            </tr>
            <tr>
              <td width="150" align="right">Mobile Number : </td>
              <td width="100" height="10"><input name="Mobile" type="text" size="25"></td>
            </tr>
            <%--<tr>
              <td align="right">Passcode : </td>
              <td>
                <input type="password" name="Password">
              </td>
            </tr>
            --%>
         
              <input type=hidden name=action value="sbfname">
              <input type=hidden name=pagesize value="10">
              <th colspan="2" valign="top">
              <input type="submit" name="operation" onclick="document.pressed=this.value" value="View Profile" />
            
            
           

<!--
			<tr>
              <td colspan="2"> <br>
                <ul>
                  <li> <a href='../servlet/RegistrationForm'>New User? Sign Up
                    Now!</a><br>
                    <br>
                  </li>
                  <li> <a href="javascript:PopWindow('forgotpassword.jsp')">Forgot
                    Passcode?</a> </li>
                </ul>
              </td>
			</tr>
-->
          </table>
         <!-- <p><img src="simages/Nectar_Logo.jpg" width="780" height="319"><br></p> -->
        </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="center"></td>
      </tr>
<!-- <tr>
        <td align="right">&nbsp;</td>
        <td align="right"><img src="../simages/zils_logo_small.jpg" width="324" height="48"></td>
      </tr>
-->
    </table>
    </form>
</CENTER>
<p>&nbsp;</p></body></html>
<%}else if(action.equals("sbfname"))
	{
		String fName = (request.getParameter("FirstName")==null)?"":request.getParameter("FirstName");
		if(fName!=null)
		System.out.println("firstName :"+fName);
		String lName = (request.getParameter("LastName")==null)?"":request.getParameter("LastName");
		System.out.println("lastName :"+lName);
		String mobileNo = (request.getParameter("Mobile")==null)?"":request.getParameter("Mobile");
		System.out.println("Mobile :"+mobileNo);
		%>
		
		<html><head><title>Admin Module</title>
		<link rel="stylesheet" href="../alm.css" type="text/css">
		<script type="text/javascript">
		function OnSubmitForm()
		{
		  if(document.pressed == 'Submit')
		  {
		   
		    document.myform.action ="../jsp/displayImage.jsp";
		  }
		  if(document.pressed == 'View Profile')
		  {
			//alert("I am in");
			document.myform.action ="../jsp/displayImage.jsp";
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

		try{
			con = pool.getConnection();
		    }
			 catch(Exception e){//System.out.println("Exception ! could not be connected" +e.getMessage());
				///nectar/jsp/databasetableditor.jsp
			 }%>
		  <form name="myform" onsubmit="return OnSubmitForm();">
		  
		  <% String primkey="";
		  String editType = request.getParameter("editmodify");
		  if(editType==null){
		  %>
		  <!-- ------------------------------start  -->
		  <table align="center" border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
        	<tr>
            <table border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <th colspan="2">Search Candidate Information</th>
            </tr>
            <tr>
              <td width="150" align="right">Candidate Name : </td>
              <td width="150" align="right"><select name="candrollno">
		        <%
		       
		        String sqlfname = "select * from CandidateMaster cm where cm.candidateid>5 and cm.firstname like '%"+fName+"%'";
		        String sqllname = "select * from CandidateMaster cm where cm.candidateid>5 and cm.lastname like '%"+lName+"%'";
		        String sqlmobile = "select * from CandidateMaster cm,AddressDetails ad where cm.candidateid=ad.candidateid and ad.MobileNo like '%"+mobileNo+"%'";
		        String sqlfullname = "select * from CandidateMaster cm where cm.candidateid>5 and cm.firstname like '%"+fName+"%' || cm.lastname like '%"+lName+"%'";
		        String sqlfullnmobile = "select distinct cm.candidateid,ad.address,cm.firstname,cm.lastname,cm.email,ad.mobileno  from CandidateMaster cm,AddressDetails ad where cm.candidateid=ad.candidateid"+ 
		        	" and cm.firstname like '%mak%' || cm.lastname like '%Kulkarni%' "+
		        	" || ad.MobileNo like '%9881%' group by cm.candidateid having cm.candidateid>5 order by candidateid";
		        if(fName!=null && !fName.equals("")){
			 	pstmt = con.prepareStatement(sqlfname);}
		        else if(lName!=null && !lName.equals("")){
				pstmt = con.prepareStatement(sqllname);}
		        else if(mobileNo!=null && !mobileNo.equals("")){
				pstmt = con.prepareStatement(sqlmobile);}
		        else if(fName!=null && !fName.equals("") && lName!=null & !lName.equals("")){
		        pstmt = con.prepareStatement(sqlfullname);}
		        else if(fName!=null && !fName.equals("") && lName!=null & !lName.equals("") && mobileNo!=null & !mobileNo.equals("")){
			    pstmt = con.prepareStatement(sqlfullnmobile);}
		        //else if(fName==null && fName.equals("") && lName==null & lName.equals("") && mobileNo==null & mobileNo.equals("")){
		        //response.sendRedirect("../jsp/Login.jsp"); }
			 	//System.out.println("ExamTestDetails pstmt :"+pstmt);
			 	rst=pstmt.executeQuery();
		        while(rst.next())    {
		        String candrollno=rst.getString("CandidateID");
		        String FirstName=rst.getString("FirstName");
		        String LastName=rst.getString("LastName");
		          
		        out.println("<option value='"+candrollno+"'>"+candrollno+" -> "+FirstName+" "+LastName+"</option>");
		        //System.out.println("candrollno :"+candrollno);
		     	}
		  		}%>
		     	</select></td>
            </tr>
   			<tr>
              <input type=hidden name=action value="sbfname">
              <input type=hidden name=pagesize value="10">
              <th colspan="2" valign="top">
              <input type="submit" name="operation" onclick="document.pressed=this.value" value="View Profile" />
              <INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></th>
              <%} %>
			</tr>
		</form><p>&nbsp;</p>
		<p>&nbsp;</p></body></html>
	



