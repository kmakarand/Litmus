
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<%@ page language="java" session="true"%>
<%
String username = (String)session.getValue("username");

if( username == "" || username == null)
{
	response.sendRedirect("Login.jsp");
}
%>
<HTML>
<HEAD>
<TITLE>Nectar Online</TITLE>
<SCRIPT LANGUAGE="javascript">
var windowHandle = '';
//<!--
function OpenWin(url)
{
	//var testWin = window.open (url, "TestWindow", "width=750, height=500, resizable=1, status=0, scrollbars=yes, toolbar=no, locationbar=no, menubar=no, left=20, top=0");
	//var testWin = window.open (url, "TestWindow", "width=" + screen.availWidth+", height=" + screen.availHeight +", resizable=1, status=1, scrollbars=yes, toolbar=no, locationbar=no, menubar=no, left=0, top=0");FEF9E2<link rel="stylesheet" href="../alm.css" type="text/css">




	//windowHandle = window.open(url,'popup','fullscreen=no,outerHeight=' + screen.availHeight + ',outerWidth=' + screen.availWidth);<IMG SRC="../simages/checker-flag.gif" WIDTH="287" HEIGHT="198" BORDER=0 ALT="">


	 var stpos=(screen.availWidth-350)/2;
	  var stpos1=(screen.availHeight-300)/2;
	window.open(url,"","toolbar=no,width=780,height=510,scrollbars=yes,left=0,top=0,status=1,resizable=1"); //800,500
}
function OpenCalculator(url)
{
	window.open(url, "calc", "width=130,height=215,left=200,top=100,resizable=0");
}
//-->
</SCRIPT>
<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>
<BODY bgcolor="#FFFFFF" topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<P>&nbsp;</P>
<CENTER>
<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>
<TR><TD>
	You are about to start a test.<BR><BR>
	<B><A HREF="javascript:OpenWin('DemoBeginTest.htm');">Click here</A> for Demo Test.</B><BR><BR>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
	<A HREF="javascript:OpenWin('NewBeginTest.jsp');"><IMG SRC="simages/checker-flag.gif" WIDTH="127" HEIGHT="98" BORDER=0 ALT=""></A><br><B> <A HREF="javascript:OpenWin('NewBeginTest.jsp');">Click here</A> to begin the test.</B>
	<P align=center></P>
			

</TD></TR>
</TABLE>


</BODY>
</HTML>
