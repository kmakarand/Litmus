<CENTER></CENTER><%@ page language="java" import="java.sql.*" %>

<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
ServletContext context = getServletContext();
pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

String action = request.getParameter("action");
System.err.println("*** Requested By : " + request.getRequestURI() + " *** Action : " + action);

if (action == null || action == "")
{
%>
<html>
<head>
<title>Key Manager.</title>
</head>
<body bgcolor="#FEF9E2" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<center><font color='#960317'>
  <P><font color='#960317' size="3"><b>Key Manager</b></font>
  <P><FORM NAME="Form1" ACTION="<%=request.getRequestURI()%>" METHOD="Post">
  <table BORDER=1 WIDTH="60%" CELLSPACING=0 CELLPADDING=0>
    <TR>
      <TD bgcolor='#FEEEC8' ALIGN="CENTER"><font color='#960317' size="3"><b>Examwise Key Search</b></font></TD>
    </TR>
    <TR>
      <TD align="CENTER"> <BR>
        <table BORDER=0>
          <tr>
            <td align="RIGHT">Search Keys for Exam :</td>
            <td>
              <select name="ExamID">
<OPTION VALUE="0" SELECTED> ---  None  --- </OPTION>
<%
	Connection con = null;
	con = pool.getConnection();

	try
	{
		Statement stmt = con.createStatement();

		String sql = "SELECT ExamID, Exam FROM ExamMaster ORDER BY Exam";
		ResultSet rs = stmt.executeQuery(sql);

		while (rs.next())
		{
%>
<OPTION VALUE="<%=rs.getInt("ExamID")%>"><%=rs.getString("Exam")%></OPTION>
<%
		}
%>
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
<BR><BR><%=e.toString()%><BR><BR>
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
            <td>
          </tr>
          <tr>
            <td align="RIGHT">Search Key :</td>
            <td>
              <input type=text name=key1 maxlength=4 size=5>
              -
              <input type=text name=key2 maxlength=4 size=5>
              -
              <input type=text name=key3 maxlength=4 size=5>
            <td>
          </tr>
          <tr>
            <td align="RIGHT">Set Page Size : </td>
            <td>
              <input type=TEXT name="PageSize" value="10" size="5" maxlength="4">
            <td>
          </tr>
        </TABLE>
        <br>
        <input type=HIDDEN name="action" value="SearchKeys">
        <input type=HIDDEN name="SearchOrder" value="ExamWise">
        <input type=Submit value="Search Keys" name="Submit">
        <input type=Reset value="Reset" name="Reset">
        <br>
      </TD>
    </TR>
  </table></FORM>
  <p><BR>
  <FORM NAME="Form2" ACTION="<%=request.getRequestURI()%>" METHOD="Post">
  <table border=1 width="60%" cellspacing=0 cellpadding=0>
    <tr>
      <td bgcolor='#FEEEC8' align="CENTER"><font color='#960317' size="3"><b>Slotwise
        Key Search</b></font></td>
    </tr>
    <tr>
      <td align="CENTER"> <br>
        <table border=0>
          <tr>
            <td align="RIGHT">Search Key :</td>
            <td>
              <input type=text name=key1 maxlength=4 size=5>
              -
              <input type=text name=key2 maxlength=4 size=5>
              -
              <input type=text name=key3 maxlength=4 size=5>
            <td>
          </tr>
          <tr>
            <td align="RIGHT">Search Keys generated in Slot No : </td>
            <td>
              <input type=TEXT name="SlotNo" value="0" size="5" maxlength="5">
            <td>
          </tr>
          <tr>
            <td align="RIGHT">Set Page Size : </td>
            <td>
              <input type=TEXT name="PageSize" value="10" size="5" maxlength="4">
            <td>
          </tr>
        </table>
        <br>
        <input type=HIDDEN name="action" value="SearchKeys">
        <input type=HIDDEN name="SearchOrder" value="SlotWise">
        <input type=Submit value="Search Keys" name="Submit">
        <input type=Reset value="Reset" name="Reset">
        <br>
      </td>
    </tr>
  </table></FORM>
</body>
</html>
<%
}
else if (action.equals("SearchKeys"))
{
%>
<html>
<head>
<title>Search Results</title>
</head>
<body bgcolor="#FEF9E2" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<CENTER><font color='#960317'>
<P>&nbsp;<P>
<%
	String SearchOrder = request.getParameter("SearchOrder");
	String Key1 = request.getParameter("key1");
	String Key2 = request.getParameter("key2");
	String Key3 = request.getParameter("key3");

	String strPage = request.getParameter("Page");
	int ExamID = 0;
	int SlotNo = 0;

	int Page = 1;
	int TotalPages = 1;

	if (strPage == null || strPage == "")
		Page = 1;
	else
		Page = Integer.parseInt( strPage );

	int PageSize = Integer.parseInt( request.getParameter("PageSize") );

	if (PageSize == 0)
		PageSize = 10;

	String maxsql = null;
	String sql = null;

	if (SearchOrder.equals("ExamWise"))
	{
		ExamID = Integer.parseInt( request.getParameter("ExamID") );

		if (ExamID != 0)
		{
			maxsql = "SELECT COUNT(*) FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3 LIKE '" +Key3+ "%' AND ExamID=" +ExamID+ " ORDER BY Key1, Key2, Key3";

			sql = "SELECT * FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3 LIKE '" +Key3+ "%' AND ExamID=" +ExamID+ " ORDER BY Key1, Key2, Key3";
		}
		else
		{
			maxsql = "SELECT COUNT(*) FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3 LIKE '" +Key3+ "%' ORDER BY Key1, Key2, Key3";

			sql = "SELECT * FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3 LIKE '" +Key3+ "%' ORDER BY Key1, Key2, Key3";
		}
	}
	else if (SearchOrder.equals("SlotWise"))
	{
		SlotNo = Integer.parseInt( request.getParameter("SlotNo") );

		if (SlotNo != 0)
		{
			maxsql = "SELECT COUNT(*) FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3 LIKE '" +Key3+ "%' AND Slot=" +SlotNo+ " ORDER BY Key1, Key2, Key3";

			sql = "SELECT * FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3 LIKE '" +Key3+ "%' AND Slot=" +SlotNo+ " ORDER BY Key1, Key2, Key3";
		}
		else
		{
			maxsql = "SELECT COUNT(*) FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3  LIKE '" +Key3+ "%' ORDER BY Key1, Key2, Key3";

			sql = "SELECT * FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3  LIKE '" +Key3+ "%' ORDER BY Key1, Key2, Key3";
		}
	}
	else
	{
		maxsql = "SELECT COUNT(*) FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3  LIKE '" +Key3+ "%' ORDER BY Key1, Key2, Key3";

		sql = "SELECT * FROM KeyMaster WHERE Key1 LIKE '" +Key1+ "%' AND Key2 LIKE '" +Key2+ "%' AND Key3  LIKE '" +Key3+ "%' ORDER BY Key1, Key2, Key3";
	}

	Connection con = null;
	con = pool.getConnection();

	try
	{
%>
Search Results.
<P><BR>
<!--  COMMENTED
<TABLE BORDER=1 WIDTH="50%" CELLSPACING=0 CELLPADDING=0>
<TR>
	<TD bgcolor='#FEEEC8' ALIGN="CENTER"><font color='#960317'><B>Sr No.</B></font></TD>
	<TD bgcolor='#FEEEC8' ALIGN="CENTER"><font color='#960317'><B>ID.</B></font></TD>
	<TD bgcolor='#FEEEC8' ALIGN="CENTER"><font color='#960317'><B>Key</B></font></TD>
	<TD bgcolor='#FEEEC8' ALIGN="CENTER"><font color='#960317'><B>Password</B></font></TD>
</TR>
-->
<%
		Statement stmt = con.createStatement();
		ResultSet maxrs = null;
		ResultSet rs = null;

		int Count = 1;
		int RecordCount = 0;

		maxrs = stmt.executeQuery(maxsql);
		maxrs.next();

		double total = Math.ceil( maxrs.getDouble(1) / (double)PageSize );
		TotalPages = (int) total;

		if (TotalPages <= 0)
			TotalPages = 1;

		rs = stmt.executeQuery(sql);
		rs.setFetchSize(PageSize);

		Count = (Page - 1) * PageSize + 1;

		if ( Page > 1)
			rs.absolute( Count - 1 );

		while (rs.next() && RecordCount < PageSize)
		{
%>
<!--Added Here  -->
<TABLE BORDER=1 WIDTH="50%" CELLSPACING=0 CELLPADDING=0>


<TR>
	<TD bgcolor='#FEEEC8' ALIGN="CENTER" WIDTH='65%'><font color='#960317'><B>Key</B></font></TD>
	<TD bgcolor='#FEEEC8' ALIGN="CENTER" WIDTH='35%'><font color='#960317'><B>Password</B></font></TD>
</TR>
<!-- Till HERE -->


<TR>
<!--
	<TD ALIGN="RIGHT" VALIGN="CENTER" HEIGHT="30"><font color='#960317'><%=Count%>&nbsp;&nbsp;</font></TD>
	<TD ALIGN="RIGHT" VALIGN="CENTER" HEIGHT="30"><font color='#960317'><%=rs.getInt("ID")%>&nbsp;&nbsp;</font></TD>
-->
	<TD VALIGN="CENTER" ALIGN="CENTER" HEIGHT="30"><font color='#960317'>&nbsp;&nbsp;<%=rs.getString("Key1")%> - <%=rs.getString("Key2")%> - <%=rs.getString("Key3")%></font></TD>
	<TD VALIGN="CENTER" ALIGN="CENTER" HEIGHT="30"><font color='#960317'>&nbsp;&nbsp;<%=rs.getString("Password")%></font></TD>
</TR>
</TABLE>
<br><br><br>
<%
			Count++;
			RecordCount++;
		}
%>
<!--</TABLE>-->
<P>&nbsp;</P>
<%
		for (int i = 1; i <= TotalPages; i++)
		{

			if (i == Page)
				out.print("&nbsp;&nbsp;&nbsp;<B>" +i+ "</B>");
			else if (SearchOrder.equals("ExamWise") )
			{
				out.print("&nbsp;&nbsp;&nbsp;<A HREF=" +request.getRequestURI()+ "?action=" +action+ "&key1=" +Key1+ "&key2=" +Key2+ "&key3=" +Key3+ "&SearchOrder=" +SearchOrder+ "&ExamID=" +ExamID+ "&PageSize=" +PageSize+ "&Page=" +i+ ">" +i+ "</A>");
			}
			else if (SearchOrder.equals("SlotWise") )
			{
				out.print("&nbsp;&nbsp;&nbsp;<A HREF=" +request.getRequestURI()+ "?action=" +action+ "&key1=" +Key1+ "&key2=" +Key2+ "&key3=" +Key3+ "&SearchOrder=" +SearchOrder+ "&SlotNo=" +SlotNo+ "&PageSize=" +PageSize+ "&Page=" +i+ ">" +i+ "</A>");
			}
			else
			{
				out.print("&nbsp;&nbsp;&nbsp;<A HREF=" +request.getRequestURI()+ "?action=" +action+ "&key1=" +Key1+ "&key2=" +Key2+ "&key3=" +Key3+ "&SearchOrder=" +SearchOrder+ "&ExamID=" +ExamID+ "&PageSize=" +PageSize+ "&Page=" +i+ ">" +i+ "</A>");
			}
		}
	}
	catch(Exception e)
	{
%>
<CENTER><P>&nbsp;</P><P><BR>
<TABLE BORDER=1 WIDTH="50%" CELLSPACING=0 CELLPADDING=0>
<TR><TD bgcolor='#FEEEC8'><font color='#960317'><B>ERROR</B></font></TD></TR>
<TR><TD><P><br><font color='#960317'><B>&nbsp;An error has occured.
<BR><BR><%=e.toString()%><BR><BR>
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
