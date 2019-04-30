
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
//var current=document.TestMainbm.id.value;

   function setr()
   {
	  // alert(document.TestMain.id.value);
      rname='r' + document.NewTestMainall.id.value;

   }

	function initialize(i)
	{
		k=i;
		//parent.displayOption(k);
		parent.setTime();
	}


	function setval()
	{
		var nop = document.NewTestMainall.nop.value;
		var strans="";

		for(var i=0;i<=nop-1;++i)
		{
			var p ="document.NewTestMainall.r["+i+"]";
			if(eval(p).checked)  document.NewTestMainall.qans.value=i+1;
			if(eval(p).checked)  document.Newmain3.qans.value=i+1;
			if(eval(p).checked)  strans=strans+document.NewTestMainall.qans.value;
			document.NewTestMainall.chkans.value=strans;
			//alert("value :"+document.NewTestMainall.chkans.value);
		}
		
		if (strans==null || strans=="")
  		{
  			//alert("First name must be filled out"+strans);
  			document.NewTestMainall.chkans.value=0;
        }
	}

	function showval()
	{
		setval();
		if(parent.isPerQuestionTimer==1) parent.temp=0;
		qtimer=parent.tcount - parent.temp;
		parent.temp=parent.tcount;
		document.NewTestMainall.timeleft.value=tmleft;
		document.Newmain3.timeleft.value=tmleft;
		var tqtime = qtimer + eval(document.NewTestMainall.addqtime.value);
		document.NewTestMainall.questimer.value=tqtime;
		document.Newmain3.questimer.value=tqtime;
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

	function OpenCalculator(url)
	{
		window.open(url, "calc", "width=130,height=215,left=200,top=100,resizable=0");
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
	Integer AQ		=(Integer)session.getValue("AllQuestions");
	//System.out.println("TQ "+TQ);
	int TotalQuestions = TQ.intValue();
	int noOptions=0;
	int AllQuestions = AQ.intValue();

	out.println("<body onResize=\"return false\" onLoad=\"initialize("+noOptions+");\">");
%>
<form name="NewTestMainall"  action="NewTestMainall.jsp" method="POST">
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="rnd" scope="page" class="com.ngs.gbl.RandomGenerator"/>
<jsp:useBean id="checker" scope="page" class="com.ngs.gbl.security"/>
<jsp:useBean id="A" scope="page" class="com.ngs.gbl.Answer"/>
<jsp:useBean id="NMC" scope="application" class="com.ngs.gen.NMCalculate"/>
<input type=hidden name=chkans value="">

<%

//----------	INITIALIZATION OF VARIABLES TO BE USED	----------//
	String UserType		= (String)  session.getValue("TypeOfUser");
	String  tstatus		= (String)	session.getValue("teststatus");
	Integer isQT		= (Integer)	session.getValue("TimerType");
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
	String  stemp		= "temp_"+stname;
	boolean AnsFlag = false;
	String BookMarkSet  = (String) session.getValue("BookMarkSet");
	String ILQ			= (String) session.getValue("ILQ");
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
	CodeGroupID			= CodeGID.intValue();
	int timeleft=0;	int count=1;int tques=1;
	int pqidi,ansgiveni,ttakeni;
		pqidi=ansgiveni=ttakeni=0;
	int BookMark=0;

//***************************************************

	Hashtable tempa = new Hashtable();
	Hashtable savea = new Hashtable();
	Vector tempb = new Vector();
	Vector saveb = new Vector();
	int firstbm = 0;
	String getbm ="";
	int lastbm = -1;
	Integer NoOfRemainingQuestions=new Integer(count-1);
	String pan ="";int pat=0;

	String id1			= request.getParameter("id");
	String pqid			= "";
	String ansgiven		= request.getParameter("qans");
	String ttaken		= request.getParameter("questimer");
	//String stname		= (String)	session.getValue("username");
	//String st			= stname+"temp";
	String tleft		= request.getParameter("timeleft");
	int lastid =0;
	lastid = Integer.parseInt(id1);
//***************************************************
	java.util.Hashtable qstore = new java.util.Hashtable();
    ServletContext context	   = getServletContext();
	pool					   =(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");

	Connection con;//,con2,con3;
			   con=null;//=con2=con3
	Statement  stmt,stmt2,stmt3,stnew,stmt4,stat,stmt5;
			   stmt=stmt2=stmt3=stnew=stmt4=stat=stmt5=null;


	//System.out.println("ISQT :"+isQT);
	isQuestionTimer=isQT.intValue();

	//System.out.println("ritmer : "+QResponseTime);
	//System.out.println("NRQ                :"+nrq);

	con=pool.getConnection();
	if(con==null) out.println("Connection not obtained");
	if(con!=null)
	{
		stnew=con.createStatement();
		ResultSet rsgetcount = stnew.executeQuery("SELECT COUNT(*) FROM "+stemp);
		while(rsgetcount.next())
		{
			int counter = rsgetcount.getInt(1);
			NoOfRemainingQuestions = new Integer(counter);
		}//end of while


		rsgetcount.close();
		stnew.close();

	}


	getbm = (String)session.getValue("GBM");
    if(teststart.equals("start"))
	{
%>
<script language="javascript">
	parent.startQuestion=<%=count%>;
	parent.totalQuestion=<%=AllQuestions%>;
	parent.totaltime=<%=ExamTime%>;
	parent.exammode=<%=ExamMode%>;
	parent.isPerQuestionTimer=<%=isQuestionTimer%>;
	for (i=0; i <=parent.totalQuestion; i++)
	parent.answerArray[i]=new Array(5);
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
	if(con==null) out.println("Connection not obtained");
	if(con!=null)
	{


						//Connection con = pool.getConnection();
		Statement stime12 =null;
		stime12 = con.createStatement();
		ResultSet rstime12 =null;
		rstime12 = stime12.executeQuery("select * from ExamStatus where CandidateID="+CandidateID);
		while(rstime12.next())
		{
			LeftTime = rstime12.getInt("TimeLeft");
		}
		stime12.close();
	}//if con!=null

 }
	if(teststart.equals("start")) LeftTime = ExamTime;
	if(getbm.equals("OFF")) ExamTime = LeftTime;
%>
<script language="javascript">
	parent.startQuestion=<%=StoreFirstQuestion%>;
	parent.isPerQuestionTimer=<%=isQuestionTimer%>;
	parent.totalQuestion=<%=AllQuestions%>;
	parent.totaltime=<%=ExamTime%>;
	parent.exammode=<%=ExamMode%>;
	parent.isPerQuestionTimer=<%=isQuestionTimer%>;
	parent.currentQuestion=<%=count%>;
	for (i=0; i <=parent.totalQuestion; i++)
	parent.answerArray[i]=new Array(5);
</script>
<%
	String b = (String)session.getValue("start");
//----------Updates the last answer given in database.TotalQuestions+1
//----------since count rolls over to tq+1 after last answer.
	if(ExamMode==0)
	{
		b="started";
		if(b.equals("started")) //1st iff
		{
			try
			{
				if(con==null) out.println("Connection not obtained");
				else //System.out.println("Connection obtained");

				if(con!=null)
				{
					stmt=con.createStatement();
					stmt2=con.createStatement();
					stat=con.createStatement();

					if(request.getParameter("all")==null)
					{
						count = 1;
						String st="temp_"+stname;
						Statement stRQ = con.createStatement();
						ResultSet rsRQ = null;

						try
						{
							rsRQ = stRQ.executeQuery("select QuestionID from "+st+" 	where SequenceNo="+lastid);
							while(rsRQ.next())
							{ResumeQuest = rsRQ.getInt("QuestionID");}
						}
						catch(SQLException e)
						{
							out.println(e.getMessage());
						}

						session.putValue("ResumeQuest",new Integer(ResumeQuest));
						ansgiveni = Integer.parseInt(ansgiven);
						ttakeni   = Integer.parseInt(ttaken);
						String Update_Cand_Temp="Update "+st+" SET  ansg='"+ansgiven+"',timetaken="+ttakeni+" WHERE SequenceNo="+Integer.parseInt(id1);

						try
						{
							stmt.executeUpdate(Update_Cand_Temp);
						}catch(Exception e)
						{out.println(Update_Cand_Temp+ " : " +e.getMessage());}


						tleft = request.getParameter("timeleft");
						session.putValue("TimeLeft",""+tleft);

						if((tleft!=null)&&(!tleft.equals("undefined")))
						{
							timeleft=Integer.parseInt(tleft);
%>
<script language="javascript">
	parent.totaltime=<%=tleft%>;
</script>

<%
						}
						try
						{
							if(isQuestionTimer>1)
							{
								if((tleft!=null)&&(timeleft!=0)&&(!tleft.equals("undefined")))
								{
										stmt2.executeUpdate("Update ExamStatus SET TimeLeft="+timeleft+" WHERE CandidateID="+CandidateID);
								}
							}
						}catch(Exception e)
						{
							out.println("ExamStatus update failed "+e.getMessage());
						}

						//pad = Previous available data
						ResultSet rspad = null;
						try
						{
							rspad = stat.executeQuery("Select QuestionID,ansg,timetaken,BookMark from "+st+" where SequenceNo=1");
						}
						catch( SQLException e)
						{
							out.println("Exception  :"+e.getMessage());
						}

						while(rspad.next())
						{
							tques = rspad.getInt("QuestionID");
							BookMark = rspad.getInt("BookMark");
							pan = String.valueOf(rspad.getInt("ansg"));
							pat = rspad.getInt("timetaken");
							//out.println("Answer"+pan);
						}



						//session.putValue("GBM","ON");
						session.putValue("NoOfRemainingQuestions",NoOfRemainingQuestions);
						session.putValue("teststatus","old");
						session.putValue("start","start");
					}
					else//else of if(count==1)
            		{

						session.putValue("NoOfRemainingQuestions",NoOfRemainingQuestions);
						pqid="0";
						if(request.getParameter("id")!=null)
						pqid=request.getParameter("id");
						if((pqid.equals("undefined"))||(pqid==null)) {System.out.print("pqid undefinned");}
						if(!pqid.equals(null)){pqidi=Integer.parseInt(pqid);}
						count = pqidi +1;
						if(request.getParameter("chkans")!=null)
						ansgiveni=Integer.parseInt(request.getParameter("chkans"));
						if(request.getParameter("questimer")!=null)
						{ttakeni=Integer.parseInt(request.getParameter("questimer"));}
						String st="temp_"+stname;
						int seq = 1;
						int updated=0;


						updated=0;
						//out.println("updated="+updated);
						Statement s10 = con.createStatement();
						ResultSet rs10 = null;
						int lastq = 0;
						try
						{
							rs10 = s10.executeQuery("Select QuestionID from "+st+" where SequenceNo="+count);

						}
						catch (SQLException e)
						{
							out.println("E caught " +e.getMessage());
						}

						while (rs10.next())
						tques =rs10.getInt("QuestionID");

						if(pqidi!=lastq)
						{
							String Update_Cand_Temp="Update "+st+" SET  ansg="+ansgiveni+",timetaken="+ttakeni+" WHERE SequenceNo="+pqidi;
							int chk=0;
							Statement stupdate = con.createStatement();
							try
							{
								chk=stupdate.executeUpdate(Update_Cand_Temp);
							}catch(Exception e)
							{
								out.println(Update_Cand_Temp+ " : " +e.getMessage());
							}

							tleft = request.getParameter("timeleft");
							session.putValue("TimeLeft",""+tleft);
							if((tleft!=null)&&(!tleft.equals("undefined")))
							{
								timeleft=Integer.parseInt(tleft);
							}
%>
<script language="javascript">
	parent.totaltime=<%=timeleft%>;
</script>
<%
							try
							{
								if(isQuestionTimer>1)
								{								if((tleft!=null)&&(timeleft!=0)&&(!tleft.equals("undefined")))
								{
									stmt.executeUpdate("Update ExamStatus SET TimeLeft="+timeleft+" WHERE CandidateID="+CandidateID);
								}
								}
							}catch(Exception e)
							{
								out.println("ExamStatus update failed "+e.getMessage());
							}

						}// If last q

						//pad = Previous available data
						ResultSet rspad = null;
						try
						{
							rspad = stat.executeQuery("Select ansg,timetaken,BookMark from "+st+" where SequenceNo="+count);
						}
						catch( SQLException e)
						{
							out.println("Exception  :"+e.getMessage());
						}

						while(rspad.next())
						{
							pan = String.valueOf(rspad.getInt("ansg"));
							pat = rspad.getInt("timetaken");
							BookMark = rspad.getInt("BookMark");
						}

						session.putValue("start","start");

					}//end of else of if(all==null)

				ResultSet rs=null;
				//System.out.println("quesgenerated"+tques);
				try
				{
					rs = stmt.executeQuery("Select * from QuestionMaster where QuestionID="+tques+" AND ExamID="+ExamID);

				}catch (SQLException e)
				{out.println(" Couldn't access Question  :"+e.getMessage());}

				while(rs.next())
				{
						 String id,ques,a1,a2,a3,a4,a5,ans,imagename,sCodeID;
						 int image=0;
						 id=ques=a1=a2=a3=a4=ans=imagename=sCodeID=a5="";
						 id = rs.getString("QuestionID");
						 ques   = checker.setString(rs.getString("Question"));
				         a1	  = checker.setString(rs.getString("Option1"));
						 a2      = checker.setString(rs.getString("Option2"));
						 a3      = checker.setString(rs.getString("Option3"));
						 a4      = checker.setString(rs.getString("Option4"));
						 a5      = checker.setString(rs.getString("Option5"));
						 ans     = checker.setString(rs.getString("Answer"));

						 //out.println("Answer"+ans);

						 sCodeID = rs.getString("CodeID");
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
												//System.out.println("In Images");
												while(rsimg.next())
														{
															imagename=rsimg.getString("Image");

														 }
											 }//if(rsimg)

							 }//if(image)

	int nop=2;
%>

<table border="0" cellspacing="1" cellpadding="1" width="80%" align=center>
	<tr>
		<th width="15%" align="right"><b>Question No.</b></th>
		<th align="left">
			<table border=0 cellspacing=0 cellpadding=0 width='100%'>
			<tr>
				<th><%=count%></th>
				<th align='right'>
				<div align="right">
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
		<td><input type=checkbox name="r"  value=1 <%if(pan.indexOf("1")!=-1) out.println("checked");%> onclick="return setval()"><%=a1%></td>
	</tr>
	<tr>
		<td align="center">(B)</td>
		<td><input type=checkbox name="r"  value=2  <%if(pan.indexOf("2")!=-1) out.println("checked");%> onclick="return setval()"><%=a2%></td>
	</tr>
<%
	if((a3!=null)&&(!a3.equals(""))&&(!a3.equals("NoOption"))&&(!a3.equals("no options")))
	{	++nop;
%>
	<tr>
		<td align="center">(C)</td>
		<td><input type=checkbox name="r"  value=3  <%if(pan.indexOf("3")!=-1) out.println("checked");%> onclick="return setval()"><%=a3%></td>
	</tr>
<%
	}
	if((a4!=null)&&(!a4.equals(""))&&(!a4.equals("NoOption"))&&(!a4.equals("no options")))
	{	++nop;
%>
	<tr>
		<td align="center">(D)</td>
		<td><input type=checkbox name="r"  value=4  <%if(pan.indexOf("4")!=-1) out.println("checked");%> onclick="return setval()"><%=a4%></td>
	</tr>
<%
	}
	if((a5!=null)&&(!a5.equals(""))&&(!a5.equals("NoOption"))&&(!a5.equals("no options")))
	{	++nop;
%>
	<tr>
		<td align="center">(E)</td>
		<td><input type=checkbox name="r"  value=5  <%if(pan.indexOf("5")!=-1) out.println("checked");%> onclick="return setval()"><%=a5%></td>
	</tr>
<%
	}

	out.println("<input type=hidden name=nop value="+nop+">");

	if(image!=0)
	{
%>
<div align=center>
<img src="../simages/<%=imagename%>"  BORDER=0 ALT="">
</div>
<%	}

	if(count<A.getTotalTempCount(stemp,con))
	{
 %>
<tr>
	<th colspan=2>
	<input type="submit" value="Next Question" border=0 onClick="return showval()">
	</th>
</tr>
	<br><br>
<%
}

	out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"all\" value=\"all\">");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
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
		   //out.println(sqle.getMessage());
		 }

      catch (Exception e)
		 {
		   //out.println(e.getMessage());
		 }
		 finally{

					if(con!=null) pool.releaseConnection(con);
					else out.println("Connection Lost");
				 }//end of finally
    }//end of 1st if

  }//emd of exam mode check

  %>
  </form>
<%

	out.println("<form name=Newmain3 action=NewTestMain.jsp method=get>");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"bookmark\" value="+BookMark+">");
	out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"addqtime\" value="+pat+">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
	out.println("<input type=\"hidden\" name=\"return\" value=\"1\">");
	out.println("<tr><th colspan=2><input type=submit value=\"Go Back To Test\"  onClick=\"return  showval()\"></th></tr>");
	out.println("</form>");

	out.println("<form name=\"NewTestMain2\" action=NewVerifyAnswers.jsp method=get>");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
	out.println("</form>");
%>
</table>
</body>
</html>


