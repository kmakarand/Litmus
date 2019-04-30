<%@ page language="java" import="java.sql.*,com.ngs.gen.KeyGenerator,java.util.*,java.text.*" session="true"%>

<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool" />

<%
PreparedStatement pstmt =null;
ServletContext context = getServletContext();
pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

String action = request.getParameter("action");
System.err.println("*** Requested By : " + request.getRequestURI() + " *** Action : " + action);

if (action == "" || action == null)
{
%>
<html>
<head>
<title>Key Generation</title>
</head>
<body bgcolor="#FEF9E2" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<CENTER>
<P>&nbsp;<P>
<TABLE BORDER=1 WIDTH="50%" CELLSPACING=0 CELLPADDING=0>
<TR><TD bgcolor='#FEEEC8' ALIGN="CENTER"><font color='#960317' size="3"><B>Key Generator</B></font></TD></TR>
<TR><TD ALIGN="CENTER"><P><br><font color='#960317'><B>
<FORM ACTION="<%=request.getRequestURI()%>" METHOD="Post">
Generate <INPUT TYPE="TEXT" NAME="KeyNos" SIZE="4" MAXLENGTH="4" VALUE="1"> Keys for Exam
<SELECT NAME="ExamID">
<%
	Connection con = null;
	con = pool.getConnection();
	

	try
	{
	    String sql = "SELECT ExamID, Exam FROM ExamMaster ORDER BY Exam";
		pstmt = con.prepareStatement(sql);
		ResultSet rs = pstmt.executeQuery();
		while (rs.next())
		{
%>
<OPTION VALUE="<%=rs.getInt("ExamID")%>"><%=rs.getString("Exam")%></OPTION>
<%
		}
%>
</SELECT>
<P><BR>
No of Columns in Output :
<SELECT NAME="NoOfCols">
<OPTION VALUE="1">1</OPTION>
<OPTION VALUE="2" SELECTED>2</OPTION>
</SELECT>
<%
	}
	catch(Exception e)
	{
%>
<CENTER><P>&nbsp;</P><P><BR>
<TABLE BORDER=1 WIDTH="50%" CELLSPACING=0 CELLPADDING=0>
<TR><TD bgcolor='#FEEEC8'><font color='#960317'><B>ERROR</B></font></TD></TR>
<TR><TD><P><br><font color='#960317'><B>&nbsp;An error has occured.
<BR><BR><%=e.getMessage()%>.<BR><BR>
</font></P>
</TD></TR>
</TABLE>
<%
	}
	finally
	{
		if (con != null)
			pool.releaseConnection(con);
		else
	        out.println ("<CENTER><P><BR><B>Error while Connecting to Database.</B>");
	}

%>
</B></font></P>
<BR>
<INPUT TYPE=HIDDEN NAME="action" VALUE="GenerateKeys">
<INPUT TYPE=Submit VALUE="Generate Keys">
</FORM>
</TD></TR>
</TABLE>
</body>
</html>
<%
}
else if (action.equals("GenerateKeys") )
{
	int KeyNos = Integer.parseInt( request.getParameter("KeyNos") );
	int ExamID = Integer.parseInt( request.getParameter("ExamID") );
	int NoOfCols = Integer.parseInt( request.getParameter("NoOfCols") );

	Connection con = null;
	con = pool.getConnection();

	String sql = "SELECT * FROM ExamMaster WHERE ExamID=" +ExamID+ "";
	pstmt = con.prepareStatement(sql);
	ResultSet rs = pstmt.executeQuery();
%>
<html>
<head>
<title>Key Generation</title>
</head>
<body bgcolor="#FEF9E2" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<CENTER><font color='#960317'>
<P>&nbsp;<P>
<%
	String Exam = null;
	while (rs.next())
	{
		Exam = rs.getString("Exam");
		break;
	}

	try
	{
%>
Following Keys have been generated for Exam : <B><%=Exam%></B>.
<P><BR>
<TABLE BORDER=0 WIDTH="100%" CELLSPACING=0 CELLPADDING=0>
<TR>
<%
		int count = 1;
		int ColCount = 1;
		int NextSlot = 0;

		while (count <= KeyNos)
		{
			String Key1 = KeyGenerator.GenerateKey(4);
			String Key2 = KeyGenerator.GenerateKey(4);
			String Key3 = KeyGenerator.GenerateKey(4);

			sql = "SELECT * FROM KeyMaster WHERE Key1='" +Key1+ "' AND Key2='";
			sql = sql + Key2 + "' AND Key3='" +Key3+ "'";

			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			boolean KeyFound = false;

			while (rs.next())
			{
				String k1 = rs.getString("Key1");
				String k2 = rs.getString("Key2");
				String k3 = rs.getString("Key3");

System.err.println("\nSimilar Key Found.\nChecking for Case sensitivness.");

				if (k1.equals(Key1) && k2.equals(Key2) && k3.equals(Key3))
				{
					KeyFound = true;
					break;
				}
			}

			if (KeyFound)
			{
System.err.println("\nKey Combination already Exists.");
System.err.println("Key No: "+count+ " | Generated Key: " +Key1+ " - " +Key2+ " - " + Key3);
System.err.println("Generating Key again .....\n");

				continue;
			}
			else
			{
				String Password = KeyGenerator.GenerateKey(6);

				sql = "SELECT MAX(ID), MAX(Slot) FROM KeyMaster";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();

				rs.next();

				int NextID = rs.getInt(1) + 1;

				if (NextSlot == 0)
				{
					NextSlot = rs.getInt(2) + 1;
				}
				
				DateFormat serverDate = new SimpleDateFormat("yyyy-MM-dd");
				//Date serverDate = new Date();
				////System.out.println(dateFormat.format(date));
					  
				sql = "INSERT INTO KeyMaster (ID, ExamID, Key1, Key2, Key3, Password, GenerationDate, Slot) VALUES ("+NextID+ "," +ExamID+ ", '" +Key1+ "','" +Key2+ "','" +Key3+ "','" + Password+ "','" +serverDate+ "'," +NextSlot+ ")";
				pstmt = con.prepareStatement(sql);
				pstmt.executeUpdate(sql);

				if (ColCount > NoOfCols)
				{
					out.println("</TR><TR><TD ALIGN='CENTER' HEIGHT='60'>");
				}
				else
				{
					out.println("<TD ALIGN='CENTER' HEIGHT='60'>");
				}
%>
  <table border="0" cellspacing="2" cellpadding="2">
    <tr>
      <td align="right"><font color='#960317'><%=count%>&nbsp;&nbsp;</font></td>
      <td align="right"><font color='#960317'>Activation Key :</font></td>
      <td><font color='#960317'>&nbsp;&nbsp;<%=Key1%> - <%=Key2%> - <%=Key3%></font></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
      <td align="right"><font color='#960317'>Password :</font></td>
      <td><font color='#960317'>&nbsp;&nbsp;<%=Password%></font></td>
    </tr>
  </table>
<%
				if (ColCount > NoOfCols)
				{
					ColCount = 1;
				}
				else
				{
					out.println("</TD>");
				}

				count++;
				ColCount++;
			}
		}
%>
</TR>
</TABLE>
<%
	}
	catch(Exception e)
	{
%>
<CENTER><P>&nbsp;</P><P><BR>
<TABLE BORDER=1 WIDTH="50%" CELLSPACING=0 CELLPADDING=0>
<TR><TD bgcolor='#FEEEC8'><font color='#960317'><B>ERROR</B></font></TD></TR>
<TR><TD><P><br><font color='#960317'><B>&nbsp;An error has occured while generating Keys.
<BR><BR><%=e.getMessage()%>.<BR><BR>
</font></P>
</TD></TR>
</TABLE>
<%	}
	finally
	{
		if (con != null)
			pool.releaseConnection(con);
		else
	        out.println ("<CENTER><P><BR><B>Error while Connecting to Database.</B>");
	}
%>
</body>
</html>
<%
}
%>
