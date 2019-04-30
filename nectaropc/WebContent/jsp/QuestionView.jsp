<%
/*
@ Company Nectar Global Services
@ Code generation Date: 06-06-2001 10.10 AM
@ Code Details: Delete Registration & Add Exams Module
@ Author: Denis Mathew
@ Email: denism@zils.com
*/
%>
<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.gen.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html><head><title>ALM</title><style>
a.l{font-family:verdana,arial;text-decoration:none;color:#960317;}
td{font-family:verdana,arial;font-size:9pt;} 
body{font-family:verdana,arial;font-size:9pt} 
td.h{background-color:#fff5e7;color:#000000;} 
td.b{background-color:#feeec8;color:#960317;
font-weight:bold;} b.man{font-size:9pt;color:#FF0000;}
</style></head><body bgcolor='#fef9e2'>
<center><span class=t><u> Modify/Delete Question</u></span></center>

<%
String pathHome="/zalm/admin/";
String username =(String)session.getAttribute("username");
String sql="",QuestionNo="",primkey="QuestionID",columnname="",columntype="",type="",editmodify="";
String primkeyval="",typeval="",QuestNum="",field="not_auto",invals="",invals1="",namesup="",prigetval="",qryStringup="",qryStringnup="",primkeydel="",typedel="";
int QuestNo=0;
//if (username == "" || username == null){
//	response.sendRedirect("Login.jsp");
//}
   if(request.getParameter("editmodify")==null){
   editmodify="initVal";
   }
   else{ 
   editmodify=request.getParameter("editmodify");
   }
    Connection con=null;  
   			
			con = pool.getConnection(); 

   /* 
    ServletContext context=getServletContext(); 
    pool =(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPool");
    con = pool.getConnection();
	*/
    ResultSet rst=null;
    Statement stmt  = con.createStatement();
    Statement stmt1 = con.createStatement();
    Statement stmt3 = con.createStatement();
    QuestionNo=request.getParameter("questionNumber");
    QuestNo=Integer.parseInt(QuestionNo);
    sql="select * from QuestionMaster where QuestionID="+QuestNo+"";
    rst=stmt.executeQuery(sql);
    ResultSetMetaData meta = rst.getMetaData();
    int num_cols = meta.getColumnCount();
    //====
    %>
    <form method="post" action="<%=request.getRequestURI()%>" name="form1">
    
    <%
                
             String columnvalue=null;
             if(editmodify.equals("initVal")){  //======if starts====
                out.print("<table cellpadding='1' cellspacing='1'>");
				out.println("<tr>");
				for (int i=1;i<= num_cols;i++){
					// getting the column names
					columnname=meta.getColumnName(i);	
									
					out.println("<td class=b>"+columnname+"</td>");
					}
				    out.println("<td>&nbsp</td><td>&nbsp;</td></tr>");
					while(rst.next()) {						  				
					  out.print("<tr>");
					  for (int k=1;k<= num_cols;k++)	{
					       columnname=meta.getColumnName(k);
					       columnvalue=rst.getString(columnname);
							if(columnname.equals("UpdateValidityDate") && columnvalue==null)
							{
							  Calendar calendar = Calendar.getInstance();
		    				  java.sql.Date ourJavaDateObject = new java.sql.Date(calendar.getTime().getTime());
		    				  columnvalue = Utils.ConvertDateToString(ourJavaDateObject);
							}
					       //getting the column type
					       columntype=meta.getColumnTypeName(k);							
					       if(primkey.equals(columnname))	{
					 	         if(columntype.equals("LONG"))	{
						          type="int";	
						          }
						   else{ type="string"; }
						   }								
					   //printing the records using html table	
					   if(columnname.equals("UpdateValidityDate"))	
					   out.print("<td class=h>"+columnvalue+"</td>");
					   else					
					   out.print("<td class=h>"+rst.getString(""+columnname+"")+"</td>");
					   //System.out.println(" column columnname->"+columnname);
					   //System.out.println(" column value->"+columnvalue);	
					   } //pass the value of primary key here
								out.print("<td><a href='"+request.getRequestURI()+"?editmodify=modval&primkey=QuestionID&type=int&questionNumber="+QuestNo+"'>Modify</a></td><td><a href='"+request.getRequestURI()+"?editmodify=delrec&primkey=QuestionID&type=int&questionNumber="+QuestNo+"'>Delete</a></td>"); 
								out.print("</tr>");										  
					  }
					  out.println("<tr><td colspan="+num_cols+">&nbsp;</td></tr>"); 
			 } //====if ends====  

             else if(editmodify.equals("modval"))	
             {           
                    //System.out.println("editmodify.equals(modval)");                        //if->equals->modval starts here				
					primkeyval=primkey;
					typeval="int";
					QuestNum=QuestionNo;
					out.print("<b>Welcome To Modify Records<b><hr color='330099'><br><br>");					
					out.print("<table align='center'>");				
					//getting the value of primary key				
					
					while(rst.next()){
						for (int y=1;y<=num_cols;y++){									
						columnname=meta.getColumnName(y);
						columntype=meta.getColumnTypeName(y);
						columnvalue=rst.getString(columnname);
						if(columnname.equals("UpdateValidityDate") && columnvalue==null)
						{
						  Calendar calendar = Calendar.getInstance();
	    				  java.sql.Date ourJavaDateObject = new java.sql.Date(calendar.getTime().getTime());
	    				  columnvalue = Utils.ConvertDateToString(ourJavaDateObject);
	    				  //System.out.println("UpdateValidityDate"+columnvalue);
						}
						//System.out.println("editmodify.equals(modval)  columntype->"+columntype); 
						int size_column=meta.getColumnDisplaySize(y);							
						//check whether the column is auto-increment
						if(!columnname.equals(field)){
							if(meta.isNullable(y)!=0)	{	//null values are allowed here															
								if(columntype.equals("LONG")){								
									out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rst.getInt(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'>(Only Numbers Allowed here)</td></tr>");	
									}
								else{
									if(size_column < 40){
										//print textfield
										//System.out.println("size_column < 40  columnname->"+columnname); 
										out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+columnvalue+"' maxlength='"+size_column+"' size='"+size_column+"'></td></tr>");		
										//System.out.println("size_column < 40  value->"+rst.getString("columnname")); 
										}
										else{	//print textarea
										out.print("<tr><td><b>"+columnname+"</b></td><td><textarea name='"+columnname+"' cols='40' rows='4'>"+columnvalue+"</textarea></td></tr>");	
										}									
									}
								//note: put * for mandatory fields							
								}
								
								
							else{
								if(columntype.equals("LONG")){								
									out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rst.getInt(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'>(Only Numbers Allowed here)&nbsp;<b class='man'>*</b></td></tr>");	
									}
								else{
										if(size_column < 40){	//print textfield
										out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+columnvalue+"' maxlength='"+size_column+"' size='"+size_column+"'><b class='man'>*</b></td></tr>");		
										}
										else{	//print textarea
										out.print("<tr><td><b>"+columnname+"</b></td><td><textarea name='"+columnname+"' cols='40' rows='4'>"+columnvalue+"</textarea><b class='man'>*</b></td></tr>");	
										}								
									}
								}
							}							
						}	
					}
										
				out.println("<tr><td colspan='2'>&nbsp;</td></tr>");
				out.println("<tr><td colspan='2'><input type='submit' name='editmodify' value='Update'>&nbsp;&nbsp;</td></tr></table>");
            	out.print("<input type='hidden' name='questionNumber' value='"+QuestNum+"'>");			
			} // if->equals->modval ends here
           //===============================
           if(editmodify.equals("Update"))	//if->equals->Update starts here
			{
				try
				{
				System.out.println("editmodify.equals(Update)");
				//-----------------------------Table Updating Code Starts here--------------------------------------------
				// primkey contains value of primarykey field
				// typeup checks whether primkey is int or string
				    QuestNum=request.getParameter("questionNumber");
					prigetval=primkey;				
					
					namesup="";	
					invals1="";
					invals="";												
					try{					
      					for(int t=1;t<=num_cols;t++){
      					columntype=meta.getColumnTypeName(t);
      					columnname=meta.getColumnName(t);
						if(!columnname.equals(field))  {															
							namesup +=columnname +"=";
							if(columntype.equals("LONG") || columntype.equals("INTEGER"))
								{							 								
							 	int val= new Integer(request.getParameter(columnname)).intValue();
							 	namesup+=""+val+",";								 		
							 	}
								else{							
								
									invals = request.getParameter(columnname);
										//====================special char conversion===================================
							  		char xxx = '\'';
									char xx1 ='\\';
									char xx2 ='\"';										
									int vallen=invals.length();					
									for(int h=0;h<vallen;h++){
										if(invals.charAt(h) == xxx){
											invals1=invals.substring(0,h)+ "\\'" + invals.substring(h+1,invals.length());				
											h +=1;
											invals = invals1;
											}
										else if(invals.charAt(h) == xx1){							
											invals1=invals.substring(0,h) + xx1 + xx1 + invals.substring(h+1,invals.length());	
											h +=5;
											invals = invals1;						
											}
										else if(invals.charAt(h) == xx2){
											invals1=invals.substring(0,h) + "\\\"" + invals.substring(h+1,invals.length());	
											h +=1;
											invals = invals1;			
											}						
									}						 
								//============================================================		
								if(namesup.endsWith("UpdateValidityDate="))
								{
								  Calendar calendar = Calendar.getInstance();
			    				  java.sql.Date ourJavaDateObject = new java.sql.Date(calendar.getTime().getTime());
			    				  invals = Utils.ConvertDateToString(ourJavaDateObject);
			    				  //System.out.println("UpdateValidityDate"+columnvalue);
			    				  System.out.println(" namesup->"+namesup);
					   			  System.out.println(" invals->"+invals);
								}	
								System.out.println(" namesup-------------------!"+namesup);
					   			System.out.println(" invals--------------------!"+invals);				 								 		
								namesup+="'"+invals+"',";	
																	
								}		
																							
							}						
						 }  
						 System.out.println(" column namesup->"+namesup);					
						qryStringup = "update QuestionMaster set "+namesup;
						}    							
					catch(Exception e)
    					{ out.println("<br>some probs "+e.getMessage()); } 	
    			QuestNo=Integer.parseInt(QuestNum);
    				
				qryStringnup=qryStringup.substring(0,qryStringup.length()-1)+" where QuestionID="+QuestNo+"";
						
				try{				
				stmt1.executeUpdate(qryStringnup);
				out.print("Records Successfully Updated.....");	
//				out.print("<META HTTP-EQUIV=REFRESH CONTENT=\"1;URL="+request.getRequestURI()+"?questionNumber="+QuestNo+"&editmodify=initVal\">");
				response.sendRedirect("../admin/previewProceed.jsp?questionumber="+QuestNo+"&ExamId=931");

				}catch(Exception e){out.print(e.getMessage()+" : Error Occured!");}
				//LINKS 
			//--------------------------------------Table Updation Ends Here--------------------------------					
				}
				catch(Exception e)
				{ out.println(e.getMessage()); }				
				
			} //if -> equals Update ends here
			//==========
				if(editmodify.equals("delrec"))	{
			QuestNum=request.getParameter("questionNumber");
			
			out.print("<input type='hidden' name='questionNumber' value='"+QuestNum+"'>");							
			String primkeyValue="QuestionID";	
			String primkeyType="int";	
			out.print("<input type='hidden' name='primkey' value='QuestionID' >");
			out.print("<input type='hidden' name='type' value='int' >");		
			out.print("<br><br><b>Do You really want to Delete this record ?</b>");
			out.print("<br><br><input type='submit' name='editmodify' value='Yes'>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' name='editmodify' value='No' onClick='history.back()'><br><br>");
			}			
			if(editmodify.equals("Yes")) {
			try	{										
				out.println("Welcome To Delelete Records");					
				//primkeydel="QuestionID";								
					QuestNum=request.getParameter("questionNumber");			
					//int prigetvalint= new Integer(primkeydel).intValue();
    				QuestNo=Integer.parseInt(QuestNum);		
					stmt3.executeQuery("delete from QuestionMaster where QuestionID="+QuestNo+"");
					out.print("Successfully Deleted Record");
					out.print("<META HTTP-EQUIV=REFRESH CONTENT=\"1;URL="+pathHome+"previewQuestionNameTest.jsp\">");					
					//out.print("<META HTTP-EQUIV=REFRESH CONTENT=\"1;URL="+request.getRequestURI()+"?editmodify=modrecords&questionNumber="+QuestNum+"\">");	
									
				}
			catch(Exception e){out.print(e.getMessage());}		
	   		}	   	
			
			//=========
%>
</table></body></html>
<%
try{
    pool.releaseConnection(con); 
    }
    catch(Exception e){}
%>
