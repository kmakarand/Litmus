
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002
DOE          : 03 - 03 - 2002
-->


<html>
<head>
<title> Test main </title>
<link rel="stylesheet" href="../alm.css" type="text/css">

<script language="javascript" src="quiz.js"></script>

</head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript">
var localvar="";
var flag=0;
var rname="";
var qtimer;
var tmleft;
var k;
//var current=document.NewTestMain.id.value;

	function setr()
	{
		rname='r' + document.NewTestMain.id.value;
	}

	function initialize(i)
	{
		k=i;
		//parent.displayOption(k);
		parent.setTime();
	}


	function setval()
	{

		var nop = document.NewTestMain.nop.value;
		var strans="";
		for(var i=0;i<=nop-1;++i)
		{
			var p ="document.NewTestMain.r["+i+"]";
			if(eval(p).checked)  document.NewTestMain.qans.value=i+1;
			if(eval(p).checked)  document.NewTestMain2.qans.value=i+1;
			if(eval(p).checked)  document.NewTestMain3.qans.value=i+1;
			if(eval(p).checked)  document.NewTestBM.qans.value=i+1;
			if(eval(p).checked)  strans=strans+document.NewTestBM.qans.value;
			document.NewTestMain.chkans.value=strans;

		}
		
	}

	function showval()
	{

		setval();
		if(parent.isPerQuestionTimer==1) parent.temp=0;
		qtimer = parent.tcount - parent.temp;
		parent.temp = parent.tcount;
		document.NewTestMain.timeleft.value=tmleft;
		document.NewTestMain2.timeleft.value=tmleft;
		document.NewTestMain3.timeleft.value=tmleft;
		document.NewTestBM.timeleft.value=tmleft;

		document.NewTestMain.questimer.value=qtimer;
		document.NewTestBM.questimer.value=qtimer;
		document.NewTestMain2.questimer.value=qtimer;
		document.NewTestMain3.questimer.value=qtimer;


		//return localvar;
	}

	function checksubmit()
	{

		showval();
		if(confirm("Do you wish to finish the test ?") == true)
		document.NewTestMain2.submit();
		else
		return false;
	}
	function OpenCalculator(url)
	{
		window.open(url, "calc", "width=130,height=215,left=200,top=100,resizable=0");
	}

</script>



<%@ page language="java" import="java.sql.*,java.util.*,org.apache.log4j.Logger" session="true"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!--errorPage="errortest.jsp"-->
<%
    Logger log = Logger.getLogger("NewTestMain.jsp");
	String stname		= (String)	session.getValue("username");
	String teststart	= (String)	session.getValue("start");
	String teststart2	= teststart;
	int ResumeQuest		= ((Integer)session.getValue("ResumeQuest")).intValue();
	if (stname == null || stname.equals(null) || stname=="") response.sendRedirect("SessionExpiry.jsp");
	Integer BrTaken		= (Integer) session.getValue("BreaksTaken");
	int BreaksTaken		= BrTaken.intValue();

	if(teststart.equals("started"))
	{
		if(request.getParameter("check")!=null)
		{

			if(request.getParameter("check").equals("1"))
			{
				String URL="./NewBreakTimer.jsp?id="+request.getParameter("id") + "&qans=" + request.getParameter("qans")+"&questimer="+request.getParameter("questimer")+"&timeleft="+request.getParameter("timeleft");
							++BreaksTaken;

				Integer newBreaksTaken = new Integer(BreaksTaken);
				session.putValue("BreaksTaken",newBreaksTaken);

				response.sendRedirect(URL);
			}
		}
	}

	Integer option	= (Integer)session.getValue("NoOfRemainingQuestions");
	int nrq			= option.intValue();
	String  NS		= (String)session.getValue("NoOfSections");
	int NoOfSections= Integer.parseInt(NS);
	////System.out.println("NRQ                :"+nrq);
	Integer TQ		=(Integer)session.getValue("TotalQuestions");
	Integer AQ		=(Integer)session.getValue("AllQuestions");
	////System.out.println("TQ "+TQ);
	int TotalQuestions = TQ.intValue();
	int AllQuestions = AQ.intValue();
	int noOptions=0;

	out.println("<body onResize=\"return false\" onLoad=\"initialize("+noOptions+");\">");
	if(nrq==AllQuestions) session.putValue("ILQ","1");

	String BookMarkSet  = (String) session.getValue("BookMarkSet");
	String ILQ			= (String) session.getValue("ILQ");

%>
<div align="center">
<form name="NewTestMain"  action="NewTestMain.jsp" method="GET">
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="rnd" scope="page" class="com.ngs.gbl.RandomGenerator"/>
<jsp:useBean id="checker" scope="page" class="com.ngs.gbl.security"/>
<jsp:useBean id="A" scope="page" class="com.ngs.gbl.Answer"/>
<jsp:useBean id="NMC" scope="application" class="com.ngs.gen.NMCalculate"/>
<input type=hidden name=chkans value="">

<center>
<%

//----------	INITIALIZATION OF VARIABLES TO BE USED	----------//


	pool=(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
	Connection con;//,con2,con3;
			   con=null;//con2=con3=
	Statement  stmt,stmt2,stmt3,stnew,stmt4,stat,stmt5;
			   stmt=stmt2=stmt3=stnew=stmt4=stat=stmt5=null;
	
	con=pool.getConnection();
	if(con==null) out.println("Connection not obtained");


	String UserType		= (String)  session.getValue("TypeOfUser");
	String  tstatus		= (String)	session.getValue("teststatus");

	Integer isQT		= (Integer)	session.getValue("TimerType");
	Integer QRT			= (Integer)	session.getValue("QResponseTime");
	Integer Brks		= (Integer)	session.getValue("Breaks");
	Integer BrkInterval	= (Integer)	session.getValue("BreakInterval");
	Integer ET			= (Integer)	session.getValue("ExamTime");
	Integer ST			= (Integer) session.getValue("SectionTime");
	Float   Crt			= (Float)	session.getValue("Criteria");
	Float   NM			= (Float)	session.getValue("NegativeMarks");
	Integer EMode		= (Integer)	session.getValue("ExamMode");
	Integer CodeGID		= (Integer)	session.getValue("CodeGID");
	Integer EID			= (Integer)	session.getValue("ExamID");
	Integer SID			= (Integer)	session.getValue("SectionID");
	Integer CID			= (Integer)	session.getValue("CandidateID");
	Integer LID			= (Integer)	session.getValue("LevelID");
	String adaptcusts	= (String)	session.getAttribute("adaptive");
	String  stemp		= "temp_"+stname;
	Vector  QBank		= new Vector();
	java.util.Hashtable Qlevel = new java.util.Hashtable();
	Integer q = new Integer("0");
	boolean AnsFlag  = false;
	int sessionlevel = 1;
	Hashtable CurrentCodeCount = new Hashtable();
	Hashtable Qcode = new Hashtable();
	Vector  QCodeBank		= new Vector();
	String CurrentCode="";
	String oldCode="";


	int SectionID = SID.intValue();
	int CandidateID		= CID.intValue();
	int QResponseTime	= QRT.intValue();
	int Breaks			= Brks.intValue();
	int BreakInterval	= BrkInterval.intValue();
	int ExamTime		= ET.intValue();
	int SectionTime		= ST.intValue();
	int Criteria		= Crt.intValue();
	int ExamMode		= EMode.intValue();
	int ExamID			= EID.intValue();
	int LevelID			= LID.intValue();
	int adaptcust		= Integer.parseInt(adaptcusts);
	int sQuesCount		= 0;
	int totalrecords	= 100;
	int TypeOfUser		= Integer.parseInt(UserType);
	int TimerType = 0;
	int CodeGroupID		= 0;
	CodeGroupID			= CodeGID.intValue();
	int timeleft=0;	int count=1;int tques=1;
	int isQuestionTimer = 0;
	int LeftTime		= 0;
	int StoreFirstQuestion = 1;
	int TakeValue = 0;
	int BookMark=0;
	int IncludeSublevels = 0;
	boolean refresh = false;
	java.util.Hashtable qstore = new java.util.Hashtable();
    ServletContext context	   = getServletContext();
    
    TimerType=isQT.intValue();

	////System.out.println("ritmer : "+QResponseTime);
	////System.out.println("NRQ                :"+nrq);

	if((tstatus.equals("old"))&&(TimerType>1))
	{
		String tleft= (String) session.getValue("TimeLeft");
		ExamTime =Integer.parseInt(tleft);
	}

	String gbm = (String)session.getValue("GBM");

	if((tstatus.equals("old")&&(gbm!=null)&&(gbm.equals("ON"))))
	{session.putValue("GBM","OFF");}

 	//out.println("LevelID "+LevelID+"<br>");
    //out.println("ExamID"+ExamID);
    
    Statement stat11 = 	con.createStatement();
	String query1 = "select * from UserDetails";
	ResultSet rqb1  = stat11.executeQuery(query1);
	////System.out.println("CandidateID :"+CandidateID);
	while(rqb1.next())
	{
	  if(ExamID == Integer.parseInt(rqb1.getString("ExamID")))
	  {
		  LevelID = rqb1.getInt("LevelID");
		  //log.info("LevelID "+LevelID);
		  if(LevelID ==4){
		  IncludeSublevels = 1;
		  LevelID=1;}
		  else
		  IncludeSublevels = 0;
		  //log.info("IncludeSublevels "+IncludeSublevels);
	   }
	}
	
	String sql = "UPDATE NewExamDetails SET LevelID=" + LevelID + ",IncludeSublevels=" + IncludeSublevels + " WHERE ExamID=" + ExamID;
	//log.info("update query :"+sql);
	int confirm = con.createStatement().executeUpdate(sql);
	//log.info("confirm :"+confirm);
%>
		<%@ include file="GetCodesNow.jsp" %>
<%

	//	out.println("CodeID :"+AllCodes);
	////System.out.println("teststart :"+teststart);
	if(teststart.equals("start"))
	{
		 ///QB GETING ADDED
		Statement stat1 = 	con.createStatement();
		String query = "select QuestionID,LevelID  from QuestionMaster where ExamID="+ExamID+" and (CodeID LIKE '"+AllCodes+"') order by LevelID,QuestionID";
		////System.out.println(query);
		ResultSet rqb  = stat1.executeQuery(query);
		int w=0 ;

		if(adaptcust==1)
		{
			// NEW CODE FOR LEVEL IDENTIFICATION
			int clevel=0;
			int oldlevel=-1;
			int first=0;
			int flevel =0;

			while(rqb.next())
			{
				Integer q1 = new Integer(rqb.getInt("QuestionID"));
				int qid=q1.intValue();
				out.println("QuestionID"+qid);
				clevel = rqb.getInt("LevelID");
				if((clevel!=oldlevel)&&(first==1))
				{
					Vector clone1 = (Vector)QBank.clone();
					Qlevel.put(new Integer(oldlevel),clone1);
					w=0;
					////System.out.println("QBank :"+QBank.toString());
					QBank.removeAllElements();

				}

				QBank.add(w,q1);
				oldlevel=clevel;
				++w;
				if(first==0) flevel=clevel;
				first=1;
			}


		Vector clone2 = (Vector)QBank.clone();
		////System.out.println("For Level :"+clevel+ "Questions are :"+clone2.toString());
		Qlevel.put(new Integer(clevel),clone2);

		//END OF NEW CODE FOR LEVEL IDENTIFICATION

		}// end of adaptcust==1

		//QB COMPLETED

		if(tstatus.equals("old")&&(nrq!=0))
		{
			if(nrq<=AllQuestions) count=nrq;//+1
			////System.out.println("changed count : "+count);
			TakeValue =1;

		}else count=1;

		if(TimerType==1) ExamTime=QResponseTime;

		StoreFirstQuestion = count;

		if(TimerType==1) ExamTime=QResponseTime;
		else if(TimerType==2) ExamTime=SectionTime;
		else if(TimerType==3) ExamTime=ExamTime;


%>
<script language="javascript">
	parent.startQuestion=<%=count%>;
	parent.totalQuestion=<%=AllQuestions%>;
	parent.totaltime=<%=ExamTime%>;
	parent.exammode=<%=ExamMode%>;
	parent.isPerQuestionTimer=<%=TimerType%>;
	parent.NoOfSections=<%=NoOfSections%>;

//dis	for (i=0; i <=parent.totalQuestion; i++)
//abled	parent.answerArray[i]=new Array(5);

	//for(i=0;i<parent.totalQuestion;i++)
	for(j=0;j<parent.totalQuestion;j++)
	{ parent.answerArray[j]=-1;}
</script>
<%
		   String a="started";
		   session.putValue("start",a);

	}//end of if(teststart)
	else //of if(teststart.equals("start"))
	{
		if(TimerType==1)
		{
			ExamTime=QResponseTime;
%>
<script language="javascript">
	parent.totaltime=<%=ExamTime%>;
	parent.isPerQuestionTimer=<%=TimerType%>;
	parent.NoOfSections=<%=NoOfSections%>;
</script>
<%
		}//end of if(TimerType==1)

		if(con==null) out.println("Connection not obtained");
		if(con!=null)
		{
			stnew=con.createStatement();
			Statement stime =null;
			stime=con.createStatement();
			ResultSet rstime =null;
			ResultSet rsgetcount = stnew.executeQuery("SELECT COUNT(*) FROM "+stemp);
			while(rsgetcount.next())
			{


				count =rsgetcount.getInt(1);
				System.out.print("counter : "+count);
				++count;
			}//end of while

			rstime = stime.executeQuery("select TimeLeft from ExamStatus where CandidateID="+CandidateID);
			while(rstime.next()) {LeftTime = rstime.getInt("TimeLeft");}
		}//if con!=null
	}

	if(teststart.equals("start")) LeftTime = ExamTime;
	else if((request.getParameter("timeleft")!=null)&&(!request.getParameter("timeleft").equals("")))
	ExamTime=Integer.parseInt(request.getParameter("timeleft"));

	if(tstatus.equals("old")&&(nrq!=0))
	{
		//Changin nrq to nrq+1;
		if(nrq<=AllQuestions) StoreFirstQuestion=nrq;//+1;

	}else StoreFirstQuestion=1;
%>
<script language="javascript">
	parent.startQuestion=<%=StoreFirstQuestion%>;
	parent.isPerQuestionTimer=<%=TimerType%>;
	parent.totalQuestion=<%=AllQuestions%>;
	parent.totaltime=<%=ExamTime%>;
	parent.exammode=<%=ExamMode%>;
	parent.isPerQuestionTimer=<%=TimerType%>;
	parent.currentQuestion=<%=count%>;
</script>
<%
	String b = (String)session.getValue("start");
    ////System.out.println("Value of start:"+b);

//----------Updates the last answer given in database.TotalQuestions+1
//----------since count rolls over to tq+1 after last answer.
	////System.out.println("ExamMode :"+ExamMode);
	////System.out.println("TotalQuestions :"+TotalQuestions);
	////System.out.println("Count :"+count);

	boolean control = false;

	if(ExamMode==0)
	{
		////System.out.println("????????????");
		if(count==AllQuestions+1) {count = count-1;control=true;}
		if((b.equals("started"))&&(count<=AllQuestions)) //1st iff
		{
			try
			{
				//con = pool.getConnection();

				if(con==null) out.println("Connection not obtained");
				else ////////System.out.println("Connection obtained");

				if(con!=null)
				{
					////System.out.println("Before statement creation");
					stmt	= con.createStatement();
					stmt2	= con.createStatement();
					stat	= con.createStatement();
					////System.out.println("Statement created");

					if((control==false)&&((count==1)||(count==(nrq))))//+1
					{

						////System.out.println("Qbank :"+QBank.toString());
						////System.out.println("sessionlevel :"+sessionlevel);
						////System.out.println("Qlevel :"+Qlevel.toString());


						session.setAttribute("requesturi",request.getRequestURI());


						if(adaptcust==1)
						QBank 	= (Vector) Qlevel.get(new Integer(sessionlevel));
						else if(adaptcust==2)
						QBank 	= (Vector) session.getAttribute("QCodeBank");

						////System.out.println("Qbank :"+QBank.toString());

						ResultSet rstname=stmt.executeQuery("Select * from "+stemp);
						if(rstname!=null)
						{
							int i=1;
							while(rstname.next())
							{
								Integer tv = new Integer(rstname.getInt("QuestionID"));
								////System.out.println("Value of tv :"+tv);
								QBank.remove(tv);
								++i;
							}//end of while(rstname)
						}//end of if(rstname)
						else
						{
						  ////////System.out.println("rstname is null");
						}

						if(tstatus.equals("old"))
						{

							String values = "id="+request.getParameter("id")+"&qans=" + request.getParameter("qans")+"&bookmark="+request.getParameter("bookmark")+"&questimer="+request.getParameter("questimer")+"&return="+request.getParameter("return")+"&timeleft="+request.getParameter("timeleft");

							//////////System.out.println(values);
							int id1,qansi,bmarki,qtimeri,returnb,tleftb;
							id1=qansi=bmarki=qtimeri=returnb=tleftb=0;
							String st="temp_"+stname;
							String qans="0";
							String chkans="";

							if(request.getParameter("return")!=null)
							{
								if(request.getParameter("id")!=null)
								id1 = Integer.parseInt(request.getParameter("id"));

								if(request.getParameter("chkans")!=null)
								qans = request.getParameter("chkans");


								if(request.getParameter("bookmark")!=null)
								bmarki = 	Integer.parseInt(request.getParameter("bookmark"));

								if(request.getParameter("questimer")!=null)
								qtimeri = Integer.parseInt(request.getParameter("questimer"));

								if(request.getParameter("return")!=null)
								returnb = Integer.parseInt(request.getParameter("return"));

								if(request.getParameter("timeleft")!=null)
								tleftb = Integer.parseInt(request.getParameter("timeleft"));
%>
<script language="javascript">
		parent.totaltime=<%=tleftb%>;
</script>

<%

								String Update_Cand_Temp="Update "+st+" SET  ansg='"+qans+"',timetaken="+qtimeri+",BookMark="+bmarki+" WHERE SequenceNo="+id1;
//out.println(Update_Cand_Temp);
								Statement stupdate = con.createStatement();
								try
								{
									stupdate.executeUpdate(Update_Cand_Temp);

								}catch(Exception e)
								{
									out.println(Update_Cand_Temp+ " : " +e.getMessage());
								}

									try
									{
										if(isQuestionTimer==0)
										{
											stmt.executeUpdate("Update ExamStatus SET TimeLeft="+tleftb+" WHERE CandidateID="+CandidateID);
										}

									}catch(Exception e)
									{
										out.println("ExamStatus update failed "+e.getMessage());

									}

								}


						}//end of if tstatus.equals("old");

						rnd.setRows(QBank.size()-1);
						////System.out.println("QBank.size()"+QBank.size());
						tques = ((Integer)QBank.get(rnd.createVal())).intValue();


						////System.out.println("tques 11122222:"+tques);
						if(TakeValue ==1)
						{
							tques = ResumeQuest;
							Statement s = null;
							s = con.createStatement();
							ResultSet r = null;
							try
							{

								r = s.executeQuery("Select CodeID from "+stemp+" where  QuestionID="+ResumeQuest);
							}
							catch(SQLException e)
							{
								out.println("Error:" +e.getMessage());
							}

							while(r.next()) oldCode = r.getString("CodeID");

						}
						if(TakeValue==0) QBank.remove(new Integer(tques));




						//context.setAttribute("QContainer",qstore);
						if(adaptcust==1)
						{
							Qlevel.put(new Integer(sessionlevel),QBank);
							session.setAttribute("Qlevel",Qlevel);
						}
						else if(adaptcust==2)
						{

							session.setAttribute("QCodeBank",QBank);

							CurrentCodeCount = (Hashtable)session.getAttribute("CurrentCodeCount");
							int cnt = ((Integer)CurrentCodeCount.get(CurrentCode)).intValue();
							cnt--;

							if(!tstatus.equals("old"))
							CurrentCodeCount.put(CurrentCode,new Integer(cnt));

							session.setAttribute("CurrentCodeCount",CurrentCodeCount);
						}

						session.setAttribute("level",new Integer(1));



					}
					else//else of if(count==1)
            		{
						//qstore =(java.util.Hashtable)getServletContext().getAttribute("QContainer");

						Integer sl = (Integer)	session.getAttribute("level");

						if(adaptcust==1)
						{
							Qlevel = (java.util.Hashtable) session.getAttribute("Qlevel");
							QBank = (Vector) Qlevel.get(sl);
						}
						else
						{
							QBank = (Vector)session.getAttribute("QCodeBank");
							////System.out.println("QCODE BANK after switch :"+QBank.toString());
						}

						////////System.out.println("LEVEL : " +sl);
						//	+"Qbank in else:"+QBank.toString());
						int pqidi,ansgiveni,ttakeni;
						pqidi=ansgiveni=ttakeni=0;
						String pqid="";
						String ansgiven="0";
						String tsrt = (String)session.getAttribute("start");


						String ttaken=request.getParameter("questimer");
						String st="temp_"+stname;
						int seq = 1;
						int updated=0;

//						int BookMark=0;


						pqid=request.getParameter("id");




						String URI1 = (String) session.getAttribute("requesturi");
//change jspaq to jsp afterwards
						String URI2 = request.getRequestURI();

						if((request.getParameter("id")!=null)&&(request.getParameter("return")==null))
						{
							URI2=URI2+"?id="+request.getParameter("id");
						}

						if((URI1!=null)&&(URI1.equals(URI2)))
						refresh = true;
						else session.setAttribute("requesturi",URI2);


//						if((tsrt!=null)&&(tsrt.equals("started"))&&(request.getParameter("questimer")==null)&&(request.getParameter("qans")==null)&&(request.getParameter("id")==null)&&(request.getParameter("bookmark")==null))
//						{refresh=true;}


						if(refresh==false)
						{


						if((pqid!=null)&&(!pqid.equals(""))&&(!pqid.equals("undefined")))
						{pqidi=Integer.parseInt(pqid);}
						else out.print("pqid undefinned");


						if((request.getParameter("chkans")!=null)&&(!request.getParameter("chkans").equals("undefined"))&&(!request.getParameter("chkans").equals("")))
						ansgiven=request.getParameter("chkans");
						//else out.print("ans given undefinned");
						////////System.out.println("Given answer"+ansgiven);

						if((ttaken!=null)&&(!ttaken.equals("undefined")))
						{ttakeni=Integer.parseInt(ttaken);}
						else out.print("ttaken undefinned");
						seq=count-1;
						if(seq==pqidi) {updated=0;}else {updated=1;}
						if((request.getParameter("bookmark")!=null)&&(!request.getParameter("bookmark").equals("undefined")))
						{
							if(request.getParameter("bookmark").equals("1")) BookMark=1;
							session.putValue("BookMarkSet","1");
						}

						String Update_Cand_Temp="Update "+st+" SET  ansg='"+ansgiven+"',timetaken="+ttakeni+",BookMark="+BookMark+" WHERE SequenceNo="+pqidi;
						////////System.out.println(Update_Cand_Temp);
						////////System.out.println("update :"+updated);


						if(updated==0)
						{
							try
							{
								////////System.out.println("u01");
								stmt.executeUpdate(Update_Cand_Temp);
								////////System.out.println("u02");
							}catch(Exception e)
							{
								out.println(Update_Cand_Temp+ " : " +e.getMessage());
							}
						}
						else if(updated==1)
						{
							try
							{
								////////System.out.println("u11");
								stmt.executeUpdate("Update "+st+" SET  ansg='0',timetaken="+ttakeni+" WHERE QuestionID="+pqidi);
								////////System.out.println("u12");
							}catch(Exception e)
							{
								out.println("2 candtemp update failed"+e.getMessage());
							}
						}



						String tleft = request.getParameter("timeleft");
						//out.println("time left:"+tleft);


							if((tleft!=null)&&(!tleft.equals("undefined"))&&(!tleft.equals("")))
							timeleft=Integer.parseInt(tleft);

//							if((tleft!="")||(tleft!=null)||(!tleft.equals("undefined")))
//							timeleft=Integer.parseInt(tleft);




							try
							{

								if(TimerType==2)
								{
									if((tleft!=null)&&(!tleft.equals("undefined"))&&(!tleft.equals("")))
									{
										stmt.executeUpdate("Update ExamStatus SET TimeLeft="+timeleft+" WHERE CandidateID="+CandidateID+" AND CodeGroupID="+CodeGroupID);
									}

								}
								else if(TimerType==3)
								{
									if((tleft!=null)&&(!tleft.equals("undefined"))&&(!tleft.equals("")))
									{
										stmt.executeUpdate("Update ExamStatus SET TimeLeft="+timeleft+" WHERE CandidateID="+CandidateID);
									}
								}

							}catch(Exception e)
							{
								out.println("ExamStatus update failed "+e.getMessage());
							}

						//}// else of if(upddated)

///////////////////*************STARTING HERE

//==============================================  November 19/2001

							ResultSet rv = null;

							rv = stat.executeQuery("Select NewAnswer from QuestionMaster where QuestionID="+Integer.parseInt(request.getParameter("id")));

							while(rv.next())
							{
								if(rv.getString("NewAnswer").equals(request.getParameter("qans")))
								AnsFlag = true;
								else AnsFlag= false;

							}



//================================================ End Of NOVEMBER
if(adaptcust==1)
{
%>
<%//***************************************************************************%>
											<%@ include file="valueadapt.jsp"%>
<%//***************************************************************************%>
<%

}

							rnd.setRows(QBank.size()-1);
							tques = ((Integer)QBank.get(rnd.createVal())).intValue();

//===========*/
							QBank.remove(new Integer(tques));
							if(adaptcust==1)
							{
								Qlevel.put(sl,QBank);
								session.setAttribute("Qlevel",Qlevel);
							}
							else if(adaptcust==2)
							{
								session.setAttribute("QCodeBank",QBank);
								CurrentCodeCount = (Hashtable)session.getAttribute("CurrentCodeCount");
								int cnt = ((Integer)CurrentCodeCount.get(CurrentCode)).intValue();
									cnt--;

								CurrentCodeCount.put(CurrentCode,new Integer(cnt));
							session.setAttribute("CurrentCodeCount",CurrentCodeCount);
							}


						}//end of if refresh
						else
						{
//							out.println("refresh");
							if(control==false) count = count-1;
							ResultSet rrs = null;
							Statement srs = null;
							srs = con.createStatement();

							try
							{
								rrs = srs.executeQuery("select QuestionID,CodeID from "+st+" where SequenceNo="+count);
							}catch (SQLException e)
							{ out.println("Error caught"+e.getMessage());}
							while(rrs.next())
							{
								tques = rrs.getInt("QuestionID");
								oldCode = rrs.getString("CodeID");
							}
%>
	<script language="javascript">
		parent.currentQuestion=<%=count%>;
//temp disabled		for (i=0; i <=parent.totalQuestion; i++)
//parent.answerArray[i]=new Array(5);
		for (i=0; i <=parent.totalQuestion; i++)
		parent.answerArray[i]=-1;

	</script>
<%
						}
////////////////////**************BEFORE THIS


					}//end of else of if(count==1)




		ResultSet rs=null;

		////////System.out.println("AllCodes :"+AllCodes);
		//out.println("<br>tques :"+tques);
		String getQDetails ="";

		if(adaptcust==1)
		getQDetails = "Select * from QuestionMaster where QuestionID="+tques+" AND (CodeID LIKE "+AllCodes+") ";
		else if(adaptcust==2)
		getQDetails = "Select * from QuestionMaster where QuestionID="+tques+" AND (CodeID LIKE '"+AllCodes+"') ";


		if((TakeValue==1)||(refresh))
		getQDetails = "Select * from QuestionMaster where QuestionID="+tques+" AND (CodeID LIKE '"+oldCode+"') ";
//		out.println(getQDetails);


		try
		{
			rs = stmt.executeQuery(getQDetails);
		}catch (SQLException e)
		{
			out.println(" Couldn't access Question  :"+e.getMessage());
		}


		while(rs.next())
		{


			String id,ques,a1,a2,a3,a4,a5,ans,imagename,sCodeID;
			int image=0;
			id=ques=a1=a2=a3=a4=a5=ans=imagename=sCodeID="";
			id = rs.getString("QuestionID");
			ques   = checker.setString(rs.getString("Question"));


			a1		= rs.getString("Option1");
			a2      = rs.getString("Option2");
			a3      = rs.getString("Option3");
			a4      = rs.getString("Option4");
			a5      = rs.getString("Option5");
			ans     = rs.getString("NewAnswer");

/*
			a1	    = checker.setString(rs.getString("Option1"));
			a2      = checker.setString(rs.getString("Option2"));
			a3      = checker.setString(rs.getString("Option3"));
			a4      = checker.setString(rs.getString("Option4"));
			a5      = checker.setString(rs.getString("Option5"));
			ans     = checker.setString(rs.getString("NewAnswer"));
*/



			sCodeID = rs.getString("CodeID");

			//String level = rs.getString("Level");

			int idv,ani;
			idv=ani=0;
			if(id!=null)   idv = Integer.parseInt(id);
			if(ans!=null)  ani = Integer.parseInt(ans);
			image =rs.getInt("Image");

			if(image!=0)
			{
				ResultSet rsimg=null;
				try
				{
					rsimg = stmt.executeQuery("Select * from ImageDetails WHERE QuestionID="+idv);
				}catch (SQLException e)
				{
					out.println("Image details resultset not obtained"+e.getMessage());
				}

				if(rsimg!=null)
				{
					////////System.out.println("In Images");
					while(rsimg.next())
					{
						imagename=rsimg.getString("Image");
					}
				}//if(rsimg)

			}//if(image)

			try
			{
				if((id!=null)&&(ans!=null)&&(request.getParameter("check")==null))
				{
					if((TakeValue==0)&&(refresh==false))
					 {
					stmt.executeUpdate("INSERT INTO "+stemp+" (SequenceNo,QuestionID,ansg,correct_ans,timetaken,CodeGroupID,CodeID,BookMark) VALUES ("+count+","+idv+",0,'"+ans+"',0,"+CodeGroupID+",\'"+sCodeID+"\',0)");
					 }
				}

			}catch(Exception e)
			{
				out.println(" Inserting questions error"+e.getMessage());
			}


			if(id==null)   id="QuestionID not Entered in DB";
			if(ques==null) ques="Question not Entered in DB";
			if(a1==null)   a1="Option not Entered in DB";
			if(a2==null)   a2="Option not Entered in DB";
			if(a3==null)   a3="Option not Entered in DB";
			if(a4==null)   a4="Option not Entered in DB";
			if(a5==null)   a5="Option not Entered in DB";
			if(ans==null)  ans="Answer not Entered in DB";

			//out.println("Store Answer"+A.getStoredAnswer(stemp,con,count));

			int nop=2;
%>



	<table border="0" cellspacing="1" cellpadding="1" width="80%">
	<tr>
		<th width="15%" align="right"><b>Question No.</b></th>
		<th align="left">
			<table border=0 cellspacing=0 cellpadding=0 width='100%'>
			<tr>
				<th align="left"><%=count%></th>
				<th>
				<div>
				</th>
			</tr>
			</table>
		</th>
	</tr>
	<tr>
		<th colspan=2 align="left">
		<table  border="0" cellspacing="0" cellpadding="1" width="100%">
		<tr><th><b>Marks for Question:<%=NMC.getMarks(tques,con)%></th><th></th></tr>
		</table>
		</th>
	</tr>
	<tr>
		<td valign="top" align="right"><b>Question : </b> </td>
		<td><%=ques%></td>
	</tr>
	<tr>
		<td align="center">(A)</td>
		<td><input type=checkbox name="r"  value=1  <%if(Integer.parseInt(A.getStoredAnswer(stemp,con,count))==1) out.println("checked");%> onclick="return setval()"><%=a1%></td>
	</tr>
	<tr>
		<td align="center">(B)</td>
		<td><input type=checkbox name="r"  value=2 <%if(Integer.parseInt(A.getStoredAnswer(stemp,con,count))==2) out.println("checked");%> onclick="return setval()"><%=a2%></td>
	</tr>
<%
	if((a3!=null)&&(!a3.equals(""))&&(!a3.equals("NoOption"))&&(!a3.equals("no options")))
	{	++nop;
%>	<tr>
		<td align="center">(C)</td>
		<td><input type=checkbox name="r"  value=3 <%if(Integer.parseInt(A.getStoredAnswer(stemp,con,count))==3) out.println("checked");%> onclick="return setval()"><%=a3%></td>
	</tr>
<%
	}
	if((a4!=null)&&(!a4.equals(""))&&(!a4.equals("NoOption"))&&(!a4.equals("no options")))
	{	++nop;
%>
	<tr>
		<td align="center">(D)</td>
		<td><input type=checkbox name="r"  value=4  <%if(Integer.parseInt(A.getStoredAnswer(stemp,con,count))==4) out.println("checked");%> onclick="return setval()"><%=a4%></td>
	</tr>
<%
	}
	if((a5!=null)&&(!a5.equals(""))&&(!a5.equals("NoOption"))&&(!a5.equals("no options")))
	{	++nop;
%>
	<tr>
		<td align="center">(E)</td>
		<td><input type=checkbox name="r"  value=5 <%if(Integer.parseInt(A.getStoredAnswer(stemp,con,count))==5) out.println("checked");%> onclick="return setval()"><%=a5%></td>
	</tr>
  <%
	}
%>

	<tr align="center">
		<td colspan="2">
		<input type="checkbox" name="bookmark" value="1">
		Bookmark
		</td>
	</tr>
 <%

	out.println("<input type=hidden name=nop value="+nop+">");
	if(image!=0)
		{

%>
			<div align=center>
			<img src="../simages/<%=imagename%>"  BORDER=0 ALT="">
			</div>
<%		}
		if(count<AllQuestions)
		{
 %>
	<tr>
		<th colspan=2><div class='clsNavigation'>
		<input type="submit" value="Next Question" border=0 onClick="return showval()">
		</div>
		</th>
	</tr>
	</table>


<%
			if(BreaksTaken<Breaks)
			{
%>
				<table width=600>
				<td align="left">
				<input name=check type=checkbox value=1>
				<font face="arial,helvetica" size="3" color=red>
				Click here if you wish to take a break after this question
			 	</font>
				</td>
				</tr>
				</table>


	<%
			}//end of if(BreaksTaken<Breaks)

//***********************************************************************//

			Statement s10 = con.createStatement();
			ResultSet r10 = s10.executeQuery("Select count(*) from "+stemp+" where CodeGroupID="+CodeGroupID);

			while(r10.next()) sQuesCount = r10.getInt(1);



//out.println("Count  :"+sQuesCount+" TotalQuestions :"+TotalQuestions);

		if(sQuesCount==TotalQuestions)
			{

%>
			<%@ include file="ChangeSection.jsp" %>

<%
			}

//*************************************************************************//
		} //end of if(count<=TotalQuestions)
		else
		{
//			out.print("<br><br>");
//			out.println("Questions Over!!Click on \"Finish Test\" ==> ");
		}
			out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
			stmt.close();

		  }/*end of if(rs!=null) */


	   }//end of if(con!=null)
	 }//end of try
	 catch (SQLException sqle)
		 {
		   //out.println(sqle.getMessage());
		 }

      catch (Exception e)
		 {
		   //out.println("Exception caught :" +e.getMessage());
		 }
		 finally
			 {
					if(con!=null) {pool.releaseConnection(con);}

				}
    }//end of 1st if


  }//emd of exam mode check
else if((b.equals("started"))&&(ExamMode==1))
	{

		con=pool.getConnection();

		stmt=con.createStatement();

	   if(con==null) out.println("Connection not obtained");
	   //else out.println("Connection obtained");
	   if(con!=null)
		 {
			ResultSet rseq =null;
			//String testpaper2="IITQuestionMaster";
			try
			  {
				rseq = stmt.executeQuery("Select * from QuestionMaster WHERE CodeID LIKE "+AllCodes);
			  }catch (SQLException e)
			  {
				 out.println("Error getting records from DB :" + e.getMessage());
		 	  }

			//out.println("Total Questions :"+TotalQuestions);
			////////System.out.println("ENNNNNNNNTERRRRRRRRRRRRRRRRRRRRRRRRR");
			//////////System.out.println("Code ="+sCode);
			while(rseq.next())
			 {
				  String id,ques,a1,a2,a3,a4,a5,ans,imagename,sCodeID;
				  int image=0;
				  id=ques=a1=a2=a3=a4=a5=ans=imagename=sCodeID="";
				  id     = rseq.getString("QuestionID");
				  //out.println("id"+id);
			      ques   = checker.setString(rseq.getString("Question"));
				  //out.println(ques);
					  a1	= checker.setString(rseq.getString("Option1"));
					  a2	= checker.setString(rseq.getString("Option2"));
					  a3	= checker.setString(rseq.getString("Option3"));
					  a4	= checker.setString(rseq.getString("Option4"));
					  a5	= checker.setString(rseq.getString("Option5"));
					 ans	= checker.setString(rseq.getString("NewAnswer"));
				  sCodeID	= rseq.getString("CodeID");
			      int idv     = Integer.parseInt(id);
				  int ani     = Integer.parseInt(ans);
				  image =rseq.getInt("Image");



				  //----------Inserting records in the temporary table of the candidate

				    try
						  {
							out.println("                   "+ans);
							stmt.executeUpdate("INSERT INTO "+stemp+" VALUES ("+count+","+idv+",0,'"+ans+"',0,"+CodeGroupID+",\'"+sCodeID+"\')");

						  }catch(Exception e)
								{
								  out.println(" Inserting questions error"+e.getMessage());
								}


				  if(image!=0)
					 {
						 ResultSet rsimg=null;
						 try
							{
							 rsimg = stmt.executeQuery("Select * from ImageDetails WHERE QuestionID="+idv);
							}catch (SQLException e)
							{
							 out.println("Image details resultset not obtained"+e.getMessage());
							}
							if(rsimg!=null)
								{
									////////System.out.println("In Images");
									while(rsimg.next())
									{
										imagename=rsimg.getString("Image");
									 }
								}//if(rsimg)

					 }//if(image)

					 out.println("Getting from DB :");

%>

						<table border="0" cellspacing="1" cellpadding="1" width="80%">
				        <tr>
				          <th width="15%" align="right"><b>Question No : </b></th>
						  <th align="left"><%=count%></th>
						</tr>

						<tr>
								<td valign="top" align="right"><b>Question : </b> </td>
								 <td><%=ques%></td>
						</tr>
						<tr>
							<td align="center">
							<input type=checkbox name="r"  value=1>
							</td>
					        <td><%=a1%></td>
					    </tr>
				        <tr>
							<td align="center"><input type=checkbox name="r"  value=2>
							</td>
					        <td><%=a2%></td>
					    </tr>
				       <tr>
							<td align="center"><input type=checkbox name="r"  value=3></td>
					        <td><%=a3%></td>
					    </tr>
				       <tr>
							<td align="center"><input type=checkbox name="r"  value=4></td>
					        <td><%=a4%></td>
					    </tr>
<%
							if(!((a5.equals("NoOption"))||(a5.equals("no options"))))
							{
%>
								<tr>
									<td align="center"><input type=checkbox name="r"  value=5></td>
									<td><%=a5%></td>
								</tr>
  <%
					 		}
%>
<!--

-->						</table>
 <%
		 if(image!=0)
				  {

%>
					<div align=center>
					<img src="../simages/<%=imagename%>"  BORDER=0 ALT="">
				    </div>
<%				  }
				count++;
				out.print("count"+count);
				if(count==(AllQuestions+1)) break;
			 }	//end of while(rseq.next())
			 out.println("<input type=hidden name=id value=1>");
  			 out.println("<input type=hidden name=qans value=1>");
			 out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
		 }//if (con!=null)

	}

   %>

  </form>
<%


	session.putValue("GBM","OFF");




	out.println("<form name=\"NewTestBM\" action=NewTestMainbm.jsp method=get>");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
	out.println("<p>&nbsp;</p><table border=0 cellspacing=1 cellpadding=1 width=\"80%\"></tr>");
	if((ExamMode==0)&&((BookMark==1)||((BookMarkSet!=null)&&(BookMarkSet.equals("1")))))
	{
		//out.println("<div align=\"left\">");
		out.println("<th align=left><div class='clsRecheck'>");
		out.println("<input type=submit value=\"Bookmarked Questions\" onClick=\"return  showval()\" ></div></th>");
		//session.putValue("teststatus","started");
	}
	else out.println("");
	out.println("</form>");

	out.println("<form name=\"NewTestMain3\" action=NewTestMainall.jsp method=get>");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");

	if(count>1)
	{

		out.println("<th colspan=2 align=right><div class='clsRecheck'><input type=submit value=\"Recheck Previous Answers\" onClick=\"return  showval()\" ></th></tr>");
	}
	else out.println("<td colspan=2></td></tr>");

		out.println("</form>");

	if(count<=AllQuestions)
	{
		out.println("<form name=\"NewTestMain2\" action=NewVerifyAnswers.jsp method=get>");
		out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
		out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
		out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
		out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
		out.println("<tr><th colspan=3 align=center><div class='clsNavigation'><input type=button value=\"Finish Test\" onClick=\"return  checksubmit()\" ></div></th></tr></table>");
		out.println("</form>");
	}



%>
</tr>
</table>
  </center>
  </body>
  </html>
