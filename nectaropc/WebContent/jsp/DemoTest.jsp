
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<link rel="stylesheet" href="../alm.css" type="text/css">
<script language="javascript" src="quiz.js"></script>
<script language="javascript">
var localvar="";
var flag=0;
var rname="";
var qtimer;
var tmleft;
var k;

//var current=document.NewTestMain.id.value;

	function setr()
	{
		rname='r' + document.NewTestMain.id.value;
	}

	function initialize(i)
	{
		k=i;
		//parent.displayOption(k);
		alert();
		parent.setTime();
	}


/*
	function showval()
	{
		if(parent.isPerQuestionTimer==1) parent.temp=0;
		qtimer = parent.tcount - parent.temp;
		parent.temp = parent.tcount;
		document.demotest.timeleft.value=tmleft;
		document.NewTestMain2.timeleft.value=tmleft;
		document.NewTestMain3.timeleft.value=tmleft;
		document.NewTestBM.timeleft.value=tmleft;
		//return localvar;
	}
*/

	function setval()
	{
		var nop = document.demotest.nop.value;
		var strans="";
		//alert("document.demotest.nop.value"+document.demotest.nop.value);
		for(var i=0;i<=nop-1;++i)
		{
			var p ="document.demotest.r["+i+"]";

			if(eval(p).checked)  document.demotest.qans.value=i+1;
			//alert("document.demotest.qans.value"+document.demotest.qans.value);
			if(eval(p).checked)  document.NewTestMain2.qans.value=i+1;
			//alert("document.NewTestMain2.qans.value"+document.NewTestMain2.qans.value);
			if(eval(p).checked)  document.NewTestMain3.qans.value=i+1;
			//alert("document.NewTestMain3.qans.value"+document.NewTestMain3.qans.value);
			if(eval(p).checked)  document.NewTestMain4.qans.value=i+1;
			//alert("document.NewTestMain4.qans.value"+document.NewTestMain4.qans.value);
			if(eval(p).checked)  document.NewTestMain5.qans.value=i+1;
			//alert("document.NewTestMain5.qans.value"+eval(p).checked);
			if(eval(p).checked)  document.NewTestBM.qans.value=i+1;
			if(eval(p).checked)  strans=strans+document.NewTestBM.qans.value;

			if(i==0)
			document.demotest.chkans1.value=strans;
			if(i==1)
			document.demotest.chkans2.value=strans;
			if(i==2)
			document.demotest.chkans3.value=strans;
			if(i==3)
			document.demotest.chkans4.value=strans;
			
			if (strans==null || strans=="")
	  		{
	  			//alert("First name must be filled out");
	  			document.demotest.chkans1.value=0;
	        	document.demotest.chkans2.value=0;
	        	document.demotest.chkans3.value=0;
	        	document.demotest.chkans4.value=0;
	  		}

			//alert("document.demotest.chkans1.value"+document.demotest.chkans1.value);
			//alert("document.demotest.chkans2.value"+document.demotest.chkans2.value);
			//alert("document.demotest.chkans3.value"+document.demotest.chkans3.value);
			//alert("document.demotest.chkans4.value"+document.demotest.chkans4.value);

	  }


	}

	function showval()
	{
		setval();
		if(parent.isPerQuestionTimer==1) parent.temp=0;
		qtimer = parent.tcount - parent.temp;
		parent.temp = parent.tcount;
		document.demotest.timeleft.value=tmleft;
		document.NewTestMain2.timeleft.value=tmleft;
		document.NewTestMain3.timeleft.value=tmleft;
		document.NewTestMain4.timeleft.value=tmleft;
		document.NewTestMain5.timeleft.value=tmleft;
		document.NewTestBM.timeleft.value=tmleft;
		//return localvar;
		
	}

	function checksubmit()
	{
	    
		showval();
		if(confirm("Do you wish to finish the test ?") == true)
		document.NewTestMain2.submit();
		else
		return false;
	}
	function OpenCalculator(url)
	{
		window.open(url, "calc", "width=130,height=215,left=200,top=100,resizable=0");
	}
	
	
	
	
	

</script>
</HEAD>

<%@ page language="java" import="java.util.*,java.sql.*" session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="rnd" scope="page" class="com.ngs.gbl.RandomGenerator"/>

<BODY>


<%

	Connection con	= null;
	try
	{

	ServletContext context	   = getServletContext();
	pool					   =(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
	con = pool.getConnection();
	String action = request.getParameter("action");
	Hashtable BMQuestions=new Hashtable();
	Hashtable QAnswers=new Hashtable();
	Hashtable QACorrect = new Hashtable();
	Hashtable QID= new Hashtable();
	Vector QB= new Vector();
	String id = "0";
	int tques=0;
	int idi =0;
	int count=1;
	int qcount=0;
	String OnPage="";
	String ansg1="",ansg2="",ansg3="",ansg4="";
	String lang = request.getParameter("lang");
	int examcode=10536;
	
	//System.out.println("action :"+action);
	//System.out.println("lang :"+lang);

	Statement s1 = con.createStatement();
	Statement s2 = con.createStatement();
	ResultSet rs1= null;
	ResultSet rs2= null;
	
	Locale locale=null;
     if (lang.equals("German")) {
       locale=Locale.GERMANY;
     } else if (lang.equals("French")) {
         locale=Locale.FRANCE;
         examcode=13;
     } else if (lang.equals("Spanish")) {
       	 locale=new Locale("es","ES");
       	 examcode=12;
     } else {
         locale=Locale.US;
 
     }
     session.putValue("myLocale",locale);
     ResourceBundle bundle = ResourceBundle.getBundle("Message",locale);
     for (Enumeration e = bundle.getKeys();e.hasMoreElements();) {
         String key = (String)e.nextElement();
         String msg = bundle.getString(key);
         //System.out.println("key :"+key);
         //System.out.println("msg :"+msg);
         session.putValue(key,msg);
     }

	if(action==null)
	{
	    //System.out.println("Demotest 1:"+lang);
	    //System.out.println("mfq :"+bundle.getString("mfq"));
	    session.putValue("lang",lang);
	    //System.out.println("Demotest 2:"+session.getValue("lang"));
	    //System.out.println("Demotest 3:"+examcode);
	    
		count=1;
		out.println("<form name=demotest method=get action="+request.getRequestURI()+">");
		try
		{
			String sql = "Select QuestionID from QuestionMaster where ExamID="+examcode;
			//System.out.println("Demotest 4:"+sql);
			rs1=  s1.executeQuery(sql);
		}
		catch(SQLException e)
		{System.out.println("Exception caught :"+e.getMessage());}
		
		int w=0;
		while(rs1.next())
		{
		    //System.out.println("rs1.getInt QuestionId :"+rs1.getInt("QuestionID"));
			QB.add(w,new Integer(rs1.getInt("QuestionID")));
			++w;
		}

		try
		{
			rs1 = s1.executeQuery("Select QuestionID from QuestionMaster where ExamID="+examcode);
		}
		catch(SQLException e)
		{System.out.println("Exception caught :"+e.getMessage());}


		rnd.setRows(QB.size()-1);
		tques = ((Integer)QB.get(rnd.createVal())).intValue();
		//System.out.println("tques"+tques);
		QB.remove(new Integer(tques));
		session.setAttribute("QB",QB);

		String getQDetails = "Select * from QuestionMaster where QuestionID="+tques;
		//System.out.println("getQDetails :"+getQDetails);

		try
		{
			rs2 = s2.executeQuery(getQDetails);
		}catch (SQLException e)
		{
			out.println(" Couldn't access Question  :"+e.getMessage());
		}



		String id1,ques,a1,a2,a3,a4,a5,ans,imagename,sCodeID;
		int image=0;
		id1=ques=a1=a2=a3=a4=a5=ans=imagename=sCodeID="";
		int ansi=0;
        imagename="reason1.gif";
		while(rs2.next())
		{
			id1= rs2.getString("QuestionID");
			ques= rs2.getString("Question");
			a1= rs2.getString("Option1");
			a2= rs2.getString("Option2");
			a3= rs2.getString("Option3");
			a4= rs2.getString("Option4");
			a5= rs2.getString("Option5");
			ans= rs2.getString("Answer");
			image=Integer.parseInt(rs2.getString("Image"));
			//out.println("ansno"+ans);
		}

		BMQuestions.put(new Integer(1),new Integer(0));
		QAnswers.put(new Integer(1),new Integer(0));
		QID.put(new Integer(1),new Integer(tques));
		QACorrect.put(new Integer(1),new Integer(ansi));

		session.setAttribute("BMQuestions",BMQuestions);
		session.setAttribute("QAnswers",QAnswers);
		session.setAttribute("QID",QID);
		session.setAttribute("DemoBM",new Integer(0));
		session.setAttribute("QACorrect",QACorrect);

		int idv,ani;
		idv=ani=0;
		if(id!=null)   idv = Integer.parseInt(id);
		if(ans!=null)  ani = Integer.parseInt(ans);
		int nop=2;
%>
	<script>
	parent.totaltime=1200;
	parent.exammode=0;
	parent.isPerQuestionTimer=3;
	parent.NoOfSections=1;
	parent.setTime();

	</script>
<table border="0" cellspacing="1" cellpadding="1" width="80%">
<tr>
<th width="15%" align="right"><b><%=bundle.getString("qn")%></b></th>
<th align="left">
<table border=0 cellspacing=0 cellpadding=0 width='100%'>
<tr>
<th><%=count%></th>
<th align='right'>
<div align="right">
</th>
</tr>
</table>
</th>
</tr>
<tr>
<th colspan=2 align="left">
<table  border="0" cellspacing="0" cellpadding="1" width="100%">
<tr><th><b><%=bundle.getString("mfq")%></th></tr>
</table>
</th>
</tr>
<tr>
<td valign="top" align="right"><b><%=bundle.getString("q")%>: </b> </td>
<td><%=ques%></td>
</tr>
<tr>
<td align="center">(A)</td>
<td><input type="checkbox" name="r"  value=1><%=a1%></td>
</tr>
<tr>
<td align="center">(B)</td>
<td><input type="checkbox" name="r"  value=2 ><%=a2%></td>
	</tr>
<%
	if((a3!=null)&&(!a3.equals(""))&&(!a3.equals("NoOption"))&&(!a3.equals("no options")))
	{	++nop;
%>	<tr>
		<td align="center">(C)</td>
		<td><input type="checkbox" name="r"  value=3  ><%=a3%></td>
	</tr>
<%
	}
	if((a4!=null)&&(!a4.equals(""))&&(!a4.equals("NoOption"))&&(!a4.equals("no options")))
	{	++nop;
%>
	<tr>
		<td align="center">(D)</td>
		<td><input type="checkbox" name="r"  value=4 ><%=a4%></td>
	</tr>
<%
	}
	if((a5!=null)&&(!a5.equals(""))&&(!a5.equals("NoOption"))&&(!a5.equals("no options")))
	{	++nop;
%>
	<tr>
		<td align="center">(E)</td>
		<td><input type="checkbox" name="r"  value=5 ><%=a5%></td>
	</tr>
  <%
	}
%>

	<tr align="center">
		<td colspan="2">
		<input type="checkbox" name="bookmark" value="1">
		<%=bundle.getString("bk")%>
		</td>
	</tr>
 <%

	out.println("<input type=hidden name=nop value="+nop+">");
	out.println("<input type=hidden name=lang value="+lang+">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"action\" value=\"next\">");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"chkans1\" value=\"\">");
	out.println("<input type=\"hidden\" name=\"chkans2\" value=\"\">");
	out.println("<input type=\"hidden\" name=\"chkans3\" value=\"\">");
	out.println("<input type=\"hidden\" name=\"chkans4\" value=\"\">");
	

	if(count<6)
		{

 %>
	<tr>
		<th colspan=2><div class='clsNavigation'>
		<input type="submit" value='<%=bundle.getString("nq")%>' border=0 onClick="return showval()">
		</div>
		</th>
	</tr>
	</table>


<%
		}

	out.println("</form>");
        

		}else if (action.equals("next"))
		{
		
		    out.println("<form name=demotest method=get action="+request.getRequestURI()+" >");
		  		     
			BMQuestions = (Hashtable) session.getAttribute("BMQuestions");
			QAnswers = (Hashtable) session.getAttribute("QAnswers");
			QACorrect = (Hashtable) session.getAttribute("QACorrect");
			QID=(Hashtable) session.getAttribute("QID");
			QB =(Vector) session.getAttribute("QB");
			id = request.getParameter("id");
			//System.out.println("ID :"+id);
			String ansg= request.getParameter("qans");
			
			ansg1= request.getParameter("chkans1");
			ansg2= request.getParameter("chkans2");
			ansg3= request.getParameter("chkans3");
			ansg4= request.getParameter("chkans4");
			//out.println("ansg1:"+ansg1);
			//out.println("ansg2:"+ansg2);
			//out.println("ansg3:"+ansg3);
			//out.println("ansg4:"+ansg4);
			String return1 = request.getParameter("return");

			if(id!=null) idi=Integer.parseInt(id);
			count = idi+1;

			if((ansg4!=null)) QAnswers.put(new Integer(idi),new Integer(Integer.parseInt(ansg4)));
            //String Qans=;
			//out.println("QAnswers"+QAnswers.get(new Integer(idi)));

			if(request.getParameter("bookmark")!=null)
			{
				BMQuestions.put(new Integer(idi),new Integer(1));
				session.setAttribute("DemoBM",new Integer(1));
			}

			if((return1!=null)&&(return1.equals("return")))
			{
				count = ((Integer)session.getAttribute("lastvalue")).intValue();
				tques = ((Integer)QID.get(new Integer(count))).intValue();

			}
			else
			{
				rnd.setRows(QB.size()-1);
				tques = ((Integer)QB.get(rnd.createVal())).intValue();
				QB.remove(new Integer(tques));
			}



			session.setAttribute("QB",QB);
			String getQDetails = "Select * from QuestionMaster where QuestionID="+tques;

			try
				{
					rs2 = s2.executeQuery(getQDetails);
				}catch (SQLException e)
				{
					out.println(" Couldn't access Question  :"+e.getMessage());
				}

				String id1,ques,a1,a2,a3,a4,a5,ans,imagename,sCodeID;
				int image=0;
				id=ques=a1=a2=a3=a4=a5=ans=imagename=sCodeID="";
				int ansi=0;
				imagename="reason1.gif";
				while(rs2.next())
				{
					id1= rs2.getString("QuestionID");
					ques= rs2.getString("Question");
					a1= rs2.getString("Option1");
					a2= rs2.getString("Option2");
					a3= rs2.getString("Option3");
					a4= rs2.getString("Option4");
					a5= rs2.getString("Option5");
					ans= rs2.getString("Answer");
					image=Integer.parseInt(rs2.getString("Image"));
				}

				ansi = Integer.parseInt(ans);

				if(return1==null)
				{
					BMQuestions.put(new Integer(count),new Integer(0));
					QAnswers.put(new Integer(count),new Integer(0));
					QID.put(new Integer(count),new Integer(tques));
					QACorrect.put(new Integer(count),new Integer(ansi));
				}

				session.setAttribute("BMQuestions",BMQuestions);
				session.setAttribute("QAnswers",QAnswers);
				session.setAttribute("QID",QID);
				session.setAttribute("lastvalue",new Integer(count));
				session.setAttribute("QACorrect",QACorrect);
				int nop=2;

		%>
		<script>
			parent.totaltime=<%=Integer.parseInt(request.getParameter("timeleft"))%>;
			parent.exammode=0;
			parent.isPerQuestionTimer=3;
			parent.NoOfSections=1;
			parent.setTime();
		</script>
		<table border="0" cellspacing="1" cellpadding="1" width="80%">
		<tr>
		<th width="15%" align="right"><b><%=bundle.getString("qn")%></b></th>
		<th align="left">
		<table border=0 cellspacing=0 cellpadding=0 width='100%'>
		<tr>
		<th><%=count%></th>
		<th align='right'>
		<A HREF="javascript:OpenCalculator('Calculator.htm');"><%=bundle.getString("ch")%></A> <%=bundle.getString("fc")%>
		</th>
		</tr>
		</table>
		</th>
		</tr>
		<tr>
		<th colspan=2 align="left">
		<table  border="0" cellspacing="0" cellpadding="1" width="100%">
		<tr><th><b><%=bundle.getString("mfq")%></th></tr>
		</table>
		</th>
		</tr>
		<tr>
		<td valign="top" align="right"><b><%=bundle.getString("q")%> : </b> </td>
		<td><%=ques%></td>
		</tr>
		<tr>
		<td align="center">(A)</td>
		<td><input type="checkbox" name="r"  value=1 <% String tmp1=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp1.indexOf("1")!=-1)out.println("checked"); %>><%=a1%></td>
		</tr>
		<tr>
		<td align="center">(B)</td>
		<td><input type="checkbox" name="r"  value=2 <% String tmp2=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp2.indexOf("1")!=-1)out.println("checked"); %> ><%=a2%></td>
			</tr>
		<%


			if((a3!=null)&&(!a3.equals(""))&&(!a3.equals("NoOption"))&&(!a3.equals("no options")))
			{	++nop;
		%>	<tr>
				<td align="center">(C)</td>
				<td><input type="checkbox" name="r"  value=3 <% String tmp3=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp3.indexOf("1")!=-1)out.println("checked"); %> ><%=a3%></td>
			</tr>
		<%
			}
			if((a4!=null)&&(!a4.equals(""))&&(!a4.equals("NoOption"))&&(!a4.equals("no options")))
			{	++nop;
		%>
			<tr>
				<td align="center">(D)</td>
				<td><input type="checkbox" name="r"  value=4 <% String tmp4=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp4.indexOf("1")!=-1)out.println("checked"); %> ><%=a4%></td>
			</tr>
		<%
			}
			if((a5!=null)&&(!a5.equals(""))&&(!a5.equals("NoOption"))&&(!a5.equals("no options")))
			{	++nop;
		%>
			<tr>
				<td align="center">(E)</td>
				<td><input type="checkbox" name="r"  value=5 <% String tmp5=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp5.indexOf("1")!=-1)out.println("checked");%> ><%=a5%></td>
			</tr>
		  <%
			}
		%>

			<tr align="center">
				<td colspan="2">
				<input type="checkbox" name="bookmark" value="1">
				<%=bundle.getString("bk")%>
				</td>
			</tr>
			
		 <%

			out.println("<input type=hidden name=nop value="+nop+">");
			out.println("<input type=hidden name=lang value="+lang+">");
			out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
			out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"action\" value=\"next\">");
			out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"chkans1\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans2\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans3\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans4\" value=\"\">");
			if(count<6)
			{ 
			   if(count>=5)
			   {
			%> 
 			<tr>
				<th colspan=2><div class='clsNavigation'>
				<input type="submit" value='<%=bundle.getString("ft")%>' onClick="return showval()">
				</div>
				</th>
			</tr>  
			<%}else{%>
			<tr>
				<th colspan=2><div class='clsNavigation'>
				<input type="submit" value='<%=bundle.getString("nq")%>' border=0 onClick="return showval()">
				</div>
				</th>
			</tr><%}%>
	</table>
  
<%          
			}

			out.println("</form>");

		}else if(action.equals("allquestions"))
		{

//ALL questions

			out.println("<form name=demotest method=get action="+request.getRequestURI()+" >");

			OnPage = "allquestions";

			BMQuestions = (Hashtable) session.getAttribute("BMQuestions");
			Vector TempAQ = new Vector();
			String first = request.getParameter("first");
			QAnswers = (Hashtable) session.getAttribute("QAnswers");
			QID=(Hashtable) session.getAttribute("QID");
			QB =(Vector) session.getAttribute("QB");

			if((first!=null)&&(first.equals("first")))
			{
				int w=0;
				for(int i=1;i<=QID.size();++i)
				{
					Integer b =(Integer) BMQuestions.get(new Integer(i));
					TempAQ.add(w,new Integer(i));
					++w;
				}
			}
			else
			{

				TempAQ = (Vector) session.getAttribute("TempAQ");
			}

			QAnswers = (Hashtable) session.getAttribute("QAnswers");
			QID=(Hashtable) session.getAttribute("QID");
			QB =(Vector) session.getAttribute("QB");
			id = request.getParameter("id");
			String ansg= request.getParameter("qans");
            ansg4= request.getParameter("chkans4");

           	if(id!=null) idi=Integer.parseInt(id);
			count = idi+1;


			if((ansg4!=null)) QAnswers.put(new Integer(idi),new Integer(Integer.parseInt(ansg4)));

			int size=0;
			int tempid=0;
			tempid = ((Integer)TempAQ.get(0)).intValue();
			tques  = ((Integer)QID.get(new Integer(tempid))).intValue();
			TempAQ.remove(0);
			count = tempid;
			session.setAttribute("TempAQ",TempAQ);
			String getQDetails = "Select * from QuestionMaster where QuestionID="+tques;

				try
				{
					rs2 = s2.executeQuery(getQDetails);
				}catch (SQLException e)
				{
					out.println(" Couldn't access Question  :"+e.getMessage());
				}

				String id1,ques,a1,a2,a3,a4,a5,ans,imagename,sCodeID;
				int image=0;
				id=ques=a1=a2=a3=a4=a5=ans=imagename=sCodeID="";
				imagename="reason1.gif";
				while(rs2.next())
				{
					id1= rs2.getString("QuestionID");
					ques= rs2.getString("Question");
					a1= rs2.getString("Option1");
					a2= rs2.getString("Option2");
					a3= rs2.getString("Option3");
					a4= rs2.getString("Option4");
					a5= rs2.getString("Option5");
					ans= rs2.getString("Answer");
					image=Integer.parseInt(rs2.getString("Image"));
				}


				//BMQuestions.put(new Integer(count),new Integer(1));
				//QAnswers.put(new Integer(count),new Integer(0));
				//QID.put(new Integer(count),new Integer(tques));

				session.setAttribute("BMQuestions",BMQuestions);
				session.setAttribute("QAnswers",QAnswers);
				session.setAttribute("QID",QID);

				int idv,ani;
				idv=ani=0;
				//if(id!=null)   idv = Integer.parseInt(id);
				//if(ans!=null)  ani = Integer.parseInt(ans);
				int nop=2;
		%>
		<script>
			parent.totaltime=<%=Integer.parseInt(request.getParameter("timeleft"))%>;
			parent.exammode=0;
			parent.isPerQuestionTimer=3;
			parent.NoOfSections=1;
			parent.setTime();
		</script>
	
		<table border="0" cellspacing="1" cellpadding="1" width="80%">
		<tr>
		<th width="15%" align="right"><b><%=bundle.getString("qn")%></b></th>
		<th align="left">
		<table border=0 cellspacing=0 cellpadding=0 width='100%'>
		<tr>
		<th><%=count%></th>
		<th align='right'>
		<div align="right">
		<A HREF="javascript:OpenCalculator('Calculator.htm');"><%=bundle.getString("ch")%></A> <%=bundle.getString("fc")%>
		</th>
		</tr>
		</table>
		</th>
		</tr>
		<tr>
		<th colspan=2 align="center">
		<table  border="0" cellspacing="0" cellpadding="1" width="100%">
		<tr><th><b><%=bundle.getString("mfq")%></th></tr>
		</table>
		</th>
		</tr>
		<tr>
		<td valign="top" align="right"><b><%=bundle.getString("q")%>: </b> </td>
		<td><%=ques%></td>
		</tr>
		<tr>
		<td align="center">(A)</td>
		<td><input type=checkbox name="r"  value=1 <% String tmp1=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp1.indexOf("1")!=-1)out.println("checked"); %>><%=a1%></td>
		</tr>
		<tr>
		<td align="center">(B)</td>
		<td><input type=checkbox name="r"  value=2  <% String tmp2=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp2.indexOf("2")!=-1)out.println("checked");%>><%=a2%></td>
			</tr>
		<%


			if((a3!=null)&&(!a3.equals(""))&&(!a3.equals("NoOption"))&&(!a3.equals("no options")))
			{	++nop;
		%>	<tr>
				<td align="center">(C)</td>
				<td><input type=checkbox name="r"  value=3 <% String tmp3=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp3.indexOf("3")!=-1)out.println("checked"); %> ><%=a3%></td>
			</tr>
		<%
			}
			if((a4!=null)&&(!a4.equals(""))&&(!a4.equals("NoOption"))&&(!a4.equals("no options")))
			{	++nop;
		%>
			<tr>
				<td align="center">(D)</td>
				<td><input type=checkbox name="r"  value=4 <% String tmp4=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp4.indexOf("4")!=-1)out.println("checked"); %> ><%=a4%></td>
			</tr>
		<%
			}
			if((a5!=null)&&(!a5.equals(""))&&(!a5.equals("NoOption"))&&(!a5.equals("no options")))
			{	++nop;
		%>
			<tr>
				<td align="center">(E)</td>
				<td><input type=checkbox name="r"  value=5 <% String tmp5=String.valueOf(((Integer)QAnswers.get(new Integer(count))).intValue());if(tmp5.indexOf("5")!=-1)out.println("checked"); %> ><%=a5%></td>
			</tr>
		  <%
			}


			out.println("<input type=hidden name=nop value="+nop+">");
			out.println("<input type=hidden name=lang value="+lang+">");
			out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
			out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"action\" value=\"allquestions\">");
			out.println("<input type=\"hidden\" name=\"bookmark\" value=1>");
			out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"chkans1\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans2\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans3\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans4\" value=\"\">");

			if (TempAQ.size()>0) size= ((Integer)TempAQ.get(0)).intValue();
			else size=0;
			if(count<=size)
			{
 %>
	<tr>
		<th colspan=2><div class='clsNavigation'>
		<input type="submit" value='<%=bundle.getString("nq")%>' border=0 onClick="return showval()">
		</div>
		</th>
	</tr>
	</table>


<%
			}

			out.println("</form>");

}else if(action.equals("bookmark"))
		{

//Bookmarked questions

			out.println("<form name=demotest method=get action="+request.getRequestURI()+" >");

			OnPage = "bookmark";

			BMQuestions = (Hashtable) session.getAttribute("BMQuestions");
			Vector TempBM = new Vector();
			String first = request.getParameter("first");
			QAnswers = (Hashtable) session.getAttribute("QAnswers");
			QID=(Hashtable) session.getAttribute("QID");
			QB =(Vector) session.getAttribute("QB");

			if((first!=null)&&(first.equals("first")))
			{

				//TempBM = BMQuestions;
				int w=0;

				for(int i=1;i<=QID.size();++i)
				{


					Integer b =(Integer) BMQuestions.get(new Integer(i));

					if(b.intValue()==1) {TempBM.add(w,new Integer(i));++w;}

				}
			}
			else
			{

				TempBM = (Vector) session.getAttribute("TempBM");
			}


			QAnswers = (Hashtable) session.getAttribute("QAnswers");
			QID=(Hashtable) session.getAttribute("QID");
			QB =(Vector) session.getAttribute("QB");
			id = request.getParameter("id");
			String ansg= request.getParameter("qans");

			if(id!=null) idi=Integer.parseInt(id);
			count = idi+1;
			if((ansg!=null)) QAnswers.put(new Integer(idi),new Integer(Integer.parseInt(ansg)));
			if(request.getParameter("bookmark")!=null)
			{
				BMQuestions.put(new Integer(idi),new Integer(1));
				session.setAttribute("DemoBM",new Integer(1));
			}

			int size=0;

			int tempid=0;

			tempid = ((Integer)TempBM.get(0)).intValue();
			tques  = ((Integer)QID.get(new Integer(tempid))).intValue();


			//out.println("before :"+TempBM.toString());
			TempBM.remove(0);

			count = tempid;
			//out.println("after :"+TempBM.toString());

			session.setAttribute("TempBM",TempBM);

			String getQDetails = "Select * from QuestionMaster where QuestionID="+tques;

				try
				{
					rs2 = s2.executeQuery(getQDetails);
				}catch (SQLException e)
				{
					out.println(" Couldn't access Question  :"+e.getMessage());
				}

				String id1,ques,a1,a2,a3,a4,a5,ans,imagename,sCodeID;
				int image=0;
				id=ques=a1=a2=a3=a4=a5=ans=imagename=sCodeID="";
				imagename="reason1.gif";
				while(rs2.next())
				{
					id1= rs2.getString("QuestionID");
					ques= rs2.getString("Question");
					a1= rs2.getString("Option1");
					a2= rs2.getString("Option2");
					a3= rs2.getString("Option3");
					a4= rs2.getString("Option4");
					a5= rs2.getString("Option5");
					ans= rs2.getString("Answer");
					image=Integer.parseInt(rs2.getString("Image"));
				}


				//BMQuestions.put(new Integer(count),new Integer(1));
				//QAnswers.put(new Integer(count),new Integer(0));
				//QID.put(new Integer(count),new Integer(tques));

				session.setAttribute("BMQuestions",BMQuestions);
				session.setAttribute("QAnswers",QAnswers);
				session.setAttribute("QID",QID);

				int idv,ani;
				idv=ani=0;
				//if(id!=null)   idv = Integer.parseInt(id);
				//if(ans!=null)  ani = Integer.parseInt(ans);
				int nop=2;
		%>
		<script>
			parent.totaltime=<%=Integer.parseInt(request.getParameter("timeleft"))%>;
			parent.exammode=0;
			parent.isPerQuestionTimer=3;
			parent.NoOfSections=1;
			parent.setTime();
		</script>
		<table border="0" cellspacing="1" cellpadding="1" width="80%">
		<tr>
		<th width="15%" align="right"><b><%=bundle.getString("qn")%></b></th>
		<th align="left">
		<table border=0 cellspacing=0 cellpadding=0 width='100%'>
		<tr>
		<th><%=count%></th>
		<th align='right'>
		<div align="right">
		<A HREF="javascript:OpenCalculator('Calculator.htm');"><%=bundle.getString("ch")%></A> <%=bundle.getString("fc")%>
		</th>
		</tr>
		</table>
		</th>
		</tr>
		<tr>
		<th colspan=2 align="left">
		<table  border="0" cellspacing="0" cellpadding="1" width="100%">
		<tr><th><b><%=bundle.getString("mfq")%></th></tr>
		</table>
		</th>
		</tr>
		<tr>
		<td valign="top" align="right"><b><%=bundle.getString("q")%> : </b> </td>
		<td><%=ques%></td>
		</tr>
		<tr>
		<td align="center">(A)</td>
		<td><input type=checkbox name="r"  value=1 <%if(((Integer)QAnswers.get(new Integer(count))).intValue()==1) out.println("checked"); %>><%=a1%></td>
		</tr>
		<tr>
		<td align="center">(B)</td>
		<td><input type=checkbox name="r"  value=2  <%if(((Integer)QAnswers.get(new Integer(count))).intValue()==2) out.println("checked"); %>><%=a2%></td>
			</tr>
		<%


			if((a3!=null)&&(!a3.equals(""))&&(!a3.equals("NoOption"))&&(!a3.equals("no options")))
			{	++nop;
		%>	<tr>
				<td align="center">(C)</td>
				<td><input type=checkbox name="r"  value=3 <%if(((Integer)QAnswers.get(new Integer(count))).intValue()==3) out.println("checked"); %> ><%=a3%></td>
			</tr>
		<%
			}
			if((a4!=null)&&(!a4.equals(""))&&(!a4.equals("NoOption"))&&(!a4.equals("no options")))
			{	++nop;
		%>
			<tr>
				<td align="center">(D)</td>
				<td><input type=checkbox name="r"  value=4 <%if(((Integer)QAnswers.get(new Integer(count))).intValue()==4) out.println("checked"); %>><%=a4%></td>
			</tr>
		<%
			}
			if((a5!=null)&&(!a5.equals(""))&&(!a5.equals("NoOption"))&&(!a5.equals("no options")))
			{	++nop;
		%>
			<tr>
				<td align="center">(E)</td>
				<td><input type=checkbox name="r"  value=5 <%if(((Integer)QAnswers.get(new Integer(count))).intValue()==5) out.println("checked"); %>><%=a5%></td>
			</tr>
		  <%
			}


			out.println("<input type=hidden name=nop value="+nop+">");
			out.println("<input type=hidden name=lang value="+lang+">");
			out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
			out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"action\" value=\"bookmark\">");
			out.println("<input type=\"hidden\" name=\"bookmark\" value=1>");
			out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
			out.println("<input type=\"hidden\" name=\"chkans1\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans2\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans3\" value=\"\">");
			out.println("<input type=\"hidden\" name=\"chkans4\" value=\"\">");

			if (TempBM.size()>0) size= ((Integer)TempBM.get(0)).intValue();
			else size=0;
			if(count<=size)
			{
 %>
	<tr>
		<th colspan=2><div class='clsNavigation'>
		<input type="submit" value='<%=bundle.getString("nq")%>' border=0 onClick="return showval()">
		</div>
		</th>
	</tr>
	</table>


<%
			}

			out.println("</form>");


		}


	out.println("<form name=\"NewTestBM\" action=DemoTest.jsp method=get>");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
	out.println("<input type=\"hidden\" name=action value=\"bookmark\">");
	out.println("<input type=\"hidden\" name=first value=\"first\">");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=hidden name=lang value="+lang+">");
	out.println("<p>&nbsp;</p><table border=0 cellspacing=1 cellpadding=1 width=\"80%\"></tr>");
	if((((Integer)session.getAttribute("DemoBM")).intValue()==1)&&(!OnPage.equals("bookmark"))&&(!OnPage.equals("allquestions")))
	{
		//out.println("<div align=\"left\">");
		out.println("<th align=left><div class='clsRecheck'>");
		out.println("<input type=submit value='"+bundle.getString("bq")+"' onClick=\"return  showval()\" ></div></th>");
		//session.putValue("teststatus","started");
	}
	else out.println("");
	out.println("</form>");

	out.println("<form name=\"NewTestMain3\" action=DemoTest.jsp method=get>");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=hidden name=lang value="+lang+">");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
	out.println("<input type=\"hidden\" name=action value=\"allquestions\">");
	out.println("<input type=\"hidden\" name=first value=\"first\">");


	if((count>1)&&(OnPage.equals("")))
	{   
	    out.println("<th colspan=2 align=right><div class='clsRecheck'><input type=submit value='"+bundle.getString("rpa")+"' onClick=\"return  showval()\" ></th></tr>");
	}
	else out.println("<td colspan=2></td></tr>");
	out.println("</form>");

	out.println("<form name=\"NewTestMain2\" action=DemoVerifyAnswers.jsp method=get>");
	out.println("<input type=hidden name=lang value="+lang+">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");

	if((count<=6)&&(OnPage.equals("")))
	{
	    if(count==6){
	    %><jsp:forward page="DemoVerifyAnswers.jsp"/><%}
	    if(count<5){
	    out.println("<tr><th colspan=3 align=center><div class='clsNavigation'><input type=button value='"+bundle.getString("ft")+"' onClick=\"return  checksubmit()\" ></div></th></tr></table>");
	    }
	}
	out.println("</form>");
	out.println("<form name=\"NewTestMain4\" action=DemoTest.jsp method=get>");
	out.println("<input type=hidden name=lang value="+lang+">");
	out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"action\" value=\"next\">");
	out.println("<input type=\"hidden\" name=\"bookmark\" value=\"1\">");
	out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
	out.println("<input type=\"hidden\" name=\"return\" value=\"return\">");
	out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");


	if(OnPage.equals("bookmark"))
		{

			out.println("<tr><th colspan=3 align=center><div class='clsNavigation'><input type=submit value='"+bundle.getString("gbtt")+"' onClick=\"return  showval()\"></div></th></tr></table>");
		}

		out.println("</form>");
		out.println("<form name=\"NewTestMain5\" action=DemoTest.jsp method=get>");
		out.println("<input type=hidden name=lang value="+lang+">");
		out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
		out.println("<input type=\"hidden\" name=\"action\" value=\"next\">");
		out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
		out.println("<input type=\"hidden\" name=\"return\" value=\"return\">");
		out.println("<input type=\"hidden\" name=\"id\" value=\"" + count + "\">");
		if(OnPage.equals("allquestions"))
		{

			out.println("<tr><th colspan=3 align=center><div class='clsNavigation'><input type=submit value='"+bundle.getString("gbtt")+"' onClick=\"return  showval()\"></div></th></tr></table>");

		}
			out.println("</form>");

	}
	catch( Exception e)
	{
		out.println("Exception caught :"+e.getMessage());
	}
%>
</BODY>
</HTML>
