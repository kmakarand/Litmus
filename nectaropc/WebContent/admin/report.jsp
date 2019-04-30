<html>
<head>
<title>Report Generator</title>
</head>
<body bgcolor=#ffffff>
<I><h2><center><font color=blue>Report Generator</font></center></h2></I>
<form action="makereport.jsp" method="GET">

<center>
<br><br>

<TABLE border=1>
<b><font face="arial,helvetica" size="3" >GENERATE REPORT AS PER</font></b>
<TR>
	<TD><input type="radio" name="r1" value="1"></TD>
	<TD>Individual Candidate </TD>
	<TD>Candidate ID :</TD>
	<TD><input type=text width=8></TD>
</TR>
<TR>
	<TD><input type="radio" name="r1" value="2"></TD>
	<TD>Test Paper</TD>
	<TD>Test Name :</TD>
	<TD><input type=text width=8></TD>
</TR>
<TR>
	<TD><input type="radio" name="r1" value="3"></TD>
	<TD>ALL CANDIDATES</TD>
	
</TR>
<TR>
	<TD></TD>
	<TD></TD>
	<TD></TD>
</TR>


</TABLE>
</center>
<CENTER><input type=submit name=submit value="GET IT" >
<input type=reset name=reset value="CLEAR">
</CENTER>
</form>
 </body>
</html>




