<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->



<html>
<head>
<title>Database</title>
</head>


<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,org.apache.commons.io.filefilter.WildcardFileFilter"%>
<%@page import="com.ngs.ReadExcelFile"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
 <SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>

<style>td{background-color:lightblue;color:black;font-family:arial;}
body{font-family:arial;font-size:10pt}
</style>
<form action=imgDet.jsp method=get>
<body bgcolor=#FEF9E2>
<H4>
<FORM>
<table align="left" cellspacing="1" cellpadding="1" border="0">

<br><td>Database: nectar</td></br>
<br><td>Table:ImageDetails</td></br>
<br><td> </td></br>
</table>

<%
Connection con =null;
 String questionNo = (String) session.getValue("questionNo");

 	int qno=0;
	String sequence="";

	out.print(questionNo);
 	sequence=request.getParameter("sequence");
	String filename=request.getParameter("filename");
	
	javax.servlet.ServletConfig myconf = getServletConfig();
	String fDir = myconf.getServletContext().getRealPath( request.getServletPath() );
	System.out.println("fDir :"+fDir);
	System.out.println("request.getServletPath() :"+request.getServletPath());
	fDir = fDir.substring(0, fDir.lastIndexOf( System.getProperty( "file.separator") ) );
	String filepath = fDir + System.getProperty("file.separator");
	System.out.println("filepath :"+filepath);
	// filepath=request.getParameter("file");
	System.out.println("sequence	:"+sequence);
	System.out.println("filename	:"+filename);
	System.out.println("file path	:"+filepath);


 try
    {
      //If the pool is not initialised

       
	// Variables
	int count=0;

	// Initialization
	mySmartUpload.initialize(pageContext);

	mySmartUpload.setTotalMaxFileSize(1000000000);

	// Upload
	mySmartUpload.upload();

	try {
		//pinjo says u candy ass get the f***'n file on the server
		// Save the files with their original names in the virtual path "/upload"
		// if it doesn't exist try to save in the physical path "/upload"
		count = mySmartUpload.save("/images");

		// Save the files with their original names in the virtual path "/upload"
		// count = mySmartUpload.save("/upload", mySmartUpload.SAVE_VIRTUAL);

		// Display the number of files uploaded
		out.println(count + " file/s uploaded.");

	} catch (Exception e) {
		out.println(e.toString());
	}

      con = pool.getConnection();
	  Statement stat = con.createStatement();
	  Statement stat1 = con.createStatement();

 int questionNo1= Integer.parseInt(questionNo);

     out.println(questionNo);
	 stat.executeUpdate("INSERT INTO ImageDetails(QuestionID,Image,SequenceID)VALUES("+questionNo1+",\'"+filename+"\',\'"+sequence+"\')");




     stat1.close();
     stat.close();
	 con.close();
	}
	 catch(Exception exception)
					{
						out.println("Duplicate Entry:"+exception);

					}
					finally
    {
        if (con != null)
            pool.releaseConnection(con);
        else
            out.println ("Error while Connecting to Database.");
    }


%>

<a href="imgDet.jsp"><h4>More Images</h4> </a>

</form>
</body>



</html>

