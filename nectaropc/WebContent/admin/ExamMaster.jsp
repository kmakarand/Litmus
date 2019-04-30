<%@ page language = "java" import = "java.sql.*,java.util.Enumeration" session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/> 

<HTML>
<TITLE>Exam </TITLE>
<HEAD>
<style>td{font-family:arial;font-size:10pt;} body{font-family:arial;font-size:11pt;} b{font-family:arial;font-size:11pt;}</style>
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT> 
</HEAD>
<script language="javascript" src='validateexammasterold.js'></script>

<BODY bgcolor='#FEF9E2' onLoad="MM_preloadImages('../jsp/simages/modify2.gif', '../jsp/simages/delete2.gif', '../jsp/simages/save2.gif', '../jsp/simages/cancel2.gif', '../jsp/simages/reset2.gif')" >
<%
	Connection conn = null;
	int count=0;
	
	
	ServletContext context   =   getServletContext(); 
	pool    =    (com.ngs.gbl.ConnectionPool)  getServletContext().getAttribute("ConPoolbse"); 
	
	String action=request.getParameter("action");
	String username = (String)session.getValue("username");
	if (username == null || username.equals(null) || username=="")
	{
		response.sendRedirect("/zalm/jsp/SessionExpiry.jsp");
	}
	else if (action == "" || action == null )
	{
		try
		{
			out.println("<H4><font color=#996633>Exam  Selection</font></H4><HR SIZE=1>");
			conn = pool.getConnection(); 
//out.println("conn " + conn);

			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="SELECT * FROM ExamMaster order by Exam" ;

			rs=stmt.executeQuery(sql);
%>
			<center>
			<form method=get>
			
				<table>
					<tr>
						<td>Select Exam for Datails:</td>
						<td><select name=examid>
<%			
						while(rs.next())
						{
%>
						<option value=<%= rs.getInt("ExamID")%>><%= rs.getString("Exam")%></option>	
<%
						}
%>
						</select></td>
					</tr>
				</table>
				<input type=image src="../jsp/simages/showdetails2.gif"  name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/showdetails1.gif',1)" border=0>
				<input type=hidden name=action value='doExamDetails'>
			</form>
			<form>

				<input type=image src="../jsp/simages/newexam2.gif"  name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/newexam1.gif',1)" border=0>				
				<input type=hidden name=action value='doNewExam'>
			</form>

<%			
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doNewExam"))
	{
		out.println("<center>");
		try
		{
			conn = pool.getConnection(); 
	
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			String sql="select count(*) from ExamMaster ";
			rs = stmt.executeQuery(sql);
			int examid=0;
			int totrecords=0;
			if (rs.next())
			{
				totrecords = Integer.parseInt(rs.getString(1));
			}
			
			sql = "select * from ExamMaster order by ExamID";
			rs= stmt.executeQuery(sql);
			int a=0;
			while(rs.next())
			{
				a= rs.getInt("ExamID");
			}
			
			if (totrecords==0){	examid =1;	}
			else 
			{
				examid= a + 1;
			}
			
			String [] month = new String[12];
			month[0]="Jan";month[1]="Feb";month[2]="Mar";month[3]="April";month[4]="May";
			month[5]="Jun";month[6]="Jul";month[7]="Aug";month[8]="Sep";month[9]="Oct";
			month[10]="Nov";month[11]="Dec";

%>			

<!--		<FORM method=POST name=frmmaster onSubmit='return checkNumber(); return notNull();'>-->
			<center>
			<FORM method=POST name=frmmaster action=<%=request.getRequestURI()%>>
			<h4><center><font color=#996633>Enter Exam Master </font></center></h4><hr>
			<table border=0 bgcolor='#FEEEC8'>
			<tr>
				<td><font color='#960317'>Exam Id : </font></td>
				<td><%=examid%></td>
			</tr>
			<tr>
				<td><font color='#960317'>Exam Name : <font color='#FF0000'>*</font></font></td>
				<td><INPUT TYPE=TEXT name=examname SIZE=20></td>
			</tr>
			
			<tr>
				<td><font color='#960317'>Exam Mode : </font></td>
				<td><select name=exammode>
						<option value=0 selected>Random</option>
						<option value=1>Sequencial</option>
					</select>
			</tr>
			<tr>
				<td><font color='#960317'>Start Date :</font></td>
				<td><select name=stdate>

<%
					String num="";
					for (int i=1;i<32;i++)
					{
						if(i<10)
						{
							num="0"+i;
%>			
							<option value=<%=num%>><%=i%></option>
<%
						}
						else
						{
%>
							<option value=<%=i%>><%=i%></option>
<%
						}
					}
%>
					</select>
				<select name=stmonth>
<%
					for (int b=0;b<month.length;b++)
					{
						if((b+1)<10)
						{
							num="0"+(b+1);
%>			
							<option value=<%=num%>><%=month[b]%></option>
<%
						}
						else
						{
%>
							<option value=<%=b+1%>><%=month[b]%></option>
<%
						}	//else
					}
%>

					</select>
			
				<select name=styear>
<%
					for(int e=2014;e<2020;e++)
					{
%>
						<option value=<%= e%>><%=e%></option>
<%
					}
%>
					</select></td>
			</tr>
			
			<tr>
				<td>
					<font color='#960317'>End Date : </font> </td>
					<td><select name=eddate>
<%
						for(int i=1;i<32;i++)
						{
						if(i<10)
						{
							num="0"+i;
%>			
							<option value=<%=num%>><%=i%></option>
<%
						}
						else
						{
%>
							<option value=<%=i%>><%=i%></option>
<%
						}

						}
%>
						</select>
			
					<select name=edmonth>
<%
					for (int b=0;b<month.length;b++)
					{
						if((b+1)<10)
						{
							num="0"+(b+1);
%>			
							<option value=<%=num%>><%=month[b]%></option>
<%
						}
						else
						{
%>
							<option value=<%=b+1%>><%=month[b]%></option>
<%
						}	//else
					}
%>

						</select>
			
				<select name=edyear>
<%
					for(int d=2014;d<=2020;d++)
					{
%>
						<option value=<%= d%>><%= d%></option>
<%
					}
%>
				</select></td>
		
			
			<tr>
				<td>
					<font color='#960317'>Conducted By :<font color='#FF0000'>*</font></font></td>
				<td>
					<INPUT TYPE=TEXT name=conductedby SIZE=20></td>
			</tr>
			
			<tr>
				<td><font color='#960317'>Center : <font color='#FF0000'>*</font></font> </td>
				<td><INPUT TYPE=TEXT name=centre SIZE=20></td>
			</tr>
			
			<tr>
				<td><font color='#960317'>Country : <font color='#FF0000'>*</font></font> </td>
				<td><INPUT TYPE=TEXT name=country SIZE=20></td>
			<tr>
			<tr>
				<td><font color='#960317'>Frequency : <font color='#FF0000'>*</font></font></td>
				<td><INPUT TYPE=TEXT name=frequency SIZE=5></td>
			</tr>
			<tr>
				<td><font color='#960317'>Display Results after Test : </font></td>
				<td><select name=showresults><option value=1>Yes</option><option value=0>NO</option></td>
			</tr>
			<tr>
				<td><font color='#960317'>Display Selection of the Test to the Candidate: </font></td>
				<td><select name=displaytests><option value=1>Yes</option><option selected value=0>NO</option></td>
			</tr>
			
	</TABLE>


			<br><INPUT TYPE='image' src="../jsp/simages/save1.gif"  name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/save2.gif',1)" border=0 onclick='return checkNumber();'>
			<input type=image src="../jsp/simages/reset1.gif"  name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/reset2.gif',1)" border=0 OnClick="javascript:return ResetForm('frmmaster');">
			<INPUT TYPE='image' src="../jsp/simages/cancel1.gif"  name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
			<INPUT TYPE=HIDDEN  name=examid value=<%= examid %>>
			<INPUT TYPE=HIDDEN  name=action value='doInsert'>
			</FORM>
<%		
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		} 
	}
////////////////////////////////////////////////////////////////////////////////////////////
// doInsert
	else if (action.equals("doInsert"))
	{
		out.println("<h4><font color=#996633>Exam Master Contents </font><h4><hr size=1>");
		try
		{
			conn = pool.getConnection(); 
	
			Statement stmt,stmt1 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1=conn.createStatement();
			String sql="";
			int examid=Integer.parseInt(request.getParameter("examid"));
			String examname=request.getParameter("examname");
			int exammode=Integer.parseInt(request.getParameter("exammode"));
			int styear=Integer.parseInt(request.getParameter("styear"));
			String stmonth = request.getParameter("stmonth");
			int stdate = Integer.parseInt(request.getParameter("stdate"));
			String startdate=styear+"-"+stmonth+"-"+stdate;
			int edyear=Integer.parseInt(request.getParameter("edyear"));
			String edmonth = request.getParameter("edmonth");
			int eddate = Integer.parseInt(request.getParameter("eddate"));
			String enddate=edyear+"-"+edmonth+"-"+eddate;
			String conductedby=request.getParameter("conductedby");
			String centre=request.getParameter("centre");
			String country=request.getParameter("country");
			int frequency=Integer.parseInt(request.getParameter("frequency"));
			int showresults=Integer.parseInt(request.getParameter("showresults"));
			int displaytests=Integer.parseInt(request.getParameter("displaytests"));

			sql="INSERT INTO ExamMaster (ExamID,Exam,ExamMode,StartDate,EndDate,ConductedBy,Centre,Country,Frequency,ShowResults,DisplayTests) values(" + examid + ",'" + examname + "'," + exammode + ",'" + startdate + "','" + enddate + "','" +conductedby + "','" + centre + "','" + country + "'," + frequency +"," +showresults +"," +displaytests + ") ";

//out.println(sql);
			int records = stmt.executeUpdate(sql);
						
			sql = "SELECT * FROM ExamMaster where ExamID = " + examid;
			rs=stmt.executeQuery(sql);
%>
			<form method=get>
			<TABLE width='100%' bgcolor='#FEEEC8'> 
			<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </TD></font><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD><TD><font color='#960317'>Show Results</font></TD><TD><font color='#960317'>Display Test</font></TD></TR>
<%			
			while(rs.next())
			{
				out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD><TD>"+ rs.getInt("ShowResults")+"</TD><TD>"+ rs.getInt("DisplayTests")+"</TD><TD><a href='ExamMaster.jsp?action=doMasterModify&examid="+ rs.getInt("ExamID")+"'><img src='../jsp/simages/modify1.gif' name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image1','','../jsp/simages/modify2.gif',1)\" border=0></a></TD> <TD><a href='ExamMaster.jsp?action=doDeleteMaster&examid="+ rs.getInt("ExamID")+"'><img src='../jsp/simages/delete1.gif' name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image4','','../jsp/simages/delete2.gif',1)\" border=0></a></TD></TR>");
			
//				"<a href='ExamMaster.jsp?action=doMasterModify&examid="+ rs.getInt("ExamID")+"'><font color='#6699FF'>Modify</font></a></TD><TD><font color='#6699FF'><a href='ExamMaster.jsp?action=doDeleteMaster&examid="+ rs.getInt("ExamID")+"'>Delete</a></font></TD>"
			}
%>
			</TABLE>
			<center>
<!--			<input type=submit value='insert in Exam Details'> -->
			<input type=hidden name=action value='doExamDetailsInsert'>
			<input type=hidden name=examid value=<%=examid%>>
			
			<input type=image src="../jsp/simages/entertestdetails.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/entertestdetails2.gif',1)" border=0 >
				

				<form>
				</form>
				<form method=post action='CodeMaster.jsp?action=doMenu&examid=<%=examid%>'>
				<input type=image src="../jsp/simages/entersubdetails1.gif" name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/entersubdetails2.gif',1)" border=0 >
				</form>

			
<%
			

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doExamDetails"))
	{
		try
		{
			out.println("<h4><font color=#996633>Exam Details  </font></h4>");
			int examid=Integer.parseInt(request.getParameter("examid"));
//out.println("id " + examid);
			conn = pool.getConnection(); 
			Statement stmt,stmt1 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			String examname="";
			String sql = "SELECT * FROM ExamMaster where ExamID = " + examid;
			rs=stmt.executeQuery(sql);
%>
			<form method=get action=<%=request.getRequestURI()%>>
			<center>
				<TABLE width='100%' bgcolor='#FEEEC8'> 
					<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </TD></font><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD><TD><font color='#960317'>Show Results </font></TD><TD><font color='#960317'>Display Test</font></TD></TR>
<%
			
					while(rs.next())
					{
						out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ 	rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD><TD>"+ rs.getInt("ShowResults")+"</TD><TD>"+ rs.getInt("DisplayTests")+"</TD><TD><a href='ExamMaster.jsp?action=doMasterModify&examid="+ rs.getInt("ExamID")+"'><img src='../jsp/simages/modify1.gif' name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image1','','../jsp/simages/modify2.gif',1)\" border=0></a></TD> <TD><a href='ExamMaster.jsp?action=doDeleteMaster&examid="+ rs.getInt("ExamID")+"'><img src='../jsp/simages/delete1.gif' name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image4','','../jsp/simages/delete2.gif',1)\" border=0></a></TD></TR>");
						examname=rs.getString("Exam");

					}
				out.println("</table><hr size=1>");
				sql = "SELECT * FROM NewExamDetails where ExamID = " + examid;
				rs=stmt.executeQuery(sql);
				if(rs.next())
				{
					sql = "SELECT * FROM NewExamDetails where ExamID = " + examid;
//					rs=stmt.executeQuery(sql);
%>			
					
					<TABLE width='100%' bgcolor='#FEEEC8'> 
					<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Group ID</TD></font><TD><font color='#960317'>Test Name</font></TD><TD><font color='#960317'># of Questions</font></TD><TD><font color='#960317'>Timer per Question </font></TD><TD><font color='#960317'>Response Time per Question (sec)</font></TD><TD><font color='#960317'># of Breaks Allowed</font></TD><TD><font color='#960317'>Interval Time (sec)</font></TD><TD><font color='#960317'>Passing Percent(%) </font></TD><TD><font color='#960317'>Total Time per Exam (hrs:min:sec) </font></TD><TD><font color='#960317'>Sequence Id </font></TD><TD><font color='#960317'>Negative Marks per Question</font></TD><TD><font color='#960317'># of Attempts Allowed </font></TD><TD><font color='#960317'>Prerequisite(Chapter/ Topic/ Module/Level) </font></TD><TD><font color='#960317'>Level of Difficulty  </font></TD><TD><font color='#960317'>Include Sub Levels? </font></TD></TR>
<%					
					int totseconds=0,time=0,minutes=0,hours=0,seconds=0;
					String showtime="";
					sql = "SELECT * FROM NewExamDetails where ExamID = " + examid;
					rs1=stmt1.executeQuery(sql);
					int d=5,s=100;
					while(rs1.next())
					{
						time=rs1.getInt("ExamTime");
						seconds =(int) Math.floor(time%60);
						time = (int)Math.floor(time/60);
						minutes =(int)Math.floor(time%60);
						time=(int)Math.floor(time/60);
						hours=(int)Math.floor(time%60);
						showtime=""+hours+":"+minutes+":"+seconds;
%>
						<tr bgcolor='#FFF5E7'><td><%=rs1.getInt("ExamID")%></td> <td><%=rs1.getInt("CodeGroupID")%></td> <td><%=rs1.getString("TestName")%></td> <td><%=rs1.getInt("NoOfQuestions")%></td> <td><%=rs1.getInt("TimerType")%></td> <td><%=rs1.getInt("ResponseTime")%></td> <td><%=rs1.getInt("NoOfBreaksAllowed")%></td> <td><%=rs1.getInt("BreakInterval")%></td> <td><%=rs1.getFloat("Criteria")%></td>
						<td><%=showtime%></td>
						<td><%=rs1.getInt("SequenceID")%></td> <td><%=rs1.getFloat("NegativeMarks")%></td> <td><%=rs1.getInt("NoOfAttemptsAllowed")%></td> <td><%=rs1.getInt("Prerequisite")%></td>
						<td><%=rs1.getInt("LevelID")%></td> <td><%=rs1.getInt("IncludeSubLevels")%></td>
						<td><a href='<%=request.getRequestURI()%>?action=doModifyDetails&examid=<%=examid%>&codegroupid=<%=rs1.getInt("CodeGroupID")%>'><img src='../jsp/simages/modify1.gif' name="Image<%=d%>" onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image<%=d%>','','../jsp/simages/modify2.gif',1)" border=0></a></td> 
						<td><a href='<%=request.getRequestURI()%>?action=doDetailsDelete&examid=<%=examid%>&codegroupid=<%=rs1.getInt("CodeGroupID")%>'><img src='../jsp/simages/delete1.gif' name='Image<%=s%>' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image<%=s%>','','../jsp/simages/delete2.gif',1)" border=0></a></td>
						<tr>
						
<%
						d++;s++;
					}
					out.println("</table>");					
				}
%>
				
				<form name=post action='<%=request.getRequestURI()%>'>
				
				<input type=hidden name=action value='doExamDetailsInsert'>
				<input type=hidden name=examid value=<%=examid%>>
				<input type=hidden name=examid value=<%=examname%>>
				<input type=image src="../jsp/simages/entertestdetails.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/entertestdetails2.gif',1)" border=0 >
				

				<form>
				</form>
				<form method=post action='CodeMaster.jsp?action=doMenu&examid=<%=examid%>'>
				<input type=image src="../jsp/simages/entersubdetails1.gif" name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/entersubdetails2.gif',1)" border=0 >
				</form>
<%			
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doExamDetailsInsert"))
	{
		try
		{
			out.println("<h4><font color=#996633>Exam Master Details Insert</font></h4>");
			out.println("<center>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			String examname="";
			//String examname=request.getParameter("examname");
//out.println("id " + examid);
			conn = pool.getConnection(); 
			Statement stmt,stmt1 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			int totrec=0;
			String name = null;
%>				
				<b>Exam Details</b>
			<form method=post name=frmdetinsert action=<%=request.getRequestURI()%> >
				<table bgcolor='#FEEEC8'>
				<tr bgcolor='#FFF5E7'><td>Exam Id :</td><td><%=examid%></td></tr>
			<!--	<tr bgcolor='#FFF5E7'><td>Exam Name :</td><td><%=examname%></td></tr> -->
				<tr bgcolor='#FFF5E7'><td valign="TOP">Select Subject(s)</td><td><select name=codegroupid size=5 multiple>
<%
				String sql="select * from CodeMaster where ExamID="+examid +" order by CodeID";
				rs=stmt.executeQuery(sql);

				String subname="",chapname="",topname="",subtopname="";
				String subcode="",chapcode="",topcode="",subtopcode="";

				while(rs.next())
				{
					String b=rs.getString("CodeID");
					String first=b.substring(0,2);
					int fr=Integer.parseInt(first);
					String second=b.substring(2,4);
					int scd=Integer.parseInt(second);
					String third=b.substring(4,6);
					int td=Integer.parseInt(third);
					String fourth=b.substring(6,8);
					int foth=Integer.parseInt(fourth);
						
					if (fr>0 && scd==0)
					{
						subname=rs.getString("Description");
						subcode=rs.getString("CodeID");
						name = subname;
					}
					if(scd>0 && td==0)
					{
						chapname=rs.getString("Description");
						chapcode=rs.getString("CodeID");
						name = subname+ " -> " +chapname;
					}
					if (td>0 && foth==0)
					{
						topname=rs.getString("Description");
						topcode=rs.getString("CodeID");
						name = subname+ " -> " +chapname+ " -> " +topname;
					}
					if (foth>0)
					{
						subtopname=rs.getString("Description");
						subcode=rs.getString("CodeID");
						name = subname+ " -> " +chapname+ " -> " +topname+ " -> " +subtopname;
					}
					out.print("<option value='"+ b + "'>" + name + "</option>");
				}
%>	
				</select></td></tr>
					<tr bgcolor='#FFF5E7'><td>Test Name :</td><td><input type=text 						name=testname></td></tr>
					<tr bgcolor='#FFF5E7'><td># of Questions  </td><td><input type=text name=noquest 	value=5> </td></tr>
					<tr bgcolor='#FFF5E7'><td>Timer per Question :</td><td><select name=timertype> 		<option	value=1>Yes</option><option value=0 selected>No</option></select></td></tr>
					<tr bgcolor='#FFF5E7'><td>Response Time per Question (sec) :</td><td><input 		type=text name=responsetime value=0></td></tr>
					<tr bgcolor='#FFF5E7'><td># of Breaks Allowed :</td><td><input type=text 			name=nobreaksallowed value=0></td></tr>
					<tr bgcolor='#FFF5E7'><td>Break Interval Time (sec) :</td><td><input type=text 			name=breakinterval value=0>	</td></tr>
					<tr bgcolor='#FFF5E7'><td>Passing Percent(%) : </td><td><input type=text 			name=criteria value='0.00'></td></tr>
					<tr bgcolor='#FFF5E7'><td>Total Time per Exam :</td><td>hours <input type=text name=hours value=0 size=5>min <input type=text name=min value=0 size=5></tr>
<%
					sql="select SequenceID from NewExamDetails where ExamID=" + examid;
					rs1=stmt.executeQuery(sql);	
					int sequenceid=0;
					while(rs1.next())
					{
						sequenceid=rs1.getInt("SequenceID");
					}
					sequenceid++;
%>
					<tr bgcolor='#FFF5E7'><td>Sequence Id  :</td><td><%=sequenceid%> </td></tr>
					<tr bgcolor='#FFF5E7'><td>Negative Marks per Question :</td><td><input type=text 	name=nemarks value='0.00'> </td></tr>
					<tr bgcolor='#FFF5E7'><td># of Attempts Allowed :</td><td><input type=text 			name=noattempts value=0></td></tr>
					<tr bgcolor='#FFF5E7'><td>Prerequisite(Chapter/ Topic/ Module/ 						Level):</td><td><select name=prerequisite size=3>
								<option value=0 selected>None</option>
<%
					sql="select * from NewExamDetails where ExamID=" + examid +" order by TestName";
					rs1=stmt.executeQuery(sql);
					while(rs1.next())
					{
						out.println("<option value="+rs1.getInt("CodeGroupID")+">"+rs1.getString("TestName")+"</option>");
					}

%>	
						</select></td></tr>
					<tr bgcolor='#FFF5E7'><td>Level of Difficulty :</td><td><SELECT name=levelid>
<%

					sql = "select * from LevelMaster";
					rs=stmt.executeQuery(sql);
					while(rs.next())
					{
						String lvl=rs.getString("Level");
						int lid = rs.getInt("LevelID");
%>
						<option value=<%=lid%>><%=lvl%></option>
<%
					}
%>
						</select></td></tr>
					<tr bgcolor='#FFF5E7'><td>Include Sub Levels? :</td><td><select name=includesublevels> <option 		value=1>Yes</option><option 				value=0>No</option></select></td></tr>
				</table>
				
				<input type=hidden name=action value='doSaveDetails'>
				<input type=hidden name=examid value=<%=examid%>>
				<input type=hidden name=sequenceid value=<%=sequenceid%>>
				<input type=image src="../jsp/simages/save1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/save2.gif',1)" border=0 onclick='return checkdetailsinsert();'>
				<input type=image src="../jsp/simages/reset1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/reset2.gif',1)" border=0 OnClick="javascript:return ResetForm('frmdetinsert');">
				<input type=image src="../jsp/simages/cancel1.gif" name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/cancel2.gif',1)" border=0 OnClick='return previous();'>
			</form>
<%					

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doSaveDetails"))
	{
		try
		{
			out.println("<h4><font color=#996633>Exam Master Details Save </font></h4>");
			String examname="";
			int examid=Integer.parseInt(request.getParameter("examid"));
			String testname= request.getParameter("testname");
			int noquest=Integer.parseInt(request.getParameter("noquest"));
			int timertype=Integer.parseInt(request.getParameter("timertype"));
			int responsetime=Integer.parseInt(request.getParameter("responsetime"));
			int nobreaksallowed=Integer.parseInt(request.getParameter("nobreaksallowed"));
			int breakinterval=Integer.parseInt(request.getParameter("breakinterval"));
			Float cri = new Float(request.getParameter("criteria"));
			float criteria = cri.floatValue();
//			int examtime=Integer.parseInt(request.getParameter("examtime"));
			int hours=Integer.parseInt(request.getParameter("hours"));
			int min=Integer.parseInt(request.getParameter("min"));
			int examtime=(hours*60*60)+(min*60);
			int sequenceid=Integer.parseInt(request.getParameter("sequenceid"));
			Float abc = new Float(request.getParameter("nemarks"));
			float nemarks = abc.floatValue();
			int noattempts = Integer.parseInt(request.getParameter("noattempts"));
			String prerequisite = request.getParameter("prerequisite");
			int levelid = Integer.parseInt(request.getParameter("levelid"));
			int includesublevels = Integer.parseInt(request.getParameter("includesublevels"));
			int adaptive=2;
			int uplimit=1;
			int downlimit=1;

			conn = pool.getConnection(); 
			Statement stmt,stmt1 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();

			int maxval=0;
			String sql="select max(CodeGroupID) from CodeGroupDetails where examid="+examid;
//out.println(sql);
			rs=stmt.executeQuery(sql);
			if(rs.next()){maxval=rs.getInt(1);}
			maxval++;
//out.println("max "+maxval);
			String code="";
			String param[] = request.getParameterValues("codegroupid");
//out.println("len : " + param.length);
			int i=0,rec=0,record=0;

			String pql="insert into NewExamDetails (ExamID,CodeGroupID,TestName,NoOfQuestions,TimerType,ResponseTime,NoOfBreaksAllowed,BreakInterval,Criteria,ExamTime,SequenceID,NegativeMarks,NoOfAttemptsAllowed,Prerequisite,LevelID,IncludeSubLevels,adaptive,uplimit,downlimit) values ("+examid+",'"+maxval+"','"+testname+"',"+noquest+","+timertype+","+responsetime+","+nobreaksallowed+","+breakinterval+","+criteria+","+examtime+","+sequenceid+","+nemarks+","+noattempts+",'"+prerequisite+"',"+levelid+","+includesublevels+","+adaptive+","+uplimit+","+downlimit+")";
//out.println(pql);
			try
			{
//out.println("in try");
				record = stmt1.executeUpdate(pql);
			}
			catch(Exception e)
			{
				out.println("Error : " + e.getMessage());
			}
//out.println("records inserted "+record+"<br>");

			for (i=0; i < param.length; i++)
			{
				code = (String) param[i];
//out.println("code "+code);
				sql="insert into CodeGroupDetails (ExamID,CodeGroupID,CodeID) values ("+examid+","+maxval+",'"+code+"')";
//out.println(sql+"<br>");
				rec = stmt.executeUpdate(sql);
//out.println("rec in examdet: "+rec);
			}		
				
			sql = "SELECT * FROM ExamMaster where ExamID = " + examid;
			rs=stmt.executeQuery(sql);
%>
			<form method=post action=<%=request.getRequestURI()%>>
			<center>
				<TABLE width='100%' bgcolor='#FEEEC8'> 
					<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </TD></font><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD><TD><font color='#960317'>Show Results</font></TD><TD><font color='#960317'>Display Test</font></TD></TR>
<%
			
					while(rs.next())
					{
						out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ 	rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD><TD>"+ rs.getInt("ShowResults")+"</TD><TD>"+ rs.getInt("DisplayTests")+"</TD><TD><a href='ExamMaster.jsp?action=doMasterModify&examid="+ rs.getInt("ExamID")+"'><img src='../jsp/simages/modify.gif' name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image1','','../jsp/simages/modify2.gif',1)\" border=0></a></TD><TD><a href='ExamMaster.jsp?action=doDeleteMaster&examid="+ rs.getInt("ExamID")+"'><img src='../jsp/simages/delete.gif' name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image2','','../jsp/simages/modify2.gif',1)\" border=0></a></TD></TR>");

					}
				out.println("</table><hr size=1>");
				
				if (record>0)
				{
					out.println("<b>"+record + " subject successfully added !!</b>");
					sql = "SELECT * FROM ExamDetails where ExamID = " + examid;
					rs=stmt.executeQuery(sql);
					if(rs.next())
					{
						sql = "SELECT * FROM ExamDetails where ExamID = " + examid;
//					rs=stmt.executeQuery(sql);

%>			
						<TABLE width='100%' bgcolor='#FEEEC8'> 
						<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Group ID</TD></font><TD><font color='#960317'>Test Name</font></TD><TD><font color='#960317'># of Questions</font></TD><TD><font color='#960317'>Timer per Question </font></TD><TD><font color='#960317'>Response Time per Question (hrs:min:sec)</font></TD><TD><font color='#960317'># of Breaks Allowed</font></TD><TD><font color='#960317'>Interval Time (min)</font></TD><TD><font color='#960317'>Passing Percent(%) </font></TD><TD><font color='#960317'>Total Time per Exam (min) </font></TD><TD><font color='#960317'>Sequence Id </font></TD><TD><font color='#960317'>Negative Marks per Question</font></TD><TD><font color='#960317'># of Attempts Allowed </font></TD><TD><font color='#960317'>Prerequisite(Chapter/ Topic/ Module/Level) </font></TD><TD><font color='#960317'>Level of Difficulty  </font></TD><TD><font color='#960317'>Include Sub Levels? </font></TD></TR>
<%					
						int totseconds=0,time=0,minutes=0,hours1=0,seconds=0;
						String showtime="";
						sql = "SELECT * FROM ExamDetails where ExamID = " + examid;
						rs1=stmt1.executeQuery(sql);
						int d=5,s=500;
						while(rs1.next())
						{
							time=rs1.getInt("ExamTime");
							seconds =(int) Math.floor(time%60);
							time = (int)Math.floor(time/60);
							minutes =(int)Math.floor(time%60);
							time=(int)Math.floor(time/60);
							hours1=(int)Math.floor(time%60);
							showtime=""+hours1+":"+minutes+":"+seconds;
%>	
							<tr bgcolor='#FFF5E7'><td><%=rs1.getInt("ExamID")%></td> 	<td><%=rs1.getInt("CodeGroupID")%></td> <td><%=rs1.getString("TestName")%></td> <td><%=rs1.getInt("NoOfQuestions")%></td> <td><%=rs1.getInt("TimerType")%></td> <td><%=rs1.getInt("ResponseTime")%></td> <td><%=rs1.getInt("NoOfBreaksAllowed")%></td> <td><%=rs1.getInt("BreakInterval")%></td> <td><%=rs1.getFloat("Criteria")%></td>
							<td><%=showtime%></td>
							<td><%=rs1.getInt("SequenceID")%></td> <td><%=rs1.getFloat("NegativeMarks")%></td> <td><%=rs1.getInt("NoOfAttemptsAllowed")%></td> <td><%=rs1.getInt("Prerequisite")%></td>
							<td><%=rs1.getInt("LevelID")%></td> <td><%=rs1.getInt("IncludeSubLevels")%></td>
							<td><a href='<%=request.getRequestURI()%>?action=doModifyDetails&examid=<%=examid%>&codegroupid=<%=rs1.getInt("CodeGroupID")%>'><img src='../jsp/simages/modify1.gif' name="Image<%=d%>" onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image<%=d%>','','../jsp/simages/modify2.gif',1)" border=0></a></td><td><a href='<%=request.getRequestURI()%>?action=doDetailsDelete&examid=<%=examid%>&codegroupid=<%=rs1.getInt("CodeGroupID")%>'><img src='../jsp/simages/delete1.gif' name="Image<%=s%>" onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image<%=s%>','','../jsp/simages/delete2.gif',1)" border=0></a>
							</td><tr>

<%
							s++;d++;
						}
						out.println("</table>");	
%>
						<input type=hidden name=action value='doExamDetailsInsert'>
						<input type=hidden name=examid value=<%=examid%>>
					<!--	<input type=hidden name=examid value=<%=examname%>> -->
						<input type=image src="../jsp/simages/entertestdetails2.gif" name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/entertestdetails.gif',1)" border=0 >
						<form>
						</form>
						<form method=post action='CodeMaster.jsp?action=doMenu&examid=<%=examid%>'>
						
						<input type=image src="../jsp/simages/entersubdetails1.gif" name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/entersubdetails2.gif',1)" border=0 >
						</form>

<%
					}

				}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doModifyDetails"))
	{
		try
		{
			out.println("<h4><font color=#996633>Exam Master Details Modify </font></h4>");
			out.println("<center>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			int codegroupid1=Integer.parseInt(request.getParameter("codegroupid"));
			String examname="";
			conn = pool.getConnection(); 
			Statement stmt,stmt1,stmt2,stmt3 = null;
			ResultSet rs=null,rs1=null,rs2= null,rs3=null;
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			stmt2 = conn.createStatement();
			stmt3 = conn.createStatement();

			String sql="select * from NewExamDetails where ExamID="+examid + " and CodeGroupID="+codegroupid1;
			int totseconds=0,time=0,minutes=0,hours1=0,seconds=0,sequenceid=0;
				String showtime="";
			rs=stmt.executeQuery(sql);
//out.println(sql);
			if(rs.next())
			{
//				cdgroupid=rs.getInt("CodeGroupID");
				sequenceid=rs.getInt("SequenceID");
				time=rs.getInt("ExamTime");
					seconds =(int) Math.floor(time%60);
					time = (int)Math.floor(time/60);
					minutes =(int)Math.floor(time%60);
					time=(int)Math.floor(time/60);
					hours1=(int)Math.floor(time%60);
					showtime=""+hours1+":"+minutes+":"+seconds;
//out.println(showtime);
%>				
				
			<form method=post name=frmmoddet action=<%=request.getRequestURI()%> >
				<table bgcolor='#FEEEC8'>
				<tr bgcolor='#FFF5E7'><td>Exam Id :</td><td><%=examid%></td></tr>
				<tr bgcolor='#FFF5E7'><td>Code Group Id :</td><td><select name=codegroupid multiple>
				
<%
				//String code="",description="";
				count=0;
				sql="select count(*) from CodeGroupDetails where CodeGroupID="+codegroupid1+" and ExamID="+examid;
//out.println(sql);
				rs1=stmt1.executeQuery(sql);
				while(rs1.next()){count=rs1.getInt(1);}
//out.println("count "+count);

				String [] selectedcode = new String[count];
				sql="select * from CodeGroupDetails where CodeGroupID="+codegroupid1 +" and ExamID="+examid;
//out.println(sql);
				rs1=stmt1.executeQuery(sql);
				int c=0;
				while(rs1.next())
				{
					selectedcode[c]=rs1.getString("CodeID");
					c++;
				}
				for (int z=0;z<selectedcode.length;z++){out.println(selectedcode[z]);}

				sql="select * from CodeMaster where ExamID=" + examid + " order by CodeID";
//out.println(sql);
				String code = null;
				String desc = null;
				rs3=stmt3.executeQuery(sql);
				String subname="",chapname="",topname="",subtopname="",name="";
				
				boolean check=false;

				while(rs3.next())
				{	
					
					check=false;
					code = rs3.getString("CodeID");
					desc = rs3.getString("Description");
					String b=rs3.getString("CodeID");
					String first=b.substring(0,2);
					int fr=Integer.parseInt(first);
					String second=b.substring(2,4);
					int scd=Integer.parseInt(second);
					String third=b.substring(4,6);
					int td=Integer.parseInt(third);
					String fourth=b.substring(6,8);
					int foth=Integer.parseInt(fourth);
						
					if (fr>0 && scd==0)
					{
						subname=rs3.getString("Description");
						name = subname;
					}
					if(scd>0 && td==0)
					{
						chapname=rs3.getString("Description");
						name = subname+ " -> " +chapname;
					}
					if (td>0 && foth==0)
					{
						topname=rs3.getString("Description");
						name = subname+ " -> " +chapname+ " -> " +topname;
					}
					if (foth>0)
					{
						subtopname=rs3.getString("Description");
						name = subname+ " -> " +chapname+ " -> " +topname+ " -> " +subtopname;
					}
					for (int k = 0;  k < selectedcode.length; k++)
					{
						if (selectedcode[k].equals(b) )
						{
							out.println("<OPTION VALUE="+b+" SELECTED>" + name + "</OPTION>");
							check=true;
						}
					}
					if(!check)
						out.println("<OPTION VALUE="+b+">" + name + "</OPTION>");
				}
				int timertype=rs.getInt("TimerType");
%>
				</select></td></tr>
				<tr bgcolor='#FFF5E7'><td>Test Name :</td><td><input type=text 						name=testname value=<%=rs.getString("TestName")%>></td></tr>
				<tr bgcolor='#FFF5E7'><td># of Questions  </td><td><input type=text name=noquest 	value=<%=rs.getInt("NoOfQuestions")%>> </td></tr>
				<tr bgcolor='#FFF5E7'><td>Timer per Question :</td><td><select name=timertype> 	
	<%
				if(timertype==1)
				{
	%>
					<option	value=1 selected>Yes</option><option value=0>No</option></select></td></tr>
	<%
				}
				else
				{
	%>
					<option	value=1>Yes</option><option selected value=0>No</option></select></td></tr>
	<%
				}
	%>
				<tr bgcolor='#FFF5E7'><td>Response Time per Question (sec) :</td><td><input 		type=text name=responsetime value=<%=rs.getInt("ResponseTime")%>></td></tr>
				<tr bgcolor='#FFF5E7'><td># of Breaks Allowed :</td><td><input type=text 			name=nobreaksallowed value=<%=rs.getInt("NoOfBreaksAllowed")%>></td></tr>
				<tr bgcolor='#FFF5E7'><td>Interval Time (sec) :</td><td><input type=text 			name=breakinterval value=<%=rs.getInt("BreakInterval")%>>	</td></tr>
				<tr bgcolor='#FFF5E7'><td>Passing Percent(%) : </td><td><input type=text 			name=criteria value=<%=rs.getFloat("Criteria")%>></td></tr>
					<tr bgcolor='#FFF5E7'><td>Total Time per Exam ) :</td><td>hours <input type=text 		name=hours size=5 value=<%=hours1%> >min <input type=text name=minutes size=5 value=<%=minutes%>>sec <input type=text name=seconds size=5 value=<%=seconds%>> </td></tr>
					<tr bgcolor='#FFF5E7'><td>Sequence Id  :</td><td><%=sequenceid%></td></tr>
					<tr bgcolor='#FFF5E7'><td>Negative Marks per Question :</td><td><input type=text 	name=nemarks value=<%=rs.getFloat("NegativeMarks")%>> </td></tr>
					<tr bgcolor='#FFF5E7'><td># of Attempts Allowed :</td><td><input type=text 			name=noattempts value=<%=rs.getInt("NoOfAttemptsAllowed")%>></td></tr>
					<tr bgcolor='#FFF5E7'><td>Prerequisite(Chapter/Topic/Module/Level):</td><td><select name=prerequisite size=4>
						<option value=0 selected>None</option>
<%
					sql="select * from NewExamDetails where ExamID=" + examid +" order by TestName";
					rs3=stmt3.executeQuery(sql);
					while(rs3.next())
					{
						out.println("<option value="+rs3.getInt("CodeGroupID")+">"+rs3.getString("TestName")+"</option>");
					}

%>						
					</select></td></tr>
					<tr bgcolor='#FFF5E7'><td>Level of Difficulty :</td><td><SELECT name=levelid>
<%
					sql = "select * from LevelMaster";
					rs=stmt.executeQuery(sql);
					while(rs.next())
					{
						String lvl=rs.getString("Level");
						int lid = rs.getInt("LevelID");
%>
						<option value=<%=lid%>><%=lvl%></option>
<%
					}
%>
						</select></td></tr>
					<tr bgcolor='#FFF5E7'><td>Include Sub Levels? :</td><td><select 					name=includesublevels> <option 		value=1>Yes</option><option 				value=0>No</option></select></td></tr>
				</table>
				<input type=hidden name=action value='doModifyDetailsSave'>

				<input type=image src="../jsp/simages/save1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/save2.gif',1)" border=0 onclick='return checkModifyDetails();'>
				<input type=hidden name=examid value=<%=examid%>>
				<input type=hidden name=codegroupid1 value=<%=codegroupid1%>>
				<input type=hidden name=sequenceid value=<%=sequenceid%>>
				<input type=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
				</form>
<%

			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doModifyDetailsSave"))
	{
		try
		{
			out.println("<h4><font color=#996633>Exam Modify Details </font><h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			int codegroupid1=Integer.parseInt(request.getParameter("codegroupid1"));
//out.println(codegroupid1);
			String testname= request.getParameter("testname");
			int noquest=Integer.parseInt(request.getParameter("noquest"));
			int timertype=Integer.parseInt(request.getParameter("timertype"));
			int responsetime=Integer.parseInt(request.getParameter("responsetime"));
			int nobreaksallowed=Integer.parseInt(request.getParameter("nobreaksallowed"));
			int breakinterval=Integer.parseInt(request.getParameter("breakinterval"));
			Float cri = new Float(request.getParameter("criteria"));
			float criteria = cri.floatValue();
			int hours=Integer.parseInt(request.getParameter("hours"));
			int minutes=Integer.parseInt(request.getParameter("minutes"));
			int seconds=Integer.parseInt(request.getParameter("seconds"));

			int examtime=(hours*60*60)+(minutes*60)+seconds;
			int sequenceid=Integer.parseInt(request.getParameter("sequenceid"));
			Float abc = new Float(request.getParameter("nemarks"));
			float nemarks = abc.floatValue();
			int noattempts = Integer.parseInt(request.getParameter("noattempts"));
			String prerequisite = request.getParameter("prerequisite");
			int levelid = Integer.parseInt(request.getParameter("levelid"));
			int includesublevels = Integer.parseInt(request.getParameter("includesublevels"));

			conn = pool.getConnection(); 
			Statement stmt1,stmt2,stmt3,stmt4 = null;String code="";
			ResultSet rs,rs1,rs2 = null;
			stmt1 = conn.createStatement();
			stmt2 = conn.createStatement();
			stmt3 = conn.createStatement();
			stmt4 = conn.createStatement();

			String sql="delete from CodeGroupDetails where CodeGroupID="+codegroupid1 + " and ExamID=" + examid;
//out.println(sql);
			int delrec=stmt1.executeUpdate(sql);
			
			sql="select CodeID from CodeMaster where ExamID=" + examid;
			rs1=stmt2.executeQuery(sql);
			
			while(rs1.next())
			{
				code = rs1.getString("CodeID");
				//System.out.println("code :"+code);
				sql="insert into CodeGroupDetails (ExamID,CodeGroupID,CodeID) values ("+examid+","+codegroupid1+",'"+code+"')";
				//sql="Update CodeGroupDetails set ExamID ="+examid+",CodeGroupID="+codegroupid1+",CodeID="+code+"' where ExamID = " + examid;
//out.println(sql);
				int rec = stmt3.executeUpdate(sql);
				//System.out.println("rec :"+rec);
			}

			sql="update NewExamDetails set CodeGroupID='"+codegroupid1+"',TestName='" + testname + "',NoOfQuestions="+ noquest + ",TimerType=" + timertype+ ",ResponseTime=" + responsetime + ",NoOfBreaksAllowed="+nobreaksallowed + ",BreakInterval=" + breakinterval +",Criteria=" + criteria + ",ExamTime=" + examtime + ",SequenceID="+ sequenceid + ",NegativeMarks="+ nemarks + ",NoOfAttemptsAllowed=" + noattempts + ",Prerequisite='" + prerequisite + "',LevelId=" + levelid + ",IncludeSubLevels=" + includesublevels + " where ExamID=" + examid + " and CodeGroupID='" + codegroupid1+ "'";

//out.println(sql);			
			
			int records = stmt4.executeUpdate(sql);
			if(records>0)
			{
				out.println(records + " successfully modified !!" );

%>
				<center>
				<form method=post action='<%=request.getRequestURI()%>' >
				<input type=hidden name=examid value=<%=examid%>>
				<input type=hidden name=action value='doExamDetails'>
				<input type=image src="../jsp/simages/ok1.gif">				
				</form>
				</center>
<%
			}

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doMasterModify"))
	{
		try
		{
			out.println("<h4><font color=#996633>Exam Master Modify Details </font><h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
//out.println("id " + examid);
			conn = pool.getConnection(); 
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
	
			String startdate="",enddate="";
			String sql="select * from ExamMaster where ExamID="+examid ;
			String [] month = new String[12];
			month[0]="Jan";month[1]="Feb";month[2]="Mar";month[3]="April";month[4]="May";
			month[5]="Jun";month[6]="Jul";month[7]="Aug";month[8]="Sep";month[9]="Oct";
			month[10]="Nov";month[11]="Dec";
			int styr=0,stmth=0,stdt=0;
			int edyr=0,edmth=0,eddt=0,showres=0,disptests=0,exammode=0;
//out.println(sql);
			rs = stmt.executeQuery(sql);
			if (rs.next())
			{
				showres=rs.getInt("ShowResults");
				exammode=rs.getInt("ExamMode");
				disptests=rs.getInt("DisplayTests");
				startdate=rs.getString("StartDate");
				enddate=rs.getString("EndDate");
//out.println(startdate);
				stdt=Integer.parseInt(startdate.substring(8,10));
//out.println(stdt);
				stmth=Integer.parseInt(startdate.substring(6,7));
//out.println(stmth);
				styr=Integer.parseInt(startdate.substring(0,4));
//out.println(styr + "<br>");
//out.println(startdate);
//out.println("dtdate :"+stdt +" "+stdt+" "+styr);

//out.println(enddate);
				eddt=Integer.parseInt(enddate.substring(8,10));
//out.println(eddt);
				edmth=Integer.parseInt(enddate.substring(6,7));
//out.println(edmth);
				edyr=Integer.parseInt(enddate.substring(0,4));
//out.println(edyr);
//out.println(enddate);
//out.println("eddt :"+eddt +" "+eddt+" "+edyr);		
%>
				<form method=get name=frmmastermodify>
				<center>
				<table border=0 bgcolor='#FEEEC8'>
				<tr bgcolor='#FEEEC8'>
					<td><font color='#960317'>Exam Id : </font></td><td><%=examid%></td>
				</tr>
				<tr bgcolor='#FEEEC8'>
					<td><font color='#960317'>Exam Name : </font><font color='#FF0000'>*</font></td>
					<td><input type=text name=examname SIZE=20 value='<%= rs.getString("Exam") %> '></td>
				</tr>
				<tr bgcolor='#FEEEC8'>
					<td><font color='#960317'>Exam Mode : </font></td>
					<td><select name=exammode>
<%
					if(exammode==0)						
					{			
%>
							<option value=0 selected>Random</option><option value=1>Sequencial</option>
<%
					}
					else
					{
%>
							<option value=0>Random</option><option value=1 selected>Sequencial</option>
<%
					}
%>
					</td>
				</tr>
				<tr bgcolor='#FEEEC8'>
					<td><font color='#960317'>Start Date :</font></td>
					<td><select name=stdate>
<%
						String num="";
						for (int c=1;c<32;c++)
						{
							if(stdt==c)
								{
									if(c<10)
									{
										num="0"+c;
%>
										<option selected value=<%=num%> ><%=c%></option>
<%
									}
									else
									{
%>
										<option selected value=<%=c%> ><%=c%></option>
<%
									}
								}
								else
								{
									if(c<10)
									{
										num="0"+c;
%>
											<option value=<%=num%>><%=c%></option>
<%
									}
									else
									{
%>
										<option value=<%=c%>><%=c%></option>
<%
									}

								}	//else
						}
%>
						</select>
						<select name=stmonth>
<%
					for (int i=0;i<month.length;i++)
					{
						if(stmth==i+1)
						{
							if(stmth<10)
							{
								num="0"+(i+1);
%>
								<option selected value=<%=num%> ><%=month[i]%></option>
<%
							}
							else
							{
%>
								<option selected value=<%=i+1%> ><%=month[i]%></option>
<%
							}
						}
						else
						{
							if(i<9)
							{
								num="0"+(i+1);
%>
								<option value=<%=num%> ><%=month[i]%></option>
<%
							}
							else
							{
%>
								<option value=<%=i+1%> ><%=month[i]%></option>
<%
							}
						}	//else					
					}
%>
						</select>
						<select name=styear>
<%
						for(int e=2014;e<2020;e++)
						{
%>
							<%if(styr==e){%>
								<option selected value=<%=e%>><%=e%></option>
							<%}else{%>
								<option value=<%= e%>><%=e%></option>					
<%
								}	//else
						}
%>
						</select>
					</td>
				</tr>
				<tr bgcolor='#FEEEC8'>
					<td>
						<font color='#960317'>End Date : </font> </td>
						<td><select name=eddate>					
<%
							
							for(int c=1;c<32;c++)
							{
								if(eddt==c)
								{
									if(c<10)
									{
										num="0"+c;
%>
										<option selected value=<%=num%> ><%=c%></option>
<%
									}
									else
									{
%>
										<option selected value=<%=c%> ><%=c%></option>
<%
									}
								}
								else
								{
									if(c<10)
									{
										num="0"+c;
%>
											<option value=<%=num%>><%=c%></option>
<%
									}
									else
									{
%>
										<option value=<%=c%>><%=c%></option>
<%
									}

								}	//else
							}
%>
							</select>
							<select name=edmonth>
<%
					num="";
					for (int i=0;i<month.length;i++)
					{			
						if(edmth==i+1)
						{
							if(edmth<10)
							{
								num="0"+(i+1);
%>
								<option selected value=<%=num%> ><%=month[i]%></option>
<%
							}
							else
							{
%>
								<option selected value=<%=i+1%> ><%=month[i]%></option>
<%
							}
						}
						else
						{
							if(i<9)
							{
								num="0"+(i+1);
%>
								<option value=<%=num%> ><%=month[i]%></option>
<%
							}
							else
							{
%>
								<option value=<%=i+1%> ><%=month[i]%></option>
<%
							}
						}	//else
					}
%>

							</select>
							<select name=edyear>
<%
							for(int d=2015;d<=2020;d++)
							{
%>	
								<%if(edyr==d){%>
									<option selected value=<%= d%>><%= d%></option>
								<%}else{%>
									<option value=<%= d%>><%= d%></option>
<%
									}	//else
							}
%>
							</select>
						
					</td>
				<tr bgcolor='#FEEEC8'>
					<td>
						<font color='#960317'>Conducted By :</font><font color='#FF0000'>*</font></td>
					<td>
						<INPUT TYPE=TEXT name=conductedby SIZE=20 value=<%= rs.getString("ConductedBy")%>></td>
				</tr>
			
				<tr bgcolor='#FEEEC8'>
					<td><font color='#960317'>Center : </font> <font color='#FF0000'>*</font></td>
					<td><INPUT TYPE=TEXT name=centre SIZE=20 value='<%= rs.getString("Centre")%>'></td>
				</tr>
			
				<tr bgcolor='#FEEEC8'>
					<td><font color='#960317'>Country : </font> <font color='#FF0000'>*</font></td>
					<td><INPUT TYPE=TEXT name=country SIZE=20 value=<%= rs.getString("Country")%>></td>
				</tr>
				<tr bgcolor='#FEEEC8'>
					<td><font color='#960317'>Frequency : <font color='#FF0000'>*</font></font></td>
					<td><INPUT TYPE=TEXT name=frequency SIZE=5 value=<%= rs.getInt("Frequency")%>></td>
				</tr>
				<tr>
				<td><font color='#960317'>Display Results after Test : </font></td>
				<td><select name=showresults>
					<%if(showres==1){%>
						<option selected value=1>Yes</option>
						<option value=0>No</option>
					<%}else if(showres==0){%>
						<option value=1>Yes</option>
						<option selected value=0>NO</option>
					<%}%></td>
			</tr>
			<tr>
				<td><font color='#960317'>Display Selection of the Test to the Candidate: </font></td>
				<td><select name=displaytests>
					<%if(disptests==1){%>
						<option selected value=1>Yes</option>
						<option value=0>No</option>
					<%}else if(disptests==0){%>
						<option value=1>Yes</option>
						<option selected value=0>NO</option>
					<%}%></td>
			</tr>
				<table>

				<INPUT TYPE=image src="../jsp/simages/save1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/save2.gif',1)" border=0 onclick='return checkMasterModify();'>

				<input type=hidden name=action value='doSave'>
				<input type=hidden name=examid value=<%= examid%>>
				
	<!--				<input type=image src="../jsp/simages/reset1.gif"  name='Image2' 	onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/reset2.gif',1)" border=0 OnClick="javascript:return ResetForm('frmmastermodify');">	-->

				<input type=image src="../jsp/simages/cancel1.gif"  name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/cancel2.gif',1)" border=0 OnClick="return previous();">
				</form>
<%
					
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doSave"))
	{
		try
		{
			out.println("<h4><font color=#996633>Exam Master Modify Details </font><h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			String examname=request.getParameter("examname");
			int exammode=Integer.parseInt(request.getParameter("exammode"));
			int styear=Integer.parseInt(request.getParameter("styear"));
			String stmonth = request.getParameter("stmonth");
			int stdate = Integer.parseInt(request.getParameter("stdate"));
			String startdate=styear+"-"+stmonth+"-"+stdate;

			int edyear=Integer.parseInt(request.getParameter("edyear"));
			String edmonth = request.getParameter("edmonth");
			int eddate = Integer.parseInt(request.getParameter("eddate"));
			String enddate=edyear+"-"+edmonth+"-"+eddate;

			String conductedby=request.getParameter("conductedby");
			String centre=request.getParameter("centre");
			String country=request.getParameter("country");
			int frequency=Integer.parseInt(request.getParameter("frequency"));
			int showresults=Integer.parseInt(request.getParameter("showresults"));
			int displaytests=Integer.parseInt(request.getParameter("displaytests"));

			conn = pool.getConnection(); 
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
	
			String sql = "update ExamMaster set Exam='" + examname + "',ExamMode="+ exammode+ ",StartDate='"+ startdate + "',EndDate='"+ enddate+ "',ConductedBy='"+conductedby +"',Centre='"+ centre + "',Country='"+country + "',Frequency="+frequency +",ShowResults="+showresults +",DisplayTests="+displaytests+" where ExamID="+ examid;
//out.println(sql);
			out.println("<center>");
			int record = stmt.executeUpdate(sql);
			if(record>0)
			{
				sql = "SELECT * FROM ExamMaster where ExamID = " + examid;
				rs=stmt.executeQuery(sql);
%>
				<form method=get action=<%=request.getRequestURI()%>>
				<TABLE width='100%' bgcolor='#FEEEC8'> 
					<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </TD></font><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD><TD><font color='#960317'>Show Results</font></TD><TD><font color='#960317'>Display Tests</font></TD></TR>
<%
			
				while(rs.next())
				{
					out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ 	rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD><TD>"+ rs.getInt("ShowResults")+"</TD><TD>"+ rs.getInt("DisplayTests")+"</TD><TD><a href='ExamMaster.jsp?action=doMasterModify&examid="+ rs.getInt("ExamID")+"'><img src='../jsp/simages/modify.gif' border=0></a></TD><TD><a href='ExamMaster.jsp?action=doDeleteMaster&examid="+ rs.getInt("ExamID")+"'><img src='../jsp/simages/delete.gif' border=0></a></TD></TR>");
				}
%>
				</TABLE>
		<!--		<input type=submit value='insert in Exam Details'>-->
				<input type=image src="../jsp/simages/entertestdetails.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/entertestdetails2.gif',1)" border=0 >
				<input type=hidden name=action value='doExamDetailsInsert'>
				<input type=hidden name=examid value=<%= examid%>>
				</form>
<!--				</form>
				<form method=post action='CodeMaster.jsp?action=doMenu&examid=<%=examid%>'>
				<input type=submit value='Enter Subject for this Exam'>
				</form> -->
				<form method=post action='CodeMaster.jsp?action=doMenu&examid=<%=examid%>'>
				<input type=image src="../jsp/simages/entersubdetails1.gif" name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/entersubdetails2.gif',1)" border=0 >
				</form>

<%	
			}
			else
				out.println("<h4>Error in Modification !!</h4>");
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doDeleteMaster"))
	{
		try
		{
			out.println("<h4><font color=#996633>Delete Exam Master  </font><h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			conn = pool.getConnection(); 
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			int records=0;
			out.println("<center>");
			String sql="select count(*) from ExamDetails where ExamID=" + examid;
			rs=stmt.executeQuery(sql);
			if (rs.next()){records=rs.getInt(1);}
			if (records>0)
			{
%>
				<form action=<%=request.getRequestURI()%>>
				<%=records%> Test are defined for this Exam.<br>
				First Delete all Test before deleting Exams.<br><br>
				Do you want delete all Test with this Exam ?<br><br>
				<input type=hidden name=action value='doAllDelete'>
				<input type=hidden name=examid value=<%=examid%>>
				
				<input type=image src="../jsp/simages/deletes1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/deletes2.gif',1)" border=0>
				
				<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
				</form>			
<%
/// delete code 
			}
			else
			{
				sql="select * from ExamMaster where ExamID=" + examid;
				rs=stmt.executeQuery(sql);
%>
				<form method=get action=<%=request.getRequestURI()%>>
				<center>
					<TABLE width='100%' bgcolor='#FEEEC8'> 
						<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </TD></font><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD><TD><font color='#960317'>Show Results</font></TD><TD><font color='#960317'>Display Tests</font></TD></TR>
<%
			
					while(rs.next())
					{
						out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ 	rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD><TD>"+ rs.getInt("ShowResults")+"</TD><TD>"+ rs.getInt("DisplayTests")+"</TD></TR>");
//						examname=rs.getString("Exam");
					}
%>
					</table><hr size=1>
					<input type=hidden name=action value='doPurge'>
					<input type=hidden name=examid value=<%=examid%>>
					<INPUT TYPE=image src="../jsp/simages/deletes1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/deletes2.gif',1)" border=0>
					<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
					</form>
<%				
			}
			
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doAllDelete"))
	{
		try
		{
			out.println("<h4><font color=#996633>Delete Exam Master  </font><h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			conn = pool.getConnection(); 
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			int records=0;
			out.println("<center>");
			String sql="delete from TestStatusDetails where ExamID=" + examid;
			records=stmt.executeUpdate(sql);

			sql="delete from ExamTestingDetails where ExamID=" + examid;
			records=stmt.executeUpdate(sql);

			sql="delete from CandidateDetails  where ExamID=" + examid;
			records=stmt.executeUpdate(sql);

			sql="delete from PerformanceMaster where ExamID=" + examid;
			records=stmt.executeUpdate(sql);

			sql="delete from ExamDetails where ExamID=" + examid;
			records=stmt.executeUpdate(sql);

			sql="delete from CodeGroupDetails where ExamID=" + examid;
			records=stmt.executeUpdate(sql);

			sql="delete from CodeMaster where ExamID=" + examid;
			records=stmt.executeUpdate(sql);

			sql="delete from ExamMaster where ExamID=" + examid;
			records=stmt.executeUpdate(sql);

			if (records>0)
			{
				out.println(records+" Test Successfully deletd from ExamDetails !!");
%>
				<center>
				<form method=post action='<%=request.getRequestURI()%>' >
				<a href="ExamMaster.jsp"><img src="../jsp/simages/ok1.gif"></a>			
				</form>
				</center>
<%
			}
			else
				out.println("Problem in Deletion !!");

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doPurge"))
	{
		try
		{
			out.println("<h4><font color=#996633>Delete Exam Master  </font><h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			conn = pool.getConnection(); 
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			int records=0;
			out.println("<center>");
			String sql="delete from ExamMaster where ExamID=" + examid;
			records=stmt.executeUpdate(sql);
			if(records>0)
			{
				out.println(records + " Exam Deleted Successfuly !!");
%>
				<center>
				<form method=post action='<%=request.getRequestURI()%>' >
				<a href="ExamMaster.jsp"><img src="../jsp/simages/ok1.gif"></a>	
				</form>
				</center>
<%
			}
			else
				out.println("Problem in Deletion !!");
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
/*	else if(action.equals("doPurge"))
	{
		try
		{
			out.println("<h4>Delete Exam Master  <h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			Class.forName("org.gjt.mm.mysql.Driver").newInstance();
			conn = DriverManager.getConnection("jdbc:mysql://172.16.3.102/alm?user=user&password=user");
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			int records=0;
			out.println("<center>");
			String sql="delete from ExamMaster where ExamID=" + examid;
			records=stmt.executeUpdate(sql);
			if (records>0)
			{
				out.println(records+" Exam Successfully deletd from ExamMaster !!");
			}
			else
				out.println("Problem in Deletion !!");

			records=0;
			sql="delete from ExamDetails where ExamID=" + examid;
			records=stmt.executeUpdate(sql);
			if (records>0)
			{
				out.println(records+" Test Successfully deletd from ExamDetails !!");
			}
			else
				out.println("Problem in Deletion !!");
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
	String codeid="";
			sql="select * from CodeGroupDetails where CodeGroupID=" +codegroupid +" and ExamID=" +examid;
			rs=stmt.executeQuery(sql);
			if (rs.next())
			{
				codeid=rs.getString("CodeID");
			}

			sql="delete from CodeMaster where ExamID=" +examid +" and CodeID="+codeid;
			records=stmt.executeUpdate(sql);
	*/
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doDetailsDelete"))
	{
		try
		{
			out.println("<h4><font color=#996633>Delete Exam Details  </font><h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			int codegroupid=Integer.parseInt(request.getParameter("codegroupid"));
			conn = pool.getConnection(); 
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			int records=0;
			out.println("<center>");
			String sql="select * from ExamDetails where ExamID=" + examid + " and CodeGroupID=" + codegroupid;
			rs=stmt.executeQuery(sql);
%>			<center>
			<form>
			<TABLE width='100%' bgcolor='#FEEEC8'> 
				<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Group ID</TD></font><TD><font color='#960317'>Test Nament></TD><TD><font color='#960317'>Grou# of Questionsnt></TD><TD><font color='#960317'>GrouTimer per Question nt></TD><TD><font color='#960317'>GrouResponse Time per Question (sec)nt></TD><TD><font color='#960317'>Grou# of Breaks Allowednt></TD><TD><font color='#960317'>GrouInterval Time (sec)nt></TD><TD><font color='#960317'>GrouPassing Percent(%) nt></TD><TD><font color='#960317'>GrouTotal Time per Exam (hrs:min:sec) </font></TD><TD><font color='#960317'>Sequence Id </font></TD><TD><font color='#960317'>Negative Marks per Questionnt></TD><TD><font color='#960317'>Grou# of Attempts Allowed nt></TD><TD><font color='#960317'>GrouPrerequisite(Chapter/ Topic/ Module/Level) nt></TD><TD><font color='#960317'>GrouLevel of Difficulty  nt></TD><TD><font color='#960317'>GrouInclude Sub Levels? </font></TD></TR>
<%					
				int totseconds=0,time=0,minutes=0,hours=0,seconds=0;
				String showtime="";
//				sql = "SELECT * FROM ExamDetails where ExamID = " + examid;
//					rs1=stmt1.executeQuery(sql);
				while(rs.next())
				{
					time=rs.getInt("ExamTime");
					codegroupid=rs.getInt("CodeGroupID");
					seconds =(int) Math.floor(time%60);
					time = (int)Math.floor(time/60);
					minutes =(int)Math.floor(time%60);
					time=(int)Math.floor(time/60);
					hours=(int)Math.floor(time%60);
					showtime=""+hours+":"+minutes+":"+seconds;
%>
					<tr bgcolor='#FFF5E7'><td><%=rs.getInt("ExamID")%></td> <td><%=rs.getInt("CodeGroupID")%></td>
					<td><%=rs.getString("TestName")%></td> <td><%=rs.getInt("NoOfQuestions")%></td> <td><%=rs.getInt("TimerType")%></td> <td><%=rs.getInt("ResponseTime")%></td> <td><%=rs.getInt("NoOfBreaksAllowed")%></td> <td><%=rs.getInt("BreakInterval")%></td> <td><%=rs.getFloat("Criteria")%></td>
					<td><%=showtime%></td>
					<td><%=rs.getInt("SequenceID")%></td> <td><%=rs.getFloat("NegativeMarks")%></td> <td><%=rs.getInt("NoOfAttemptsAllowed")%></td> <td><%=rs.getInt("Prerequisite")%></td>
					<td><%=rs.getInt("LevelID")%></td> <td><%=rs.getInt("IncludeSubLevels")%></td>
										
					<tr>
<%
				}
				out.println("</table>");
%>
				<input type=hidden name=codegroupid value=<%=codegroupid%>>
				<input type=hidden name=examid value=<%=examid%>>
				<input type=hidden name=action value='doPack'>
				<input type=image src="../jsp/simages/deletes1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/deletes2.gif',1)" border=0>

				<input type=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>

				</form>
<%

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Connecting to Database."); 
		}
	}
////////////////////////////////////////////////////////////////////////////////////////////
	else if(action.equals("doPack"))
	{
		try
		{
			out.println("<h4><font color=#996633>Delete Exam Master  </font><h4><hr size=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
			int codegroupid=Integer.parseInt(request.getParameter("codegroupid"));
			conn = pool.getConnection(); 
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			int records=0,records1=0;
			out.println("<center>");
			String sql="delete from TestStatusDetails where CodeGroupID=" + codegroupid +" and ExamID=" +examid;
			records=stmt.executeUpdate(sql);

			sql="delete from ExamTestingDetails where CodeGroupID=" + codegroupid +" and ExamID=" +examid;
			records=stmt.executeUpdate(sql);

			sql="delete from PerformanceMaster where CodeGroupID="+ codegroupid +" and ExamID=" +examid;
			records=stmt.executeUpdate(sql);

			sql="delete from ExamDetails where CodeGroupID=" +codegroupid +" and ExamID=" +examid;
			records1=stmt.executeUpdate(sql);			

			sql="delete from CodeGroupDetails where CodeGroupID=" +codegroupid +" and ExamID=" +examid;
			records=stmt.executeUpdate(sql);
		
			if (records1>0)
			{
				out.println(records+" Test Successfully deletd from ExamDetails !!");
			}
			else
				out.println("Problem in Deletion !!");
%>
				<form method=post action='<%=request.getRequestURI()%>' >
				<input type=hidden name=examid value=<%=examid%>>
				<input type=hidden name=action value='doExamDetails'>
				<input type=image src="../jsp/simages/ok1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/ok2.gif',1)" border=0>		
				</form>
<%		

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally 
		{ 
			if (conn != null) 
				pool.releaseConnection(conn); 
	        else 
		        out.println ("Error while Realising Connection to Database."); 
		}
	}
%>	
</body>
</html>
