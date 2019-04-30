
<%@page language="java" import="java.sql.*,java.util.*"%>
<%@ include file="ConnectionDB1.jsp"%>
<% 
ResultSet rs=null;String sql1="";
String action=request.getParameter("doupdate");


if(action.equals(""))
{
sql1="select * from QuestionMaster where Question";// LIKE \"%the program will be%\" ";
//sql1="select * from QuestionMaster where Question LIKE '%Which of these tags are all &#60;table&#62; tags?%'";
//sql1="select * from QuestionMaster where Question LIKE '%In RMI a contract is established between%'";
//sql1="select * from QuestionMaster where Question LIKE '%found page%'";
//sql1="select * from QuestionMaster where Question LIKE '%The &#63;&#58;operator is called the conditional operator.%'";
//sql1="select * from QuestionMaster where Question LIKE '%is the alternate option%'";


rs=conn1.createStatement().executeQuery(sql1);
out.println("<FORM NAME=frmQuery METHOD=POST action=''>");
rs.next();
{
  out.println("<br><TEXTAREA NAME='' ROWS='12' COLS='80'>"+rs.getString("Question")+"</TEXTAREA>");
  out.println("<br><INPUT TYPE='text' size='100%' NAME='txtQuery' value='"+rs.getString("Option1")+"'>");
  out.println("<br><INPUT TYPE='text' size='100%' NAME='txtQuery' value='"+rs.getString("Option2")+"'>");
  out.println("<br><INPUT TYPE='text' size='100%' NAME='txtQuery' value='"+rs.getString("Option3")+"'>");
  out.println("<br><INPUT TYPE='text' size='100%' NAME='txtQuery' value='"+rs.getString("Option4")+"'>");
}
out.println("<br><INPUT TYPE='submit' name='submit'>");
out.println("<br><INPUT TYPE='hidden' name='doupdate' value='update'>");
}

//if(action.equals("update")
{
//out.println("suceess");
//sql1="Update * from QuestionMaster where Question LIKE '%operations are an%' ";
//rs=conn1.createStatement().executeQuery(sql1);
}
%>

   