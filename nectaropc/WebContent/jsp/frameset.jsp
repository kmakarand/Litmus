<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title>Jsp Frameset</title>
</head>
<frameset rows="10%,*">
<frame src="timer.jsp" name="frame1"scrolling="no" frameborder="0">
<frameset cols="100%,*">
<frame src="NewTestMain.jsp" name="frame2" frameborder="0">
<!-- <frame src="frame3.jsp" name="frame3"> -->
</frameset>
</frameset>
</html>