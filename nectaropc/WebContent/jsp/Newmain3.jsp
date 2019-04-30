
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<html>
<head>
<title>Test</title>

<%
	out.println("<script language='javascript'>");
	out.println("if(top.temp2) top.location.href='Newmain3.jsp?id=" + request.getParameter("id") +"&qans=" + request.getParameter("qans")+"&bookmark="+request.getParameter("bookmark")+"&questimer="+request.getParameter("questimer")+"&return="+request.getParameter("return")+"&timeleft="+request.getParameter("timeleft")+"'");
	out.println("</script>");

	String values = "id="+request.getParameter("id")+"&qans=" + request.getParameter("qans")+"&bookmark="+request.getParameter("bookmark")+"&questimer="+request.getParameter("questimer")+"&return="+request.getParameter("return")+"&timeleft="+request.getParameter("timeleft");
	//System.out.println(values);

%>


	<%@ page language="java" import=""%>

<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<style>body{font-family:arial;font-size:11pt;color:#330099;}</style>
</head>
<script language="javascript" src="quiz.js"></script>


<form name="mainbm" action="testover.html" method="GET">
<script language="javascript">
function cancelRefresh() 
		{
		  // keycode for F5 function
		  if (window.event && window.event.keyCode == 116) {
		    window.event.keyCode = 8;
			  }
			  // keycode for backspace
		 if (window.event && window.event.keyCode == 8) 
			 {
				// try to cancel the backspace
				window.event.cancelBubble = true;
				window.event.returnValue = false;
				return false;
	
		    }

	}
</script>
<!--<%
   String testval=(String)session.getValue("testover");
   if(testval.equals("false"))
   {
 %>
-->
   <script language="javascript">
	function cancelRefresh() 
		{
		  // keycode for F5 function
		  if (window.event && window.event.keyCode == 116) {
		    window.event.keyCode = 8;
			  }
			  // keycode for backspace
		 if (window.event && window.event.keyCode == 8) 
			 {
				// try to cancel the backspace
				window.event.cancelBubble = true;
				window.event.returnValue = false;
				return false;
	
		    }

	}
</script>
    <frameset name=frs cols ="70%,30%" bordercolor=#ffffff frameborder=1>
<% 
	String start = (String) session.getAttribute("start");
	if((start!=null)&&(start.equals("start")))
	out.println("<frame src=NewTestMain.jsp?"+values+" name=\"temp2\">");
	else out.println("<frame src=NewTestMain.jsp name=\"temp2\">");

	%>		
	

	<!--<frame src="TestMain.jsp" name="temp2">-->
		<frame src="about:blank" name="temp3">
    </frameset>
  
<!-- <%
	 
   }else
   {
    
 %>
	
	  <script language="javascript">
			window.open("testover.html","_top");
      </script>   
    
    
  <%	
   }//end of else
   %>
-->
</form>
</html>
