<%@ page language = "java" import = "java.sql.*,java.util.*" %>
<jsp:useBean id="mysqlc" scope="page" class="connect.mysql" />
<html>
<head>
<title>Payment Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE=JavaScript src="validatefunction.js"></SCRIPT>
<script language=javascript>
function x()
{
	if( ! checkEmpty(document.f.CandidateID,"Enter CandidateID"))
	{
		return false; 
	}
	return true;
}
function xx()
{
	if(document.f1.ExamID.selectedIndex == 0)
	{
		alert("Select ExamType");
		return false; 
	}
	if( ! checkEmpty(document.f1.CandidateID,"Enter CandidateID"))
	{
		return false; 
	}
	if( ! checkEmpty(document.f1.Amount,"Enter Amount"))
	{
		return false; 
	}
	if( ! checkNumeric(document.f1.Amount))
	{
		return false; 
	}
	if( ! checkNumeric(document.f1.CandidateID))
	{
		return false; 
	}
     return true;
}
</script>
</head>

<body bgcolor="#FEF9E2">
<%
		Connection con4 = mysqlc.mysqlconnect();
		Statement st4 = con4.createStatement();
		ResultSet rs4 = st4.executeQuery("select * from ExamMaster ORDER BY ExamID");
		Vector examNames = new Vector();
		int examNo = 0;
		while(rs4.next())
			examNames.addElement(rs4.getString("Exam"));

String confirm = request.getParameter("confirm");
if (confirm == null || confirm == "")
{
%>
  <form name="f" method=POST>    
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
	<td colspan=2 bgcolor="#DCDCDC" valign=middle><B>Enter CandidateID</B></td>
	</tr>
    <tr> 
      <td align="right"><b><font face="Arial, Helvetica, sans-serif" size="2" color="#993333">Enter 
        CandidateID :&nbsp;</font></b></td>
      <td><b><font face="Arial, Helvetica, sans-serif" size="2"> 
        <input type="text" name="CandidateID">
        </font></b></td>
    </tr>
	<tr><td colspan=2>&nbsp;</td></tr>
    <tr> 
      <td colspan=2 align=center> 
        <input type=submit name=confirm value="Submit" OnClick="return x();">
      </td>
    </tr>
  </table>
 </form>

<%
}
else if(confirm.equals("Submit"))
{
%>
<font size="3" face="Verdana, Arial, Helvetica, sans-serif"><B>Payment details</B></font> 
<hr size=1>
<%
	try
	{
		Connection con2 = mysqlc.mysqlconnect();
		Statement st2 = con2.createStatement();
		String q1 = "";
		if(request.getParameter("ExamID") !=null && request.getParameter("ExamID") != "")
		{
			q1 = "select count(*) from PaymentDetails where CandidateID=" + Integer.parseInt(request.getParameter("CandidateID")) + " and ExamID=" + Integer.parseInt(request.getParameter("ExamID")); 
		}
		else
		q1 = "select count(*) from PaymentDetails where CandidateID=" + Integer.parseInt(request.getParameter("CandidateID")); 
		ResultSet rs2 = st2.executeQuery(q1); 
		int countRecords = 0;
		while(rs2.next())
		countRecords = rs2.getInt(1);
		if(countRecords == 1)
		{
%>
<form name=f1 method="post" action="/zalm/servlet/editPaymentDetailsServlet4">
<%
		Connection con1 = mysqlc.mysqlconnect();
		Statement st = con1.createStatement();
		String q = "";
		if(request.getParameter("ExamID") !=null && request.getParameter("ExamID") != "")
		{
			q = "select * from PaymentDetails where CandidateID=" + Integer.parseInt(request.getParameter("CandidateID")) + " and ExamID=" + Integer.parseInt(request.getParameter("ExamID")); 
		}
		else
		q = "select * from PaymentDetails where CandidateID=" + Integer.parseInt(request.getParameter("CandidateID")); 
		ResultSet rs = st.executeQuery(q); 
		while(rs.next())
		{
%> 

  <table width="79%" border="0" cellspacing="3" cellpadding="0">
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">ExamID</font></div>
      </td>
      <td width="25%"> 
        <input type=hidden name=ExamID value=<%=rs.getInt("ExamID") %>>
        <font size="2" face="Verdana, Arial, Helvetica, sans-serif"><b><%=rs.getInt("ExamID") %></b> 
          </font>
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">CandidateID</font></div>
      </td>
        <input type=hidden name=CandidateID value=<%=rs.getInt("CandidateID") %>>
      <td width="26%"> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
        <b><%= rs.getInt("CandidateID")%></b>
        </font> </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Amount<font color="#CC0000">*</font></font></div>
      </td>
      <td width="25%"> 
        <input type="text" name="Amount" value=<%= rs.getInt("CandidateID")%>>
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Currency</font></div>
      </td>
      <td width="26%">
        <select name="Currency">
          <option value=Rs.>Rupees</option>
          <option value=$>Dollors</option>
        </select>
<%
	int currency = 0;
	if(rs.getString("Currency").equals("Rs."))
		currency = 0;
	else
		currency = 1;


%>
<script language="javascript">
document.f1.Currency.selectedIndex = <%= currency %>
</script>
      </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Mode 
          of Payment</font></div>
      </td>
      <td width="25%">
        <select name="ModeOfPayment">
          <option value=DD>DD</option>
          <option value=Cheque>Cheque</option>
        </select>
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Date</font></div>
      </td>
      <td width="26%"> 
        <input type="text" name="Date" value=<%= rs.getString("Date")%>>
      </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Bank</font></div>
      </td>
      <td width="25%"> 
        <input type="text" name="Bank" value=<%= rs.getString("Bank")%>>
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Branch</font></div>
      </td>
      <td width="26%"> 
        <input type="text" name="Branch" value=<%= rs.getString("Branch")%>>
      </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Cheque 
          No</font></div>
      </td>
      <td width="25%"> 
        <input type="text" name="ChequeNo"  value=<%= rs.getString("ChequeNo")%>>
      </td>
      <td width="20%"> 
        <div align="right"></div>
      </td>
      <td width="26%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Is 
          PaymentRealized? </font></div>
      </td>
      <td width="25%"> 
        <select name="isPaymentRealized">
          <option value="0">No</option>
          <option value="1">Yes</option>
        </select>
<script language="javascript">
document.f1.isPaymentRealized.selectedIndex = <%= rs.getInt("isPaymentRealized") %>
</script>
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Realization 
          Date </font></div>
      </td>
      <td width="26%"> 
        <input type="text" name="RealizationDate"  value=<%= rs.getString("RealizationDate")%>>
      </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Is 
          Cheque Bounced?</font></div>
      </td>
      <td width="25%"> 
        <select name="isChequeBounced">
          <option value="0">No</option>
          <option value="1">Yes</option>
        </select>
<script language="javascript">
document.f1.isChequeBounced.selectedIndex = <%= rs.getInt("isChequeBounced") %>
</script>
      </td>
      <td width="20%"> 
        <div align="right"></div>
      </td>
      <td width="26%">&nbsp; </td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <div align="center"> 
          <input type=submit value="Submit Details" name="submit" onClick="return xx();">
          <input type=reset value=Reset>
        </div>
      </td>
    </tr>
  </table>
<%
		}
		}
		if(countRecords == 0)
%>
			<b><font face="Arial, Helvetica, sans-serif" size="2" color="#993333">No matching records found</font></b>
<%
		if(countRecords > 1)
		{
%>
  </form><form name="f2" method=POST>    
  <input type=hidden name=CandidateID value=<%= request.getParameter("CandidateID") %>>
   CandidateID: <%= request.getParameter("CandidateID") %><br>This candidate has multiple ExamIDs.<br> Select one ExamID
   <select name="ExamID">
<%
	try
	{
		Connection con3 = mysqlc.mysqlconnect();
		Statement st3 = con3.createStatement();
		ResultSet rs3 = st3.executeQuery("select * from PaymentDetails where CandidateID=" + Integer.parseInt(request.getParameter("CandidateID")));

		int no=0;
		while(rs3.next())
		{
			no = rs3.getInt("ExamID") + 1;
			out.println("<option value=" + rs3.getInt("ExamID") + ">" + examNames.elementAt(no) + "</option>");
		}
	}catch(Exception ex){out.println(ex.getMessage());}
%> 
   </select>

<br>  <input type=submit name=confirm value="Submit">
 </form>

<%
		}
	}catch(Exception ex){out.println(ex.getMessage());}
}
%> 



</body>
</html>
