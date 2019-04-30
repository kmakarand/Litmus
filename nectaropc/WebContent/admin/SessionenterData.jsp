


<html>
<head>
<title>Database</title>
</head>

<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<style>td{background-color:lightblue;color:black;font-family:arial;}
body{font-family:arial;font-size:10pt}
</style>
<form action=SecondAddQuestion.jsp method=get>
<body bgcolor=#FEF9E2>
<H4>

<table align="left" cellspacing="1" cellpadding="1" border="0"> 

<br><td>Database: alm</td></br>
<br><td>Table: QuestionMaster</td></br>
<br><td><%
out.println("Data Entered on: " + new java.util.Date());
%></td></br>
</table>



 <%
	String code=null;
		int options;	
		int qno=0;
		 
		int partyid=Integer.parseInt((String)session.getValue("partyid")); 
		int examtype=Integer.parseInt((String)session.getValue("examtype")); 
 		options=Integer.parseInt(request.getParameter("options")); 
		String a11="";
		String a21="";
		String a31="";
		String a41="";
		String a51="";
     String question=request.getParameter("question");	

       		if (options==2){
			  a11=request.getParameter("a11");
			  a21=request.getParameter("a21");
			  a31=new String("no options");
			  a41=new String("no options");
			  a51=new String("no options");

				}else if (options==4){
				  a11=request.getParameter("a11");
				  a21=request.getParameter("a21");
			      a31=request.getParameter("a31");
				  a41=request.getParameter("a41");
				  a51=new String("no options");
				
				} else{
						  a11=request.getParameter("a11");
						  a21=request.getParameter("a21");
						  a31=request.getParameter("a31");
						  a41=request.getParameter("a41");
						  a51=request.getParameter("a51");
							   }
		 
 		int ans1=Integer.parseInt(request.getParameter("ans1")); 
		String exp1=request.getParameter("exp1");
		int level1=Integer.parseInt(request.getParameter("level1"));
		int examid=Integer.parseInt((String)session.getValue("examid")); 
				
		  
        String subjectid=(String)session.getValue("subjectid");
        String chapter=(String)session.getValue("chapter");
		String topic=(String)session.getValue("topic");
		String subtopic=(String)session.getValue("subtopic");
 
		int rtime=Integer.parseInt(request.getParameter("rtime"));
	 
 		StringBuffer sbf=new StringBuffer();
		sbf.append(subjectid);
		sbf.append(chapter);
		sbf.append(topic);
		sbf.append(subtopic);
code= new String(sbf);
out.print(code);


 try
    {
      //If the pool is not initialised
      Connection con = pool.getConnection();
	  Statement stat = con.createStatement(); 
		 Statement stat1 = con.createStatement(); 


	ResultSet rs=stat1.executeQuery("SELECT MAX(QuestionID) AS QuestionID FROM QuestionMaster");
			while(rs.next()){
			
			 String questionumber=rs.getString("QuestionID");
			 int questionumber1=Integer.parseInt(questionumber);
			 qno=questionumber1 +1 ;
			  
								}
					

 
stat.executeUpdate("INSERT INTO QuestionMaster(QuestionID,Code,PartyID,Question,ExamType,NoOfOptions,Option1,Option2,Option3,Option4,Option5,Answer,Explanation,Level,ExamID,ResonableTime )VALUES("+qno+",\'"+code+"\',"+partyid+",\'"+question+"\',"+examtype+","+options+",\'"+a11+"\',\'"+a21+"\',\'"+a31+"\',\'"+a41+"\',\'"+a51+"\',"+ans1+",\'"+exp1+"\',"+level1+","+examid+","+rtime+")");
 

     
      stat1.close();
     stat.close();
	 con.close();
	}
	 catch(Exception exception) 
					{
						out.println("Duplicate Entry:"+exception);
						
					}

     
%>

 <input type="Submit" value="Back">
</form> 
<a href="/zalm/admin/SecondAddQuestion.jsp"><h4>Change Questions</h4> </a> 
<a href="/zalm/admin/SessionAddQuestion.jsp"><h4>Enter Data From Root</h4> </a> 
</body>



</html>

