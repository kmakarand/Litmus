
<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>

<head>
</head>
<body>
<p>&nbsp;</p>

<form name="f2" method="POST" action="" >
<%	String action="",strTableName="";
    Vector vTableName=new Vector();
	action=request.getParameter("pocess");
	strTableName=request.getParameter("varTableName");
	if(action==null)action="";
	
	Connection con = pool.getConnection();
    

if(action.equalsIgnoreCase("")){

    int str1=0;
	String str2="";
    String sql1 = "Select * from ExamDetails";//"+strTableName;
    String tableName="";
    
	// Get DatabaseMetaData
    DatabaseMetaData dbmd = con.getMetaData();

    // Get all table types.
    ResultSet rs = dbmd.getTables(null, null, null,
    new String[] { "TABLE" });

	// Printout table data
	int tblNum = 0;
	//System.out.println("basicViewDBMeta");
	while (rs.next())
	{
	tblNum ++;
	//tableName = rs.getString(3);
	//out.println(tblNum + " " + tableName);

	/*if(strTableName.equals(tableName))
	{*/%>
      
    <%//}*/
	
	}
	
    
  	ResultSet rs1=con.createStatement().executeQuery(sql1);
	
    ResultSetMetaData rmeta = rs1.getMetaData();
	int numCols=rmeta.getColumnCount();

	out.println("<HTML><HEAD><TITLE>Candidates' Registration List</TITLE>");
  	out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
  	out.println("<BODY><CENTER>");

    out.println("<TABLE BORDER=0 CELLPADDING=1 CELLSPACING=1>");
	out.println("<TR><TH COLSPAN="+numCols+"><B>Details of List</B></TH></TR>");
   	out.println("<TR>");
	for(int i=1;i<=numCols;++i)
	{
      if(i<=numCols)
      	  out.println("<TH>"+rmeta.getColumnName(i)+"</TH>");
	  //else
		  //out.println("<TH>"+rmeta.getColumnName(i).trim()+"</TH>");
	}
        out.println("</TR>");
		out.println("<TR>");
    while(rs1.next())
	{
		for(int i=1;i<=numCols;++i)
		{
			if(i<=numCols)
				out.println("<TD>"+rs1.getString(i)+"</TD>");
			//else
				//out.println("<TD>"+rs1.getString(i).trim()+"</TD>");
			if(i==numCols)
                out.println("</TR>");         
		}
		
    }
    
	out.println("<TR><Th COLSPAN="+numCols+" align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
    out.println("</TABLE>");
	out.println("</BODY>");
	out.println("</HTML>");
}
	%>
