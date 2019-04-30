
<HTML>
<HEAD>
<TITLE> New Document </TITLE>

</HEAD>

<%@ page language="java" import="java.util.*" session="true"%>


<BODY>


<%

	Vector  QBank		= new Vector();
	java.util.Hashtable Qlevel = new java.util.Hashtable();

	try
	{
		Qlevel  = (java.util.Hashtable) session.getAttribute("Qlevel");

		Enumeration e1 = Qlevel.keys();

		while(e1.hasMoreElements())
		{

			Integer s1 = (Integer)e1.nextElement();
			QBank = (Vector) Qlevel.get(s1);
			out.println("<BR><b> LEVEL : "+s1+" </b><BR> "+QBank.toString());
		}
		

	}
	catch( Exception e)
	{
		out.println("Exception caught :"+e.getMessage());
	}
%>
</BODY>
</HTML>
