
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002
DOE          : 03 - 03 - 2002
-->


<html>
<head>
<title> Test Main BM</title>
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
//var current=document.TestMainbm.id.value;

   function setr()
   {
	  // alert(document.TestMain.id.value);
      rname='r' + document.TestMainbm.id.value;

   }

	function initialize(i)
	{
		k=i;
		parent.displayOption(k);
		parent.setTime();
	}


	function setval()
	{
	    document.TestMainbm.qans.value=localvar;
		document.main3.qans.value=localvar;
		//alert(document.TestMain.qans.value);
		//document.TestMain.questimer.value=qtimer;
		 if(localvar=="") document.TestMainbm.qans.value="0";
		 if(localvar=="") document.TestMainbm.main3.value="0";
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
		document.TestMainbm.timeleft.value=tmleft;
		document.main3.timeleft.value=tmleft;
		//if(k!=1) document.TestMain.timeleft.value=parent.totaltime-parent.timeleft;
		//alert(document.main3.timeleft.value);
		var tqtime = qtimer + eval(document.TestMainbm.addqtime.value);
		document.TestMainbm.questimer.value=tqtime;
		document.main3.questimer.value=tqtime;
		if(localvar=="")	parent.answerArray[document.TestMainbm.id.value]=-1;
		if(localvar=="")	parent.answerArray[document.main3.id.value]=-1;
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

	if (stname == null || stname.equals(null) || stname=="")
	response.sendRedirect("SessionExpiry.jsp");


	Integer option =(Integer)session.getValue("NoOfRemainingQuestions");
	int nrq = option.intValue();
	//System.out.println("NRQ                :"+nrq);
	Integer TQ=(Integer)session.getValue("TotalQuestions");
	//System.out.println("TQ "+TQ);
	int TotalQuestions = TQ.intValue();
	int noOptions=0;

	out.println("<body bgcolor=\"#fff5e7\"  onResize=\"return false\" onLoad=\"initialize("+noOptions+");\">");
%>

	<form name="TestMainbm"  action="TestMainbm.jsp" method="POST">

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
	String BookMarkSet  = (String) session.getValue("BookMarkSet");
	String ILQ			= (String) session.getValue("ILQ");


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
	int ResumeQuest		= ((Integer)session.getValue("ResumeQuest")).intValue();
	//out.println("ResumeQuest : " +ResumeQuest);
	CodeGroupID			= CodeGID.intValue();


	int timeleft=0;	int count=1;int tques=1;
	int pqidi,ansgiveni,ttakeni;
		pqidi=ansgiveni=ttakeni=0;

//***************************************************

	Hashtable tempa = new Hashtable();
	Hashtable savea = new Hashtable();
	Vector tempb = new Vector();
	Vector saveb = new Vector();
	int firstbm = 0;
	String getbm ="";
	int lastbm = -1;
	Integer NoOfRemainingQuestions=new Integer(count-1);

	int pan =0;int pat=0;


		//int pqidi,ansgiveni,ttakeni;
		//	pqidi=ansgiveni=ttakeni=0;

		String id1			= request.getParameter("id");
		String pqid			= "";
		String ansgiven		= request.getParameter("qans");
		String ttaken		= request.getParameter("questimer");
		//String stname		= (String)	session.getValue("username");
		//String st			= stname+"temp";
		String tleft		= request.getParameter("timeleft");

		//out.println("id1 : "+id1);
		//out.println("qans :"+ansgiven);
		//out.println("ttaken :"+ttaken);


		int lastid =0;
		lastid = Integer.parseInt(id1);
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





		////System.out.println("checkkkkkkkkk");
		con3=pool.getConnection();
		if(con3==null) out.println("Connection not obtained");
		////System.out.println("Before INCLUDED FILE");

		////System.out.println("AFTER INCLUDED FILE");
		getbm = (String)session.getValue("GBM");
		//System.out.println("GBM :"+getbm);
		if(con3!=null)
			{





					if(getbm.equals("OFF"))
					{


						String stn=stname+"temp";

						Statement stRQ = con3.createStatement();
						ResultSet rsRQ = null;
						try
						{
							rsRQ = stRQ.executeQuery("select QuestionID from "+stn+" 	where SequenceNo="+lastid);

							while(rsRQ.next()) {ResumeQuest = rsRQ.getInt("QuestionID");}
						}
						catch(SQLException e)
						{
							out.println(e.getMessage());
						}

						session.putValue("ResumeQuest",new Integer(ResumeQuest));


						Statement sbm =null;
						sbm=con3.createStatement();
						ResultSet rsbm =null;
						rsbm = sbm.executeQuery("SELECT SequenceNo,QuestionID FROM "+stemp+" where BookMark=1 order by SequenceNo");
						Hashtable a = new Hashtable();
						Vector b = new Vector();
						int i=0;





						while(rsbm.next())
						{


							if(i==0)
							{

								a.put(""+rsbm.getInt("SequenceNo"),""+rsbm.getInt("QuestionID"));
								b.add(i,""+rsbm.getInt("SequenceNo"));
								if(b.size()>0)
								count = Integer.parseInt((String)b.get(i));
								++i;
							}
							else
							{
								a.put(""+rsbm.getInt("SequenceNo"),""+rsbm.getInt("QuestionID"));
								b.add(i,""+rsbm.getInt("SequenceNo"));
								++i;
							}


						}
							tempa =a;
							tempb=b;
							session.putValue("A",a);
							session.putValue("B",b);


					}
					else
					{
						tempa = (Hashtable) session.getValue("A");
						tempb = (Vector) session.getValue("B");
						if(tempb.size()>0)
						{count = Integer.parseInt((String)tempb.get(0));}
						else
						{

							Statement sid = null;
							ResultSet rsid= null;
							sid = con3.createStatement();
							String stn=stname+"temp";

							try
							{
								rsid = sid.executeQuery("select max(SequenceNo),QuestionID from "+stn+" where BookMark=1 group by BookMark ");
							}
							catch(SQLException se)
							{
								out.println("Error :"+se.getMessage());
							}


							while (rsid.next())
							{
								count  = rsid.getInt(1);
								lastbm = rsid.getInt("QuestionID");

							}

						}

					}

			}



    if(teststart.equals("start"))
		{


			//if(isQuestionTimer==1) ExamTime=QResponseTime;
			//else ExamTime = LeftTime;
			//StoreFirstQuestion = count;

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

						ResultSet rsgetcount = stnew.executeQuery("SELECT COUNT(*) FROM "+stemp);
						while(rsgetcount.next())
							{
								int counter = rsgetcount.getInt(1);
								System.out.print("counter : "+counter);
								NoOfRemainingQuestions = new Integer(counter-1);
								//count =Integer.parseInt(counter);
								//++count;//incremented to get next question
							}//end of while


						rsgetcount.close();
						stnew.close();

						Connection con12 = pool.getConnection();
						Statement stime12 =null;
						stime12 = con12.createStatement();
						ResultSet rstime12 =null;
						rstime12 = stime12.executeQuery("select * from ExamStatus where CandidateID="+CandidateID);
						while(rstime12.next()) {
								LeftTime = rstime12.getInt("TimeLeft");
										}
						stime12.close();
						//out.println("Left time 1: "+LeftTime);
					 }//if con2!=null
					// out.println("Left time 2: "+LeftTime);

		       }
			   if(teststart.equals("start")) LeftTime = ExamTime;
			  /*
				if(tstatus.equals("old")&&(nrq!=0))
				{
				   if(nrq<=TotalQuestions) StoreFirstQuestion=nrq;

				}else StoreFirstQuestion=1;
				*/
				//******************************Bookmarked


				//**********************************
			   //out.println("StoreFirstQuestion :"+StoreFirstQuestion);


			   StoreFirstQuestion=1;

				if(getbm.equals("OFF")) ExamTime = LeftTime;
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

	//System.out.println("ExamMode :"+ExamMode);
	//System.out.println("TotalQuestions :"+TotalQuestions);
	//System.out.println("Count :"+count);



	  if(ExamMode==0)
			{
			 //System.out.println("????????????");
			 //System.out.println("b :"+b);
			 b="started";
			 //System.out.println("b :"+b);
			 if(b.equals("started")) //1st iff
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


									 if(getbm.equals("OFF"))
									 {

											//System.out.println(" IN HEREEEEEE");
											//System.out.println("countttt :" +count);
											//out.println("temp a :"+tempa.toString());


											//tques =Integer.parseInt((String)tempa.get(""+count));

											if(tempa.size()>0)
														{

															tques =Integer.parseInt((String)tempa.get(""+count));
														}
														else
														  {

															tques = lastbm;
														  }


											String st=stname+"temp";
											ansgiveni = Integer.parseInt(ansgiven);
											ttakeni   = Integer.parseInt(ttaken);

											String Update_Cand_Temp="Update "+st+" SET  ansg="+ansgiveni+",timetaken="+ttakeni+" WHERE SequenceNo="+Integer.parseInt(id1);

											try
											{
												stmt.executeUpdate(Update_Cand_Temp);
											}catch(Exception e)
											{out.println(Update_Cand_Temp+ " : " +e.getMessage());}


												tleft = request.getParameter("timeleft");

												//System.out.println("tleft :"+tleft);

												session.putValue("TimeLeft",""+tleft);

												if((tleft!=null)&&(!tleft.equals("undefined")))
												{
													//System.out.println("4.2");
												    timeleft=Integer.parseInt(tleft);
												}
													//out.print("Time Inserted : "+timeleft);


												try
												{


													if(isQuestionTimer==0)
													{
														if((tleft!=null)&&(timeleft!=0)&&(!tleft.equals("undefined")))
														{
															stmt2.executeUpdate("Update ExamStatus SET TimeLeft="+timeleft+" WHERE CandidateID="+CandidateID);
															//System.out.println("6");
														}
													 }
												 }catch(Exception e)
													{
														out.println("ExamStatus update failed "+e.getMessage());

													}

/*     */
											//pad = Previous available data
											ResultSet rspad = null;


											try
											{
												rspad = stat.executeQuery("Select ansg,timetaken from "+st+" where SequenceNo="+count);

											}
											catch( SQLException e)
											 {
												 out.println("Exception  :"+e.getMessage());
											 }



											  while(rspad.next())
												{
													pan = rspad.getInt("ansg");
													pat = rspad.getInt("timetaken");
												}

%>
<script language="javascript">
//	var r='r' + <%=count%>+ "[" +<%=pan%>  + "]";
//	alert(r);
//	if(top.frames[1].ans2)
//		eval("top.frames[1].ans2." + r).checked();

</script>
<%

/*      */

											session.putValue("GBM","ON");
											session.putValue("NoOfRemainingQuestions",NoOfRemainingQuestions);
											session.putValue("teststatus","old");
											session.putValue("start","start");



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

												pqid="0";
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
												int BookMark=1;
												seq=count-1;
												//out.println("sequence : "+seq);
												//out.println("vi : "+vi);

												//System.out.println("3");


												updated=0;



												//out.println("updated="+updated);

												//System.out.println("4");

												String Update_Cand_Temp="Update "+st+" SET  ansg="+ansgiveni+",timetaken="+ttakeni+",BookMark="+BookMark+" WHERE SequenceNo="+pqidi;
												//QuestionID="+vi;
												//out.println("<BR>"+Update_Cand_Temp+"<BR>");
												int chk=0;
												Statement stupdate = con.createStatement();

														try
															{
																chk=stupdate.executeUpdate(Update_Cand_Temp);
																System.out.print("check : "+chk);
																//out.print("upppppppppppppddddd");
															}catch(Exception e)
																	{out.println(Update_Cand_Temp+ " : " +e.getMessage());
																	}

													//System.out.println("AFFFTERRR UPPPDATTTE");

													tleft = request.getParameter("timeleft");

													//System.out.println("4.1");
													//System.out.println("tleft :"+tleft);

													session.putValue("TimeLeft",""+tleft);

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



														//out.print(tques);
														//System.out.println("Search over 2");


														if(tempa.size()>0)
														{
															tques =Integer.parseInt((String)tempa.get(""+count));
														}
														else
														  {

															tques = lastbm;

														  }
/*      */
											//pad = Previous available data
											ResultSet rspad = null;


											try
											{
												rspad = stat.executeQuery("Select ansg,timetaken from "+st+" where SequenceNo="+count);

											}
											catch( SQLException e)
											 {
												 out.println("Exception  :"+e.getMessage());
											 }



											  while(rspad.next())
												{
													pan = rspad.getInt("ansg");
													pat = rspad.getInt("timetaken");
												}



%>
<script language="javascript">
	//var r='r' + <%=count%>+ "[" +<%=pan%>  + "]";
//	alert(r);
	//if(top.frames[1].ans2)
	//	eval("top.frames[1].ans2." + r).checked();
</script>
<%


/*   */




														session.putValue("start","start");

											  }//end of else of if(count==1)



				//out.println("tempa" +tempa.toString());
				tempb.remove(""+count);
				tempa.remove(""+count);

				//out.println("tempa" +tempa.toString());
				session.putValue("A",tempa);
				session.putValue("B",tempb);




				// tques=1;//for testing

				ResultSet rs=null;
				//out.println(testpaper);

				//System.out.println("quesgenerated"+tques);
				try
					{
						rs = stmt.executeQuery("Select * from QuestionMaster where QuestionID="+tques+" AND ExamID="+ExamID);

					}catch (SQLException e)
							{out.println(" Couldn't access Question  :"+e.getMessage());}

		        //out.println("Querry executed");
				 while(rs.next())
					  {
						 //out.println("Rs obtained");

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
					  //insertion of previous question and given answer

						out.println("<font color=\"#fff5e7\">"+ans+"</font>");


						if(id==null)   id="QuestionID not Entered in DB";
						if(ques==null) ques="Question not Entered in DB";
						if(a1==null)   a1="Option not Entered in DB";
						if(a2==null)   a2="Option not Entered in DB";
						if(a3==null)   a3="Option not Entered in DB";
						if(a4==null)   a4="Option not Entered in DB";
						if(a5==null)   a4="Option not Entered in DB";
						if(ans==null)  ans="Answer not Entered in DB";


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

		  		            </tr>
			          </table>
					  <table>
<%if(pan!=0){%>
					             <td align="left"><font size=2 color=blue>Previous answer selection for this question : <%=pan%><br>
									You can change your answer or click the same answer again to retain the answer</font><br> <font size=2 color=red>(Note: Do not leave it unattempted).
								</font>
								</td>
<%}else{out.println("<td></td>");}%>
						</table>
 <%
		 if(image!=0)
			  {

%>
					<div align=center>
					<img src="../simages/<%=imagename%>"  BORDER=0 ALT="">
				    </div>
<%			  }
					//out.println("tempa size :"+tempa.size());
						 if(tempa.size()>0)
							    {

 %>

						          <table width=400>
									   <tr><td align="right">
									       <input type="image" src="../simages/next1.gif" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver = "MM_swapImage('Image1','','../simages/next2.gif',1)" onClick="return  showval()">
										   </td>
									   </tr>
									   <tr>

									</table>
									<br><br>
<%								//	if(BreaksTaken<Breaks)
											{
%>
<!--												<table width=600>
													 <td align="left">
												       <input name=check type=checkbox value=1>
														<font face="arial,helvetica" size="3" color=red>
															Click here if you wish to take a break after this question
			 										    </font>
													   </td>
												   </tr>

												  </table>
-->

	<%
											}//end of if(BreaksTaken<Breaks)

							     } //end of if(count<=TotalQuestions)
						          else
									  {
										 out.print("<br><br><font face=\"arial,helvetica\" size=\"2\" 	color=red>");
										 out.println("BookMark Questions Over!! Click on \"Finish Test\" to end test <br>");
										 out.println("OR   \"Go Back to Test\" to resume test </font>");
										 session.putValue("ILQ","1");
/*
										 if(BookMarkSet.equals("1"))
										  {
											out.println("<form action=menu2.jsp method=post>");
											out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
										    out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
										    out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
											out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
											out.println("<input type=submit value=\"Go to Bookmarked Questions\" >");
											out.println("</form>");

										  }
*/
									 }


					  out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
					  out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
					  out.println("<input type=\"hidden\" name=\"addqtime\" value="+pat+">");
				      out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
					  out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
					  out.println("<input type=\"hidden\" name=\"qid\" value=\"" + tques + "\">");
					  stmt.close();

		  }
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
	 //String ansgiven=request.getParameter("qans");
     //String ttaken=request.getParameter("questimer");
	 //out.println("previous ans : " + ansgiven);
	  ansgiveni=Integer.parseInt(ansgiven);
	  ttakeni=Integer.parseInt(ttaken);
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
   else if((b.equals("started"))&&(ExamMode==0)&&(ILQ.equals("1"))&&(BookMarkSet.equals("1")))
	{

		out.println("Bookmarked Questions");
	}
    else
	  {
     %>

     <script language="javascript">
       location.replace("testover.html","_top");
      </script>
   <%
     }
  }//emd of exam mode check

  %>
  </form>
<%

	out.println("<form name=main3 action=main3.jsp method=get>");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"bookmark\" value=\"1\">");
	out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
	 out.println("<input type=\"hidden\" name=\"addqtime\" value="+pat+">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
	out.println("<input type=\"hidden\" name=\"return\" value=\"1\">");
	out.println("<table align=left width=400><tr><td align=left><input type=submit value=\"Go Back To Test\" onClick=\"return  showval()\" ></td></tr></table>");
	out.println("</form>");

%>


  </body>
  </html>


