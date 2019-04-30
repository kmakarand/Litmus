<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("ExamTestDetail.jsp");
		Connection con = pool.getConnection();
		String editmodify="",counter1="",records="",primkeyval="",type="",typeval="",typeup="",primkeydel="",typedel="";
		String namesup="",names1up="",qmarkup="",qmark1up="",qryStringup="",qryStringnup="",valuesup="",prigetval="";
		String columnname="",columntype="",extra="",field="",nullvalue="",nullfield="",qryString="",invals="",invals1="";
		String names = "",names1="",qmark="",qmark1="",values = "",sql="";
		int value=0,num_cols=0;		
		//here we are storing the form action path
		String form1action="ExamTestDetail.jsp";
		String adminpath="../admin/teditor.jsp";
		String tablename="",primkey="";
		int y=0;	
		// initialising strings of inserting table data 
		String transactionid="",examid="",date="",time="",candidateid="",subjectid="",questionid="",answer="",timetaken="",checkautoinc="";
		PreparedStatement pstmt=null;
		try
		{
			if (action == null || action == "")
			{
				String adminuser = (String) session.getAttribute("username");
				System.out.println("adminuser	:"+adminuser);
				
				if (adminuser == "" || adminuser == null)	{
					response.sendRedirect("../jsp/Login.jsp");
				}			
				//response.setContentType("text/html");
				editmodify=request.getParameter("editmodify");
				tablename=request.getParameter("tablename");	
				System.out.println("editmodify	:"+editmodify);
				System.out.println("tablename	:"+tablename);
					
				// Now printing the head tag and style tag			
				out.println("<html><head><title>Table Editor</title><script language='JavaScript' src='../jsp/almscript.js'></script><style>a.l{font-family:verdana,arial;text-decoration:none;color:#960317;}td{font-family:verdana,arial;font-size:9pt;} body{font-family:verdana,arial;font-size:9pt} td.h{background-color:#fff5e7;color:#000000;} td.b{background-color:#feeec8;color:#960317;font-weight:bold;} b.man{font-size:9pt;color:#FF0000;}</style></head><body bgcolor='#fef9e2'>");	     	
			   	out.println("<form action='"+form1action+"?tablename="+tablename+"' method='post' name='form1'>");  
			   	out.println("<input type='hidden' value='"+tablename+"' name='tablename'>");
			   	// the initial hidden field is to browse through the records
			   	out.println("<input type='hidden' value='' name='initial'>");	   	
			   	//out.println("Value of editmodify :"+editmodify);
			   	out.println("Welcome "+adminuser+"<br><b>Table Name: "+tablename+"</b><br><br>");
			   	 
			   	try	{ //Checking the External Parameters
					tablename=request.getParameter("tablename");	
					sql = "select * from "+tablename;
					pstmt = con.prepareStatement(sql);
					System.out.println("ExamTestDetails pstmt :"+pstmt);
					ResultSet rs=pstmt.executeQuery();
					ResultSetMetaData meta = rs.getMetaData();
					num_cols = meta.getColumnCount();
					DatabaseMetaData dbmeta=con.getMetaData();
					ResultSet rs1=dbmeta.getPrimaryKeys("","nectar",tablename);
					//this query is used for checking auto_increment value
					sql = "desc "+tablename;
					pstmt = con.prepareStatement(sql);
					ResultSet rs2=pstmt.executeQuery();
					ResultSet rs3=null,rs4=null;
					
					while(rs2.next()) 	{
						System.out.println("indide loop");
							extra=rs2.getString("Extra");
						    System.out.println("Extra :"+extra);
					 		if(extra.equals("auto_increment"))
					 			{
					 			field=rs2.getString("Field");
					 			}	 	
					 	}	
					if(editmodify.equals("Add New Records")){				
						//printing the form to insert the data into table
						//out.println("<b>Welcome To Add Records<b>");
						out.println("<table align='center'>");
						for (int m=1;m<= num_cols;m++)	{
									// getting the column names
									columnname=meta.getColumnName(m);
									int size_column=meta.getColumnDisplaySize(m);
									columntype=meta.getColumnTypeName(m);
									//check whether the column is auto-increment
									if(!columnname.equals(field)){
										//note: put * for mandatory fields
										if(meta.isNullable(m)!=0){
											//null values are allowed here
											if(columntype.equals("LONG")){
												out.println("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' maxlength='"+size_column+"'>(Only Numbers Allowed)</td></tr>");
												}
											else{
												out.println("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' maxlength='"+size_column+"' size='"+size_column+"'></td></tr>");
												}
											}
										else{ // null values are not allowed here									
											if(columntype.equals("LONG")){
												out.println("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' maxlength='"+size_column+"' size='"+size_column+"'>&nbsp;(Only Numbers Allowed)&nbsp;<b class='man'>*</b></td></tr>");	
												}
											else{
												out.println("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' maxlength='"+size_column+"' size='"+size_column+"'>&nbsp;<b class='man'>*</b></td></tr>");		
												}
											}
										}
									}			
						out.println("<tr><td colspan='2'>&nbsp;</td></tr>");
						out.println("<tr><td colspan='2'><input type='submit' name='editmodify' value='Submit'>&nbsp;&nbsp;<input type='reset' name='reset' value='Reset'></td></tr></table>");
						out.print("<br><br><center><b class='man'>* &nbsp; Indicates Mandatory Fields.</b></center>");
						}
				//this page shows the listing of the table
				//-------------first page-----------------------------------------
				//----------------------------------------------------------------
				if(editmodify.equals("modrecords"))	{
					int nextval=0;
					int initial;			
						if(request.getParameter("initial")!=null){
						initial=Integer.parseInt(request.getParameter("initial"));
						}
						else{ initial=1;}																	
						//getting the primarykey of the table here.					
						while(rs1.next())	{
								primkey=rs1.getString("COLUMN_NAME");
								System.out.print("<b>PRIMARY KEY :</b>"+primkey+"<br>");
							}
						//rs1.close();
						//getting the number of columns				
						out.print("<table cellpadding='1' cellspacing='1' border='0'  bgcolor='feeec8'>");
						out.println("<tr>");
						for (int i=1;i<= num_cols;i++)	{
									// getting the column names
									columnname=meta.getColumnName(i);							
									out.println("<td class=b>"+columnname+"</td>");
									}
						out.println("<td>&nbsp</td><td>&nbsp;</td></tr>");
								while(rs1.next()) {	
								  nextval++;
								  if(nextval>=((initial*20)-19) && nextval <= (initial*20))	{					
									out.print("<tr>");
									for (int k=1;k<= num_cols;k++){
										columnname=meta.getColumnName(k);
										//getting the column type
										columntype=meta.getColumnTypeName(k);
										//---------------------------------		
										if(primkey.equals(columnname)){
											if(columntype.equals("LONG")){
												type="int";	
												}
											else{ type="string"; }
											}
										//---------------------------------		
										//printing the records using html table							
										out.print("<td class=h>"+rs1.getString(""+columnname+"")+"</td>");	
										} //pass the value of primary key here
										out.print("<td><a href='"+form1action+"?editmodify=modval&tablename="+tablename+"&primkey="+rs2.getString(primkey)+"&type="+type+"'>Modify</a></td><td><a href='"+form1action+"?editmodify=delrec&tablename="+tablename+"&primkey="+rs2.getString(primkey)+"&type="+type+"'>Delete</a></td>"); 
										out.print("</tr>");
									}//if nextval ends	
						
								  if(nextval > (initial*20)) { break; }						  
								  }
								  out.println("<tr><td colspan="+num_cols+">&nbsp;</td></tr>");
								if(initial > 1)	  {
								  	out.println("<tr><td colspan="+num_cols+"><a href='"+form1action+"?editmodify=modrecords&tablename="+tablename+"&initial="+(initial-1)+"'> << Previous 20 Records << </a></td></tr>");	
								  }
								 if(nextval > (initial*20))	  {
								  	out.println("<tr><td colspan="+num_cols+"><a href='"+form1action+"?editmodify=modrecords&tablename="+tablename+"&initial="+(initial+1)+"'> >> Next 20 Records >> </a></td><tr>");	
								  }
						
							out.println("<tr><td colspan="+num_cols+"><input type='submit' name='editmodify' value='Add New Records'></td></tr>");	
							out.print("</table>");	
						}			
					if(editmodify.equals("Submit"))	{ //if->equals->Submit starts here				
							//--------------------------Table Inserting Rec Code Starts here--------------------
							names="";
							invals1="";
							invals="";
								qryString ="";	
							//out.println(num_cols);						
							for(int e=1;e<=num_cols;e++){
								columnname=meta.getColumnName(e);
								if(!columnname.equals(field))	{								
									names += columnname + ",";
									qmark += columnname + "val,";
									}																			
								}						
								names1=names.substring(0,names.length()-1);
								qmark1=qmark.substring(0,qmark.length()-1);				
								qryString = "insert into "+tablename+"("+names1+") values (";
							try{					
		      					for(int f=1;f<=num_cols;f++)      					
								{
		      					columntype=meta.getColumnTypeName(f);
		      					columnname=meta.getColumnName(f);
								if(!columnname.equals(field))   {															
										if(columntype.equals("LONG") || columntype.equals("INTEGER")){							 								
										 		int val= new Integer(request.getParameter(columnname)).intValue();
										 		qryString+=""+val+",";								 		
										 	}
										else{														 			
									 		//values = request.getParameter(columnname);	
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
													h += 5;
													invals = invals1;						
													}
												else if(invals.charAt(h) == xx2){
													invals1=invals.substring(0,h) + "\\\"" + invals.substring(h+1,invals.length());	
													h +=1;
													invals = invals1;			
													}						
											}						 
										//============================================================							 								 		
												//qryString+="'"+values+"',";										
												qryString+="'"+invals+"',";																			
											}								
									}						
								 }  
								//out.println("<br>insert into "+tablename+"("+names1+")values ("+qmark1+")");
								}
		    				catch(SQLException e){out.println("<br>The Values Not Inserted "+e.getMessage());}     	
							catch(Exception e){out.println("<br>some probs "+e.getMessage());} 			
						String qryStringn=qryString.substring(0,qryString.length()-1)+")";				
						//out.println("query String : " + qryStringn + "<br>");
						pstmt = con.prepareStatement(qryStringn);
						pstmt.executeUpdate(qryStringn);		//LINKS 
						out.println("<br><br><br><table border=0 align='center'><tr><td><a href='"+form1action+"?tablename="+tablename+"&editmodify=Add New Records'><b>Continue Adding Records</b></a></td><td><a href='"+form1action+"?tablename="+tablename+"&editmodify=modrecords'><b> Record Listing</b></a></td><td><a href='"+adminpath+"'> Back To Mainpage</a> </td></tr></table>");
						}//if->equals->Submit ends here	
				//--------------------------Table Inserting Rec Code Starts here------------------------	
				if(editmodify.equals("modval"))	{ //if->equals->modval starts here				
						//get the value of primary keys,if auto exists then that value
						try{
							primkeyval=request.getParameter("primkey");
							typeval=request.getParameter("type");
							//out.print("<b>Welcome To Modify Records<b><br><br>");
							out.print("<input type='hidden' name='primkey' value='"+primkeyval+"'>");
							out.print("<input type='hidden' name='typeup' value='"+typeval+"'>");
							out.print("<table align='center'>");
							while(rs1.next())	{
								primkey=rs1.getString("PK_NAME");					
							}
							rs1.close();
							//out.println("Primary :"+primkey);
							//getting the value of primary key
						 if(typeval.equals("string"))   {
						 	sql = "select * from "+tablename+" where "+primkey+"='"+primkeyval+"'";
						 	pstmt = con.prepareStatement(sql);
							rs3=pstmt.executeQuery();
							while(rs3.next())	{
								for (y=1;y<=num_cols;y++)	{									
								columnname=meta.getColumnName(y);
								columntype=meta.getColumnTypeName(y);
								int size_column=meta.getColumnDisplaySize(y);						
								//check whether the column is auto-increment
								if(!columnname.equals(field))	{
									if(meta.isNullable(y)!=0)	{	//null values are allowed here													
										if(columntype.equals("LONG"))	{								
											out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rs3.getInt(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'>(Only Numbers Allowed here)</td></tr>");	
											}
											else{
											out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rs3.getString(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'></td></tr>");	
											}
										}
									else{	//null values are not allowed here
											if(columntype.equals("LONG")){								
											out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rs3.getInt(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'>(Only Numbers Allowed here)&nbsp;<b class='man'>*</b></td></tr>");	
											}
											else{
											out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rs3.getString(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'><b class='man'>*</b></td></tr>");	
											}									
										}
									//note: put * for mandatory fields							
									}
								}
							}
						}
						else if(typeval.equals("int"))	{
							int primintval=new Integer(primkeyval).intValue();
							sql = "select * from "+tablename+" where "+primkey+"='"+primintval+"'";
							pstmt = con.prepareStatement(sql);
							rs3=pstmt.executeQuery();
							while(rs3.next())	{
								for (y=1;y<=num_cols;y++){									
								columnname=meta.getColumnName(y);
								columntype=meta.getColumnTypeName(y);
								int size_column=meta.getColumnDisplaySize(y);							
								//check whether the column is auto-increment
								if(!columnname.equals(field))	{
									if(meta.isNullable(y)!=0)	{	//null values are allowed here															
										if(columntype.equals("LONG")){								
											out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rs3.getInt(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'>(Only Numbers Allowed here)</td></tr>");	
											}
										else{
											out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rs3.getString(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'></td></tr>");	
											} //note: put * for mandatory fields							
										}
									else{
										if(columntype.equals("LONG"))	{								
											out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rs3.getInt(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'>(Only Numbers Allowed here)&nbsp;<b class='man'>*</b></td></tr>");	
											}
										else{
											out.print("<tr><td><b>"+columnname+"</b></td><td><input name='"+columnname+"' value='"+rs3.getString(""+columnname+"")+"' maxlength='"+size_column+"' size='"+size_column+"'><b class='man'>*</b></td></tr>");	
											}
										}
									}							
								}
							}	
						}							
						out.println("<tr><td colspan='2'>&nbsp;</td></tr>");
						out.println("<tr><td colspan='2'><input type='submit' name='editmodify' value='Update'>&nbsp;&nbsp;<input type='reset' name='reset' value='Reset'></td></tr></table>");
					    //out.println("<br><br><table border=0 align='center'><tr><td><a href='"+adminpath+"'> Back To Mainpage</a> </td><td>&nbsp;</td></tr></table>");
						   }
						 catch(Exception e)
						 	{ out.print(e.getMessage()); }					
					} // if->equals->modval ends here	
			if(editmodify.equals("Update"))	{ //if->equals->Update starts here			
						try{
							//-----------------------------Table Updating Code Starts here--------------------------------------------
							// primkey contains value of primarykey field
							// typeup checks whether primkey is int or string
							prigetval=request.getParameter("primkey");
							typeup=request.getParameter("typeup");				
							while(rs1.next()){
								primkey=rs1.getString("PK_NAME");					
							}
							rs1.close();
							namesup="";						
							invals="";
							invals1="";		
							try{					
		      					for(int t=1;t<=num_cols;t++) {
		      					columntype=meta.getColumnTypeName(t);
		      					columnname=meta.getColumnName(t);
								if(!columnname.equals(field))   { 							
										namesup +=columnname +"=";
										if(columntype.equals("LONG") || columntype.equals("INTEGER"))	{							 								
										 	int val= new Integer(request.getParameter(columnname)).intValue();
										 	namesup+=""+val+",";								 		
										 	}
										else{														
									 		//valuesup = request.getParameter(columnname);
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
													h += 5;
													invals = invals1;						
													}
												else if(invals.charAt(h) == xx2){
													invals1=invals.substring(0,h) + "\\\"" + invals.substring(h+1,invals.length());	
													h +=1;
													invals = invals1;			
													}						
											}						 
										//============================================================							 								 		
										//	namesup+="'"+valuesup+"',";	
											namesup+="'"+invals+"',";									
											}																
									}						
								 }  					
								qryStringup = "update "+tablename+" set "+namesup;
								}    							
							catch(Exception e)	{ out.println("<br>some probs "+e.getMessage()); } 	
		    			if(typeup.equals("int")){
		    			int prigetvalint= new Integer(prigetval).intValue();		
						qryStringnup=qryStringup.substring(0,qryStringup.length()-1)+" where "+primkey+"="+prigetvalint+"";
						}
						else{
						qryStringnup=qryStringup.substring(0,qryStringup.length()-1)+" where "+primkey+"='"+prigetval+"'";	
						}	
						pstmt = con.prepareStatement(qryStringnup);			
						pstmt.executeQuery();	
						out.print("<br><br><b>Records Successfully Updated ............<b>");
						//--------------------------------------Table Updation Ends Here--------------------------------					
						}
						catch(Exception e){ out.println(e.getMessage()); }				
					} //if -> equals Update ends here			
						//--------------------------------------Record Deletion Starts Here--------------------------------					
					if(editmodify.equals("delrec"))	{
					try	{
						//out.println("Welcome To Delelete Records");					
						primkeydel=request.getParameter("primkey");
						typedel=request.getParameter("type");
						while(rs1.next())
							{
							primkey=rs1.getString("PK_NAME");					
							}
							rs1.close();
					out.print("<input type='hidden' name='primkey' value='"+primkeydel+"' >");
					out.print("<input type='hidden' name='type' value='"+typedel+"' >");
					
						//stmt6.executeQuery("delete from "+tablename+" where "+primkey+"=);
						
						String url=form1action+"?tablename="+tablename+"&editmodify=modrecords";
						//out.print("<br><br><b>Record Successfully Deleted...</b><br>");
							out.print("<br><br><b>Do You really want to Delete this record ?</b>");
						out.print("<br><br><input type='submit' name='editmodify' value='Yes'>&nbsp;&nbsp;&nbsp;&nbsp;<input type='button' name='editmodify' value='No' onClick='history.back()'><br><br>");
					
						//out.println("<br><br><table border=0 align='center'><tr><td><a href='"+adminpath+"'> Back To Mainpage</a>&nbsp;&nbsp; </td><td><a href='"+url+"'>&nbsp;&nbsp;Back to Records Listing</a></td></tr></table>");
						}
					catch(Exception e){out.print(e.getMessage());}	
					
			   		}
			   		if(editmodify.equals("Yes")) {
					try	{
						while(rs1.next())
							{
							primkey=rs1.getString("PK_NAME");					
							}
							rs1.close();
						primkeydel=request.getParameter("primkey");
						typedel=request.getParameter("type");
										
					//	out.println("Welcome To Delete Records");
							if(typedel.equals("int"))
		    				{
		    				int prigetvalint= new Integer(primkeydel).intValue();
		    				out.print("delete from "+tablename+" where "+primkey+"="+prigetvalint+"");
		    				try{		
		    				sql = "delete from "+tablename+" where "+primkey+"="+prigetvalint+"";
		    				pstmt = con.prepareStatement(sql);
							pstmt.executeUpdate();
							out.print("<br><br> Record Successfully Deleted");
							}
							catch(Exception e){	out.print("<br><br> Record Could not be Deleted");}
							
							}
						else{
								out.print("delete from "+tablename+" where "+primkey+"="+primkeydel+"");
							try{
								sql = "delete from "+tablename+" where "+primkey+"='"+primkeydel+"'";
								pstmt = con.prepareStatement(sql);
								pstmt.executeUpdate();
								out.print("<br><br> Record Successfully Deleted");
							}
							catch(Exception e){	out.print("<br><br> Record Could not be Deleted");}
							
							}
						}
						catch(Exception e){}				
					 }	
			//--------------------------------------Record Deletion ends Here--------------------------------					
				}
				catch(Exception e){ out.println(e.getMessage()); }	
				out.print("<br><br><table align='right'><tr><td>Links:</td><td class=b><a href='"+form1action+"?tablename="+tablename+"&editmodify=modrecords' class=l>Record Listing</a></td><td class=b><a href='javascript:history.back()' class=l> &lt;&lt;Back&lt;&lt; </td><td class=b><a href='"+adminpath+"' class=l> Back To Mainpage</a></td></tr></table>");
				out.println("</form></body></html>"); 	
			}
		}catch(Exception e){ out.println(e.getMessage());e.printStackTrace(); }	
%>