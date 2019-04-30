<%@ page language = "java" import = "java.sql.*" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<html>
<head>
<title>Payment Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE=JavaScript src="validatefunction.js"></SCRIPT>
<script language=javascript>
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
<font size="3" face="Verdana, Arial, Helvetica, sans-serif"><B>Payment details</B></font> 
<hr size=1>
<form name=f1 method="post" action="/zalm/servlet/paymentDetailsServlet4">
  <table width="79%" border="0" cellspacing="3" cellpadding="0">
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">ExamID 
          <font color="#CC0000">*</font></font></div>
      </td>
      <td width="25%"> 
        <select name="ExamID">
          <option value=0>Select Exam Name</option>
          <%
	try
	{
		Connection con = pool.getConnection();
		Statement st1 = con.createStatement();
		ResultSet rs1 = st1.executeQuery("select * from ExamMaster ORDER BY Exam");
		while(rs1.next())
		{
			out.println("<option value=" + rs1.getInt("ExamID") + ">" + rs1.getString("Exam") + "</option>");
		}
	}catch(Exception ex){out.println(ex.getMessage());}
%> 
        </select>
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Candidate 
          ID <font color="#CC0000">*</font></font></div>
      </td>
      <td width="26%"> <font size="2" face="Verdana, Arial, Helvetica, sans-serif"> 
        <input type="text" name="CandidateID" maxlength="20">
        </font> </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Amount<font color="#CC0000">*</font></font></div>
      </td>
      <td width="25%"> 
        <input type="text" name="Amount" value="" maxlength="255">
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Currency</font></div>
      </td>
      <td width="26%">
        <select name="Currency">
          <option value=Rs.>Rupees</option>
          <option value=$>Dollors</option>
        </select>
      </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Mode 
          of Payment</font></div>
      </td>
      <td width="25%">
        <select name="ModeOfPayment">
          <option value="DD">DD</option>
          <option value="Cheque">Cheque</option>
          <option value="Cash">Cash</option>
        </select>
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Date</font></div>
      </td>
      <td width="26%"> 
        <input type="text" name="Date" maxlength="25">
      </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Bank</font></div>
      </td>
      <td width="25%"> 
        <input type="text" name="Bank" maxlength="20">
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Branch</font></div>
      </td>
      <td width="26%"> 
        <input type="text" name="Branch" maxlength="25">
      </td>
    </tr>
    <tr> 
      <td width="29%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Cheque 
          No</font></div>
      </td>
      <td width="25%"> 
        <input type="text" name="ChequeNo" maxlength="16">
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
      </td>
      <td width="20%"> 
        <div align="right"><font size="2" face="Verdana, Arial, Helvetica, sans-serif">Realization 
          Date </font></div>
      </td>
      <td width="26%"> 
        <input type="text" name="RealizationDate" maxlength="16">
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
      </td>
      <td width="20%"> 
        <div align="right"></div>
      </td>
      <td width="26%">&nbsp; </td>
    </tr>
    <tr> 
      <td colspan="4"> 
        <div align="center"> 
          <input type=submit value="Submit Details" onClick="return xx();">
          <input type=reset value=Reset>
        </div>
      </td>
    </tr>
  </table>
</form>

</body>
</html>
