<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,org.apache.commons.io.filefilter.WildcardFileFilter"%>
<%@page import="com.ngs.ReadExcelFile,com.ngs.entity.*"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js">
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<%
String resultMessage="";
Connection con=null;
ResultSet rst=null;
PreparedStatement pstmt=null;
String action = request.getParameter("action");
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
  <form name="f1" method=POST action="Questions.jsp">
    <table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
        <tr>
        <td align="center">&nbsp;</td>
        <td align="center"> <br>
          <table border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <th colspan="2">Search in Question Database</th>
            </tr>
            <tr>
              <td width="150" align="right">Search Query : </td>
              <td width="100" height="10"><input name="q" type="text" size="35"></td>
            </tr>
            <%--<tr>
              <td align="right">Passcode : </td>
              <td>
                <input type="password" name="Password">
              </td>
            </tr>
            --%>
            <tr>
            	<TD align=right>Choose Test :</TD>
            	<td><select name="ExamID">
		        <%
		        String sql = "select distinct qm.examId,em.exam from Questionmaster qm,Exammaster em where qm.examId=em.examId order by qm.examId";
				Query query = em.createQuery(sql);
				List<Object[]> objList= query.getResultList();
				
				int examId=0;String examName="";
		        for(Object[] obj:objList)
		        {
		        	examId = (Integer)obj[0];
		        	examName = (String)obj[1];
		        	out.println("<option value='"+examId+"'>"+examName+"</option>");
		        //System.out.println("candrollno :"+candrollno);
		     	}
		        
		     	%>
		     	
				</select></td>
            <tr>
              <input type=hidden name=action value="">
              <input type=hidden name=page value="1">
              <input type=hidden name=pagesize value="10">
              <th colspan="2" valign="top">
                <input type=submit value="Search" name="submit">
                
            </tr>
           
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
<%} %>
<p>&nbsp;</p></body></html>
