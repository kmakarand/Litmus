<!DOCTYPE html>
<html>
<head>
<title>HTML Target Frames</title>
</head>

<frameset cols="*" bordercolor="#ffffff" frameSpacing="0" frameborder="0" border=0 >
	<frame src="jdbcmenu.jsp" name="menu_page" scrolling=no frameborder=0 framespacing=0 border=0 marginwidth=0 marginheight=0 noresize>
<%--	<frame src="welcome.jsp" name="main_page" frameborder=0 framespacing=0 border=0 marginwidth=0 marginheight=0 target="_self" align=center>--%>
	<noframes>
		<body >
			<p>This page uses frames, but your browser doesn't support them.</p>
		</body>
	</noframes>
</frameset>
</html>