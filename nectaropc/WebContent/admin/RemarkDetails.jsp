<%@ page language="java" import="java.sql.*,java.io.*" session="true"%>
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>
<html>
<head>
<title>Remark Module</title>
<style>td{font-family:arial;font-size:10pt;} body{font-family:arial;font-size:11pt;} b{font-family:arial;font-size:11pt;}</style>
</head>
<script language="javascript" src='validateexammaster.js'></script>
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>
<script langauge="javascript">
function check()
{
	var x="document.frmremdet.percentage";
	if (!isnulls(x) || !checkNumeric(eval(x),"Percentage is a Numeric Field"))
	{
		alert("Percentage Field cannot be Empty !!");
		eval(x).focus();
		return false;
	}

	if (eval(x).value>100)
	{
		alert("Percentage cannot be more than 100 !! ");
		eval(x).value="";
		eval(x).focus();
		return false;
	}
	x="document.frmremdet.remark";
	if (!isnulls(x))
	{
		alert("Remark Field cannot be Empty !!");
		eval(x).focus();
		return false;
	}
	if (eval(x).value.length>255)
	{
		alert("remark cannot be more than 255 !! ");
		eval(x).value="";
		eval(x).focus();
		return false;
	}
//	else
//		document.frmremdet.submit();
}
function checkEdit()
{
	x="document.frmedit.newremark";
	if (!isnulls(x))
	{
		alert("Remark Field cannot be Empty !!");
		eval(x).focus();
		return false;
	}
	if (eval(x).value.length>255)
	{
		alert("Remark cannot be more than 255 !! ");
		eval(x).value="";
		eval(x).focus();
		return false;
	}
	else
		document.frmedit.submit();
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
function checkNumeric(field,msg)
{
	var strString = field.value;
	var strValidChars = "0123456789.-";
	var strChar;
//	var blnResult = true;
//	for (i = 0; i < strString.length && blnResult == true; i++)

	for (a = 0; a < strString.length ; a++)
	{
		strChar = strString.charAt(a);
		if (strValidChars.indexOf(strChar) == -1)
		{
			alert(msg);
			field.value="";
			field.focus();
			return false;
		}
	}
	return true;
}
function checkdelete()
{
	var get=confirm("Are you Sure you want to delete this Remark !!");
	if (get)
	{
		document.frmdelete.submit();
	}
	return get;
}
</script>
<body bgcolor='#FEF9E2' onLoad="MM_preloadImages('../jsp/simages/modify2.gif', '../jsp/simages/delete2.gif', '../jsp/simages/save2.gif', '../jsp/simages/cancel2.gif', '../jsp/simages/reset2.gif')" >
<%
	String action = request.getParameter("action");
//	String username1 = (String)session.getValue("username");
	ServletContext context   =   getServletContext();
	pool    =    (com.ngs.gbl.ConnectionPool)  getServletContext().getAttribute("ConPoolbse");
	Connection conn = null;
	String username = (String)session.getValue("username");
	if (username == null || username.equals(null) || username=="")
	{
		response.sendRedirect("../jsp/SessionExpiry.jsp");
	}
	else if (action == "" || action==null)
	{
		try
		{
			out.println("<H4> Remark Details </H4><HR SIZE=1>");

			conn = pool.getConnection();
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
						<td>Select Exam :</td>
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
				<table>

			<input type=image src="../jsp/simages/submit1.gif" name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/submit2.gif',1)" border=0 >

			<input type=hidden name=action value='doView'>

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
	else if (action.equals("doView"))
	{
		try
		{
			out.println("<H4> Remark Details </H4><HR SIZE=1>");
			int examid=Integer.parseInt(request.getParameter("examid"));
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt,stmt1 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			String examname="";
			String sql= "select Exam from ExamMaster where ExamID=" + examid;
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				examname=rs.getString("Exam");
			}
			sql="SELECT * FROM RemarkDetails where ExamID="+examid+" order by ExamID,RemarkID" ;
%>
			<center>
			<form method=get>
				<table border=0 bgcolor='#FEEEC8'>
					<tr bgcolor='#FEEEC8'><td>RemarkID</td>
						<td>Exam Name</td>
						<td>Percentage</td>
						<td>Remarks</td>
					</tr>
<%
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
%>
					<tr bgcolor='#FFF5E7'><td><%= rs.getInt("RemarkID") %></td>
<%

					sql="select Exam from ExamMaster where ExamID="+examid;
					rs1=stmt1.executeQuery(sql);
					while (rs1.next())
					{
						examname=rs1.getString("Exam");
					}
					String asd="'RemarkDetails.jsp?action=doChange&examid="+examid+"&percentage="+rs.getFloat("Percentage")+"&examname="+examname+"'";
					String qwe="'RemarkDetails.jsp?action=doKill&examid="+examid+"&percentage="+rs.getFloat("Percentage")+"&examname="+examname+"'";
%>
					<td><%=  examname %></td><td><%= rs.getFloat("Percentage") %></td>
					<td><a href=<%=asd %>><%= rs.getString("Remark") %></a></td>
					<td><a href=<%=asd %>>modify</a></td><td><a href=<%=qwe %>>delete</a></td></tr>
<%
				}
%>
				</table>

				<INPUT TYPE='image' src="../jsp/simages/enternewremarks.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/enternewremarks2.gif',1)" border=0 >
				<input type=hidden name=examid value=<%=examid%>>
				<input type=hidden name=examname value=<%=examname%>>
				<input type=hidden name=action value='doNewRemark'>
				<INPUT TYPE='image' src="../jsp/simages/cancel1.gif"  name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
				</form>
<%
			}
			catch(Exception e)
			{
				//System.out.println("Connection Error : " + e.getMessage());
			}
			finally
			{
				if (conn != null)
					pool.releaseConnection(conn);
		        else
			        out.println ("Error while Connecting to Database.");
			}
	}
	else if (action.equals("doNewRemark"))
	{
		out.println("<H4>Remark Details Entry</H4><HR SIZE=1>");
		try
		{
			int examid=Integer.parseInt(request.getParameter("examid"));
			String examname=request.getParameter("examname");
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="select * from RemarkDetails where ExamID="+examid;
			rs=stmt.executeQuery(sql);
			int remarkid=0;
			while(rs.next())
			{
				remarkid=rs.getInt("RemarkID");
			}
%>
			<center>
			<form method=post name=frmremdet action='<%= request.getRequestURI()%>'>
			<table border=0>
				<tr>
					<td>Exam Name :</td>
					<td><%= examname%></td>
				</tr>
				</tr>
					<td>Enter Percentage :</td>
					<td><input type=text name=percentage></td>
				</tr>
					<td>Enter Remark :</td>
					<td><TEXTAREA valign="top" NAME=remark ROWS="3" COLS="30" ></TEXTAREA> </td>
				</tr>
			</table>

			<input type=hidden name=examid value=<%= examid %>>
			<input type=hidden name=examname value=<%= examname %>>
			<input type=hidden name=action value="doRemSave">
			<INPUT TYPE='image' src="../jsp/simages/save1.gif"  name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/save2.gif',1)" border=0 onclick='return check();'>

			<input type=image src="../jsp/simages/reset1.gif"  name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/reset2.gif',1)" border=0 OnClick="javascript:return ResetForm('frmremdet');">

			<INPUT TYPE='image' src="../jsp/simages/cancel1.gif"  name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
			</form>
<%
		}
		catch(Exception e)
		{
			//System.out.println("Connection Error : " + e.getMessage());
		}
		finally
		{
			if (conn != null)
				pool.releaseConnection(conn);
	        else
		        out.println ("Error while Connecting to Database.");
		}
	}
	else if (action.equals("doRemSave"))
	{
		out.println("<H4>Remark Details Entry</H4><HR SIZE=1>");
		try
		{
			int examid=Integer.parseInt(request.getParameter("examid"));
			Float temp = new Float (request.getParameter("percentage"));
			float percentage= temp.floatValue();
			String remark = request.getParameter("remark");
			String examname=request.getParameter("examname");
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
/*			String examname="";
			String sql="select * from ExamMaster where ExamID="+examid;
			rs=stmt.executeQuery(sql);
			while (rs.next())
			{
				examname=rs.getString("Exam");
			}
*/			String sql="select * from RemarkDetails where ExamID="+examid +" and Percentage="+percentage;
//out.println(sql);
			rs=stmt.executeQuery(sql);
			if (rs.next())
			{
%>

				<center>
				<h4>Percentage has already been defined !!</h4>
				</FORM>
				<FORM METHOD=POST ACTION='RemarkDetails.jsp'>
				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/home2.gif',1)" border=0 >
				<INPUT TYPE='image' src="../jsp/simages/cancel1.gif"  name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
				</FORM>

<%
			}
			else
			{

				sql="INSERT INTO RemarkDetails (ExamID,Percentage,Remark) values ("+examid+","+percentage+",'"+remark+"')";
				int records=stmt.executeUpdate(sql);
				if(records>0)
				{
					out.println("<h4>"+records + " Remark Sucessfully Inserted ..</h4>");

					sql="select * from RemarkDetails where ExamID="+examid + " order by RemarkID" ;
%>
					<center>
					<table border=0 bgcolor='#FEEEC8'>
						<tr bgcolor='#FEEEC8'><td>RemarkID</td>
							<td>Exam Name</td>
							<td>Percentage</td>
							<td>Remark</td>
						</tr>
<%
					rs=stmt.executeQuery(sql);
					while(rs.next())
					{
%>
						<tr bgcolor='#FFF5E7'><td><%= rs.getInt("RemarkID") %></td><td><%= examname %></td><td><%= rs.getFloat("Percentage") %></td><td><%= rs.getString("Remark") %></td></tr>
<%
					}
%>
					</table>
					</FORM>
					<FORM METHOD=POST ACTION='RemarkDetails.jsp'>
						<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/home2.gif',1)" border=0 >
					</FORM>
<%

				}
				else
				{
					out.println("Error in Inserting Remark !! ");
				}
			}
		}
		catch(Exception e)
		{
			//System.out.println("Connection Error : " + e.getMessage());
		}
		finally
		{
			if (conn != null)
				pool.releaseConnection(conn);
	        else
		        out.println ("Error while Connecting to Database.");
		}
	}
	else if(action.equals("doEdit"))
	{
		out.println("<H4>Modify Remark Details </H4><HR SIZE=1>");
		try
		{
			int examid=Integer.parseInt(request.getParameter("examid"));
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="SELECT Exam FROM ExamMaster WHERE ExamID="+examid;
			rs=stmt.executeQuery(sql);
			String examname="";
			out.println("<center>");
			out.println("<form method=get>");
			while(rs.next())
			{
				examname=rs.getString("Exam");
			}
			sql="SELECT Percentage FROM RemarkDetails where ExamID=" + examid +" order by ExamID";
			rs=stmt.executeQuery(sql);
%>
			Select Percentage (%) for Subject <b><%= examname %> :</b>
			<select name=percentage size=5>
<%
			while(rs.next())
			{
%>
				<option value="<%= rs.getFloat("Percentage")%>" selected><%=rs.getFloat("Percentage")%></option>
<%
			}
%>
			</select>
			<br><input type=submit value=Enter>
			<INPUT TYPE='image' src="../jsp/simages/save1.gif"  name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/save2.gif',1)" border=0 onclick='return previous();'>
			<input type=hidden name=action value='doChange'>
			<input type=hidden name=examname value=<%= examname %>>
			<input type=hidden name=examid value=<%= examid %>>
			<INPUT TYPE='image' src="../jsp/simages/cancel1.gif"  name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
			</form>
			<Form method=get action='RemarkDetails.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/home2.gif',1)" border=0 >
			</form>

<%
		}
		catch(Exception e)
		{
			//System.out.println("Connection Error : " + e.getMessage());
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
		out.println("<H4>Modify Remark Details </H4><HR SIZE=1>");
		try
		{
			Float temp = new Float (request.getParameter("percentage"));
			float percentage= temp.floatValue();
			String examname= request.getParameter("examname");
			int examid=Integer.parseInt(request.getParameter("examid"));
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String oldremark="",newremark="";
			String sql="select * from RemarkDetails where ExamID="+examid+" and Percentage like '"+percentage+"%'";
			rs=stmt.executeQuery(sql);
			while(rs.next())
			{
				oldremark=rs.getString("Remark");
			}
%>
			<center>
			<form name=frmedit method=get action=<%=request.getRequestURI()%>>
			<table border=0>
				<tr><td>Exam Name :</td><td><%=examname%><td></tr>
				<tr><td>Percentage (%) :</td><td><%=percentage%><td></tr>
<!--				<tr><td>Remark :</td><td><%=oldremark%><td></tr>	-->
				<tr><td valign="top">Enter new Remark :</td><td><TEXTAREA NAME="newremark" ROWS="3" COLS="30"><%=oldremark%></TEXTAREA><td></tr>
			</table>

			<INPUT TYPE='image' src="../jsp/simages/save1.gif"  name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/save2.gif',1)" border=0 onclick='return checkEdit();'>
			<input type=hidden name=action value='doPack'>
			<input type=hidden name=percentage value=<%= percentage %>>
			<input type=hidden name=oldremark value=<%= oldremark %>>
			<input type=hidden name=examid value=<%= examid %>>
			<INPUT TYPE='image' src="../jsp/simages/cancel1.gif"  name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
			</form>
			<Form method=get action='RemarkDetails.jsp'>
			<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/home2.gif',1)" border=0 >

			</form>
<%
		}
		catch(Exception e)
		{
			//System.out.println("Error : " + e.getMessage());
		}
		finally
		{
			if (conn != null)
				pool.releaseConnection(conn);
	        else
		        out.println ("Error while Connecting to Database.");
		}
	}
	else if(action.equals("doPack"))
	{
		out.println("<H4>Modify Remark Details </H4><HR SIZE=1>");
		try
		{
			Float temp = new Float (request.getParameter("percentage"));
			float percentage= temp.floatValue();
			String newremark=request.getParameter("newremark");
			String oldremark=request.getParameter("oldremark");
			int examid=Integer.parseInt(request.getParameter("examid"));
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt,stmt1,stmt2 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			String sql="update RemarkDetails set Remark='"+newremark+"' where Percentage like '"+percentage+"%' and ExamID="+examid;
			int records=stmt1.executeUpdate(sql);
			if (records>0)
			{
				out.println("<h4>"+records+" Remark Sucessfully Modified");
				sql="select * from RemarkDetails Where ExamId="+examid + " and Percentage like'" +percentage +"%'";
				rs1=stmt1.executeQuery(sql);
				out.println("<center>");
				out.println("<table border=1>");				out.println("<tr><td>RemarkID</td><td>ExamID</td><td>Percentage</td><td>Remark</td></tr>");
				while(rs1.next())
				{
					out.println("<tr><td>"+rs1.getInt("RemarkID")+"</td><td>"+rs1.getInt("ExamID")+"</td><td>"+rs1.getFloat("Percentage")+"</td><td>"+rs1.getString("Remark")+"</td></tr>");
				}
				out.println("</table>");
				out.println("<form method=get >");
				out.println("<input type=hidden name=examid value="+examid+">");
				out.println("<input type=hidden name=action value='doView'>");
				out.println("<INPUT TYPE='image' src=\"../jsp/simages/ok1.gif\"  name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver =\"MM_swapImage('Image3','','../jsp/simages/ok2.gif',1)\" border=0 >");
				out.println("</form>");
			}
			else
%>
				<h4>Error in Modification</h4>
				<center>
				<Form method=get action='RemarkDetails.jsp'>
				<INPUT TYPE='image' src="../jsp/simages/home1.gif"  name='Image4' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image4','','../jsp/simages/home2.gif',1)" border=0 >

				<INPUT TYPE='image' src="../jsp/simages/cancel1.gif"  name='Image5' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image5','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
				</form>
<%


		}
		catch(Exception e)
		{
			//System.out.println("Error : " + e.getMessage());
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
		out.println("<H4>Delete Remark </H4><HR SIZE=1>");
		try
		{
			int examid=Integer.parseInt(request.getParameter("examid"));
			String examname=request.getParameter("examname");
			Float temp = new Float(request.getParameter("percentage"));
			float percentage=temp.floatValue();
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt,stmt1 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();
			String sql="select * from RemarkDetails where ExamID="+examid + " and Percentage="+ percentage;
			out.println("<Form method=get name=frmdelete>");
			rs=stmt.executeQuery(sql);
%>
			<center>
			<table bgcolor='#FEF9E2'>	<tr bgcolor='#FEEEC8'><td>RemarkID</td><td>ExamID</td><td>Percentage</td><td>Remark</td></tr>
<%
			while(rs.next())
			{
%>
				<tr><td><%=rs.getInt("RemarkID")%></td>
<%
				String examname1="";
				sql="select Exam from ExamMaster where ExamID="+rs.getInt("ExamID");
				rs1=stmt1.executeQuery(sql);
				while (rs1.next())
				{
					examname1=rs1.getString("Exam");
				}
%>
				<td><%= examname1 %></td><td><%= rs.getFloat("Percentage") %></td><td><%= rs.getString("Remark") %></td></tr>
<%
				}
%>
			</table>
			<INPUT TYPE='image' src="../jsp/simages/delete1.gif"  name='Image1' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image1','','../jsp/simages/delete2.gif',1)" border=0>
			<INPUT TYPE=hidden name=action value='doPurge'>
			<INPUT TYPE=hidden name=examid value=<%= examid %>>
			<INPUT TYPE=hidden name=percentage value=<%= percentage %>>
			<INPUT TYPE='image' src="../jsp/simages/cancel1.gif"  name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/cancel2.gif',1)" border=0 onclick='return previous();'>
			</form>
<%
		}
		catch(Exception e)
		{
			//System.out.println("Error : " + e.getMessage());
		}
		finally
		{
			if (conn != null)
				pool.releaseConnection(conn);
	        else
		        out.println ("Error while Connecting to Database.");
		}
	}
	else if(action.equals("doPurge"))
	{
		out.println("<H4>Delete Remark </H4><HR SIZE=1>");
		try
		{
			int examid=Integer.parseInt(request.getParameter("examid"));
			Float temp = new Float(request.getParameter("percentage"));
			float percentage=temp.floatValue();
//			Connection conn = null;
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql="delete from RemarkDetails where ExamID="+examid +" and Percentage="+percentage;
			int records=stmt.executeUpdate(sql);
			if (records>0)
			{
				out.println("<h4>"+records +" Sucessfully Deleted !!</h4>");
			}
			else
				out.println("Error In Deletion !!");
%>
			<center>
			<form method=get >
			<input type=hidden name=examid value=<%=examid%>>
			<input type=hidden name=action value='doView'>
			<INPUT TYPE='image' src="../jsp/simages/ok1.gif"  name='Image3' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image3','','../jsp/simages/ok2.gif',1)" border=0 >
			</form>
<%
		}
		catch(Exception e)
		{
			//System.out.println("Error : " + e.getMessage());
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
