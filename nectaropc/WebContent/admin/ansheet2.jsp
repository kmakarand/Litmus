<html>
<head>
<title>Answer Sheet</title>
<%@ page language="java" session="true" %>
<% 
	Integer ET=(Integer)session.getValue("ExamTime");
	int	totaltime =ET.intValue();
	out.print(totaltime);
	String tstatus2=(String)session.getValue("teststatus");
	if(tstatus2.equals("old"))
	{
	  String gettime=(String)session.getValue("TimeLeft"); 
	  totaltime=Integer.parseInt(gettime);
	  out.print(totaltime);
	}
%>	

<script language="javascript">
 var ansvar="";
 var r ="";
 var tf=0;
 var timeup=0;
 var timeleft=0;
 var tcount=0;
 var temp=0;
 //var totaltime=500;
 //var lcurrent = parent.temp2.current;

 function TimerFunc()
 {
  
  tf = window.setTimeout("TimerFunc();",1000);
  tcount++;
  
  //parent.temp2.qtimer=tcount-temp;
  //temp=temp + parent.temp2.qtimer;
  //alert(parent.temp2.qtimer);

  //temp=tcount;
  timeleft=<%out.print(totaltime);%>-tcount;
  parent.temp2.tmleft=timeleft;
  window.status = timeleft + "  Seconds remaining";
  if(timeleft==60)
	 {
	  alert("Only 1 minute left"); 
	 }
    if(timeleft==0)
     {
       window.clearTimeout(tf);
       timeup=1;
       document.ans2.submit();
     } 
 }

	
   function setvar(i)
   {
     parent.temp2.setr();
     r = parent.temp2.rname;
     alert(r);
	 var newr="r"+i;
	 if(r==newr)
	   {
		 for(var i=0;i<=3;++i)
		 {
			var p = "window.document.ans2." + r + "[" + i + "]"
			if(eval(p).checked) 
			 ansvar=eval(p).value;
		  }
	   
			 parent.temp2.localvar=ansvar;
			 alert(parent.temp2.localvar);
			 parent.temp2.setval();
	   }else
		{
		   alert("Please select the appropriate answer");
			
			for(var i=0;i<=3;++i)
			{
				var p = "window.document.ans2." + newr+"[" + i + "]";
				if(eval(p).checked) 
				eval(p).checked=false;
			}
		   
		  
	   }	
		  
    }//end of function setvar
	
	function setTime()
	{
		document.ans2.timetaken.value=<%out.print(totaltime);%>-timeleft;
	}

 
</script>
<body onload="TimerFunc()">

<form name="ans2" action="verifier2.jsp" method="GET" target="_top">



<table width="200">
 <tr>
   <td width=20%></td>
   <td width=20% align=center><font face="arial,helvetica" size="2" color="">A</font></td>
   <td width=20% align=center><font face="arial,helvetica" size="2" color="">B</font></td>
   <td width=20% align=center><font face="arial,helvetica" size="2" color="">C</font></td>
   <td width=20% align=center><font face="arial,helvetica" size="2" color="">D</font></td>
 </tr>
<%
   //String id=request.getParameter("cid");
   //out.println(id);

  //Integer getrows = (Integer)session.getValue("rowcount");
  //int rows = getrows.intValue();
	String tstatus =(String)session.getValue("teststatus");
	Integer option= new Integer(0);
	Integer val=(Integer)session.getValue("TotalQuestions");
	int testopt=val.intValue();
	int nrq=0;
	out.println(tstatus);
	if(tstatus.equals("old"))
	{
	   option =(Integer)session.getValue("NoOfRemainingQuestions");
	   nrq=option.intValue();
	   
	}

  for(int i=1;i<=testopt;++i)
  {
   
   out.println("<tr>");
   out.println("<td width=\"20%\" align=center><font face=\"arial,helvetica\" size=\"2\" color=\"blue\" >(" + i + ")</font></td>");
	if(i>nrq)
	  {	
		out.println("<td width=\"20%\" align=center><input type=\"radio\" name=\"r"+i+"\" value=\"1\" onClick=\"setvar("+i+");\"></td>");   
		out.println("<td width=\"20%\" align=center><input type=\"radio\" name=\"r"+i+"\" value=\"2\" onClick=\"setvar("+i+");\"></td>");   
		out.println("<td width=\"20%\" align=center><input type=\"radio\" name=\"r"+i+"\" value=\"3\" onClick=\"setvar("+i+");\"></td>");   
		out.println("<td width=\"20%\" align=center><input type=\"radio\" name=\"r"+i+"\" value=\"4\" onClick=\"setvar("+i+");\"></td>");  
		out.println("</tr>");
	  }	
  }
  String tover1="true";
  session.putValue("testover",tover1);
  
%>
</table>
<input type=hidden name="timetaken" value="500">
<input type=submit value=" Submit Answers" onClick="setTime()">
</form>
</body>
</html>