<%@ page language = "java" import = "java.sql.*" session="true"%>
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>
<HTML>
<TITLE>Exam </TITLE>
</HEAD>
<style>td{font-family:arial;font-size:10pt;} body{font-family:arial;font-size:11pt;} b{font-family:arial;font-size:11pt;}</style>
</HEAD>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>
<script language=javascript>
function previous()
{
	history.back();
	return false;
}
function out()
{
	window.close();
}
/*function rtrim(argvalue) {
	alert("rt "+argvalue);
  while (1) {
    if (argvalue.substring(argvalue.length - 1, argvalue.length) != " ")
	  {
		alert("if ");
		return false;
      break;
	  }
    argvalue = argvalue.substring(0, argvalue.length - 1);
	alert(argvalue);
  }

  return argvalue;
}
*/
function checksubnull()
{
	var x="document.frmsubject.subname";
/*	var b=rtrim(x);
	if (false)
	{
		alert("after " + x);
		return false;
	}
*/	if (!isnulls(x))
	{
		alert("Subject Name cannot be Empty");
		eval(x).focus();
		return false;
	}
	if (eval(x).value.length>100)
	{
		alert("Subject Name cannot be more than 100 characters long !! ");
		eval(x).value="";
		eval(x).focus();
		return false;
	}
//	else
//		document.frmsubject.submit();
	return true;
}
function chapnull()
{
	var x="document.frmchap.chapname";
	if (!isnulls(x))
	{
		alert("Chapter Name cannot be Empty");
		eval(x).focus();
		return false;
	}
	if (eval(x).value.length>100)
	{
		alert("Chapter Name cannot be more than 100 characters long !! ");
		eval(x).value="";
		eval(x).focus();
		return false;
	}
//	document.frmchap.submit();
	return true;

}
function topicnull()
{
	var x="document.frmtopic.topicname";
	if (!isnulls(x))
	{
		alert("Topic Name cannot be Empty");
		eval(x).focus();
		return false;
	}
	if (eval(x).value.length>100)
	{
		alert("Topic Name cannot be more than 100 characters long !! ");
		eval(x).value="";
		eval(x).focus();
		return false;
	}
	//document.frmtopic.submit();
		return true;

}
function subtopicnull()
{
	var x="document.frmsubtopic.topicname";
	if (!isnulls(x))
	{
		alert("Sub Topic Name cannot be Empty");
		eval(x).focus();
		return false;
	}
	if (eval(x).value.length>100)
	{
		alert("Sub Topic Name cannot be more than 100 characters long !! ");
		eval(x).value="";
		eval(x).focus();
		return false;
	}
	//document.frmsubtopic.submit();
		return true;
}
function deletes()
{
	var get=confirm("Are you Sure you want to delete !! \n Corresponding Details will also be deleted !! ");
	if (get)
	{
		document.frmdelete.submit();
	}
		return get;

}

function changenull()
{
	var x="document.frmChange.newname";
	if (!isnulls(x))
	{
		alert("Name cannot be Empty");
		eval(x).focus();
		return false;
	}
	if (eval(x).value.length>100)
	{
		alert("Name cannot be more than 100 characters long !! ");
		eval(x).value="";
		eval(x).focus();
		return false;
	}
	return true;
	//document.frmChange.submit();
}
function isnulls(name)
{

	if (eval(name).value=="")
	{
		return false;
	}
	else
		return true;
}
</script>
<BODY BGCOLOR='#FEF9E2' onLoad="MM_preloadImages('../jsp/simages/modify2.gif', '../jsp/simages/delete2.gif', '../jsp/simages/save2.gif', '../jsp/simages/cancel2.gif', '../jsp/simages/reset2.gif')">
<%

	String action = request.getParameter("action");
	String action2 = "";
	ServletContext context   =   getServletContext();
	pool    =    (com.ngs.gbl.ConnectionPool)  getServletContext().getAttribute("ConPoolbse");
	Connection conn = null;
//	if((request.getParameter("action2")!="")||(request.getParameter("action2")!=null))
//	{action2=request.getParameter("action2");}
	String username1 = (String)session.getValue("username");
	//out.println("name : " + username1);

	if (action == "" || action==null)
	{
		out.println("<H4>Chapter Entry</H4><HR SIZE=1>");
		try
		{

			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="SELECT * FROM ExamMaster order by Exam" ;
			rs=stmt.executeQuery(sql);
%>
			<center>
			<form method=get action='<%= request.getRequestURI()%>'>

			Select Exam :<select name=examid>
<%
			while(rs.next())
			{
%>
				<option value=<%= rs.getInt("ExamID")%>><%= rs.getString("Exam")%></option>
<%
			}
%>
			</select><br><br>
			<input type=submit value=Enter>
			<input type=hidden name=action value='doMenu'>
			<input type=button value=Exit onclick='window.close();'>
			</form>
<%
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}

	}
	else if(action.equals("doMenu"))
	{
		int examid= Integer.parseInt(request.getParameter("examid"));
%>
		<H4>Code Entry Module</H4><HR SIZE=1>
		<CENTER>
		<FORM METHOD=POST action='<%= request.getRequestURI()%>'>
		<TABLE BORDER=0>
		<TR><TD>Subject</TD><TD><INPUT TYPE="radio" NAME="codename" value=1 checked></TD></TR>
		<TR><TD>Chapter</TD><TD><INPUT TYPE="radio" NAME="codename" value=2></TD></TR>
		<TR><TD>Topic</TD><TD><INPUT TYPE="radio" NAME="codename" value=3></TD></TR>
		<TR><TD>SubTopic</TD><TD><INPUT TYPE="radio" NAME="codename" value=4></TD></TR>
		<TR><TD>View</TD><TD><INPUT TYPE="radio" NAME="codename" value=5></TD></TR>
		</TABLE>
		<INPUT TYPE=HIDDEN NAME=action VALUE='doInn'>
		<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0>
		<input type=hidden name=examid value=<%=examid%>>
		<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
<%
	}
	else if (action.equals("doInn") )
	{
		int cdnum = Integer.parseInt(request.getParameter("codename"));
		int examid= Integer.parseInt(request.getParameter("examid"));

		if (cdnum==1)
		{
			try
			{
//				Connection conn = null;
				conn = pool.getConnection();
				Statement stmt = null;
				ResultSet rs = null;
				stmt = conn.createStatement();
				String examname="";
				String sql="SELECT * FROM ExamMaster where ExamID="+examid;
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{examname=rs.getString("Exam"); }

%>
				<H4>Subject Entry<H4><HR SIZE=1>
				<CENTER>
				<FORM METHOD=POST NAME=frmsubject action='<%= request.getRequestURI()%>'>
					<TABLE BORDER=0>
					<TR><TD>Define a new Subject for <b><%= examname%> :</b></TD><TD><INPUT TYPE="text" NAME="subname" size=30></TD></TR>
					</TABLE>

					<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0 onclick='return checksubnull();'>
					<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>

					<input type=hidden name=examid value=<%=examid%>>
					<INPUT TYPE=HIDDEN NAME=action VALUE='doSubject'>
				</FORM>
				<FORM METHOD=POST ACTION='ExamMaster.jsp'>

				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
				</FORM>
<%
			}
			catch(Exception e)
			{
				out.println("Error : "+ e.getMessage());
			}
			finally
			{
				if (conn != null)
					pool.releaseConnection(conn);
				else
					out.println ("Error while Connecting to Database.");
			}
		}
//  2
		if (cdnum==2)
		{
			out.println("<H4>Chapter Entry</H4><HR SIZE=1>");
			try
			{
//				Connection conn = null;
				conn = pool.getConnection();
				Statement stmt = null;
				ResultSet rs = null;
				stmt = conn.createStatement();
				String sql="SELECT * FROM CodeMaster where right(CodeID,6)='000000' and ExamId="+examid+" ORDER BY DESCRIPTION" ;
//out.println(sql);
				rs=stmt.executeQuery(sql);
%>
				<CENTER>
				<Form method=post action='<%= request.getRequestURI()%>'>
				<TABLE>
				<TR><TD>Select the Name of the Subject :</TD>
				<TD><select name=subcode>
<%
				while(rs.next())
				{
					out.println("<OPTION VALUE="+rs.getString("CodeID")+">"+rs.getString("Description")+"</OPTION>");
				}
%>
				</SELECT></TD>
				</TABLE>
				<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0>

				<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
				<INPUT TYPE=HIDDEN NAME=action VALUE='doChapter'>
				<input type=hidden name=examid value=<%=examid%>>
				</FORM>
				<FORM METHOD=POST ACTION='ExamMaster.jsp'>
				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
//3
		if (cdnum==3)
		{
			out.println("<H4>Topic Entry</H4><HR SIZE=1>");
			try
			{
//				Connection conn = null;
				conn = pool.getConnection();
				Statement stmt = null;
				ResultSet rs = null;
				stmt = conn.createStatement();
				String sql="SELECT * FROM CodeMaster where right(CodeID,6)='000000'  and ExamId="+examid+" ORDER BY DESCRIPTION" ;
				rs=stmt.executeQuery(sql);
%>
				<CENTER>
				<Form method=post action='<%= request.getRequestURI()%>'>

				<table>
				<tr><td>Select the Name of the subject :</td>
					<td><select name=subcode>
<%
				while(rs.next())
				{
					out.println("<OPTION VALUE="+rs.getString("CodeID")+">"+rs.getString("Description")+"</OPTION>");
				}
				out.println("</SELECT></td></tr>");
%>
				</table>

				<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0>

				<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
				<INPUT TYPE=HIDDEN NAME=action VALUE='doTopic'>
				<input type=hidden name=examid value=<%=examid%>>
				</FORM>
				<FORM METHOD=POST ACTION='ExamMaster.jsp'>
				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
// 4
		if (cdnum==4)
		{
			out.println("<H4>Sub Topic Entry</H4><HR SIZE=1>");
			try
			{
//				Connection conn = null;
				conn = pool.getConnection();
				Statement stmt = null;
				ResultSet rs = null;
				stmt = conn.createStatement();
				String sql="SELECT * FROM CodeMaster where right(CodeID,6)='000000'  and ExamId="+examid+" ORDER BY DESCRIPTION" ;
				rs=stmt.executeQuery(sql);
%>
				<CENTER>
				<Form METHOD=POST action='<%= request.getRequestURI()%>'>

				<table><tr>
						<td>Select the Name of the subject :</td>
						<td><select name=subcode>
<%
				while(rs.next())
				{
					out.println("<OPTION VALUE="+rs.getString("CodeID")+">"+rs.getString("Description")+"</OPTION>");
				}
				out.println("</SELECT></td></tr>");
%>
				<table>
<!--				<INPUT TYPE=image src="../jsp/simages/submit1.gif"> -->

				<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0>

				<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
				<INPUT TYPE=HIDDEN NAME=action VALUE='doSubTopic'>
				<input type=hidden name=examid value=<%=examid%>>
				</FORM>
				<FORM METHOD=POST ACTION='ExamMaster.jsp'>
				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
// 5
		if (cdnum==5)
		{
			out.println("<H4>View Code Master</H4><HR SIZE=1>");
			try
			{
				//int examid= Integer.parseInt(request.getParameter("examid"));
//out.println(examid);
//				Connection conn = null;
				conn = pool.getConnection();
				Statement stmt,stmt1 = null;
				ResultSet rs,rs1 = null;
				stmt = conn.createStatement();
				stmt1 = conn.createStatement();

				String sql="SELECT * FROM CodeMaster where right(CodeID,6) = '000000' and ExamID="+examid+" order by CodeID";
//out.println(sql);
				String pql="";
				int subcd=1;
				rs=stmt.executeQuery(sql);
%>
				<CENTER>
				<TABLE BORDER=0 BGCOLOR='#FEEEC*'>
				<TR BGCOLOR='#FEEEC*'><TD> <FONT COLOR='#960317'>Code</FONT></TD><TD><FONT COLOR='#960317'>Subject</FONT></TD><TD><FONT COLOR='#960317'>Chapter</FONT></TD><TD><FONT COLOR='#960317'>Topic</FONT></TD><TD><FONT COLOR='#960317'>Sub Topic</FONT></TD></TR>
				<TR><TD>
<%
				String subcode="",subjectcode="";
				while(rs.next())
				{
					String x=rs.getString("CodeID");
					subcd=Integer.parseInt(x.substring(0,2));
					if (subcd<10)
						subcode="0"+subcd;
					else
						subcode=""+subcd;
					pql="select * from CodeMaster where CodeID like '"+subcode+"%' and ExamID="+examid+ " order by CodeID";
					rs1=stmt1.executeQuery(pql);
					int count=0;
					String subname="",chapname="",topname="";
					while (rs1.next())
					{
						String b=rs1.getString("CodeID");
						String first=b.substring(0,2);
						int fr=Integer.parseInt(first);
						String second=b.substring(2,4);
						int scd=Integer.parseInt(second);
						String third=b.substring(4,6);
						int td=Integer.parseInt(third);
						String fourth=b.substring(6,8);
						int foth=Integer.parseInt(fourth);
//+"&val="+subname+"
						if (fr>0 && scd==0)
						{
							subname=rs1.getString("Description");
							out.print("<TR BGCOLOR='#FFF5E7'><TD>"+ rs1.getString("CodeID")+"</TD><TD>");
							out.print("<A href='"+request.getRequestURI()+"?action=doChange&examid="+examid+"&subname=Subject&namecode="+rs1.getString("CodeID")+"'>");
							out.print(subname);
							out.print("</A></TD><TD>&nbsp; </TD><TD>&nbsp; </TD><TD>&nbsp; </TD>");
							out.println("<td><a href='"+request.getRequestURI()+"?action=doChange&examid="+ examid+"&subname=Subject&namecode="+rs1.getString("CodeID")+"'><img src='../jsp/simages/modify.gif' border=0></a></td>");
							out.println("<td><a href='"+request.getRequestURI()+"?action=doDelete&examid="+ rs.getInt("ExamID")+"&codeid="+rs1.getString("CodeID")+"'><img src='../jsp/simages/delete.gif' border=0></td></a></td></tr>");
						}
						if(scd>0 && td==0)
						{
							chapname=rs1.getString("Description");
							out.print("<TR BGCOLOR='#FFF5E7'><TD>"+ rs1.getString("CodeID")+"</TD><TD> &nbsp;</TD><TD>");
							out.print("<a href='"+request.getRequestURI()+"?action=doChange&examid="+examid+"&subname=Chapter&namecode="+rs1.getString("CodeID")+"'>");
							out.print(chapname+"</TD><TD>&nbsp; </TD><TD>&nbsp; </TD>");
							out.println("<td><a href='"+request.getRequestURI()+"?action=doChange&examid="+ examid+"&subname=Chapter&namecode="+rs1.getString("CodeID")+"'><img src='../jsp/simages/modify.gif' border=0></a></td>");
							out.println("<td><a href='"+request.getRequestURI()+"?action=doDelete&examid="+ rs.getInt("ExamID")+"&codeid="+rs1.getString("CodeID")+"'><img src='../jsp/simages/delete.gif' border=0></td></a></tr>");
						}
						if (td>0 && foth==0)
						{
							topname=rs1.getString("Description");
							out.println("<TR BGCOLOR='#FFF5E7'><TD>"+ rs1.getString("CodeID")+"</TD><TD>&nbsp;</TD><TD>&nbsp;</TD><TD>");
							out.print("<a href='"+request.getRequestURI()+"?action=doChange&examid="+examid+"&subname=Topic&namecode="+rs1.getString("CodeID")+"'>");
							out.print(topname+"</TD><td>&nbsp; </td>");
							out.println("<td><a href='"+request.getRequestURI()+"?action=doChange&examid="+ examid+"&subname=Topic&namecode="+rs1.getString("CodeID")+"'><img src='../jsp/simages/modify.gif' border=0></a></td>");
							out.println("<td><a href='"+request.getRequestURI()+"?action=doDelete&examid="+ rs.getInt("ExamID")+"&codeid="+rs1.getString("CodeID")+"'><img src='../jsp/simages/delete.gif' border=0></td></a></td></tr>");
						}
						if (foth>0)
						{
							out.println("<TR BGCOLOR='#FFF5E7'><TD>"+ rs1.getString("CodeID")+"</TD><TD>&nbsp;</TD><TD>&nbsp; </TD><td>&nbsp; </td><TD>");
							out.print("<a href='"+request.getRequestURI()+"?action=doChange&examid="+examid+"&subname=SubTopic&namecode="+rs1.getString("CodeID")+"'>");
							out.print(rs1.getString("Description")+"</TD>");
							out.println("<td><a href='"+request.getRequestURI()+"?action=doChange&examid="+ examid+"&subname=SubTopic&namecode="+rs1.getString("CodeID")+"'><img src='../jsp/simages/modify.gif' border=0></a></td>");
							out.println("<td><a href='"+request.getRequestURI()+"?action=doDelete&examid="+ rs.getInt("ExamID")+"&codeid="+rs1.getString("CodeID")+"'><img src='../jsp/simages/delete.gif' border=0></td></a></td></tr>");
						}

					}
					subcd++;
				}
%>
</TABLE>
<FORM METHOD=GET ACTION='ExamMaster.jsp'>
<INPUT TYPE=SUBMIT VALUE=Home>
<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
</FORM>

</CENTER>
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

	}
// doSubject
	else if (action.equals("doSubject") )
	{
		try
		{
			String subname = request.getParameter("subname");
//	out.println(subname);
			int examid= Integer.parseInt(request.getParameter("examid"));
//out.println(examid);
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="SELECT * FROM CodeMaster where ExamID="+examid+" order by CodeID";
			rs=stmt.executeQuery(sql);
			int num=00;
			while(rs.next())
			{
				String subcode=rs.getString("CodeID");
				num=Integer.parseInt(subcode.substring(0,2));
			}
			num=num+1;
			String code="",examname="";
			if (num<10)
				code = "0"+ num + "000000";
			else
				code = ""+ num + "000000";
			sql="select Exam from ExamMaster where ExamID="+examid;
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				examname=rs.getString("Exam");
			}
			sql="INSERT INTO CodeMaster (ExamID,CodeID,Description) values ("+examid+",'"+code+"','"+subname+"')";
			int records = stmt.executeUpdate(sql);
			if (records > 0 )
			{
				out.println("<H4>"+records + " Subject sucessfully inserted !!</H4><HR size=1>");
				sql="SELECT * FROM CodeMaster where CodeID='" + code + "' and Description='"+subname+"'";
//out.println(sql);
				rs=stmt.executeQuery(sql);
				int count=1;
%>
				<CENTER>
				<TABLE BORDER=1>
				<TR BGCOLOR='#bfd2ec'><TD>Sr. No.</TD><TD>Code</TD><TD>Description</TD></TR>
				<TR><TD>
<%
				while(rs.next())
				{
					out.println("<TR><TD>"+ count +"</TD><TD>"+ rs.getString("CodeID")+"</TD><TD>"+ rs.getString("Description")+"</TD></TR>");
					count++;
				}
%>
				</TABLE>
				<FORM METHOD=POST ACTION='<%=request.getRequestURI()%>'>
				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
				<INPUT TYPE=HIDDEN name=examid value=<%=examid%>>
				<INPUT TYPE=HIDDEN name=action value='doMenu'>
				</FORM>
				<FORM METHOD=POST ACTION='<%=request.getRequestURI()%>'>
				<INPUT TYPE=SUBMIT VALUE='Enter more subjects'>
				<INPUT TYPE=HIDDEN name=examid value=<%=examid%>>
				<INPUT TYPE=HIDDEN name=codename value=1>
				<INPUT TYPE=HIDDEN name=action value='doInn'>
				</FORM>

<%
			}
			else
				out.println("Error in Inserting Subject !!");
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
// doChapter
	else if (action.equals("doChapter") )
	{
		String subcode=request.getParameter("subcode");
//out.println(subcode);
		int examid= Integer.parseInt(request.getParameter("examid"));
		out.println("<H4>Chapter Entry</H4><HR SIZE=1>");
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="SELECT * FROM CodeMaster where CodeID='"+subcode+"'" ;
			rs=stmt.executeQuery(sql);
			String subname="";
			if(rs.next())
			{
				subname=rs.getString("Description");
			}
%>
			<CENTER>
			<FORM METHOD=POST action="<%=request.getRequestURI()%>" NAME=frmchap>
			<table><tr>
			<td>Enter Chapter Name :</td>
			<INPUT TYPE=HIDDEN size=10 NAME=subcode value=<%=subcode%>>
			<td><INPUT TYPE=TEXT NAME=chapname></td>
			</tr></table>
			<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0 onclick='return chapnull();'>

			<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>

			<INPUT TYPE=HIDDEN NAME=action VALUE='doSaveChapter'>
			<INPUT TYPE=HIDDEN NAME=examid VALUE=<%=examid%>>
			</FORM>
			<FORM METHOD=POST ACTION='ExamMaster.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
	else if (action.equals("doSaveChapter") )
	{
		try
		{
			String chapter = request.getParameter("chapname");
			String subcode= request.getParameter("subcode");
			int examid= Integer.parseInt(request.getParameter("examid"));
			out.println("<H4>Chapter Entry</H4><HR SIZE=1>");

			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			subcode=subcode.substring(0,2);
			String sql="SELECT * FROM CodeMaster where left(CodeID,2)='"+subcode+"' and ExamID="+examid+" order by CodeID" ;
			rs=stmt.executeQuery(sql);
			int num=00;
			while(rs.next())
			{
				String subcode1=rs.getString("CodeID");
				num=Integer.parseInt(subcode1.substring(2,4));
			}
			num=num+1;
			String chapcode="";
			if(num<10)
				chapcode="0"+num;
			else
				chapcode=""+num;
			String code=subcode+chapcode+"0000";
			sql="INSERT INTO CodeMaster (ExamId,CodeID,Description) values ("+examid+",'"+code+"','"+chapter+"')";
			int records = stmt.executeUpdate(sql);
			if (records > 0)
			{
				out.println("<H4>"+records + " Subject sucessfully inserted !!</H4>");
				sql="SELECT * FROM CodeMaster where CodeID='" + code + "' and ExamID=" + examid;
				rs=stmt.executeQuery(sql);
%>
				<CENTER>
				<TABLE BORDER=1>
				<TR BGCOLOR='#bfd2ec'><TD>Code</TD><TD>Description</TD></TR>
				<TR><TD>
<%
				while(rs.next())
				{
					out.println("<TR><TD>"+ rs.getString("CodeID")+"</TD><TD>"+ rs.getString("Description")+"</TD></TR>");
				}
%>
				</TABLE>
				<FORM METHOD=POST ACTION='ExamMaster.jsp'>
				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
				</FORM>
				<form METHOD=POST ACTION='<%=request.getRequestURI()%>'>
				<INPUT TYPE=submit VALUE='Enter more chapters'>
				<INPUT TYPE=HIDDEN NAME=action VALUE='doChapter'>
				<INPUT TYPE=HIDDEN NAME=examid VALUE=<%=examid%>>
				<INPUT TYPE=HIDDEN NAME=subcode VALUE=<%=subcode%>>
				</form>


<%
			}
			else
				out.println("Error in Inserting the subject");
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
// doTopic
	else if (action.equals("doTopic") )
	{
		try
		{
			String subcode = request.getParameter("subcode");
			int examid= Integer.parseInt(request.getParameter("examid"));
			out.println("<H4>Topic Entry </H4><HR SIZE=1>");

			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="SELECT Description FROM CodeMaster where CodeID='"+subcode+"' and ExamID="+examid ;
			rs=stmt.executeQuery(sql);
			out.println("<FORM METHOD=post>");
			subcode=subcode.substring(0,2);
			out.println("<CENTER>");
			String subname="";
			while(rs.next())
			{
				subname= rs.getString("Description");
			}
			out.println("<table>");
			out.println("<tr><td>Subject Name : </td><td>" + subname+"</td></tr>");
			out.println("<tr><td>Select chapter :</td>");
			sql="SELECT * FROM CodeMaster where right(left(CodeID,4),2) != '00' and right(CodeID,4) = '0000' and left(CodeID,2) ='"+ subcode+"' and ExamID=" + examid +" order by CodeID";
//out.println(sql);
			rs=stmt.executeQuery(sql);
			out.println("<td><select name=chapcode>");
			while(rs.next())
			{
				out.println("<option value="+rs.getString("CodeID")+">"+rs.getString("Description")+"</option>");
			};
			out.println("</select></td></tr>");
%>
			</table>
			<INPUT TYPE=HIDDEN NAME='action' VALUE='doTopicEnter'>
			<input type=hidden name=examid value=<%=examid%>>

			<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0 >

			<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>

			</FORM>
			<FORM METHOD=POST ACTION='ExamMaster.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
	else if (action.equals("doTopicEnter") )
	{
		String chaptercode = request.getParameter("chapcode");
		int examid= Integer.parseInt(request.getParameter("examid"));
		out.println("<H4>Topic Entry </H4><HR SIZE=1>");
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String subcode=chaptercode.substring(0,2);
			String subjectcode=subcode+"000000";
			String chapcode=chaptercode.substring(2,4);
			chapcode=subcode+chapcode+"0000";
			String sql="SELECT * FROM CodeMaster where CodeID='"+subjectcode+"' and ExamID="+examid ;
			rs=stmt.executeQuery(sql);
			out.println("<CENTER>");
			out.println("<form method=post name=frmtopic>");
			String subname="";
			while(rs.next())
			{
				subname= rs.getString("Description");
			}
			sql="SELECT * FROM CodeMaster where CodeID='"+chapcode+"' and ExamID=" +examid ;
			rs=stmt.executeQuery(sql);
			String chapname="";
			while(rs.next())
			{
				chapname= rs.getString("Description");
			}
%>
			<table>
			<tr><td>Subject Name :</td><td><%=subname%></td></tr>
			<tr><td>Chapter Name :</td><td><%= chapname%></td></tr>
			<tr><td>Enter the name of Topic : </td><td><INPUT TYPE=TEXT size=20 NAME=topicname></td></tr>
			</table>

			<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0 onclick='return topicnull();'>

			<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
			<INPUT TYPE=HIDDEN NAME=action VALUE='doSaveTopic'>
			<INPUT TYPE=HIDDEN NAME=examid VALUE=<%=examid%>>
			<INPUT TYPE=HIDDEN NAME=chaptercode VALUE=<%=chaptercode%>>
			</form>

			<FORM METHOD=POST ACTION='ExamMaster.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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

	//////////////////////////////////////////////       check icrementation
	else if (action.equals("doSaveTopic"))
	{
		out.println("<H4>Topic Entry </H4><HR SIZE=1>");
		String chapcode = request.getParameter("chaptercode");
		String topicname=request.getParameter("topicname");
		int examid= Integer.parseInt(request.getParameter("examid"));
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String subchap = chapcode.substring(0,4);

			String topiccode="";
			int topc=Integer.parseInt(chapcode.substring(4,6));
//out.println(topc);

			String sql="select * from CodeMaster where left(CodeID,4)='"+subchap+"' and ExamID="+examid+" order by CodeID";
//out.println(sql);
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				topc=topc+1;
			}
			if (topc<10)
				topiccode="0"+topc;
			else
				topiccode=""+topc;
			topiccode= subchap+topiccode+"00";

			sql="INSERT INTO CodeMaster (ExamID,CodeID,Description) values ("+examid+",'"+topiccode+"','"+topicname+"')";
out.println(sql);
			int records = stmt.executeUpdate(sql);
			if (records>0)
			{
				out.println("<H4>"+records + " Subject sucessfully inserted !!</H4>");
				sql="SELECT * FROM CodeMaster where CodeID='" + topiccode + "' and ExamID=" + examid;
				rs=stmt.executeQuery(sql);
%>
				<CENTER>
				<TABLE BORDER=1>
				<TR BGCOLOR='#bfd2ec'><TD>Code</TD><TD>Description</TD></TR>
				<TR><TD>
<%
				while(rs.next())
				{
					out.println("<TR><TD>"+ rs.getString("CodeID")+"</TD><TD>"+ rs.getString("Description")+"</TD></TR>");
				}
%>
				</TABLE>
				<FORM METHOD=POST ACTION='<%=request.getRequestURI()%>'>
				<INPUT TYPE=SUBMIT VALUE=Home>
				</FORM>
				<FORM METHOD=POST ACTION='<%=request.getRequestURI()%>'>
				<INPUT TYPE=submit VALUE='Enter more topic'>
				<INPUT TYPE=HIDDEN NAME='action' VALUE='doTopicEnter'>
				<input type=hidden name=examid value=<%=examid%>>
				<input type=hidden name=chapcode value=<%=chapcode%>>
				</FORM>

<%
			}
			else
				out.println("Error in Inserting Subject !!");
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
	else if (action.equals("doSubTopic") )
	{
		String subcode = request.getParameter("subcode");
		int examid= Integer.parseInt(request.getParameter("examid"));
		out.println("<H4>Sub Topic Entry </H4><HR SIZE=1>");
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="SELECT Description FROM CodeMaster where CodeID='"+subcode+"' and ExamID=" + examid + " order by CodeID";
			rs=stmt.executeQuery(sql);
			out.println("<FORM METHOD=post>");
			subcode=subcode.substring(0,2);
			out.println("<CENTER>");
			String subname="";
			while(rs.next())
			{
				subname= rs.getString("Description");
			}
			out.println("<table>");
			out.println("<tr><td>Subject Name : </td><td>" + subname + "</td></tr>");
			out.println("<tr><td>Select chapter :</td>");
			sql="SELECT * FROM CodeMaster where right(left(CodeID,4),2) != '00' and right(CodeID,4) = '0000' and left(CodeID,2) ='"+ subcode+"' and ExamID="+ examid + " order by CodeID" ;
			rs=stmt.executeQuery(sql);
			out.println("<td><select name=chapcode>");
			while(rs.next())
			{
				out.println("<option value="+rs.getString("CodeID")+">"+rs.getString("Description")+"</option>");
			};
			out.println("</select></td><tr>");
%>
			</table>
			<INPUT TYPE=HIDDEN NAME='action' VALUE='doSubTopicChap'>
			<INPUT TYPE=HIDDEN NAME=examid VALUE=<%=examid%>>

			<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0 >

			<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>

			</FORM>
			<FORM METHOD=POST ACTION='ExamMaster.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
	else if (action.equals("doSubTopicChap") )
	{
		String code = request.getParameter("chapcode");
		int examid= Integer.parseInt(request.getParameter("examid"));
		out.println("<H4>Sub Topic Entry </H4><HR SIZE=1>");

		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String subject=code.substring(0,2);
			String subcode=subject+"000000";
			String chapter=code.substring(2,4);
			String chapcode=subject+chapter+"0000";

			String sql="SELECT Description FROM CodeMaster where CodeID='"+subcode+"' and ExamID=" +examid + " order by CodeID";
			rs=stmt.executeQuery(sql);
			out.println("<FORM METHOD=post>");

			out.println("<CENTER>");
			String subname="";
			while(rs.next())
			{
				subname= rs.getString("Description");
			}
			sql="SELECT Description FROM CodeMaster where CodeID='"+chapcode+"' and ExamID=" + examid ;
			rs=stmt.executeQuery(sql);
			String chapname="";
			while(rs.next())
			{
				chapname= rs.getString("Description");
			}
			out.println("<table>");
			out.println("<tr><td>Subject Name : </td><td>" + subname + "</td></tr>");
			out.println("<tr><td>chapter Name : </td><td>" + chapname+ "</td></tr>");
			sql="SELECT * FROM CodeMaster where left(CodeID,2) ='"+subject+"' and right(left(CodeID,4),2) = '"+chapter+"' and right(CodeID,2) = '00' and left(right(CodeID,4),2) != '00' and ExamID="+ examid + " order by CodeID";
			rs=stmt.executeQuery(sql);
			out.println("<tr><td>Select Topic Name :</td><td>");
			out.println("<select name=chapcode>");
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				out.println("<option value="+rs.getString("CodeID")+">"+rs.getString("Description")+"</option>");
			}
			out.println("</select></td></tr>");
			out.println("</table>");
			out.println("<INPUT TYPE=HIDDEN NAME=code VALUE='"+code+"'>");
%>
			<INPUT TYPE=HIDDEN NAME='action' VALUE='doSubTopicSave'>
			<INPUT TYPE=HIDDEN NAME=examid VALUE=<%=examid%>>
			<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0 >

			<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
			</FORM>
			<FORM METHOD=POST ACTION='ExamMaster.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
	else if (action.equals("doSubTopicSave"))
	{
		out.println("<H4>Sub Topic Entry </H4><HR SIZE=1>");
		int examid= Integer.parseInt(request.getParameter("examid"));
		String code = request.getParameter("chapcode");
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String subcode=code.substring(0,2);
			String subject = subcode+"000000";
			String chapcode=code.substring(2,4);
			String chapter = subcode+chapcode+"0000";
			String topiccode=code.substring(4,6);
			String topic = subcode+chapcode+topiccode+"00";

			String sql="select * from CodeMaster where CodeID="+subject +" and ExamID=" + examid + " order by CodeID";
//out.println(sql);

			rs=stmt.executeQuery(sql);
			out.println("<center>");
			out.println("<FORM METHOD=POST name=frmsubtopic>");
			out.println("<table>");
			while(rs.next())
			{
				out.println("<tr><td>Subject Name : </td><td>" + rs.getString("Description")+"</td></tr>");
			}
			sql="select * from CodeMaster where CodeID="+chapter+" and ExamID=" + examid + " order by CodeID";

			rs=stmt.executeQuery(sql);
			if(rs.next())
			{
				out.println("<br><tr><td>Chapter Name : </td><td>" + rs.getString("Description")+"</td></tr>");
			}
			sql="select * from CodeMaster where CodeID="+topic+" and ExamID=" + examid + " order by CodeID";

			rs=stmt.executeQuery(sql);
			if(rs.next())
			{
				out.println("<br><tr><td>Topic Name : </td><td>" + rs.getString("Description")+"</td></tr>");
			}
			out.println("<br><tr><td>Enter Sub Topic Name : </td><td>");
			out.println("<INPUT TYPE=TEXT NAME=topicname></td></tr>");
			out.println("</table>");
			out.println("<INPUT TYPE=image src='../jsp/simages/submit1.gif' name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)\" border=0 onclick='return subtopicnull();'>");

			out.println("<INPUT TYPE=image src='../jsp/simages/cancel1.gif' name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)\" border=0 onclick='return previous();'>");

			out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doSave'>");
			out.println("<INPUT TYPE=HIDDEN NAME=examid VALUE="+examid+">");
			out.println("<INPUT TYPE=HIDDEN NAME=code VALUE='"+code+"'>");
			out.println("</form>");
%>

			<FORM METHOD=POST ACTION='ExamMaster.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
	else if (action.equals("doSave"))
	{
		out.println("<H4>Topic Entry </H4><HR SIZE=1>");
		String code = request.getParameter("code");
		String topicname = request.getParameter("topicname");
		int examid= Integer.parseInt(request.getParameter("examid"));
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String subchaptop = code.substring(0,6);
			String subcode="";
			int topc=Integer.parseInt(code.substring(6,8));

			String sql="select * from CodeMaster where left(CodeID,6)='"+subchaptop+"' and ExamID="+examid+" order by CodeID";

			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				topc=topc+1;
			}
			if (topc<10)
				subcode="0"+topc;
			else
				subcode=""+topc;
			String topiccode= subchaptop+subcode;

			sql="INSERT INTO CodeMaster (ExamID,CodeID,Description) values ("+examid+",'"+topiccode+"','"+topicname+"')";
			int records = stmt.executeUpdate(sql);
			if(records>0)
			{
				out.println("<H4>"+records + " Subject sucessfully inserted !!</H4>");
				sql="SELECT * FROM CodeMaster where CodeID='" + topiccode + "' and ExamID="+examid + " order by CodeID";
				rs=stmt.executeQuery(sql);
%>
				<CENTER>
				<TABLE BORDER=1>
				<TR BGCOLOR='#bfd2ec'><TD>Code</TD><TD>Description</TD></TR>
				<TR><TD>
<%
				while(rs.next())
				{
					out.println("<TR><TD>"+ rs.getString("CodeID")+"</TD><TD>"+ 	rs.getString("Description")+"</TD></TR>");
				}
%>
				</TABLE>
				<FORM METHOD=POST ACTION='<%=request.getRequestURI()%>'>
				<INPUT TYPE=submit VALUE='Enter more subtopics'>
				<INPUT TYPE=HIDDEN NAME='action' VALUE='doSubTopicSave'>
				<INPUT TYPE=HIDDEN NAME=examid VALUE=<%=examid%>>
				<INPUT TYPE=HIDDEN NAME=chapcode VALUE=<%=code%>>
				</FORM>
				<FORM METHOD=POST ACTION='ExamMaster.jsp'>
				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
				</FORM>
<%
			}
			else
				out.println("Error in Inserting Subject !!");
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
	else if (action.equals("doEdit"))
	{
		out.println("<H4>Edit </H4><HR SIZE=1>");
		int code = Integer.parseInt(request.getParameter("code"));
		int examid = Integer.parseInt(request.getParameter("examid"));
		String val=request.getParameter("val");
		String sql="";
		String subname="";
		String newname="";

		switch(code)
		{
			case 1:
				sql="select * from CodeMaster where left(CodeID,2) != '00' and right(CodeID,6) ='000000'  and ExamId="+examid+" order by Description";
				subname="Subject";
				break;
			case 2:
				sql="select * from CodeMaster where right(left(CodeID,4),2) != '00' and right(CodeID,4)='0000'  and ExamId="+examid+" order by Description";
				subname="Chapter";
				break;
			case 3:
				sql="select * from CodeMaster where left(right(CodeID,4),2) != '00' and right(CodeID,2)='00'  and ExamId="+examid+" order by Description";
				subname="Topic";
				break;
			case 4:
				sql="select * from CodeMaster where  right(CodeID,2)!='00'  and ExamId="+examid+" order by Description";
				subname="SubTopic";
				break;
		}
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			rs=stmt.executeQuery(sql);
%>
			<CENTER>
			<FORM METHOD=POST>
			<TABLE BORDER=0>
			<TR><TD>Select <%=subname %> Name : </TD>
			<TD><Select name=namecode>
%>
<%
			while(rs.next())
			{
				out.println("<option value="+ rs.getString("CodeID")+">"+ 	rs.getString("Description")+"</option>");
			}
%>
			</SELECT>
			</TD></TR></TABLE>
			<INPUT TYPE=SUBMIT VALUE=Enter>
			<INPUT TYPE=HIDDEN NAME=action VALUE='doChange'>
			<INPUT TYPE=HIDDEN NAME=subname VALUE=<%=subname%>>
			<INPUT TYPE=HIDDEN NAME=examid VALUE=<%=examid%>>
			</FORM>
			<FORM METHOD=POST ACTION='ExamMaster.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
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
	else if(action.equals("doChange"))
	{
		out.println("<H4>Edit </H4><HR SIZE=1>");
		int examid = Integer.parseInt(request.getParameter("examid"));
		String subname=request.getParameter("subname");
		String namecode=request.getParameter("namecode");
//		String val=request.getParameter("val");
		String navanam="";
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="select * from CodeMaster where CodeID='"+namecode+"' and ExamID="+examid+"";
//out.println(sql);
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				navanam=rs.getString("Description");
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
%>
		<CENTER>
		<FORM name=frmChange action="<%=request.getRequestURI()%>" METHOD=POST>
		<TABLE><TR>
			<TD>Enter new name for <B><%= subname %> :</B></TD>
			<TD><INPUT TYPE=TEXT size=50 NAME=newname VALUE="<%= navanam %>"></TD>
		</TR></TABLE>
		<INPUT TYPE=HIDDEN NAME="action" VALUE="doPack">

		<INPUT TYPE=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0 onclick='return changenull();'>

		<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>

		<INPUT TYPE=HIDDEN NAME=subname VALUE=<%= subname %>>
		<INPUT TYPE=HIDDEN NAME=examid VALUE=<%= examid %>>
		<INPUT TYPE=HIDDEN NAME=namecode VALUE=<%= namecode %>>
		</FORM>

		<FORM METHOD=POST ACTION='ExamMaster.jsp'>
		<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >
		</FORM>

<%

	}
	else if (action.equals("doPack"))
	{
		out.println("<H4>Save </H4><HR SIZE=1>");
		String newname=request.getParameter("newname");
		String namecode=request.getParameter("namecode");
		int examid = Integer.parseInt(request.getParameter("examid"));
		try
		{
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="update CodeMaster set Description='"+newname+"' where CodeID='"+namecode+"' and ExamID="+examid;
			int records=stmt.executeUpdate(sql);
			if(records>0)
			{
				out.println("<H4>"+records + " Record Sucessfully Modified !!</H4>");
				sql="SELECT * FROM CodeMaster where CodeID='" + namecode + "'and ExamID="+examid;
				rs=stmt.executeQuery(sql);
%>
				<CENTER>
				<TABLE BORDER=1>
				<TR BGCOLOR='#bfd2ec'><TD>Code</TD><TD>Description</TD></TR>
				<TR><TD>
<%
				while(rs.next())
				{
					out.println("<TR><TD>"+ rs.getString("CodeID")+"</TD><TD>"+ 	rs.getString("Description")+"</TD></TR>");
				}
%>
				</TABLE>
				<FORM METHOD=POST ACTION='<%=request.getRequestURI()%>'>
				<INPUT TYPE=SUBMIT VALUE=Home>
				</FORM>
<%
			}
			else
				out.println("Error in Modification !!");
		}
		catch(Exception e)
		{
			out.println("Error : "+ e.getMessage());
		}
		finally
		{
			if (conn != null)
				pool.releaseConnection(conn);
	        else
		        out.println ("Error while Connecting to Database.");
		}
	}
	else if (action.equals("doDelete"))
	{
		out.println("<H4>Delete </H4><HR SIZE=1>");
		try
		{
			int examid = Integer.parseInt(request.getParameter("examid"));
			String codeid = request.getParameter("codeid");
			String subject=codeid.substring(0,2);
			String chapter=codeid.substring(2,4);
			String topic=codeid.substring(4,6);

			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="";
			int records=0;

			if (codeid.substring(2,8).equals("000000"))
			{
				sql="select count(*) from CodeMaster where left(CodeID,2) =" + subject +" and ExamID="+ examid;
//out.println(sql);
				rs=stmt.executeQuery(sql);
				if (rs.next())
				{
					records=rs.getInt(1);
				}
				if(records>1)
				{
					sql="select * from CodeMaster where left(CodeID,2) =" + subject +" and ExamID=" +examid + " order by CodeID";
%>
					<CENTER>
					<FORM METHOD=POST NAME=frmdelete action='<%=request.getRequestURI()%>'>
					<b>All the following Records will be deleted !!</b>
					<TABLE BORDER=0>
					<TR BGCOLOR='#FEEEC*'><TD> <FONT COLOR='#960317'>Exam ID</FONT></TD><TD><FONT COLOR='#960317'>Code ID</FONT></TD><TD><FONT COLOR='#960317'>Description</FONT></TD></TR>
<%
					rs=stmt.executeQuery(sql);
					while(rs.next())
					{
						out.println("<TR BGCOLOR='#FFF5E7'><TD>"+rs.getString("ExamID")+"</TD><TD>"+rs.getString("CodeID")+"</TD><TD>"+rs.getString("Description")+"</TD><TR>");
					}
					out.println("</table>");
%>
					<input type=hidden name=action value='doSubDelete'>
					<input type=hidden name=examid value=<%=examid%>>
					<input type=hidden name=codeid value=<%=codeid%>>

					<INPUT TYPE=image src="../jsp/simages/delete1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/delete2.gif',1)" border=0 >
					<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
					</form>


<%
				} // end  if
				else
				{
//out.println("one subject");
					sql="select * from CodeMaster where CodeID="+codeid + " and ExamID=" +examid;
%>
					<CENTER>
					<FORM METHOD=POST NAME=frmdelete action='<%=request.getRequestURI()%>'>

					<TABLE BORDER=0>
					<TR BGCOLOR='#FEEEC*'><TD> <FONT COLOR='#960317'>Exam ID</FONT></TD><TD><FONT COLOR='#960317'>Code ID</FONT></TD><TD><FONT COLOR='#960317'>Description</FONT></TD></TR>
<%
					rs=stmt.executeQuery(sql);
					while(rs.next())
					{
						out.println("<TR BGCOLOR='#FFF5E7'><TD>"+rs.getString("ExamID")+"</TD><TD>"+rs.getString("CodeID")+"</TD><TD>"+rs.getString("Description")+"</TD><TR>");
					}
					out.println("</table>");
%>

					<input type=hidden name=action value='doKill'>
					<input type=hidden name=examid value=<%=examid%>>
					<input type=hidden name=codeid value=<%=codeid%>>
					<INPUT TYPE=image src="../jsp/simages/delete1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/delete2.gif',1)" border=0 >
					<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
					</form>

<%
				}
			}
			else if (codeid.substring(4,8).equals("0000"))
			{
				String cd=subject+chapter;
				sql="select count(*) from CodeMaster where  ExamID=" +examid + " and left(CodeID,4) like '"+cd+"' order by CodeID";

//out.println(sql);
				rs=stmt.executeQuery(sql);
				if (rs.next())
				{
					records=rs.getInt(1);
				}
				if(records>1)
				{
//out.println("more records");
				sql="select * from CodeMaster where  ExamID=" +examid + " and left(CodeID,4) like '"+cd+"' order by CodeID";
%>
				<CENTER>
				<FORM METHOD=POST NAME=frmdelete action='<%=request.getRequestURI()%>'>
				<b>All the following Records will be deleted !!</b>
				<TABLE BORDER=0>
				<TR BGCOLOR='#FEEEC*'><TD> <FONT COLOR='#960317'>Exam ID</FONT></TD><TD><FONT COLOR='#960317'>Code ID</FONT></TD><TD><FONT COLOR='#960317'>Description</FONT></TD></TR>
<%
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
					out.println("<TR BGCOLOR='#FFF5E7'><TD>"+rs.getString("ExamID")+"</TD><TD>"+rs.getString("CodeID")+"</TD><TD>"+rs.getString("Description")+"</TD><TR>");
				}
				out.println("</table>");
%>
					<input type=hidden name=action value='doChapDelete'>
					<input type=hidden name=examid value=<%=examid%>>
					<input type=hidden name=codeid value=<%=codeid%>>
					<input type=hidden name=cd value=<%=cd%>>

					<INPUT TYPE=image src="../jsp/simages/delete1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/delete2.gif',1)" border=0 >
					<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
					</form>

<%
				}
				else
				{
//out.println("one chapter");
					sql="select * from CodeMaster where  ExamID=" +examid + " and CodeID='"+codeid+"' order by CodeID";
%>
				<CENTER>
				<FORM METHOD=POST NAME=frmdelete action='<%=request.getRequestURI()%>'>
				<TABLE BORDER=0>
				<TR BGCOLOR='#FEEEC*'><TD> <FONT COLOR='#960317'>Exam ID</FONT></TD><TD><FONT COLOR='#960317'>Code ID</FONT></TD><TD><FONT COLOR='#960317'>Description</FONT></TD></TR>
<%
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
					out.println("<TR BGCOLOR='#FFF5E7'><TD>"+rs.getString("ExamID")+"</TD><TD>"+rs.getString("CodeID")+"</TD><TD>"+rs.getString("Description")+"</TD><TR>");
				}
				out.println("</table>");
%>
					<input type=hidden name=action value='doKill'>
					<input type=hidden name=examid value=<%=examid%>>
					<input type=hidden name=codeid value=<%=codeid%>>

					<INPUT TYPE=image src="../jsp/simages/delete1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/delete2.gif',1)" border=0 >
					<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
					</form>

<%
				}
			}
			else if (codeid.substring(6,8).equals("00"))
			{
//out.println("in topic");
				String cd=subject+chapter+topic;
				sql="select count(*) from CodeMaster where  ExamID=" +examid + " and left(CodeID,6) like '"+cd+"' order by CodeID";
//out.println(sql);
				rs=stmt.executeQuery(sql);
				if (rs.next())
				{
					records=rs.getInt(1);
				}
				if(records>1)
				{
				sql="select * from CodeMaster where  ExamID=" +examid + " and left(CodeID,6) like '"+subject+chapter+topic+"' order by CodeID";
%>
				<CENTER>
				<FORM METHOD=POST NAME=frmdelete action='<%=request.getRequestURI()%>'>
				<b>All the following Records will be deleted !!</b>
				<TABLE BORDER=0>
				<TR BGCOLOR='#FEEEC*'><TD> <FONT COLOR='#960317'>Exam ID</FONT></TD><TD><FONT COLOR='#960317'>Code ID</FONT></TD><TD><FONT COLOR='#960317'>Description</FONT></TD></TR>
<%
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
					out.println("<TR BGCOLOR='#FFF5E7'><TD>"+rs.getString("ExamID")+"</TD><TD>"+rs.getString("CodeID")+"</TD><TD>"+rs.getString("Description")+"</TD><TR>");
				}
				out.println("</table>");
%>
					<input type=hidden name=action value='doTopicDelete'>
					<input type=hidden name=examid value=<%=examid%>>
					<input type=hidden name=codeid value=<%=codeid%>>
					<input type=hidden name=cd value=<%=cd%>>

					<INPUT TYPE=image src="../jsp/simages/delete1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/delete2.gif',1)" border=0 >
					<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
					</form>

<%
				}
				else
				{
//out.println("one topic");
					sql="select * from CodeMaster where  ExamID=" +examid + " and CodeID='"+codeid+"'  order by CodeID";
//out.println(sql);
				rs=stmt.executeQuery(sql);

%>
				<CENTER>
				<FORM METHOD=POST NAME=frmdelete action='<%=request.getRequestURI()%>'>

				<TABLE BORDER=0>
				<TR BGCOLOR='#FEEEC*'><TD> <FONT COLOR='#960317'>Exam ID</FONT></TD><TD><FONT COLOR='#960317'>Code ID</FONT></TD><TD><FONT COLOR='#960317'>Description</FONT></TD></TR>
<%
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
					out.println("<TR BGCOLOR='#FFF5E7'><TD>"+rs.getString("ExamID")+"</TD><TD>"+rs.getString("CodeID")+"</TD><TD>"+rs.getString("Description")+"</TD><TR>");
				}
				out.println("</table>");
%>
					<input type=hidden name=action value='doKill'>
					<input type=hidden name=examid value=<%=examid%>>
					<input type=hidden name=codeid value=<%=codeid%>>

					<INPUT TYPE=image src="../jsp/simages/delete1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/delete2.gif',1)" border=0 >
					<INPUT TYPE=image src="../jsp/simages/cancel1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
					</form>
<%
				}
			}
			else
			{
//out.println("in subtopic");
				sql="select * from CodeMaster where  ExamID=" +examid + " and CodeID='"+codeid+"'  order by CodeID";
//out.println(sql);
				rs=stmt.executeQuery(sql);

%>
				<CENTER>
				<FORM METHOD=POST NAME=frmdelete action='<%=request.getRequestURI()%>'>

				<TABLE BORDER=0>
				<TR BGCOLOR='#FEEEC*'><TD> <FONT COLOR='#960317'>Exam ID</FONT></TD><TD><FONT COLOR='#960317'>Code ID</FONT></TD><TD><FONT COLOR='#960317'>Description</FONT></TD></TR>
<%
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
					out.println("<TR BGCOLOR='#FFF5E7'><TD>"+rs.getString("ExamID")+"</TD><TD>"+rs.getString("CodeID")+"</TD><TD>"+rs.getString("Description")+"</TD><TR>");
				}
				out.println("</table>");
%>
					<input type=hidden name=action value='doKill'>
					<input type=hidden name=examid value=<%=examid%>>
					<input type=hidden name=codeid value=<%=codeid%>>

					<INPUT TYPE=image src="../jsp/simages/delete1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/delete2.gif',1)" border=0 >

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
	else if(action.equals("doKill"))
	{
		out.println("<H4>Delete </H4><HR SIZE=1>");
		try
		{
			int examid = Integer.parseInt(request.getParameter("examid"));
			String codeid = request.getParameter("codeid");

			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();

			String sql="delete from CodeMaster where ExamID=" + examid +" and CodeId=" + codeid;
			int records=stmt.executeUpdate(sql);
			if (records > 0)
			{
				out.println("<H4>"+records+ " Record Sucessfully Deleted !!</H4>");
%>
				<center>
				<form method=post action='ExamMaster.jsp' >
				<input type=image src="../jsp/simages/ok1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/ok2.gif',1)" border=0>
				</form>
				</center>
<%
			}
			else
				out.println("Error occured in Deleting Record !!");
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
	else if(action.equals("doSubDelete"))
	{
		out.println("<H4>Delete </H4><HR SIZE=1>");
		try
		{
			int examid = Integer.parseInt(request.getParameter("examid"));
			String subcode = request.getParameter("subcode");

			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();

			String sql="delete from CodeMaster where ExamID=" + examid +" and left(CodeID,2)=" + subcode;

			int records=stmt.executeUpdate(sql);
			if (records > 0)
			{
				out.println("<H4>"+records+ " Record Sucessfully Deleted !!</H4>");
%>
				<center>
				<form method=post action='ExamMaster.jsp' >
				<input type=image src="../jsp/simages/ok1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/ok2.gif',1)" border=0>
				</form>
				</center>
<%
			}
			else
				out.println("Error occured in Deleting Record !!");
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
	else if(action.equals("doChapDelete"))
	{
		out.println("<H4>Delete </H4><HR SIZE=1>");
		try
		{
			int examid = Integer.parseInt(request.getParameter("examid"));
			String subcode = request.getParameter("subcode");
			String cd = request.getParameter("cd");

			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();

			String sql="delete from CodeMaster where ExamID=" + examid +" and left(CodeID,4) like '" + cd +"'";
//out.println(sql);
			int records=stmt.executeUpdate(sql);
			if (records > 0)
			{
				out.println("<H4>"+records+ " Record Sucessfully Deleted !!</H4>");
%>
				<center>
				<form method=post action='ExamMaster.jsp' >
				<input type=image src="../jsp/simages/ok1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/ok2.gif',1)" border=0>
				</form>
				</center>
<%
			}
			else
				out.println("Error occured in Deleting Record !!");
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
	else if(action.equals("doTopicDelete"))
	{
		out.println("<H4>Delete </H4><HR SIZE=1>");
		try
		{
			int examid = Integer.parseInt(request.getParameter("examid"));
			String subcode = request.getParameter("subcode");
			String cd = request.getParameter("cd");

			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();

			String sql="delete from CodeMaster where ExamID=" + examid +" and left(CodeID,6) like '" + cd + "'";
//out.println(sql);
			int records=stmt.executeUpdate(sql);
			if (records > 0)
			{
				out.println("<H4>"+records+ " Record Sucessfully Deleted !!</H4>");
%>
				<center>
				<form method=post action='ExamMaster.jsp' >
				<input type=image src="../jsp/simages/ok1.gif" name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/ok2.gif',1)" border=0>
				</form>
				</center>
<%
			}
			else
				out.println("Error occured in Deleting Record !!");
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
%>
</BODY>
</HTML>
