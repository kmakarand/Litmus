
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
	//System.out.println("if(top.temp2) top.location.href='Newmainbm.jsp?id=" + request.getParameter("id") +"&qans=" + request.getParameter("qans")+"&questimer="+request.getParameter("questimer")+"&timeleft="+request.getParameter("timeleft")+"'");
	out.println("if(top.temp2) top.location.href='Newmainbm.jsp?id=" + request.getParameter("id") +"&qans=" + request.getParameter("qans")+"&questimer="+request.getParameter("questimer")+"&timeleft="+request.getParameter("timeleft")+"'");
	out.println("</script>");
	String values = "id="+request.getParameter("id")+"&qans=" + request.getParameter("qans")+"&questimer="+request.getParameter("questimer")+"&timeleft="+request.getParameter("timeleft");
	//System.out.println("VALUES : "+values);

%>


	<%@ page language="java" import=""%>

<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<style>body{font-family:arial;font-size:11pt;color:#330099;}</style>
</head>
<script language="javascript" src="quizbm.js"></script>


<form name="Newmainbm" action="testover.html" method="GET">
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
<% out.println("<frame src=NewTestMainbm.jsp?"+values+" name=\"temp2\">");%>	
	<!--<frame src="NewTestMainbm.jsp" name="temp2">-->
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
