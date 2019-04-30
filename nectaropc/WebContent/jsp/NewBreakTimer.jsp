
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<html>
	<head>
		<title>New Break Timer</title>
<%
	out.println("<script language='javascript'>");
	out.println("if(top.temp2) top.location.href='NewBreakTimer.jsp?id=" + request.getParameter("id") +"&qans=" + request.getParameter("qans")+"&questimer="+request.getParameter("questimer")+"&timeleft="+request.getParameter("timeleft")+"';");
	out.println("</script>");

%>
	</head>




		<script language="javascript">
			
			var tf=0;
			var timeup=0;
			var timeleft=0;
			var tcount=0;
			
			
			function BreakTimer(brt)
			{
	  
				  tf			= window.setTimeout("BreakTimer("+brt+");",1000);
				  tcount++;
				  //var breaktime = brt;
			      timeleft		= brt -tcount;
				  window.status = timeleft + "  Seconds remaining";
				  if(timeleft==0)
					     {
					       window.clearTimeout(tf);
					       timeup=1;
					       document.NewBreakTimer.submit();
					     } 
				
			}
		</script>

	<%@ page language="java" import="java.sql.*"%>

	<%
		
		
		
		Integer Brks		= (Integer)	session.getValue("Breaks");
		Integer BrkInterval	= (Integer)	session.getValue("BreakInterval");
		Integer SID			= (Integer) session.getValue("SectionID");	
		Integer CGID		= (Integer) session.getValue("CodeGID");

		int Breaks			= Brks.intValue();
		int BreakInterval	= BrkInterval.intValue();
		int SectionID		= SID.intValue();
		int CodeGroupID		= CGID.intValue();
		
		
		

	%>
	<body bgcolor="#fff5e7" onload="BreakTimer(<%=BreakInterval%>);">

	<form name="NewBreakTimer" action="NewMain.jsp">

	<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

	<%

		int pqidi,ansgiveni,ttakeni;
			pqidi=ansgiveni=ttakeni=0;
		
		session.setMaxInactiveInterval(3600);
		String pqid			= "";
		String ansgiven		= request.getParameter("qans");
		String ttaken		= request.getParameter("questimer");
		String stname		= (String)	session.getValue("username");
		String st			= stname+"temp";			
		String tleft		= request.getParameter("timeleft");
		int timeleft		= 0;
		Integer CID			= (Integer)	session.getValue("CandidateID");
		int CandidateID		= CID.intValue();
		int count			= 0;
		Integer BrTaken		= (Integer) session.getValue("BreaksTaken");
		int BreaksTaken		= BrTaken.intValue();
		

			if(request.getParameter("id")!=null)			pqid=request.getParameter("id");
			if((pqid.equals("undefined"))||(pqid==null))	out.print("pqid undefinned");
			if(!pqid.equals("undefined"))					pqidi=Integer.parseInt(pqid);
			if(ansgiven.equals("undefined"))				out.print("ansgiven undefinned");
			if(!ansgiven.equals("undefined"))				ansgiveni=Integer.parseInt(ansgiven);
			if(ttaken.equals("undefined"))					out.print("ttaken undefinned");
			if(!ttaken.equals("undefined"))					ttakeni=Integer.parseInt(ttaken);
												
		
		ServletContext context = getServletContext();
		    pool			   = (com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
		java.util.Hashtable qstore = new java.util.Hashtable();
		qstore =(java.util.Hashtable)getServletContext().getAttribute("QContainer");
		
		Connection con=null;
		Statement stnew=null;
		Statement stmt=null;
		con=pool.getConnection();

		if(con==null) out.println("Connection not obtained");
		if(con!=null)
				 {
					   	stnew=con.createStatement();
						ResultSet rsgetcount = stnew.executeQuery("SELECT COUNT(*) FROM "+st);
						while(rsgetcount.next())
							{
								String counter = rsgetcount.getString(1);
								System.out.print("counter : "+counter);
								count =Integer.parseInt(counter);
								//++count;//incremented to get next question 
							}//end of while
					 }//if con!=null

		//update previous answer
		//out.println("getting size:"+qstore.size());
			Integer NoOfRemainingQuestions=new Integer(count);
			session.putValue("NoOfRemainingQuestions",NoOfRemainingQuestions);
			session.putValue("teststatus","old");
			session.putValue("start","start");
			Integer p  = new Integer(qstore.size());
			Integer v  = (Integer)qstore.get(p);
			int		vi = v.intValue();
												//out.println("earlier ques:"+vi);
		
		
		
			int seq = 1;
			int updated=0;
			seq=count-1;
				
			if(seq==pqidi)	updated=0;
			else updated=1;
			stmt=con.createStatement();


			String Update_Cand_Temp="Update "+st+" SET  ansg='"+ansgiven+"',timetaken="+ttakeni+" WHERE QuestionID="+vi+" AND SectionID="+SectionID+" AND CodeGroupID="+CodeGroupID;



			if(updated==0)
					{
						try
							{
								stmt.executeUpdate(Update_Cand_Temp);
							}catch(Exception e)
									{out.println(Update_Cand_Temp+ " : " +e.getMessage());}
					}
					else if(updated==1)
							{
								try
									{
										stmt.executeUpdate("Update "+st+" SET  ansg=0,timetaken="+ttakeni+" WHERE QuestionID="+vi);
									}catch(Exception e)
										{out.println("2 candtemp update failed"+e.getMessage());}
							}
				

	

	
			if((tleft!="")||(tleft!=null)||(!tleft.equals("undefined")))
									{
										timeleft=Integer.parseInt(tleft);
										session.putValue("TimeLeft",tleft);
									}
													//out.print("Time Inserted : "+timeleft);
			try
				{
								if((tleft!="")||(tleft!=null)||(!tleft.equals("undefined")))
												{
													stmt.executeUpdate("Update ExamStatus SET TimeLeft="+timeleft+",BreaksTaken="+BreaksTaken+"  WHERE CandidateID="+CandidateID+" AND  SectionID="+SectionID+" AND  CodeGroupID="+CodeGroupID);
												}
							
				}catch(Exception e)
						{
							out.println("ExamStatus update failed "+e.getMessage());
						}

		
		out.println("Your Break Session is on.The test will resume as soon as your break time gets over ");

%>

</form>
</body>
</html>


