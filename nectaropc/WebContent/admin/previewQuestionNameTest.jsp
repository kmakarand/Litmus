<%@ page language="java" import="java.sql.*"  session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>
 <style>td{font-family:arial;font-size:9pt;} body{font-family:arial;font-size:9pt;}
 a{text-decoration:none}</style>
</head><BODY bgColor=#FEF5E7>

    <b><font size="3" color="#000099">Preview Question Master</font> <br>
  ____________________________________________________________________________   Please Select Your Question

<%
Connection con=null;
Statement stmt=null;
ResultSet rs=null;

try{

      //If the pool is not initialised
        ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

		con = pool.getConnection();
 		stmt = con.createStatement();

	%>



<table border=0 cellspacing=0 cellpadding=0 width=700>
<tr valign=top>




         <%
		 int nextval=0;int initial=0;
		 if(request.getParameter("initial")!=null){
				initial=Integer.parseInt(request.getParameter("initial"));
				}
				else{ initial=1;}
			rs = stmt.executeQuery("SELECT * FROM QuestionMaster ORDER BY QuestionID DESC");
			while(rs.next()){
				nextval++;
				if(nextval>=((initial*20)-19) && nextval <= (initial*20))	{	//starts
				%>
				<tr>
				<%
				String question=(rs.getString("Question"));
				String ques ="";
				String questionNnumber=(rs.getString("QuestionID"));
				if(question.length()>40) ques = question;
				else ques = question.substring(0, question.length());
				%>
				<%out.print("<td>"+questionNnumber+"</td>");%>
				<td>
				</td>
				<td>
<a href='../admin/previewProceed.jsp?questionumber=<%=questionNnumber%>'><%=ques%></a>
					<hr noshade>
				</td></tr>
				<%
					}//start ends
				 if(nextval > (initial*20)) { break; }
				}	//while ends
				%>  </table>  <%

			  if(initial > 1)	  {
			out.print("<br><a href='"+request.getRequestURI()+"?initial="+(initial-1)+"'> >> Next 20 Records >> </a><br>");
			  }
			if(nextval > (initial*20))	  {
			out.print("<br><a href='"+request.getRequestURI()+"?initial="+(initial+1)+"'> << Previous 20 Records << </a><br>");
						  }
				}
    catch (Exception ex)   {
		   out.print("Exception pinjo!!!!!!  "+ex);
		}
		finally
    {
        if (con != null)
            pool.releaseConnection(con);
        else
            out.println ("Error while Connecting to Database.");
    }
%>



</body>

</html>
