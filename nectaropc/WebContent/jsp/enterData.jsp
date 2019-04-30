
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->

<html>
<head>
<title>Database</title>
<style>td{font-family:arial;font-size:9pt;}  body{font-family:arial;font-size:9pt;}</style>
</head>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="checker" scope="page" class="com.ngs.gbl.specialChars"/>
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>

<style>td{background-color:lightblue;color:black;font-family:arial;}
body{font-family:arial;font-size:10pt}
</style>
<form action=AddQuestion.jsp method=get>
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
 
		Statement stat=null,statimage=null;
	    Statement stat1=null;
		Connection con=null;
		ResultSet rs=null,rsimage=null;
		String username = (String)session.getValue("username");
		String code="",question="",exp1="",subjectid="",questionumber="",status="";
		int options=0,level1=0,examid=0,rtime=0,examtype=0,questionumber1=0;
		String a11="",a21="",a31="",a41="",a51="",ai="",bi="",ci="",di="",ei="",quesi="",expi="",marks="",word="",ti="";
		int qno=0,ans1=0;
		int partyid=0;
		try{
		partyid=Integer.parseInt(request.getParameter("partyid")); 
		question=checker.check(request.getParameter("question"));	
		status=request.getParameter("status");	
		examtype=Integer.parseInt(request.getParameter("examtype")); 
		options=Integer.parseInt(request.getParameter("ansopts")); 
		
		}
		catch(Exception e){out.print("Level1");}
		if (options==2){
			
	    	  a11=checker.check(request.getParameter("a11"));
			  a21=checker.check(request.getParameter("a21"));
			  a31=checker.check(new String("no options"));
			  a41=checker.check(new String("no options"));
			  a51=checker.check(new String("no options"));
			

				}else if (options==4){
					try{
				  a11=checker.check(request.getParameter("a11"));
				  a21=checker.check(request.getParameter("a21"));
			      a31=checker.check(request.getParameter("a31"));
				  a41=checker.check(request.getParameter("a41"));
				  a51=checker.check(new String("no options"));
					}catch(Exception e){out.print("Level2");}
				} else{
						  a11=checker.check(request.getParameter("a11"));
						  a21=checker.check(request.getParameter("a21"));
						  a31=checker.check(request.getParameter("a31"));
						  a41=checker.check(request.getParameter("a41"));
						  a51=checker.check(request.getParameter("a51"));
							   }
		 
		 ans1=Integer.parseInt(request.getParameter("ans1")); 
		 exp1=checker.check(request.getParameter("exp1"));
		 level1=Integer.parseInt(request.getParameter("level1"));
		 examid=Integer.parseInt(request.getParameter("examid")); 
		 subjectid=request.getParameter("codegroupid");// this is provided from tolanis code
		 
		 rtime=Integer.parseInt(request.getParameter("rtime"));
		 marks=request.getParameter("marks");


 try
  {
  //If the pool is not initialised
        
        ServletContext context = getServletContext(); 
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPool");
       
          
     
      con = pool.getConnection();
	  stat = con.createStatement(); 
      stat1 = con.createStatement(); 
	   statimage = con.createStatement(); 
	 

 
	 rs=stat1.executeQuery("SELECT MAX(QuestionID) AS QuestionID FROM QuestionMaster");
			while(rs.next()){
			
			 questionumber=rs.getString("QuestionID");
			 if (questionumber==null){
			 qno=1;
			 }else{
			 questionumber1=Integer.parseInt(questionumber);
			 qno=questionumber1 +1 ;
					} 
								}
}catch(Exception esatament){
out.print("Exception at Question no"+esatament);
}//try for questio ID

try{

String newdate= new java.sql.Date(System.currentTimeMillis()).toString();
String newdate1=newdate.substring(2,10);
//out.println("Newdate1:"+newdate1);
String newtime=new java.sql.Time(System.currentTimeMillis()).toString();
//String newtime1=newtime.substring(2,4);
//out.println("Newtime1:"+newtime1);

//int tok;

     StringTokenizer st = new StringTokenizer(newdate1,"-");
    try
	{
		while (st.hasMoreTokens()) {
		  word+=st.nextToken();
		 
		// t+=st.nextToken().sval;
		       }
	}catch(Exception e)
	{out.println("tokenizer:"+e.getMessage());}
out.println("Value from tokenizer date"+word);
	
    StringTokenizer st1 = new StringTokenizer(newtime,":");
    try
	{
		while (st1.hasMoreTokens()) {
		  ti+=st1.nextToken();
		 
		// t+=st.nextToken().sval;
		       }
	}catch(Exception e)
	{out.println("tokenizer:"+e.getMessage());}
out.println("Value from tokenizer time"+ti);


String rrn = username + 
			word+
			ti.substring(0,4);

/*String rrn = username + 
			(new java.sql.Date(System.currentTimeMillis())).toString().substring(2,10)+
			(new java.sql.Time(System.currentTimeMillis())).toString();*/
out.println("Relative Record Number:"+rrn);

String sql = "INSERT INTO QuestionMaster( QuestionID, CodeID, PartyID,"+
		" Question, ExamType, NoOfOptions, Option1, Option2, Option3, Option4, "+
		"Option5, Answer, Explanation, LevelID, ExamID, ResonableTime, status, "+
		"Marks, NewAnswer, RRN ) VALUES("+ qno+",'"+subjectid+"',"+partyid+",'"+question+"',"+examtype+","+options+
		",'"+a11+"','"+a21+"','"+a31+"','"+a41+"','"+a51+"',"+ans1+",'"+exp1+"',"+ level1+","+examid+","+rtime+",'"+status+"',"+marks+","+ans1+",'"+ 
		rrn +"' )";
	
int updt = con.createStatement().executeUpdate(sql);
if(updt>0){
	out.print("Record Inserted Successfully!");
}else{
	out.print("Error in updating the record!");
}
}
catch(Exception e){out.print("Could not Insert Records! "+e.getMessage());}
String image1=request.getParameter("image1");


%><br><br><br><br><br><br><br><br>
	<%
	try{
	 rsimage=statimage.executeQuery("SELECT * FROM QuestionMaster WHERE QuestionID='" +qno+ "'");
			while(rsimage.next()){
				 quesi=rsimage.getString("Question");
				  ai=rsimage.getString("Option1");
				   bi=rsimage.getString("Option2");
				    ci=rsimage.getString("Option3");
					 di=rsimage.getString("Option4");
					  ei=rsimage.getString("Option5");
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
					             <td align="left" width="80%" class=an><%=ai%><td> 
						    </tr> 
            	
							<tr>
								 <td align="center" width="20%" class=an>(b)</td> 
					             <td align="left" width="80%" class=an ><%=bi%><td> 
				            </tr>
				            <tr> 
					             <td align="center" width="20%" class=an> (c)</td> 
							     <td align="left" width="80%"  class=an><%=ci%><td> 
				            </tr>  
          
							<tr>
							     <td align="center" width="20%" class=an> (d)</td> 
						         <td align="left" width="80%"  class=an><%=di%><td> 
							</tr> 
							<tr>
							     <td align="center" width="20%" class=an> (e)</td> 
						         <td align="left" width="80%"  class=an><%=ei%><td> 
							</tr> 
							<tr>
							     <td align="center" width="20%" class=an> Explanation:</td> 
						         <td align="left" width="80%"  class=an><%=expi%><td> 
							</tr> 
     
			          </table>
<%
								 
			}//end of while							
}catch(Exception esatament){
out.print("Exception at Image no"+esatament);
}//try for questio ID
	  
					  
					  
					  
					  %>

	<%
						  if(image1!=null){
	%>
			
						  <script language='JavaScript'>
		//alert("Please Insert Image");
		//msgWindow=window.open("/zalm/admin/imgDetQues.jsp","ImageWindow","toolbar=no,scrollbars=yes");
	
	</script>

<%
	}//end of string for loop
     stat.close();

//        if (con != null) 
//            pool.releaseConnection(con); 
//        else 
 //           out.println ("Error while Connecting to Database."); 
//        }
       
%>
<!--jsp:forward page="AddQuestion.jsp">
<jsp:param name="employee" value="2"/>
</jsp:forward-->
  <td align="left"><a href='AddQuestion.jsp'>More Questions</a></td><br><td align="center"><a href='../servlet/ExamTestDetailNumber?tablename=QuestionMaster&editmodify=modrecords&questionNumber=<%//=qno%>'>Edit/Delete</a></td>

</form>       
</body>
      


</html>

