<html>
<head>
<title> Xml Pasrser Page </title>
</head>
<body bgcolor=#FEF9E2>
<form action="../admin/xmlBean.jsp" method="POST">


<table align="center" cellspacing="2" cellpadding="2" border="1">
<tr><td>File Name:</td><td><input type=text name="filename" width=5></td></tr><br>
<tr><td>Select the file to be uploaded:</td><td><INPUT TYPE="FILE" NAME="fileList"></td></tr> <BR>

<tr><td>Database Confirm:</td><td> <SELECT name="exam">

<OPTION VALUE="alm">Adaptive learning
<OPTION VALUE="zalm">IIT
<OPTION VALUE="rpdb">CET Bombay
<OPTION VALUE="dcet">CET Delhi
<OPTION VALUE="cat">CAT  MBA
<OPTION VALUE="gre">GRE
</SELECT></td></tr>


<tr><td>   TableName</td><td><input type=text name=tablename width=5></td></tr>

   <tr> <td><input type=submit name=t1 value=" Parse "></td><td>Please Upload File before Parsing</td></tr>

 </table>
</form>
</body>
</html>
