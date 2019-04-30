
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<html>
<head>
<title>Zed C A Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
</head>

<script language="javascript">



/**
* This function is used for checking whether the test
* has been selected or not.If not the function gives
* an error message asking user to select a test.
*/

function checkselect()
{
var totalb = document.NewBeginTest.total.value;
var flag=0;

if(totalb>1)
{
for(var i=0;i<totalb;++i)
	{
		var p = "document.NewBeginTest.rtest"+ "[" + i + "]" ;
		if(eval(p).checked==false)	flag=0;
		if(eval(p).checked)			flag=1;
		if(flag==1)					break;

	}
}//end od if(totalb>1)
else
{
var p = "document.NewBeginTest.rtest";
if(eval(p).checked==false)	 flag=0;
if(eval(p).checked)			 flag=1;
}//end of else

if(flag==0) {alert('Please select the test');return false;}
if(flag==1) document.NewBeginTest.submit();

}

function checkselect2()
{
var totalb = document.NewBeginTest.tsections.value;
var flag=0;

if(totalb>1)
{
for(var i=0;i<totalb;++i)
	{
		var p = "document.NewBeginTest.rtestname"+ "[" + i + "]" ;
		if(eval(p).checked==false)	flag=0;
		if(eval(p).checked)			flag=1;
		if(flag==1)					break;

	}
}//end od if(totalb>1)
else
{
var p = "document.NewBeginTest.rtestname";
if(eval(p).checked==false)	 flag=0;
if(eval(p).checked)			 flag=1;
}//end of else

if(flag==0) {alert('Please select the Option');return false;}
if(flag==1) {document.NewBeginTest.submit();return false;}

}
</script>

<body onLoad="MM_preloadImages( '../simages/submit1.gif', '../simages/submit2.gif' )"  >
<form name="NewBeginTest" action="Forward.jsp" method="GET">

<%@ page language="java" import="java.sql.*"  session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>


<%

//----------	INITIALIZATION OF VARIABLES	----------//

String UserType = (String) session.getValue("TypeOfUser");
Integer CID		= (Integer)session.getValue("CandidateID");
String ITC		= (String) session.getValue("isTableCreated");
String start	= "start"; session.putValue("start",start);
String test		= "false"; session.putValue("testover", test);
boolean flag	= false;   int isTableCreated=0;
String Name		= (String) session.getValue("Name");
//String c1		= request.getParameter("cid");

//----------  For Lanserver,Change this
String c1 = (String)session.getValue("username");
//System.out.println("NewBeginTest:Start	username:"+c1);
//session.putValue("NoOfSections","1");
if (c1 == null || c1.equals(null) || c1=="")
response.sendRedirect("SessionExpiry.jsp");

Connection con	= null;
//ServletContext context = getServletContext();
//context.setAttribute("ConPoolbse",pool);
int CandidateID,TypeOfUser,ExamID,CreateTable,BreaksTaken,SectionID,Status,ResumeQuest;
CandidateID=TypeOfUser=ExamID=CreateTable=BreaksTaken=SectionID=Status=ResumeQuest=0;
ResultSet rs,rs2,r,Cdetails,rsemid,rs3;
rs=rs2=r=Cdetails=rsemid=rs3=null;
String b="";int CodeGroupID=0;
int sect =	0;

boolean registered=false;int ind=0;
ServletContext context = getServletContext();
pool =(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");


//----------Loading the driver and creating the connection object----------//
try
{
con = pool.getConnection();

if(con!=null)
{
//----------Creating the statement object for executing querry
Statement stmt = con.createStatement();
Statement stmt2= con.createStatement();

if((UserType!=null)||(UserType!=""))	TypeOfUser = Integer.parseInt(UserType);
if(CID!=null)CandidateID= CID.intValue();
if((ITC!=null)||(ITC!=""))isTableCreated = Integer.parseInt(ITC);

//out.println("isTable  :"+isTableCreated);

session.putValue("SectionStatus","OFF");
session.putValue("TestAttemptNo",new Integer(1));
session.putValue("AttemptNoStatus","OFF");
session.putValue("BookMarkSet","0");

//System.out.println("NewBeginTest:table create	isTableCreated:"+isTableCreated);
if(isTableCreated==0)
{
String c= "temp_"+c1;
String crt="CREATE TABLE "+c+"(SequenceNo INT(2),QuestionID INT(7), ansg VARCHAR(5), correct_ans VARCHAR(5),timetaken INT,CodeGroupID INT(8),CodeID Varchar(8),BookMark INT(1), UNIQUE (SequenceNo))";
String up="UPDATE CandidateMaster SET isTableCreated=1 WHERE Username=\'"+c1+"\'";
session.putValue("isTableCreated","1");

/// Setting Bookmark


try
{
	stmt.executeUpdate(crt);
}
 catch(Exception e)
  {
	  out.println("up2 :"+e.getMessage());
  }
try
{
	stmt.executeUpdate(up);
}
	catch(Exception e)
	{
		out.println("up3 :"+e.getMessage());
	}
}//end of isTableCreated==0

try
{
  rs2=stmt.executeQuery("SELECT * from ExamStatus where CandidateID="+CandidateID+" AND SectionStart=1");
}
catch (SQLException e)
{
	out.println("2 :"+e.getMessage());
}

if(rs2.next())
{
    //System.out.println("NewBeginTest:rs2.next() :");
	ind=1;
	//rs2.beforeFirst();
	//rs2.next();	
	String time	= "";
	time			= rs2.getString("TimeLeft");
	CodeGroupID		= rs2.getInt("CodeGroupID");
	ExamID			= rs2.getInt("ExamID");
	BreaksTaken		= rs2.getInt("BreaksTaken");
	SectionID		= rs2.getInt("SectionID");
	//SectionID		= rs2.getInt("SectionID");
	//Status		= rs2.getInt("SectionOver");
	session.putValue("SectionID",new Integer(SectionID));
	Integer BrTaken = new Integer(BreaksTaken);
	out.print("<input type=hidden name=CodeGroupID value="+CodeGroupID+ "> ");
	out.print("<input type=hidden name=ExamID value="+ExamID+ "> ");
	out.print("<input type=hidden name=rtest value="+ExamID+ "> ");
	session.putValue("TimeLeft",time);
	session.putValue("BreaksTaken",BrTaken);

}

if(ind==0)
	{
		try
			{
				rs3	= stmt2.executeQuery("Select ExamStatus.CodeGroupID,ExamStatus.ExamID,ExamStatus.SectionID,NewExamDetails.SectionName from ExamStatus,NewExamDetails where ExamStatus.CandidateID="+CandidateID+" AND  ExamStatus.SectionStart=0 AND  ExamStatus.CodeGroupID=NewExamDetails.CodeGroupID AND  ExamStatus.SectionID=NewExamDetails.SectionID  AND ExamStatus.ExamID=NewExamDetails.ExamID");
			}
			catch (SQLException e)
			{
				out.println("SQL Exception caught ");
			}

		if(rs3.next())
			{

				//System.out.println("NewBeginTest:rs3.next() :");
				//rs3.beforeFirst();

				String time	= "";
				ExamID = rs3.getInt("ExamID");
				sect =1;
				int n=0;
                out.println("ExamId"+ExamID);
                //System.out.println("NewBeginTest:rs3.next() ExamId:"+ ExamID);
				out.println("Hello "+Name+",Your previous test was incomplete .Select next section to complete your test<br><br>");
				out.println("<table  width=\"480\" height=\"25\">");
				while(rs3.next())
				{

					CodeGroupID		= rs3.getInt("CodeGroupID");
					ExamID			= rs3.getInt("ExamID");
					SectionID		= rs3.getInt("SectionID");
					out.println("<tr><td align=\"left\" valign=\"top\">");
					out.println("<input type=radio name=\"rtestname\" value=\""+CodeGroupID+"\"</td>"+rs3.getString("SectionName"));
					out.println("</tr></td>");
					++n;
					//System.out.println("NewBeginTest:rs3.next() ExamId:"+ExamID+" "+CodeGroupID+" "+SectionID);
				}
				out.println("</table>");
				out.println("<input type=hidden name=tsections value="+n+"> ");
				out.println("<input type=hidden name=ExamID value="+ExamID+ "> ");
				out.println("<input type=hidden name=rtest value="+ExamID+ "> ");
				out.println("<input type=hidden name=st value=1>");
				out.println("<input type=hidden name=CodeGroupID value="+CodeGroupID+"> ");
				out.println("<input type=hidden name=SectionID value="+SectionID+ ">");
				//out.println("<input type=hidden name=lastsection value=1>");
				session.putValue("SectionStatus","OFF");
				session.putValue("teststatus","new");
				String nsec1 = ""+n;
				session.putValue("NoOfSections",nsec1);
				session.putValue("BreaksTaken",new Integer(0));
				session.putValue("NoOfRemainingQuestions",new Integer(0));
				//System.out.println("NewBeginTest:rs3.next() Exit");

		}
	}// if ind=0
if(ind==1)
{
    //System.out.println("NewBeginTest:if(ind==1)");
	String a	 = "old"; session.putValue("teststatus",a);
	String ctemp = "temp_"+c1;
	try
		{
			  r	= stmt.executeQuery("select * from "+ctemp);
		}
		catch (SQLException e)
		{
			out.println("3 :"+e.getMessage());
		}
	int num=0;
	if(r!=null)
		{
			while(r.next())
			{
				num++;
				ResumeQuest = r.getInt("QuestionID");
				if(r.getInt("BookMark")==1) session.putValue("BookMarkSet","1");
			}
		}

	ResultSet r1 = null;
	session.putValue("ResumeQuest",new Integer(ResumeQuest));

    //System.out.println("NewBeginTest:before eexecute query for NewExamDetails");
	try
	{
		r1 = stmt.executeQuery("Select COUNT(*) FROM NewExamDetails where ExamID="+ExamID+" AND SectionID="+SectionID);
	}
	catch(SQLException sqe)	{out.println("SQL EXCEPTION CAUGHT " +sqe.getMessage());}
	 //System.out.println("NewBeginTest:after eexecute query for NewExamDetails");
	
	
	Integer NoOfRemainingQuestions=new Integer(num);
	session.putValue("NoOfRemainingQuestions",NoOfRemainingQuestions);
	String nsec ="1";
	while(r1.next())	nsec = r1.getString(1);

	session.putValue("NoOfSections",nsec);

	//----------Session set for the no. of options
	//----------answersheet in case of old test

	out.println("<P>&nbsp;</P>");
	out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1' ALIGN='CENTER'>");
	out.println("<TR><TH>Incomplete Test</TH></TR>");

	out.println("<TR><TD><BR>Hello "+Name+",<BR>You have not completed your test. Complete your test.<BR><BR></TD></TR>");

}
else if((ind==0)&&(sect==0))
	{

		 b="new";
		 session.putValue("teststatus",b);
		 Integer opt=new Integer(0);
		 session.putValue("NoOfRemainingQuestions",opt);
		 Integer BrTaken = new Integer(0);
		 session.putValue("BreaksTaken",BrTaken);

		 session.putValue("ResumeQuest",new Integer(ResumeQuest));

		 //----------Session set for the no. of
		 //----------options for answersheet in case of old test

		 int testids[]=new int[30];
		 try
		    {
				Cdetails = stmt.executeQuery("Select * from CandidateDetails WHERE CandidateID="+CandidateID);
			}
			catch (SQLException e)
			{
				out.println("4 :"+e.getMessage());
			}
		 if(Cdetails!=null)
				    {
						int i=0;
						while(Cdetails.next())
								{
									++i;
									testids[i]=Cdetails.getInt("ExamID");
									registered=true;
								}
						String[] arr	= new String[i];
						int DisplayTest[]= new int[i];
						for(int k=1;k<=i;++k)
								{
									try
										{
											rsemid = stmt.executeQuery("Select * from ExamMaster WHERE ExamID="+testids[k]);
										}
										catch (SQLException e)
										{
										   out.println("5 :"+e.getMessage());
								  		}
									while(rsemid.next())
											{
												//rsemid.next();
												arr[k-1]=rsemid.getString("Exam");
												DisplayTest[k-1]=rsemid.getInt("DisplayTests");
											}
									}//end of for
								if(registered)
										{
											out.println("<P>&nbsp;</P>");
											out.println("<table border=0 cellspacing=1 cellpadding=0 align=\"center\"><tr><th  bgcolor=#330099>Hello "+Name+"<BR>Welcome to the Nectar Examination.<BR>Click on the Submit button below to proceed further.</th></tr>");
											out.println("<tr><td><BR>");
											//out.print("Select Test : <br><br>");
											out.println("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" align='center'>");
%>
											<input type=hidden name="total" value=<%=i%> >
<%
											for(int j=1;j<=i;++j)
												{
												    String testdesc = "I certify that all the information supplied to the Nectar Global Edutech Pvt Ltd (NGEPL) is complete "+
												    "and correct to the best of my knowledge and belief. I understand that the <b><font color='red'>"+arr[j-1]+"</font></b> examination for which I am applying is voluntary"+
												    " on my part and I voluntarily accept and agree without reservation to the conditions set forth in the Examination Candidate Guide."; 
													out.println("<tr>        <td><input type=\"radio\" name=\"rtest\" value="+testids[j]+" >"+testdesc+"</td></tr>");
													out.println("<input type=\"hidden\" name=dt"+testids[j]+" value="+DisplayTest[j-1]+">");
												}
												out.println("</table><BR>");
												//out.println("</tr>  <tr> <th align=\"center\">   </th></tr></table>");
										}
					}//end of if(Cdetails)
			}//end of elseofif(ind==1)

if(b.equals("new"))
{
if(registered)	out.println("</tr><tr> <th align=\"center\"><input type=button value=\" I Agree  \" onClick=\"return checkselect()\"></th></tr></table>");
//<input type=\"image\" src=\"../simages/submit1.gif\" name=\"Image1\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver = \"MM_swapImage('Image1','','../simages/submit2.gif',1)\" border=0 onClick=\"return checkselect()\">
else
{
out.println("<TABLE BORDER='0' CELLSPACING='1' CELLPADDING='1'>");
out.println("<TR><TH>Exam Status</TH></TR>");
out.println("<TR><TD><P>You haven't registered for any test.</P>Please, contact your examiner for more details.<BR><BR></TD></TR>");
out.println("<INPUT TYPE='BUTTON' VALUE='Close' OnClick='javascript:window.close()'>");
out.println("</TABLE>");
}
}else
{

out.println("<TR><TH><input type=Submit value=\" Resume Test \" ></TH></TR>");
out.println("</TABLE>");

/*
if(sect==0)	out.println("<input type=\"image\" src=\"../simages/submit1.gif\" name=\"Image1\" onMouseOut=\"MM_swapImgRestore()\" border=0 onMouseOver = \"MM_swapImage('Image1','','../simages/submit2.gif',1)\">");
else if(sect==1) out.println("<br><br><br><input type=\"image\" src=\"../simages/submit1.gif\" name=\"Image1\" border=0 onMouseOut=\"MM_swapImgRestore()\" onMouseOver = \"MM_swapImage('Image1','','../simages/submit2.gif',1)\" onClick=\"return checkselect2()\">");
*/
//out.println("<input type=Submit value=\"Submit\" >");
}

}//end of if(con!=null)
}//end of try
catch(SQLException sqle)
{
out.println("SQL EXCEPTION CAUGHT  " +sqle.getMessage());
}
catch(Exception e)
{
out.println("GENERAL EXCEPTION CAUGHT "+e.getMessage());
}
finally
{
//Release the connection
if(con!=null)  pool.releaseConnection(con);
else out.println("Connection not obtained");
}
%>

</form>
</body>
</html>
