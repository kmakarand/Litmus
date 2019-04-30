
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

</HEAD>

<%@ page  %>


<BODY>


<%
	int TotalMarks=0;

	try
	{

		int pqidi,ansgiveni,ttakeni;
		pqidi=ansgiveni=ttakeni=0;
		String pqid="";
		String ansgiven="0"; 
		String tsrt = (String)session.getAttribute("start");
						
						
		String ttaken=request.getParameter("questimer");
		String st="temp_"+c1;
		int seq = 1;
		int updated=0;
						
		int BookMark=0;
						
		pqid=request.getParameter("id");
						
						



		if((pqid!=null)&&(!pqid.equals(""))&&(!pqid.equals("undefined")))
		{pqidi=Integer.parseInt(pqid);}
		else out.print("pqid undefinned");
						
						
		if((request.getParameter("qans")!=null)&&(!request.getParameter("qans").equals("undefined"))&&(!request.getParameter("qans").equals("")))
		ansgiven=request.getParameter("qans");
		else out.print("ans given undefinned");
						
		if((ttaken!=null)&&(!ttaken.equals("undefined")))
		{ttakeni=Integer.parseInt(ttaken);}
		else out.print("ttaken undefinned");
						
		if((request.getParameter("bookmark")!=null)&&(!request.getParameter("bookmark").equals("undefined")))
		{
			if(request.getParameter("bookmark").equals("1")) BookMark=1;
			session.putValue("BookMarkSet","1");
		}

		String Update_Cand_Temp="Update "+st+" SET  ansg='"+ansgiven+"',timetaken="+ttakeni+",BookMark="+BookMark+" WHERE SequenceNo="+pqidi;
						

						
		try
		{
			stmt.executeUpdate(Update_Cand_Temp);
		}catch(Exception e)
		{
			out.println(Update_Cand_Temp+ " : " +e.getMessage());
		}

							

		

	}
	catch( Exception e)
	{
		out.println("Exception caught :"+e.getMessage());
	}
%>
</BODY>
</HTML>
