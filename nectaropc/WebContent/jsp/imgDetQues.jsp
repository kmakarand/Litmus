<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->
<HTML>
<BODY bgcolor=#FEF9E2>

<%@ page language="java" import="java.sql.*" session="true"%>
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>
 <SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>

<H3>ALM Image Manager</H3>

<%
ResultSet rs=null;
Connection con=null;
 int qno=0;
 String questionumber="";

 try
    {
      //If the pool is not initialised
        ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");


      con = pool.getConnection();
	 if(con!=null){   out.println("Connection obtained");
						}

	  Statement stat = con.createStatement();


	  rs=stat.executeQuery("SELECT MAX(QuestionID) AS QuestionID FROM QuestionMaster");
			while(rs.next()){

			 questionumber=rs.getString("QuestionID");
			 out.print(questionumber);
			session.putValue("questionNo",questionumber);
								}

 out.println("Question Number:"+questionumber);


     stat.close();

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
	 <br>
 <hr>
<FORM METHOD="POST" ACTION="imgDetailsQues.jsp" ENCTYPE="multipart/form-data">
<table align="left" cellspacing="1" cellpadding="1" border="0">


<tr><td>Browse File Name: </td><td>   <INPUT TYPE="File" NAME="file" SIZE="40"></td></tr>
</table>
  <br><br><br><br><br><br><br><br>
   <input type="image" src="../jsp/simages/save1.gif" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver= "MM_swapImage('Image1','','../jsp/simages/save2.gif',1)" OnClick="return checkIfEmpty()">
	  <input name="Image2" type=image src="../jsp/simages/reset1.gif" onMouseOut="MM_swapImgRestore()" onMouseOver = "MM_swapImage('Image2','','../jsp/simages/reset2.gif',1)" OnClick="javascript:return ResetForm();">
</FORM>

</BODY>
</HTML>
