<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		////System.out.println("databasetableditor	start:");
		String action = request.getParameter("action");
		ResultSetMetaData meta =null;
		HashMap hm = new HashMap();HashMap tablemap = new HashMap();
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("ExamTestDetail.jsp");
		Connection con = pool.getConnection();
		String editmodify="",counter1="",records="",primkeyval="",type="",typeval="",typeup="",primkeydel="",typedel="";
		String namesup="",names1up="",qmarkup="",qmark1up="",qryStringup="",qryStringnup="",valuesup="",prigetval="";
		String columnname="",columnvalue="",columntype="",extra="",field="",nullvalue="",nullfield="",qryString="",invals="",invals1="";
		String names = "",names1="",qmark="",qmark1="",values = "",sql="";
		int value=0,num_cols=0;		
		//here we are storing the form action path
		String form1action="databasetableditor.jsp";
		String adminpath="../admin/teditor.jsp";
		String tablename="",primkey="";
		int y=0;	
		// initialising strings of inserting table data 
		String transactionid="",examid="",date="",time="",candidateid="",subjectid="",questionid="",answer="",timetaken="",checkautoinc="";
		PreparedStatement pstmt=null;StringBuilder strcat=new StringBuilder();
		String pkcolumn=null;String pkvalue="";String editdelete="";
		EntityManager em = EntityManagerHelper.getEntityManager();
		try
		{
			
			if (action == null || action == "")
			{
			    String adminuser = (String) session.getAttribute("username");
				////System.out.println("adminuser	:"+adminuser);
				////System.out.println("databasetableditor	start:");
				
				if (adminuser == "" || adminuser == null)	{
					response.sendRedirect("../jsp/Login.jsp");
				}			
				//response.setContentType("text/html");
				editmodify=request.getParameter("editmodify");
				editdelete=request.getParameter("editdelete");
				tablename=request.getParameter("tablename");
				pkvalue=request.getParameter("pkcolumn");	
				//System.out.println("start editmodify	:"+editmodify);
				//System.out.println("start tablename	:"+tablename);
				//System.out.println("start pkcolumn	:"+pkvalue);
				//System.out.println("start editdelete	:"+editdelete);
					
				// Now printing the head tag and style tag			
				out.println("<html><head><title>Table Editor</title><script language='JavaScript' src='../jsp/almscript.js'></script><style>a.l{font-family:verdana,arial;text-decoration:none;color:#960317;}td{font-family:verdana,arial;font-size:9pt;} body{font-family:verdana,arial;font-size:9pt} td.h{background-color:#fff5e7;color:#000000;} td.b{background-color:#feeec8;color:#960317;font-weight:bold;} b.man{font-size:9pt;color:#FF0000;}</style> </head><body bgcolor='#fef9e2'>");	     	
			   	out.println("<form action='"+form1action+"?tablename="+tablename+"' method='post' name='form1'>");  
			   	out.println("<input type='hidden' value='"+tablename+"' name='tablename'>");
			   	// the initial hidden field is to browse through the records
			   	out.println("<input type='hidden' value='' name='initial'>");	   	
			   	//out.println("Value of editmodify :"+editmodify);
			   	out.println("Welcome "+adminuser+"<br><b>Table Name: "+tablename+"</b><br><br>");
			   	 
			   	try	{ //Checking the External Parameters
					//tablename=request.getParameter("tablename");	
					sql = "select * from "+tablename;
					pstmt = con.prepareStatement(sql);
					////System.out.println("ExamTestDetails pstmt :"+pstmt);
					ResultSet rs=pstmt.executeQuery();
					meta = rs.getMetaData();
					num_cols = meta.getColumnCount();
					////System.out.println("num_cols	num_cols:"+num_cols);
					DatabaseMetaData dbmeta=con.getMetaData();
					ResultSet rs1=dbmeta.getPrimaryKeys("","nectar",tablename);
					//this query is used for checking auto_increment value
					sql = "desc "+tablename;
					pstmt = con.prepareStatement(sql);
					ResultSet rs2=pstmt.executeQuery();
					ResultSet rs3=null,rs4=null;
					int i=1;
					String primaryKey="";
					
					DatabaseMetaData metad = con.getMetaData();
				    ResultSet rsmeta = metad.getPrimaryKeys(null, null, tablename);
				
				    java.util.List list = new java.util.ArrayList();
				    rsmeta.next();
				    //while (rs.next()) 
				    {
				      pkcolumn = rsmeta.getString("COLUMN_NAME");
				      ////System.out.println("getPrimaryKeys(): columnName=" + pkcolumnName);
				    }
				    
				    String datasql = "select * from "+tablename+" where "+pkcolumn+"="+pkvalue;
				    ////System.out.println("datasql=" + datasql);
					pstmt = con.prepareStatement(datasql);
					////System.out.println("ExamTestDetails pstmt :"+pstmt);
					ResultSet rsdata=pstmt.executeQuery();rsdata.next();
					int id=1;
					int jd=1;int kd=1;
					while(id<=num_cols)
					{
					 String colvalue = rsdata.getString(id);
					 ////System.out.println("colvalue"+colvalue);
					 columnname=meta.getColumnName(id);
					 String tn = meta.getColumnTypeName(id);
					 ////System.out.println("meta.getColumnTypeName(id) :"+tn);
					 ////System.out.println("strcat==== :"+strcat);
					 if(jd<=num_cols-2 && (tn.equals("INT") || (tn.equals("FLOAT"))))
					 strcat.append(columnname+"="+colvalue+",");
					 else if(jd<=num_cols-2 && (tn.equals("CHAR") || tn.equals("VARCHAR") || tn.equals("DATE")))
					 strcat.append(columnname+"='"+colvalue+"',");
					 if(jd==num_cols && (tn.equals("INT") || (tn.equals("FLOAT"))))
					 strcat.append(columnname+"="+colvalue);
					 else if(jd==num_cols && (tn.equals("CHAR") || tn.equals("VARCHAR") || tn.equals("DATE")))
					 strcat.append(columnname+"='"+colvalue+"'");
					 hm.put(columnname,colvalue);
					 id++;jd++;
					}
					////System.out.println(strcat);
					
					/*String finalsql = "update "+tablename+" set "+strcat+" where "+pkcolumnName+"="+pkvalue;
					//System.out.println("finalsql :"+finalsql);
					pstmt = con.prepareStatement(finalsql);
					int resdata = pstmt.executeUpdate();
					//System.out.println("finalsql :"+finalsql);*/
				    
				    if(editmodify.equals("modrecords")){				
						//printing the form to insert the data into table
						//out.println("<b>Welcome To Add Records<b>");
						out.println("<table width='56%' align='center'>");
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
											    out.println("<tr><td><b>"+columnname+"</b></td><td><input value='"+hm.get(columnname)+"' name='"+columnname+"' maxlength='"+size_column+"'>(Only Numbers Allowed)</td></tr>");
												}
											else{
												out.println("<tr><td><b>"+columnname+"</b></td><td><input value='"+hm.get(columnname)+"' name='"+columnname+"' maxlength='"+size_column+"' size='"+size_column+"'></td></tr>");
												}
											}
										else{ // null values are not allowed here									
											if(columntype.equals("LONG")){
												out.println("<tr><td><b>"+columnname+"</b></td><td><input value='"+hm.get(columnname)+"' name='"+columnname+"' maxlength='"+size_column+"' size='"+size_column+"'>&nbsp;(Only Numbers Allowed)&nbsp;<b class='man'>*</b></td></tr>");	
												}
											else{
												if(columnname.equals(pkcolumn))
												out.println("<tr><td><b>"+columnname+"</b></td><td><input value='"+hm.get(columnname)+"' name='"+columnname+"' maxlength='"+size_column+"' size='"+size_column+"' readonly>&nbsp;<b class='man'>*</b></td></tr>");
												else
												out.println("<tr><td><b>"+columnname+"</b></td><td><input value='"+hm.get(columnname)+"' name='"+columnname+"' maxlength='"+size_column+"' size='"+size_column+"'>&nbsp;<b class='man'>*</b></td></tr>");
														
												}
											}
										}
									}			
						out.println("<tr><td colspan='2'>&nbsp;</td></tr>");
						out.println("<tr><td colspan='2'><input type='hidden' name='pkvalue' value='"+pkvalue+"'><input type='hidden' name='pkcolumn' value='"+pkcolumn+"'><input type='hidden' name='action' value='Edit'><input type='submit' name='editmodify' value='Update'>&nbsp;&nbsp;<input type='Submit' name='editmodify' value='Delete'></td></tr></table>");
						out.print("<br><br><center><b class='man'>* &nbsp; Indicates Mandatory Fields.</b></center>");
						}
								
				}
				catch(Exception e){ out.println(e.getMessage()); }	
				out.print("<br><br><table align='right'><tr><td>Links:</td><td class=b><a href='"+form1action+"?tablename="+tablename+"&editmodify=modrecords' class=l>Record Listing</a></td><td class=b><a href='javascript:history.back()' class=l> &lt;&lt;Back&lt;&lt; </td><td class=b><a href='"+adminpath+"' class=l> Back To Mainpage</a></td></tr></table>");
				out.println("</form></body></html>"); 	
			}else if(action.equals("Edit"))
			{
			
				//System.out.println("success Edit action:");
				editmodify=request.getParameter("editmodify");
				tablename=request.getParameter("tablename");	
				pkcolumn=request.getParameter("pkcolumn");	
				pkvalue=request.getParameter("pkvalue");
				editdelete=request.getParameter("editdelete");
				//System.out.println("editmodify	:"+editmodify);
				//System.out.println("tablename	:"+tablename);
				//System.out.println("pkcolumn	:"+pkcolumn);
				//System.out.println("pkvalue		:"+pkvalue);
				//System.out.println("editdelete		:"+editdelete);
				
			   	if(editmodify.equals("Update"))
			   	{
				   	//System.out.println("Youare out"+num_cols);
				   	
					sql = "select * from "+tablename;
					pstmt = con.prepareStatement(sql);
					////System.out.println("ExamTestDetails pstmt :"+pstmt);
					ResultSet rs=pstmt.executeQuery();
					meta = rs.getMetaData();
					num_cols = meta.getColumnCount();
					String colvalue ="";int id=1;
					int jd=1;int kd=1;
					for (int m=1;m<= num_cols;m++)	
					{
						////System.out.println("Youare in");
						// getting the column names
						columnname=meta.getColumnName(m);
						colvalue =request.getParameter(columnname);
						int size_column=meta.getColumnDisplaySize(m);
						columntype=meta.getColumnTypeName(m);
						//System.out.println("Column name		:"+ columnname);
						//System.out.println("Column value	:"+ colvalue);
						columnname=meta.getColumnName(id);
						String tn = meta.getColumnTypeName(id);
						if(jd<=num_cols-2 && (tn.equals("INT") || (tn.equals("FLOAT"))))
					 	strcat.append(columnname+"="+colvalue+",");
					 	else if(jd<=num_cols-2 && (tn.equals("CHAR") || tn.equals("VARCHAR") || tn.equals("DATE")))
					 	strcat.append(columnname+"='"+colvalue+"',");
					 	if(jd==num_cols && (tn.equals("INT") || (tn.equals("FLOAT"))))
					 	strcat.append(columnname+"="+colvalue);
					 	else if(jd==num_cols && (tn.equals("CHAR") || tn.equals("VARCHAR") || tn.equals("DATE")))
					 	strcat.append(columnname+"='"+colvalue+"'");
					 	hm.put(columnname,colvalue);
					 	id++;jd++;
					}
					
						String finalsql = "update "+tablename+" set "+strcat+" where "+pkcolumn+"="+pkvalue;
						//System.out.println("finalsql :"+finalsql);
						pstmt = con.prepareStatement(finalsql);
						int resdata = pstmt.executeUpdate();
						out.println("<html><head><title>Table Editor</title><script language='JavaScript' src='../jsp/almscript.js'></script><style>a.l{font-family:verdana,arial;text-decoration:none;color:#960317;}td{font-family:verdana,arial;font-size:9pt;} body{font-family:verdana,arial;font-size:9pt} td.h{background-color:#fff5e7;color:#000000;} td.b{background-color:#feeec8;color:#960317;font-weight:bold;} b.man{font-size:9pt;color:#FF0000;}</style></head><body bgcolor='#fef9e2'>");
						if(resdata>0)
						out.print("<br><br><center><b class='man'> &nbsp; Data Modified Successfully</b></center>");
						else
						out.print("<br><br><center><b class='man'> &nbsp; Data Modified Failed</b></center>");
						//System.out.println("success :"+resdata);
						out.println("</body></html>"); 	
						con.close();
				}
				else if(editmodify.equals("Delete"))
			   	{
					//System.out.println("success Delete:");
					String finalsql = "delete from "+tablename+" where "+pkcolumn+"="+pkvalue;
					pstmt = con.prepareStatement(finalsql);
					int resdata = pstmt.executeUpdate();
					out.println("<html><head><title>Table Editor</title><script language='JavaScript' src='../jsp/almscript.js'></script><style>a.l{font-family:verdana,arial;text-decoration:none;color:#960317;}td{font-family:verdana,arial;font-size:9pt;} body{font-family:verdana,arial;font-size:9pt} td.h{background-color:#fff5e7;color:#000000;} td.b{background-color:#feeec8;color:#960317;font-weight:bold;} b.man{font-size:9pt;color:#FF0000;}</style></head><body bgcolor='#fef9e2'>");
					if(resdata>0)
					out.print("<br><br><center><b class='man'> &nbsp; Data Deleted Successfully</b></center>");
					else
					out.print("<br><br><center><b class='man'> &nbsp; Data Modified Failed</b></center>");
					//System.out.println("success :"+resdata);
					out.println("</body></html>"); 	
					con.close();
				}
				
				
			}
		}catch(Exception e){ out.println(e.getMessage());e.printStackTrace(); }	
%>