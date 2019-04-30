
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<html>
<head>
<title>Score Chart</title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<link rel="stylesheet" href="../alm.css" type="text/css">
</head>

<body bgcolor="#fff5e7">
<br><br>

<br>
<%@ page language="java" import="java.io.*,java.util.*,java.sql.*" session="true"  %>
<%! String courseName=""; %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="NMC" scope="application" class="com.ngs.gen.NMCalculate"/>
<jsp:useBean id="gdt" scope="application" class="com.ngs.gen.Utils"/>

<%
    int count=1; 
    ServletContext context = getServletContext();
	pool = (com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
	

	Connection con = pool.getConnection();

	String result = "";
	//if(request.getParameter("result").equals("1")) result ="Pass";
	//else result="Fail";


try{
	    

        if(count==1)
	    {
        Integer CID			= (Integer)session.getValue("CandidateID");
		String ClientID = (String) session.getAttribute("ClientID");
		Integer EID			= (Integer)session.getValue("ExamID");
		int CandidateID		= CID.intValue();
		int examid		= EID.intValue();

		//out.println("ClientId"+ClientID);
        //out.println("CandidateId"+CandidateID);
		Calendar calendar = new GregorianCalendar();
		String strcurDate= calendar.get(Calendar.YEAR)+"-"+(calendar.get(Calendar.MONTH)+1)+"-"+calendar.get(Calendar.DATE);
		//out.println("Current Date: " +strcurDate);

		String sql="Insert into ExamDetails(CandidateID,ClientID,ExamDate) values ("+CandidateID+",'"+ClientID+"','"+strcurDate+"')";
		int j = con.createStatement().executeUpdate(sql);
		//System.out.println("INSERT INTO ExamDetails j:"+j);	

		String sql1="select TestName from NewExamDetails where ExamID="+examid;
		ResultSet rst1 = con.createStatement().executeQuery(sql1);
		while(rst1.next())
	   {
         courseName=rst1.getString("TestName");
         //System.out.println("courseName :"+courseName);
	   }
       count++;
	   }
       }catch(SQLException e)
		{
			out.println("Insert Candidate Exception :"+e.getMessage());
			//System.out.println("Insert Candidate Exception :"+e.getMessage());
		}
		finally
					{
				      //Pool Being Emptied on condition
					  if(con!=null)
							{
							  pool.releaseConnection(con);
							  //pool2.emptyPool();
							  //out.println("Pool Emptied");
							}
					 }
%>
<div align="center">

    <p>&nbsp;</p>
    <table border=0 cellspacing=1 cellpadding=0 align="center" width="70%">
      <tr>
        <th  bgcolor=#330099>Result of the Test</th>
      </tr>
      <tr>
        <td  bgcolor=#330099 align="center"><br>
          <table border="0" cellspacing="1" cellpadding="1" class="result">
            <tr>
              <td align="right" width="60%">Exam :</td>
              <td width="40%"><%=courseName%></td>
            </tr>
            <tr>
              <td align="right">Total Questions :</td>
              <td><%=request.getParameter("AllQuestions")%></td>
            </tr>
            <tr>
              <td align="right">No. of Correct answers :</td>
              <td><%=request.getParameter("right")%></td>
            </tr>
            <tr>
              <td align="right">No. of Incorrect answers :</td>
              <td><%=request.getParameter("wrong")%></td>
            </tr>
            <tr>
              <td align="right">No. of unattempted questions :</td>
              <td><%=request.getParameter("unatt")%></td>
            </tr>
            <tr>
              <td align="right">Percentage Score Obtained:</td>
              <td><%
							float pco=((Float.parseFloat(request.getParameter("right")))*100/(Float.parseFloat(request.getParameter("AllQuestions"))));%>
							<%=pco%> %
							<!--if(request.getParameter("scorep").length()>5)
			  out.println(request.getParameter("scorep").substring(0,5)+"%");
			  else out.println(request.getParameter("scorep")+"%");-->
				      </td>
            </tr>
			<tr>
              <td align="right">Passing Crieteria:</td>
              <td><%/*=request.getParameter("PassingCriteria")*/%>50 %</td>
            </tr>
            <tr>
              <td align="right">Result :</td>
              <td><%if(pco>=50)out.println("Pass");else out.println("Fail");%></td>
            </tr>

          </table>
          <br>
		  <%//request.getParameter("score")%>
        </td>
      </tr>
      <tr>
        <th align="center">
          <input type="submit" name="Button" value="Close" onclick='window.close();'>
        </th>
      </tr>
    </table>
<br><br><br>

</div>


<!--
	<center><b><u><font color=#960317>Score Chart: </font></u></b><br><br></center>
	<center>
	<TABLE BORDER=1 cellspacing=0 cellpadding=0>
	<TR bgcolor="#facfae"><TD><font color=#960317>No.of correct answers</font></TD><TD><font color=#960317>No.of wrong answers</font></TD><TD><font color=#960317>No. of unattempted Questions</font></TD><TD><font color=#960317>Total Questions</font></TD><TD><font color=#960317>Final Score</font></TD></TR>
	<TR align=center><TD><font color=#960317><%=request.getParameter("right")%></font></TD><TD><font color=#960317><%=request.getParameter("wrong")%></font></TD><TD><%=request.getParameter("unatt")%></font></TD><TD><font color=#960317><%=request.getParameter("TotalQuestions")%></font></TD><TD><font color=#960317><%=request.getParameter("score")%></font></TD></TR>
	</TABLE>
	</center>
	-->
</body>
</html>
