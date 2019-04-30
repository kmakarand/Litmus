
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->

<html>
<head>
<title>Main Jsp</title>
<META HTTP-EQUIV="pragma" CONTENT="no-cache">
<style>body{font-family:arial;font-size:11pt;color:#330099;}</style>
</head>
<script language="javascript" src="quiz.js"></script>


<!--<%@ page language="java" errorPage="errortest.jsp"%>-->

<form name="main1" action="testover.html" method="GET">
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
    <frameset  cols ="70%,30%" bordercolor=#ffffff frameborder=1>
	
	<frame src="NewTestMain.jsp" name="temp2">
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
