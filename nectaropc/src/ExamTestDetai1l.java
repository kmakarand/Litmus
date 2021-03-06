
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import java.sql.*;
import com.ngs.gbl.*;
public class ExamTestDetai1l extends HttpServlet {
	//counter is the name of submit button and recors will store the total no. of records
	String editmodify,counter1,records,primkeyval,type,typeval,typeup,primkeydel,typedel;
	String namesup,names1up,qmarkup,qmark1up,qryStringup,qryStringnup,valuesup,prigetval;
	String columnname,columntype,extra,field,nullvalue,nullfield,qryString="",invals,invals1;
	String names = "",names1="",qmark="",qmark1="",values = "";
	int value,num_cols;		
	//here we are storing the form action path
	String form1action="../servlet/ExamTestDetail";
	String adminpath="../admin/tableeditor.jsp";
	String tablename,primkey;
	int y=0;	
	// initialising strings of inserting table data 
	String transactionid,examid,date,time,candidateid,subjectid,questionid,answer,timetaken,checkautoinc;
	private Connection con=null;
	com.ngs.gbl.ConnectionPool pool;	
	public void init(ServletConfig config)
	throws ServletException	{
		 super.init(config);
		 // here we connect to MySql database
		 try{ 
		 	ServletContext context = getServletContext(); 
 			pool=(com.ngs.gbl.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
			con = pool.getConnection();			      
			}
		 catch(Exception e){System.out.println("Exception ! could not be connected" +e.getMessage());} 		 
		}
	public void service(HttpServletRequest req,HttpServletResponse res)
	throws ServletException,IOException	{		
		HttpSession session=req.getSession(true);
		String adminuser = (String) session.getAttribute("username");
		if (adminuser == "" || adminuser == null)	{
			res.sendRedirect("../jsp/Login.jsp");
		}			
		res.setContentType("text/html");
		ServletOutputStream out;
		out = res.getOutputStream();			
		editmodify=req.getParameter("editmodify");
		tablename=req.getParameter("tablename");		
		// Now printing the head tag and style tag			
			out.println("<html><head><title>Table Editor</title><script language='JavaScript' src='../jsp/almscript.js'></script><style>a.l{font-family:verdana,arial;text-decoration:none;color:#960317;}td{font-family:verdana,arial;font-size:9pt;} body{font-family:verdana,arial;font-size:9pt} td.h{background-color:#fff5e7;color:#000000;} td.b{background-color:#feeec8;color:#960317;font-weight:bold;} b.man{font-size:9pt;color:#FF0000;}</style></head><body bgcolor='#fef9e2'>");	     	
	   	out.println("<form action='"+form1action+"?tablename="+tablename+"' method='post' name='form1'>");  
	   	out.println("<input type='hidden' value='"+tablename+"' name='tablename'>");
	   	// the initial hidden field is to browse through the records
	   	out.println("<input type='hidden' value='' name='initial'>");	   	
	   	//out.println("Value of editmodify :"+editmodify);
	   	out.println("Welcome "+adminuser+"<br><b>Table Name: "+tablename+"</b><br><br>");
		System.out.println("Welcome "+adminuser+"<br><b>Table Name: "+tablename);
	   	 
	   	try	{ //Checking the External Parameters
			tablename=req.getParameter("tablename");			
			Statement stmt=con.createStatement();
			Statement stmt1=con.createStatement();
			Statement stmt3=con.createStatement();	
			Statement stmt4=con.createStatement();	
			Statement stmt5=con.createStatement();
			Statement stmt6=con.createStatement();
			ResultSet rs=stmt.executeQuery("select * from "+tablename+"");
			ResultSetMetaData meta = rs.getMetaData();
			num_cols = meta.getColumnCount();
			//System.out.println("Welcome num_cols"+num_cols);
			DatabaseMetaData dbmeta=con.getMetaData();
			ResultSet rs1=dbmeta.getPrimaryKeys("","zcalm",tablename);
			//this query is used for checking auto_increment value
			ResultSet rs2=stmt1.executeQuery("desc "+tablename);
			ResultSet rs3=null,rs4=null;
		
			while(rs2.next()) 	{
			 	extra=rs2.getString("Extra");
				//System.out.println("Welcome extra"+extra);
			 		if(extra.equals("auto_increment"))
			 			{
			 			field=rs2.getString("Field");
						//System.out.println("Welcome field"+field);
			 			}	 	
			 	}	
			System.out.println("Welcome editmodify"+editmodify);
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
			int nextval=0;int cnt=0;
			String []grpId = new String[10];
			String []grpName = new String[10];
			int initial;			
				if(req.getParameter("initial")!=null){
				initial=Integer.parseInt(req.getParameter("initial"));
				System.out.println("Welcome initial"+initial);
				}
				else{ initial=1;}																	
				//getting the primarykey of the table here.		
				
				while(rs.next())	
				{
					
					grpId[cnt]=rs.getString("GroupId");
					grpName[cnt]=rs.getString("GroupName");
					System.out.println("GroupId :"+grpId[cnt]);
					System.out.println("GroupName :"+grpName[cnt]);
					cnt++;
					System.out.println("cnt :"+cnt);
					//out.print("<b>PRIMARY KEY :</b>"+primkey+"<br>");
				}
							
				/*while(rs1.next())	{
						primkey=rs1.getString("PK_NAME");
						System.out.println("Welcome primkey"+primkey);
						//out.print("<b>PRIMARY KEY :</b>"+primkey+"<br>");
					}
				//rs1.close();*/
				rs.close();
				//getting the number of columns				
				out.print("<table border='0'  bgcolor='feeec8'>");
				out.println("<tr>");
				for (int i=1;i<= num_cols;i++)	{
							// getting the column names
							columnname=meta.getColumnName(i);							
							out.println("<td class=b>"+columnname+"</td>");
							//System.out.println("<td class=b>"+columnname+"</td>");
							}
						out.println("<td>&nbsp</td><td>&nbsp;</td></tr>");
						while(rs1.next()) {	
						
						  //Code added here
						  primkey=rs1.getString("PK_NAME");
						  System.out.println("Welcome primkey"+primkey);
						  //out.print("<b>PRIMARY KEY :</b>"+primkey+"<br>");
						  //code end here 	
							
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
								for(int i=0;i<cnt;i++)
								{		
									out.print("<td class=h>"+grpId[i]+" "+grpName[i]+"</td>");	
									out.print("</tr>");			
								}
								
								} //pass the value of primary key here
								out.print("<td><a href='"+form1action+"?editmodify=modval&tablename="+tablename+"&primkey="+rs1.getString(primkey)+"&type="+type+"'>Modify</a></td><td><a href='"+form1action+"?editmodify=delrec&tablename="+tablename+"&primkey="+rs1.getString(primkey)+"&type="+type+"'>Delete</a></td>"); 
								System.out.print("<td><a href='"+form1action+"?editmodify=modval&tablename="+tablename+"&primkey="+rs1.getString(primkey)+"&type="+type+"'>Modify</a></td><td><a href='"+form1action+"?editmodify=delrec&tablename="+tablename+"&primkey="+rs1.getString(primkey)+"&type="+type+"'>Delete</a></td>");
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
								 		int val= new Integer(req.getParameter(columnname)).intValue();
								 		qryString+=""+val+",";								 		
								 	}
								else{														 			
							 		//values = req.getParameter(columnname);	
							 		invals = req.getParameter(columnname);
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
				stmt3.executeQuery(qryStringn);		//LINKS 
				out.println("<br><br><br><table border=0 align='center'><tr><td><a href='"+form1action+"?tablename="+tablename+"&editmodify=Add New Records'><b>Continue Adding Records</b></a></td><td><a href='"+form1action+"?tablename="+tablename+"&editmodify=modrecords'><b> Record Listing</b></a></td><td><a href='"+adminpath+"'> Back To Mainpage</a> </td></tr></table>");
				}//if->equals->Submit ends here	
		//--------------------------Table Inserting Rec Code Starts here------------------------	
		if(editmodify.equals("modval"))	{ //if->equals->modval starts here				
				//get the value of primary keys,if auto exists then that value
				try{
					primkeyval=req.getParameter("primkey");
					typeval=req.getParameter("type");
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
					rs3=stmt4.executeQuery("select * from "+tablename+" where "+primkey+"='"+primkeyval+"'");
					while(rs3.next())	{
						for (int y=1;y<=num_cols;y++)	{									
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
					rs3=stmt4.executeQuery("select * from "+tablename+" where "+primkey+"='"+primintval+"'");
					while(rs3.next())	{
						for (int y=1;y<=num_cols;y++){									
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
					prigetval=req.getParameter("primkey");
					typeup=req.getParameter("typeup");				
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
								 	int val= new Integer(req.getParameter(columnname)).intValue();
								 	namesup+=""+val+",";								 		
								 	}
								else{														
							 		//valuesup = req.getParameter(columnname);
							 		invals = req.getParameter(columnname);
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
				stmt3.executeQuery(qryStringnup);	
				out.print("<br><br><b>Records Successfully Updated ............<b>");
				//--------------------------------------Table Updation Ends Here--------------------------------					
				}
				catch(Exception e){ out.println(e.getMessage()); }				
			} //if -> equals Update ends here			
				//--------------------------------------Record Deletion Starts Here--------------------------------					
			if(editmodify.equals("delrec"))	{
			try	{
				//out.println("Welcome To Delelete Records");					
				primkeydel=req.getParameter("primkey");
				typedel=req.getParameter("type");
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
				primkeydel=req.getParameter("primkey");
				typedel=req.getParameter("type");
								
			//	out.println("Welcome To Delete Records");
					if(typedel.equals("int"))
    				{
    				int prigetvalint= new Integer(primkeydel).intValue();
    				out.print("delete from "+tablename+" where "+primkey+"="+prigetvalint+"");
    				try{		
					stmt6.executeQuery("delete from "+tablename+" where "+primkey+"="+prigetvalint+"");
					out.print("<br><br> Record Successfully Deleted");
					}
					catch(Exception e){	out.print("<br><br> Record Could not be Deleted");}
					
					}
				else{
						out.print("delete from "+tablename+" where "+primkey+"="+primkeydel+"");
					try{
					stmt6.executeQuery("delete from "+tablename+" where "+primkey+"='"+primkeydel+"'");
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
		public void destroy(){
			try	{
				//con.close();
				pool.releaseConnection(con); 
				}
			catch(Exception e){	}	
			}
}
