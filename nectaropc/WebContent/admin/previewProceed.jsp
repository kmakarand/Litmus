<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->
<%@ page errorPage="errorpage.jsp" %>


<html>
<head>
<title>Preview</title>
<style>td{font-family:arial;font-size:9pt;}  body{font-family:arial;font-size:9pt;}</style>
 </head>

<%@ page language="java" import="java.sql.*"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="checker" scope="page" class="com.ngs.gbl.specialChars"/>
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>

<style>td{background-color:#FACFAE;color:black;font-family:arial;}
body{font-family:arial;font-size:10pt}
</style>
<body bgcolor=#FEF9E2>
<form action=previewQmaster.jsp method=get>

<H4>


<table align="left" cellspacing="1" cellpadding="1" border="0">
</td>

Preview Question Number:
</table>
 <%
		String question="",ExamId="";
		question=request.getParameter("questionumber");
		ExamId=request.getParameter("ExamId");
		out.print(question);
 %>
 <br><br></h4>
 <%
		Statement stat=null,statimage=null;
		Statement stat1=null;
		Connection con=null;
		ResultSet rs=null,rsimage=null;

		String ai="",bi="",ci="",di="",quesi="",expi="";




 try
    {
      //If the pool is not initialised

        ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");



      con = pool.getConnection();
	  statimage = con.createStatement();

	try{
	 rsimage=statimage.executeQuery("SELECT * FROM QuestionMaster WHERE QuestionID='" +question+ "'");
			while(rsimage.next()){
				 quesi=rsimage.getString("Question");
				  ai=rsimage.getString("Option1");
				   bi=rsimage.getString("Option2");
				    ci=rsimage.getString("Option3");
					 di=rsimage.getString("Option4");
					  expi=rsimage.getString("Explanation");

	%>
	<table  width="480" height="75">
							<tr>
					             <td align="left" valign="top" class=qu><%=quesi%></td>
					        </tr>
	</table>


	<table width="480" >
							<tr>
								 <td align="center" width="20%" class=an> (a)</td>
					             <td align="left" width="80%" class=an><%=ai%></td>
						    </tr>

							<tr>
								 <td align="center" width="20%" class=an>(b)</td>
					             <td align="left" width="80%" class=an ><%=bi%></td>
				            </tr>
				            <tr>
					             <td align="center" width="20%" class=an> (c)</td>
							     <td align="left" width="80%"  class=an><%=ci%></td>
				            </tr>

							<tr>
							     <td align="center" width="20%" class=an> (d)</td>
						         <td align="left" width="80%"  class=an><%=di%></td>
							</tr>
<br>
							<tr>
							     <td align="center" width="20%" class=an> Explanation:</td>
						         <td align="left" width="80%"  class=an><%=expi%></td>
							</tr>

</table>
<%

			}//end of while
statimage.close();
	}catch(Exception esatament){
out.print("Exception at Image no"+esatament);
}//try for questio ID

	}
	 catch(Exception exception)
					{
						out.println("Duplicate Entry:"+exception);

					}

					{
        if (con != null)
            pool.releaseConnection(con);
        else
            out.println ("Error while Connecting to Database.");
        }

%>
  <td><a href='previewQuestionName.jsp?ExamId=<%=ExamId%>'>Preview More</a></td>  <td align="center"><a href='../jsp/QuestionView.jsp?editmodify=initVal&questionNumber=<%=question%>'>Edit/Delete</a></td>


</form>
</body>

</html>

