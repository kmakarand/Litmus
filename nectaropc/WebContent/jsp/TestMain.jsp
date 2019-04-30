
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

	<style>
		td.qu{font-family:arial;font-size:10pt;background-color:#facfae;color:#960317;font-weight:bold;}
		td.an{font-family:arial;font-size:10pt;background-color:#facfae;color:#000000;}
		INPUT
			{
				FONT-SIZE: 10px;
				FONT-FAMILY: Verdana;
				BACKGROUND-COLOR: #aaccdd
			}

	</style>
	<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
</head>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript">
var localvar="";
var flag=0;
var rname="";
var qtimer;
var tmleft;
var k;
//var current=document.TestMain.id.value;

   function setr()
   {
	  // alert(document.TestMain.id.value);
      rname='r' + document.TestMain.id.value;
   }

	function initialize(i)
	{
		//parent.totalQuestion=20;
		k=i;

		//MM_preloadImages( '../simages/subanswer1.gif', '../simages/subanswer2.gif' );
		parent.displayOption(k);
		parent.setTime();
	}


	function setval()
	{
	    document.TestMain.qans.value=localvar;
		document.TestBM.qans.value=localvar;
		//alert(document.TestMain.qans.value);
		//document.TestMain.questimer.value=qtimer;
		 if(localvar=="") document.TestMain.qans.value="0";
	   //document.testmain5.submit();
	}
	function showval()
	{
		//alert(parent.tcount);
		//alert(parent.temp);
		if(parent.isPerQuestionTimer==1) parent.temp=0;
		qtimer = parent.tcount - parent.temp;
		parent.temp = parent.tcount;
		//alert(qtimer);
		document.TestMain.timeleft.value=tmleft;
		document.TestBM.timeleft.value=tmleft;
		//if(k!=1) document.TestMain.timeleft.value=parent.totaltime-parent.timeleft;
		//alert(document.TestMain.timeleft.value);
		document.TestMain.questimer.value=qtimer;
		document.TestBM.questimer.value=qtimer;

		//alert("BM time:"+document.TestBM.questimer.value);
		if(localvar=="")	parent.answerArray[document.TestMain.id.value]=-1;
		if(localvar=="")	parent.answerArray[document.TestBM.id.value]=-1;
		//alert(document.TestMain.id.value);
		//alert(parent.answerArray[document.TestMain.id.value]);
		//alert("totaltime"+parent.totaltime);
		//alert("timeleft"+parent.timeleft);
		//alert("Time : "+parent.Time);
		return localvar;
	}


	function cancelRefresh()
		{
		  // keycode for F5 function
		  if (window.event && window.event.keyCode == 116) {
		    window.event.keyCode = 8;
			  }
			  // keycode for backspace
		 if (window.event && window.event.keyCode == 8)
			 {
				// try to cancel the backspace
				window.event.cancelBubble = true;
				window.event.returnValue = false;
				return false;

		    }

	}

</script>



<%@ page language="java" import="java.sql.*,java.util.*" session="true"  %>
<!--errorPage="errortest.jsp"-->
<%
	String stname		= (String)	session.getValue("username");
	String teststart	= (String)	session.getValue("start");

    int ResumeQuest		= ((Integer)session.getValue("ResumeQuest")).intValue();

	if (stname == null || stname.equals(null) || stname=="")
	response.sendRedirect("SessionExpiry.jsp");

	Integer BrTaken		= (Integer) session.getValue("BreaksTaken");
	int BreaksTaken		= BrTaken.intValue();

	if(teststart.equals("started"))
		{
			if(request.getParameter("check")!=null)
			{

					if(request.getParameter("check").equals("1"))
						{
							String URL="./BreakTimer.jsp?id="+request.getParameter("id") + "&qans=" + request.getParameter("qans")+"&questimer="+request.getParameter("questimer")+"&timeleft="+request.getParameter("timeleft");
							++BreaksTaken;
							Integer newBreaksTaken = new Integer(BreaksTaken);
							session.putValue("BreaksTaken",newBreaksTaken);
							response.sendRedirect(URL);
				}
			}
		}

	Integer option =(Integer)session.getValue("NoOfRemainingQuestions");
	int nrq = option.intValue();
	//System.out.println("NRQ                :"+nrq);
	Integer TQ=(Integer)session.getValue("TotalQuestions");
	//System.out.println("TQ "+TQ);
	int TotalQuestions = TQ.intValue();
	int noOptions=0;

	out.println("<body bgcolor=\"#fff5e7\"  onResize=\"return false\" onLoad=\"initialize("+noOptions+");\">");
	if(nrq==TotalQuestions) session.putValue("ILQ","1");


	String BookMarkSet  = (String) session.getValue("BookMarkSet");
	String ILQ			= (String) session.getValue("ILQ");


	//if((ILQ!=null)&&(ILQ.equals("1"))&&(BookMarkSet.equals("1")))
	//	out.println("<form name=\"TestMain\" action=\"mainbm.jsp\" method=\"GET\">");
	//out.println("<form name=\"TestMain\" action=\"TestMain.jsp\" method=\"GET\">");
%>

	<form name="TestMain"  action="TestMain.jsp" method="GET">

	<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>
	<jsp:useBean id="rnd" scope="page" class="com.ngs.gbl.RandomGenerator"/>
	<jsp:useBean id="checker" scope="page" class="com.ngs.gbl.security"/>

	<script language="javascript"> cancelRefresh();</script>
	<center>
	<%
	  if(nrq<=TotalQuestions)  //CHANGED AUGUS 7
		{
    %>
	<table  width="480">
		<tr>
			<td align="left" ><b>Q#</b></td>
			<td ><b>Question</b></td>
		</tr>
	</table>
	<%
		}
	%>

	<br>

<%

//----------	INITIALIZATION OF VARIABLES TO BE USED	----------//


	String UserType		= (String)  session.getValue("TypeOfUser");
	String  tstatus		= (String)	session.getValue("teststatus");
	Integer isQT		= (Integer)	session.getValue("isQuestionTimer");
	Integer QRT			= (Integer)	session.getValue("QResponseTime");
	Integer Brks		= (Integer)	session.getValue("Breaks");
	Integer BrkInterval	= (Integer)	session.getValue("BreakInterval");
	Integer ET			= (Integer)	session.getValue("ExamTime");
	Float   Crt			= (Float)	session.getValue("Criteria");
	Float   NM			= (Float)	session.getValue("NegativeMarks");
	Integer EMode		= (Integer)	session.getValue("ExamMode");
	Integer CodeGID		= (Integer)	session.getValue("CodeGID");
	Integer EID			= (Integer)	session.getValue("ExamID");
	Integer CID			= (Integer)	session.getValue("CandidateID");
	String  stemp		= stname+"temp";
	boolean AnsFlag = false;



/*
	//System.out.println(teststart);
	//System.out.println(stname);
	//System.out.println(tstatus);
	//System.out.println("Remaining Questions"+option);
	//System.out.println("isQT"+isQT);
	//System.out.println(QRT);
	//System.out.println(Brks);
	//System.out.println(BrkInterval);
	//System.out.println(ET);
	//System.out.println(Crt);
	//System.out.println("NegativeMarks :"+NM);
	//System.out.println(EMode);
	//System.out.println(CodeGID);
	//System.out.println(EID);
	//System.out.println(CID);
*/

	int CandidateID		= CID.intValue();
	int QResponseTime	= QRT.intValue();
	int Breaks			= Brks.intValue();
	int BreakInterval	= BrkInterval.intValue();
	int ExamTime		= ET.intValue();
	int Criteria		= Crt.intValue();
	int ExamMode		= EMode.intValue();
	int ExamID			= EID.intValue();
	int totalrecords	= 100;
	int TypeOfUser		= Integer.parseInt(UserType);
	int isQuestionTimer = 0;
	int CodeGroupID		= 0;
	int LeftTime		= 0;
	int StoreFirstQuestion = 1;
	int TakeValue = 0;
	//out.println("ResumeQuest : " +ResumeQuest);
	CodeGroupID			= CodeGID.intValue();
	int timeleft=0;	int count=1;int tques=1;
	int BookMark=0;

//***************************************************

	//Vector tempa = new Vector();
	//Vector tempb = new Vector();

//***************************************************
	java.util.Hashtable qstore = new java.util.Hashtable();

    ServletContext context	   = getServletContext();
	pool					   =(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");

	Connection con,con2,con3;
			   con=con2=con3=null;
	Statement  stmt,stmt2,stmt3,stnew,stmt4,stat,stmt5;
			   stmt=stmt2=stmt3=stnew=stmt4=stat=stmt5=null;
	isQuestionTimer=isQT.intValue();

	//System.out.println("ritmer : "+QResponseTime);
	//System.out.println("NRQ                :"+nrq);



		if((tstatus.equals("old"))&&(isQuestionTimer==0))
			{
				String tleft= (String) session.getValue("TimeLeft");
				ExamTime =Integer.parseInt(tleft);
				//out.println("tlesft :"+tleft);
			}

	String gbm = (String)session.getValue("GBM");
	if((tstatus.equals("old")&&(gbm!=null)&&(gbm.equals("ON"))))
	{session.putValue("GBM","OFF");}

		////System.out.println("checkkkkkkkkk");
		con3=pool.getConnection();
		if(con3==null) out.println("Connection not obtained");
		////System.out.println("Before INCLUDED FILE");
%>
		<%@ include file="GetCodes.jsp" %>
<%

		////System.out.println("AFTER INCLUDED FILE");
		if(con3!=null)
			{
				stmt5=con3.createStatement();
				ResultSet rstotalrecords = stmt5.executeQuery("SELECT COUNT(*) FROM QuestionMaster");

				while(rstotalrecords.next())
					{
						String totalrec = rstotalrecords.getString(1);
						totalrecords=Integer.parseInt(totalrec);
					}//end of while
			}

	rnd.setRows(totalrecords);

    if(teststart.equals("start"))
		{
	       if(tstatus.equals("old")&&(nrq!=0))
				{
				   //System.out.println("Count getting changed");
				   //if(nrq<TotalQuestions) count=nrq+1;
				   //else count=nrq;

//Changing count = nrq to count= nrq+1; on 21 dec 2001

				   if(nrq<=TotalQuestions) count=nrq+1;
				   //System.out.println("changed count : "+count);
				   TakeValue =1;
				   //out.println("Getting count :"+count+" in this loop ");
				}else count=1;

			if(isQuestionTimer==1) ExamTime=QResponseTime;
			StoreFirstQuestion = count;

%>
			<script language="javascript">
					parent.startQuestion=<%=count%>;
					parent.totalQuestion=<%=TotalQuestions%>;
					parent.totaltime=<%=ExamTime%>;
					parent.exammode=<%=ExamMode%>;
					parent.isPerQuestionTimer=<%=isQuestionTimer%>;
					for(i=0;i<=parent.totalQuestion;i++)	{ parent.answerArray[i]=-1;}
			</script>
<%
		   String a="started";
		   session.putValue("start",a);

		 }//end of if(teststart)
	     else //of if(teststart.equals("start"))
			 {
				if(isQuestionTimer==1)
					{
						ExamTime=QResponseTime;
%>
						<script language="javascript">

							parent.totaltime=<%=ExamTime%>;
							parent.isPerQuestionTimer=<%=isQuestionTimer%>;

						</script>
<%
					}//end of if(isQuestionTimer==1)
			   con2 = pool.getConnection();
		       if(con2==null) out.println("Connection not obtained");
			   if(con2!=null)
					 {
					   	stnew=con2.createStatement();
						Statement stime =null;
						stime=con2.createStatement();
						ResultSet rstime =null;
						ResultSet rsgetcount = stnew.executeQuery("SELECT COUNT(*) FROM "+stemp);
						while(rsgetcount.next())
							{
								String counter = rsgetcount.getString(1);
								System.out.print("counter : "+counter);
								count =Integer.parseInt(counter);
								++count;//incremented to get next question
							}//end of while


						rstime = stime.executeQuery("select TimeLeft from ExamStatus where CandidateID="+CandidateID);
						while(rstime.next()) {LeftTime = rstime.getInt("TimeLeft");}
						//System.out.println("Left time 1: "+LeftTime);
					 }//if con2!=null
					 //System.out.println("Left time 2: "+LeftTime);

		       }

			   if(teststart.equals("start")) LeftTime = ExamTime;

			   if(tstatus.equals("old")&&(nrq!=0))
				{
//Changin nrq to nrq+1;
				   if(nrq<=TotalQuestions) StoreFirstQuestion=nrq+1;

				}else StoreFirstQuestion=1;


			   //out.println("StoreFirstQuestion :"+StoreFirstQuestion);
			   //out.println("count :" +count);
%>
<script language="javascript">
	parent.startQuestion=<%=StoreFirstQuestion%>;
	parent.isPerQuestionTimer=<%=isQuestionTimer%>;
	parent.totalQuestion=<%=TotalQuestions%>;
	parent.totaltime=<%=ExamTime%>;
	//alert(parent.totaltime);
	parent.exammode=<%=ExamMode%>;
	parent.isPerQuestionTimer=<%=isQuestionTimer%>;

	parent.currentQuestion=<%=count%>;
	for(i=parent.currentQuestion+1;i<=parent.totalQuestion;i++)	{ parent.answerArray[i]=-1;}
</script>
<%
	String b = (String)session.getValue("start");
    //System.out.println("Value of start:"+b);

//----------Updates the last answer given in database.TotalQuestions+1
//----------since count rolls over to tq+1 after last answer.

/*
	String tempcode="";
	String Subject,Chapter,Topic,Subtopic;
	Subject=Chapter=Topic=Subtopic="";
	int m1=0;int n=sCode.length()-1;
	//System.out.println("Value of n :"+ n);

		while(n>=0)
			{
				int check=0;
				for(int i=n;i>=n-1;--i)
					{
						if(sCode.charAt(i)=='0') check++;
					}
				if(check!=2) tempcode=sCode.substring(n-1,n+1)+tempcode;
				//out.println("Sub string : "+sCode.substring(n-1,n+1));
				//out.println("tpCode : "+tempcode);
				n=n-2;
			}

	System.out.print("tempcode : "+tempcode);

	*/
	//System.out.println("ExamMode :"+ExamMode);
	//System.out.println("TotalQuestions :"+TotalQuestions);
	//System.out.println("Count :"+count);



	  if(ExamMode==0)
			{
			 //System.out.println("????????????");
			 if((b.equals("started"))&&(count<=TotalQuestions)) //1st iff
			     {
			        try
						 {
							 con = pool.getConnection();
				             if(con==null) out.println("Connection not obtained");

							 else //System.out.println("Connection obtained");

					 		 if(con!=null)
					            {
									//Creating the statement object for executing querry
									 //System.out.println("Before statement creation");
									 stmt	= con.createStatement();
									 stmt2	= con.createStatement();
									 stat	= con.createStatement();
									 //System.out.println("Statement created");
                    /*
									 ResultSet rstat=null;
									 rstat=stat.executeQuery("SELECT Code,TestName From ExamDetails WHERE ExamID="+ExamID);
									 int n2=tempcode.length();
									 String sb,cp,tp,stp;
									 sb=cp=tp=stp="";
									 sb=tempcode.substring(0,2)+"000000";
									 if(tempcode.length()>=4) cp=tempcode.substring(0,4)+"0000";
									 if(tempcode.length()>=6) tp=tempcode.substring(0,6)+"00";
									 if(tempcode.length()==8) stp=tempcode.substring(0,8);


									 while(rstat.next())
										 {
											String cd = rstat.getString("Code");
											String tname = rstat.getString("TestName");
											if(sb.equals(cd)) Subject=tname;
											if(cp.equals(cd)) Chapter=tname;
											if(tp.equals(cd)) Topic=tname;
											if(stp.equals(cd)) Subtopic =tname;
										 }

									 String paper=""; paper ="Paper:"+Subject;
									 if(tempcode.length()>=4) paper=paper+"--&gt;"+Chapter;
									 if(tempcode.length()>=6) paper=paper+"--&gt;"+Topic;
									 if(tempcode.length()==8) paper=paper+"--&gt;"+Subtopic;
					 				 out.println("<b><i>"+paper+"</i></b>");
									 out.println("<input type=hidden name=\"paper\" value=\""+paper+"\">");

						 */

									//System.out.println("int1");
									//System.out.println("COUNT :"+count+"NRQ="+nrq);


									 if((count==1)||(count==(nrq+1)))
									      {


											//out.println("Count : " +count);
											//out.println("Before bean used");
											//out.println("Coming in");

											//----------CHECKING THE CAND TABLE FOR QUESTIONS ASKED
/*
												ResultSet rstname=stmt.executeQuery("Select * from ExamTestingDetails WHERE CandidateID="+CandidateID+" AND (CodeID LIKE "+AllCodes+")");
*/
											//out.println("after etd");

											ResultSet rstname=stmt.executeQuery("Select * from "+stemp);

											 if(rstname!=null)
													{
														 int i=1;
														 while(rstname.next())
															  {
																 int tQuestionID=Integer.parseInt(rstname.getString("QuestionID"));
																 Integer tv = new Integer(tQuestionID);
																 Integer tk= new Integer(i);
																 qstore.put(tk,tv);
																 ++i;
															  }//end of while(rstname)
													}//end of if(rstname)




											if(tstatus.equals("old"))
												 {


/*

													//CHECKING THE CANDTEMP TABLE FOR QUESTIONS ASKED
													ResultSet rstnametemp=stmt.executeQuery("Select * from "+stemp);//+" WHERE Code=\'"+sCode+"\'");
													//

													 if(rstnametemp!=null)
															{
																 int i=qstore.size();
																 while(rstnametemp.next())
																	  {
																		 int tQuestionID=Integer.parseInt(rstnametemp.getString("QuestionID"));
																		 ++i;
																		 Integer tv = new Integer(tQuestionID);
																		 Integer tk= new Integer(i);
																		 qstore.put(tk,tv);

																	  }//end of while(rstname)


																	//CHANGE THE COUNT VARIABLE
																	//if(i!=0) count=i;

															}//end of if(rstnametemp)
*/
														}//end of if tstatus.equals("old");




											tques = rnd.createVal();
											while(tques==0) tques=rnd.createVal();
											int gate=0;
											//addddddddedddddddddddddddddddddddddddddd
											//out.println("Generated1:"+tques);
											boolean quesfound=true;

											//----------To check if generated question is present in Question master as per code and...
											ResultSet rqexist = null;
											//int qexist=0;
											//out.print("Getting Questions");
											//System.out.println("qstore : " +qstore.size());
											//System.out.println("count : " +count);

											//changes here
											if((count==1)&&(qstore.size()==0)) gate=1;
											//System.out.println("gate : " +gate);
											while((quesfound==true)&&((qstore.size()>0)||(gate==1)))
												 {
													//System.out.println("Entering search 1 ");
													////System.out.println("Subject	 IDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD" +SubjectID);
													for(int j=1;j<=qstore.size();++j)
														 {
															while((tques==0))//&&(count!=20)
															{tques=rnd.createVal();}
															//out.println("generated nonzero no	 :"+tques);

															//out.print("In loop1:"+j);
															Integer k= new Integer(j);
															Integer tq1 = (Integer)qstore.get(k);
															//int tq1i=tq1.intValue();
															if (tques==tq1.intValue())  quesfound=true;
															else quesfound=false;
															if(quesfound) break;
														 }
														////System.out.println("Tqueeeeeeeeeeeeeeeeeeeeesssssssss"+tques);

														//if(quesfound==false)
														//{
														Statement st1 = con.createStatement();
														rqexist=st1.executeQuery("Select Count(*)  from  QuestionMaster WHERE  (CodeID LIKE "+AllCodes+")  AND QuestionID="+tques+" AND ExamID="+ExamID);
				///ADDED Exam ID +" AND ExamID=5"
														while(rqexist.next())
															{
																String recs=rqexist.getString(1);
																int recsi =Integer.parseInt(recs);
																//out.println("recs : "+recsi);
																if(recsi==0) quesfound=true;
																if(recsi!=0) quesfound=false;
																if(recsi!=0) break;
															}
														//}

														 if(quesfound==true) tques=rnd.createVal();

												 }//end of while(quesfound)

												//out.println("Search over 2");

											//------------Changed here 7thapril

											//	if(count==1) tques=323;
											  if(TakeValue ==1) tques = ResumeQuest;
											  Integer key2 = new Integer(qstore.size()+1);
											  Integer value2= new Integer(tques);
											  if(TakeValue==0) qstore.put(key2,value2);


											//addddddddedddddddddeddddeeddddddd



											 //out.println("pinjo");
											 //out.println(tques);
											 //Integer key =new Integer(1);
											 //Integer value=new Integer(tques);
											 //qstore.put(key,value);
				  							 context.setAttribute("QContainer",qstore);

//*********************************************************************************
//*********************************************************************************


	String values = "id="+request.getParameter("id")+"&qans=" + request.getParameter("qans")+"&bookmark="+request.getParameter("bookmark")+"&questimer="+request.getParameter("questimer")+"&return="+request.getParameter("return")+"&timeleft="+request.getParameter("timeleft");


								////System.out.println(values);
								int id1,qansi,bmarki,qtimeri,returnb,tleftb;
								id1=qansi=bmarki=qtimeri=returnb=tleftb=0;
								String st=stname+"temp";

								if(request.getParameter("return")!=null)
								{


									if(request.getParameter("id")!=null)
									id1 = Integer.parseInt(request.getParameter("id"));

									if(request.getParameter("qans")!=null)
									qansi = Integer.parseInt(request.getParameter("qans"));


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

									String Update_Cand_Temp="Update "+st+" SET  ansg="+qansi+",timetaken="+qtimeri+",BookMark="+bmarki+" WHERE SequenceNo="+id1;


									Statement stupdate = con.createStatement();


									try
									{
									  stupdate.executeUpdate(Update_Cand_Temp);

									}catch(Exception e)
									{out.println(Update_Cand_Temp+ " : " +e.getMessage());
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




//*********************************************************************************
//*********************************************************************************


										  }
										  else//else of if(count==1)
            								  {
												qstore =(java.util.Hashtable)getServletContext().getAttribute("QContainer");


												//update previous answer
												//out.println("getting size:"+qstore.size());
												//System.out.println("1");


												Integer p= new Integer(qstore.size());
												Integer v = (Integer)qstore.get(p);
												int vi=v.intValue();
												//out.println("earlier ques vi:"+vi);
												int pqidi,ansgiveni,ttakeni;
													pqidi=ansgiveni=ttakeni=0;
												String pqid="0";
												if(request.getParameter("id")!=null)
														{
															pqid=request.getParameter("id");
														}


												//System.out.println("2");


												if((pqid.equals("undefined"))||(pqid==null)) {System.out.print("pqid undefinned");}

												//System.out.println("pqid :" +pqid);

												if(!pqid.equals(null)){pqidi=Integer.parseInt(pqid);}

												//System.out.println("2.1");

												//String ansgiven ="0"
												//ansgiven=request.getParameter("qans");
												//if(ansgiven.equals(null)) out.print("ansgiven undefinned");

												//System.out.println(" qans :" +request.getParameter("qans"));

												if(request.getParameter("qans")!=null)
													{
														//System.out.println("coming in ");
														ansgiveni=Integer.parseInt(request.getParameter("qans"));
													}


												//System.out.println("2.2");

												//String ttaken=request.getParameter("questimer");
												//if(ttaken.equals(null)) out.print("ttaken undefinned");



												//out.println("previous ques : " + pqid);
												//out.println("previous ans : " + ansgiveni);
												if(request.getParameter("questimer")!=null)
													{ttakeni=Integer.parseInt(request.getParameter("questimer"));}

												//System.out.println("2.3");
												String st=stname+"temp";
												int seq = 1;
												int updated=0;

												seq=count-1;
												//out.println("sequence : "+seq);
												//out.println("vi : "+vi);

												//System.out.println("3");


												if(seq==pqidi) {updated=0;}
												else {updated=1;}

												//out.println("bookmark : " +request.getParameter("bookmark"));
												if((request.getParameter("bookmark")!=null)&&(!request.getParameter("bookmark").equals("undefined")))
												  {
													if(request.getParameter("bookmark").equals("1"))
													  {
														BookMark=1;
														session.putValue("BookMarkSet","1");
													  }
												  }

												//out.println("updated="+updated);

												//System.out.println("4");

												String Update_Cand_Temp="Update "+st+" SET  ansg="+ansgiveni+",timetaken="+ttakeni+",BookMark="+BookMark+" WHERE SequenceNo="+pqidi;
												//QuestionID="+vi;
												//out.println("<BR>"+Update_Cand_Temp+"<BR>");
												int chk=0;
												Statement stupdate = con.createStatement();
												if(updated==0)
													{
														try
															{
																chk=stupdate.executeUpdate(Update_Cand_Temp);
																System.out.print("check : "+chk);
																//out.print("upppppppppppppddddd");
															}catch(Exception e)
																	{out.println(Update_Cand_Temp+ " : " +e.getMessage());
																	}
													}
													else if(updated==1)
															{
																try
																	{
																		stupdate.executeUpdate("Update "+st+" SET  ansg=0,timetaken="+ttakeni+" WHERE QuestionID="+vi);
																	}catch(Exception e)
																			{out.println("2 candtemp update failed"+e.getMessage());
																			}

															}

													//System.out.println("AFFFTERRR UPPPDATTTE");

													String tleft = request.getParameter("timeleft");

													//System.out.println("4.1");
													//System.out.println("tleft :"+tleft);
													//if((tleft=="")||(tleft==null)||(tleft.equals("undefined"))) //out.println("Getting tleft null");
													//out.println("tlleft : "+tleft);
													if((tleft!=null)&&(!tleft.equals("undefined")))
															{

																//System.out.println("4.2");
																timeleft=Integer.parseInt(tleft);
															}
													//out.print("Time Inserted : "+timeleft);
													//System.out.println("4.3");

													try
														{

														//System.out.println("5");
														if(isQuestionTimer==0)
															{																		if((tleft!=null)&&(timeleft!=0)&&(!tleft.equals("undefined")))
																	{
																		stmt.executeUpdate("Update ExamStatus SET TimeLeft="+timeleft+" WHERE CandidateID="+CandidateID);
																		//System.out.println("6");
																	}
															}
														}catch(Exception e)
																{
																	out.println("ExamStatus update failed "+e.getMessage());

																}





													 tques = rnd.createVal();

													 //System.out.println("7");

													 boolean quesfound=true;
													 ResultSet rqexist = null;
													 while(quesfound==true)
														 {
															//out.println("Entering search 2 ");
															for(int j=1;j<=qstore.size();++j)
																	 {
																		//Changed on local server
																		while(tques==0) tques=rnd.createVal();
																		//out.print("In loop2:"+j);
																		Integer k= new Integer(j);
																		Integer tq1 = (Integer)qstore.get(k);
																		//int tq1i=tq1.intValue();
																		if (tques==tq1.intValue())  								 {quesfound=true;//out.println("Match found");
																		}
																		else quesfound=false;
																		if(quesfound) break;
																	 }
															 ////System.out.println("Tqueeeeeeeeeeeeeeeeeeeeesssssssss"+tques);

														 if(!quesfound)
															{
																rqexist=stmt.executeQuery("Select Count(*)  from  QuestionMaster WHERE  (CodeID LIKE "+AllCodes+") AND QuestionID="+tques+" AND ExamID="+ExamID);
								//Adding Exam ID 17/7/01 +" AND ExamID=5"
																//out.println("Coming in");
																//out.println("All Codes : "+AllCodes);
																//out.println("ExamID    : "+ExamID);
																//out.println("tques	   : "+tques);

																while(rqexist.next())
																		{
																			String recs=rqexist.getString(1);
																			int recsi =Integer.parseInt(recs);
																			if(recsi==0) quesfound=true;
																			if(recsi!=0) quesfound=false;
																			if(recsi!=0) break;
																			//out.println("recsi : "+recsi);
																			//out.println("ques : "+tques);
																			//out.println("quesfound :"+quesfound);
																		}
															}

																 if(quesfound==true) tques=rnd.createVal();
																 //if(count==20) break;
																//out.println("<br><br>Ques generated:"+tques+"<br><br>");
														 }//end of while(quesfound)
														//out.print(tques);
														//System.out.println("Search over 2");
														//if(count==20) tques=20;
													    Integer key2 = new Integer(qstore.size()+1);
						 							    Integer value2= new Integer(tques);
							                            qstore.put(key2,value2);
														//out.println("before hash");
													    for(int m=1;m<=qstore.size();++m)
															 {
																	Integer k= new Integer(m);
																	Integer tq2 = (Integer)qstore.get(k);
																	// tq1in = tq2.intValue();
																	//out.print("     h");
																	//out.print(tq2.intValue());
															 }
													    //out.println("after hash");

											  }//end of else of if(count==1)


				// tques=1;//for testing

				ResultSet rs=null;
				//out.println(testpaper);
				 if(TakeValue ==1) tques = ResumeQuest;
				//System.out.println("quesgenerated"+tques);
				//out.println("ExamID"+ExamID);
				//out.println("AllCodes= "+AllCodes);
				//out.println("QuestionID= "+tques);
				////System.out.println("SubjectID"+SubjectID);
				try
					{
						rs = stmt.executeQuery("Select * from QuestionMaster where QuestionID="+tques+" AND (CodeID LIKE "+AllCodes+") " +" AND ExamID="+ExamID);
//AND ExamID=5
//EXAM ID =5 ADDED IN THE WHERE CLAUSE
					}catch (SQLException e)
							{out.println(" Couldn't access Question  :"+e.getMessage());}

		        //out.println("Querry executed");
				 while(rs.next())
					  {
						 ////System.out.println("Rs obtained");

//						 //System.out.println("Entering rs of question");
						 //rs.next();
						 //out.println("getting rs.next of question");
						 String id,ques,a1,a2,a3,a4,a5,ans,imagename,sCodeID;
						 int image=0;
						 id=ques=a1=a2=a3=a4=ans=imagename=sCodeID=a5="";
						 id = rs.getString("QuestionID");
						 //out.println(id);
						 //out.println("<b>     id"+id+"</b>");
						 ques   = checker.setString(rs.getString("Question"));
						// out.println("<input type=\"hidden\" name=\"q1\" value='"+ques+	"'>");
	 %>

 						  <script language=javascript>

						 // alert(document.TestMain.q1.value);
							</script>
						  <%
							//out.println(ques);
				          a1	  = checker.setString(rs.getString("Option1"));
						  a2      = checker.setString(rs.getString("Option2"));
						  a3      = checker.setString(rs.getString("Option3"));
						  a4      = checker.setString(rs.getString("Option4"));
						  a5      = checker.setString(rs.getString("Option5"));
						  ans     = checker.setString(rs.getString("Answer"));
						  sCodeID = rs.getString("CodeID");

						 //String exp  = rs.getString("Explanation");
					     //String level = rs.getString("Level");
						 int idv,ani;
						 idv=ani=0;
						 if(id!=null)   idv = Integer.parseInt(id);

						 if(ans!=null)  ani = Integer.parseInt(ans);
						 image =rs.getInt("Image");
						 //out.print("image : "+image);
						// if(image=null) image=0;
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
												//System.out.println("In Images");
												while(rsimg.next())
														{
															imagename=rsimg.getString("Image");

														 }
											 }//if(rsimg)

							 }//if(image)

					 //out.println("Getting from DB :");
					 //out.println(idv);
					 //out.println(ani);
					 //String s= stname+"temp";
					 // //System.out.println("insertion of previous question and given answer");
					  try
						  {
							out.println("<font color=\"#fff5e7\">"+ans+"</font>");


							if(TakeValue==0)
							  {
								if((id!=null)&&(ans!=null)&&(request.getParameter("check")==null))
								{
								  stmt.executeUpdate("INSERT INTO "+stemp+" VALUES ("+count+","+idv+",0,"+ani+",0,"+CodeGroupID+",\'"+sCodeID+"\',0)");
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
								if(a5==null)   a4="Option not Entered in DB";
								if(ans==null)  ans="Answer not Entered in DB";

								////System.out.println(id+ques+a1+a2+a3+a4+a5+ans);


%>
						<table  width="480" height="75">
							<tr>
								 <td align="left" valign="top" class=qu>(<%=count%>)</td>
					             <td align="left" valign="top" class=qu><%=ques%></td>
					        </tr>
				        </table>
			           <table width="480" >
							<tr>
								 <td align="center" width="20%" class=an> (a)</td>
					             <td align="left" width="80%" class=an><%=a1%><td>
						    </tr>

							<tr>
								 <td align="center" width="20%" class=an>(b)</td>
					             <td align="left" width="80%" class=an ><%=a2%><td>
				            </tr>
				            <tr>
					             <td align="center" width="20%" class=an> (c)</td>
							     <td align="left" width="80%"  class=an><%=a3%><td>
				            </tr>

							<tr>
							     <td align="center" width="20%" class=an> (d)</td>
						         <td align="left" width="80%"  class=an><%=a4%><td>
							</tr>
<%
							if((a5!=null)&&(!((a5.equals("NoOption"))||(a5.equals("no options")))))
							{
%>
							<tr>
							     <td align="center" width="20%" class=an> (e)</td>
						         <td align="left" width="80%"  class=an><%=a5%><td>
							</tr>
  <%
							}
%>
						    <tr>
								 <td> </td>
					             <td align="center"> </td>
		  		            </tr>
			          </table>
 <%
		 if(image!=0)
			  {

%>
					<div align=center>
					<img src="../simages/<%=imagename%>"  BORDER=0 ALT="">
				    </div>
<%			  }
						 if(count<TotalQuestions)
							    {

									if(count==(TotalQuestions-1)) session.putValue("ILQ","1");
									out.println("<br><br><table width=600><td align=\"left\">");

									out.println("<input name=\"bookmark\" type=checkbox value=1>");
									  out.println("<font face=\"arial,helvetica\" size=\"2\" color=red>");
									out.println("BOOKMARK QUESTION");

					  //out.println("<input type=\"hidden\" name=\"bookmark\" value=\"0\">");
					  out.println("</font></td></table>");
 %>

						          <table width=400>
									   <tr><td align="right">
									       <input type="image" src="../simages/next1.gif" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver = "MM_swapImage('Image1','','../simages/next2.gif',1)" onClick="return  showval()">
										   </td>
									   </tr>
									   <tr>

									</table>
									<br><br>


<%


							if(BreaksTaken<Breaks)
											{
%>
												<table width=600>
													 <td align="left">
												       <input name=check type=checkbox value=1>
														<font face="arial,helvetica" size="2" color=red>
															Click here if you wish to take a break after this question
			 										    </font>
													   </td>
												   </tr>

												  </table>


	<%
											}//end of if(BreaksTaken<Breaks)

							     } //end of if(count<=TotalQuestions)
						          else
									  {
										 out.print("<br><br><font face=\"arial,helvetica\" size=\"3\" 	color=red>");
										 out.println("Questions Over!!Click on \"Finish Test\" ");
										 //out.println("<input type=submit value=\"Go to Bookmarked Questions\" >");
										 session.putValue("GBM","OFF");

										/*
										 if(BookMarkSet.equals("1"))
										  {
											out.println("<form action=mainbm.jsp method=get>");
											out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
										    out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
										    out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
											out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
											out.println("<input type=submit value=\"Go to Bookmarked Questions\" >");
											out.println("</form>");
										  }
										  */
									 }

			          /*
					  out.println("<table width=600><td align=\"left\">");

					  out.println("<input name=\"bookmark\" type=checkbox value=1>");
					  out.println("<font face=\"arial,helvetica\" size=\"3\" color=red>");
					  out.println("BOOKMARK QUESTION");
					  //out.println("<input type=\"hidden\" name=\"bookmark\" value=\"0\">");
					  out.println("</font></td></table>");
					  */
					  out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
					  out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
				      out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
					  out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
					  out.println("<input type=\"hidden\" name=\"pq\" value=\"" + tques + "\">");
					  stmt.close();


		  }/*end of if(rs!=null) */
			 // else { out.print("Suitable match for generated questionid not found in 	table!!!");
		  		  // }
	   }//end of if(con!=null)
	 }//end of try
	 catch (SQLException sqle)
		 {
		   out.println(sqle.getMessage());
		 }

      catch (Exception e)
		 {
		   out.println(e.getMessage());
		 }
		 finally{
			       /*if(count==10)
					{
					  if(con!=null)
						{
						  //pool.emptyPool();
						  //out.println("Pool Emptied");
						}
					}
					else*/
					if(con!=null) pool.releaseConnection(con);
					else out.println("Connection Lost");
					if(con2!=null) pool.releaseConnection(con2);
					//else out.println("Connection Lost");
					if(con3!=null) pool.releaseConnection(con3);
					//else out.println("Connection Lost");
				 }//end of finally
    }//end of 1st if
	else if((b.equals("started"))&&(count==(TotalQuestions+1))&&(nrq<TotalQuestions)&&(ExamMode!=1))
	{

	  con = pool.getConnection();
	   stmt=con.createStatement();
	  qstore =(java.util.Hashtable)getServletContext().getAttribute("QContainer");
 	  //update previous answer
      //out.println("getting size:"+qstore.size());
	  Integer p= new Integer(qstore.size());
	  Integer v = (Integer)qstore.get(p);
	  int vi=v.intValue();
	  //out.print(vi);
	 out.print("<br><br><font face=\"arial,helvetica\" size=\"3\" color=red>");
	 out.println("Questions Over!!Click on \"Finish Test\" ==> ");
	 String ansgiven=request.getParameter("qans");
     String ttaken=request.getParameter("questimer");
	 //out.println("previous ans : " + ansgiven);
	 int ansgiveni=Integer.parseInt(ansgiven);
	 int ttakeni=Integer.parseInt(ttaken);
	 String st=stname+"temp";
	 //out.print("ques:"+vi);
	 //out.print(st);
	 //out.print("answer given :"+ansgiveni);
	 //out.print("Timetaken :"+ttakeni);
	 try
	  {
		 String query  = "Update "+st+" SET ansg="+ansgiveni+",timetaken="+ttakeni+"   WHERE QuestionID="+vi;
		 //out.println(query);
		 int i=0;
		// out.println("i= " + i);
		 i = stmt.executeUpdate(query);
		 //out.println("i= " + i);
	  }catch(Exception e)
	  {
		  out.println("Candtemp update failed"+e.getMessage());
	  }
   }
   /*
   else if((b.equals("started"))&&(ExamMode==0)&&(ILQ.equals("1"))&&(BookMarkSet.equals("1")))
	{

		out.println("Bookmarked Questions");
	}*/
    else
	  {
     %>

     <script language="javascript">
       location.replace("testover.html","_top");
      </script>
   <%
     }
  }//emd of exam mode check
else if((b.equals("started"))&&(ExamMode==1))
	{

		try
		{
			con2=pool.getConnection();
			stmt=con2.createStatement();
			//Statement stmtn = con2.createStatement();
		   if(con2==null) out.println("Connection not obtained");
		   //else out.println("Connection obtained");
			if(con2!=null)
			{
				ResultSet rseq =null;
				//String testpaper2="IITQuestionMaster";
				try
				  {
					rseq = stmt.executeQuery("Select * from QuestionMaster WHERE CodeID LIKE "+AllCodes+" and ExamID="+ExamID);
				  }catch (SQLException e)
				  {
					 out.println("Error getting records from DB :" + e.getMessage());
		 		  }

				//out.println("Total Questions :"+TotalQuestions);
				//System.out.println("ENNNNNNNNTERRRRRRRRRRRRRRRRRRRRRRRRR");
				////System.out.println("Code ="+sCode);
				while(rseq.next())
				 {
					  String id,ques,a1,a2,a3,a4,ans,imagename,sCodeID,a5;
					  int image=0;
					  id=ques=a1=a2=a3=a4=a5=ans=imagename=sCodeID="";
					  id     = rseq.getString("QuestionID");
					 // out.println("id"+id);
				      ques   = checker.setString(rseq.getString("Question"));
					  //out.println(ques);
						  a1	= checker.setString(rseq.getString("Option1"));
						  a2	= checker.setString(rseq.getString("Option2"));
						  a3	= checker.setString(rseq.getString("Option3"));
						  a4	= checker.setString(rseq.getString("Option4"));
						  a5	= checker.setString(rseq.getString("Option4"));
						 ans	= checker.setString(rseq.getString("Answer"));
					  sCodeID	= rseq.getString("CodeID");
				      int idv     = Integer.parseInt(id);
					  int ani     = Integer.parseInt(ans);
					  image =rseq.getInt("Image");



					  //----------Inserting records in the temporary table of the candidate

					    try
							  {
								//out.println("                   "+ans);
								stmt.executeUpdate("INSERT INTO "+stemp+" VALUES 	("+count+","+idv+",0,"+ani+",0,"+CodeGroupID+",\'"+sCodeID+"\',0)");

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
											//System.out.println("In Images");
											while(rsimg.next())
											{
												imagename=rsimg.getString("Image");
											 }
										}//if(rsimg)

							 }//if(image)

							// out.println("Getting from DB :");

%>
								<table  width="480" height="75">
									<tr>
									<td align="left" valign="top" class=qu>(<%=count%>)</td>
									<td align="left" valign="top" class=qu><%=ques%></td>
								    </tr>
						       </table>
						       <table width="480" >
									<tr>
									<td align="center" width="20%" class=an> (a)</td>
									<td align="left" width="80%" class=an><%=a1%><td>
									</tr>
            						<tr>
									 <td align="center" width="20%" class=an>(b)</td>
									 <td align="left" width="80%" class=an ><%=a2%><td>
		 				            </tr>

						            <tr>
						             <td align="center" width="20%" class=an> (c)</td>
						             <td align="left" width="80%"  class=an><%=a3%><td>
							        </tr>

									<tr>
									 <td align="center" width="20%" class=an> (d)</td>
						             <td align="left" width="80%"  class=an><%=a4%><td>
									</tr>
<%
									if(!((a5.equals("NoOption"))||(a5.equals("no options"))))
									{
%>
										<tr>
		 								<td align="center" width="20%" class=an> (e)</td>
								        <td align="left" width="80%"  class=an><%=a5%><td>
										</tr>
  <%
					 				}
%>
									<tr>
								     <td> </td>
									 <td align="center"> </td>
						            </tr>
						          </table>
 <%
				 if(image!=0)
						  {

%>
								<div align=center>
								<img src="../simages/<%=imagename%>"  BORDER=0 ALT="">
							    </div>
<%						  }
						count++;
					//out.print("count"+count);
					if(count==(TotalQuestions+1)) break;
			 }	//end of while(rseq.next())
			 out.println("<input type=hidden name=id value=1>");
  			 out.println("<input type=hidden name=qans value=1>");
			 out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
			 out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
		 }//if (con2!=null)
		}
		 catch (SQLException sqle)
		 {
		   out.println(sqle.getMessage());
		 }

      catch (Exception e)
		 {
		   out.println(e.getMessage());
		 }
		 finally{

					if(con2!=null) pool.releaseConnection(con2);
					//else out.println("Connection Lost");

				 }//end of finally

	}

   %>
  </table>
  </center>
  </form>
<%


	session.putValue("GBM","OFF");

	out.println("<form name=\"TestBM\" action=mainbm.jsp method=get>");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
	if((ExamMode==0)&&((BookMark==1)||((BookMarkSet!=null)&&(BookMarkSet.equals("1")))))
	{
		out.println("<input type=submit value=\"Go to Bookmarked Questions\" onClick=\"return  showval()\" >");
		//session.putValue("teststatus","started");
	}
		out.println("</form>");

%>

  </body>
  </html>


