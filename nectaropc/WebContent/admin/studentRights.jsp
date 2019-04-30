

 <html><head><title>Admin Module</title>
<style>td{font-family:arial;font-size:10pt;color:#003399;} a:link,a:visited,a:active{text-decoration:none;color:#003399;}
body{font-family:arial;color:#003399;}</style></head><body bgcolor=#FEF9E2>

<%@ page language="java" import="java.sql.*"  session="true" %>


<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<form action="securelogin.jsp" method=POST><br>
<%
    boolean flag=false;
	int rights=0;
    int rowcount=0;
    String c1=null;
    String p1=null;
    if((request.getParameter("cid")!=null)&&(request.getParameter("pwd")!=null))
    {
    c1= request.getParameter("cid");
    p1= request.getParameter("pwd");
    }
    else   {
    c1=(String)session.getValue("adminuser");
    p1=(String)session.getValue("adminpass");
    }

	Connection con=null;
	ServletContext context = getServletContext();
	context.setAttribute("ConPoolbse",pool);
  //Loading the driver and creating the connection object
  try    {
      //If the pool is not initialised
      con = pool.getConnection();

       if(con!=null)    {
         //Creating the statement object for executing querry
         Statement stmt = con.createStatement();
         ResultSet rs = stmt.executeQuery("Select * from adminusers");
          if(rs!=null)        {
             while (rs.next())      {
     if((c1.equals(rs.getString("admin_id")))&&(p1.equals(rs.getString("password"))))
                  {
                    flag=true;
                    session.putValue("adminuser",c1);
                    session.putValue("adminpass",p1);
                  }
                 if(flag) break;
              }//end of while
           }//end of if(rs!=null)

           if(flag)     {

             ResultSet rs1 = stmt.executeQuery("select * from adminusers ");
	         if(rs1!=null) 	{
	            while(rs1.next())
			         { rowcount++;

				 }



			}//end of if(rs1!=null) used for obtaining row count


			try{
			String nameID=request.getParameter("cid");
			 Statement stmt3 = con.createStatement();
 ResultSet rs2 = stmt3.executeQuery("select * from adminusers where admin_id=\'"+nameID+"\'");
			  while(rs2.next()){
			rights=Integer.parseInt(rs2.getString("superUser"));
			}//next

			if(rights==1){
			out.print("Welcome Super User,  "+c1+"");
			%>

			<a href="/zalm/admin/studentRights.jsp">Revise Rights</a>




			<b><%

			}//if

			}catch(Exception e){
				out.print(e);
				}


			 pool.releaseConnection(con);





	  %>
              <input type=hidden name="Rows" value="<%=rowcount%>">
	  <b><h2 align="center">Administration
  Module</h2> </b><hr noshade height='1'><br>
<table border='0' align='center'>
<tr><td>&nbsp;</td><td><a href="/zalm/admin/upload.htm"><h4> Upload Manager</h4> </a></td><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td><td><a href="/zalm/admin/AddQuestion.jsp"><h4> Question Answer Entry</h4> </a></td><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td><td><a href="/zalm/admin/xmlparser.html"><h4> Data from Other Formats </h4> </a></td><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td><td><a href="/zalm/admin/tableeditor.jsp"><h4> Master Files Data Entry</h4> </a></td><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td><td><a href="/zalm/admin/ModExamPatt.jsp"><h4> Exam Pattern</h4> </a>   </td><td>&nbsp;</td></tr>
</table>
  <%
          }//if(flag)
          else  {
   %>
          <script language="javascript">
          location.replace("/zalm/admin/zeealmadmin.htm");
          </script>
   <%
          }
	   }//end of if(con!=null)
   }//end of try
   catch(SQLException sqle)	{
	       System.err.println(sqle.getMessage());
        }
    catch (Exception e)   {
		   System.err.println(e.getMessage());
		}
    finally	{	  //Release the connection
	        pool.releaseConnection(con);
            }
   %>
  </form></body></html>