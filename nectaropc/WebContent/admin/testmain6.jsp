<html>
<head>
<title> Test main </title>

<style>
td.qu{font-family:arial;font-size:10pt;background-color:#003399;color:#ffffff;font-weight:bold;}
td.an{font-family:arial;font-size:10pt;background-color:#cacaff;color:#990066;}
</style>

</head>


<script language="javascript">
var localvar="";
var flag=0;
var rname="";
var qtimer;
var tmleft;
//var current=document.testmain6.id.value;

   function setr()
   {
      rname="r" + document.testmain6.id.value;
   }

	function initialize()
	{
		//parent.totalQuestion=20;

		parent.displayOption();
		parent.setTime();
	}


	function setval()
	{
	    document.testmain6.qans.value=localvar;
		//document.testmain6.questimer.value=qtimer;
		 if(localvar=="") document.testmain6.qans.value="0";

	   //document.testmain5.submit();
	}
	function showval()
	{

		qtimer = parent.tcount - parent.temp;
		parent.temp = parent.tcount;
		document.testmain6.timeleft.value=tmleft;
		document.testmain6.questimer.value=qtimer;
		return localvar;

	}

</script>

<body bgcolor="#ffffff" text="#990066" onload="initialize()">

<%@ page language="java" import="java.sql.*,java.util.*" session="true"  %>
<form name="testmain6"  action="testmain6.jsp" method="GET">

<jsp:useBean id="pool" scope="page" class="rehanpinjo.ConnectionPool"/>
<jsp:useBean id="rnd" scope="page" class="rehanpinjo.RandomGenerator"/>


<center>
<table  width="480">
<tr>
   <td align="left" ><b>Q_no</b></td>
   <td ><b>Question</b></td>
</tr>
</table>
<br>
<%

    String teststart=(String)session.getValue("start");
	String stname =(String)session.getValue("name");
	String stemp=stname+"temp";
	String tstatus =(String)session.getValue("teststatus");
	Integer option =(Integer)session.getValue("NoOfRemainingQuestions");
	int nrq = option.intValue();
	Integer TQ=(Integer)session.getValue("TotalQuestions");
	Integer QRT=(Integer)session.getValue("QResponseTime");
	Integer Brks=(Integer)session.getValue("Breaks");
	Integer BrkInterval=(Integer)session.getValue("BreakInterval");
	Integer ET=(Integer)session.getValue("ExamTime");
	Integer Crt=(Integer)session.getValue("Criteria");
	Integer EMode=(Integer)session.getValue("ExamMode");
	Integer ECode=(Integer)session.getValue("ExamCode");
	Integer EID=(Integer)session.getValue("ExamID");
	Integer SID=(Integer)session.getValue("SubjectID");
	String  test=(String)session.getValue("Exam");
	Integer CID = (Integer)session.getValue("CandidateID");
    int CandidateID = CID.intValue();
	int TotalQuestions = TQ.intValue();
	int QResponseTime = QRT.intValue();
	int Breaks = Brks.intValue();
	int BreakInterval= BrkInterval.intValue();
	int ExamTime = ET.intValue();
	int Criteria = Crt.intValue();
	int ExamMode = EMode.intValue();
	int ExamCode = ECode.intValue();
	int ExamID   = EID.intValue();
	int SubjectID= SID.intValue();
	String testpaper = test+"QuestionMaster";
	int timeleft=0;
	int count=1;

	java.util.Hashtable qstore = new java.util.Hashtable();
    ServletContext context = getServletContext();
    pool =(rehanpinjo.ConnectionPool)getServletContext().getAttribute("ConPoolbse");
	if( tstatus.equals("old"))
	{
		//out.println("0lllllllllllllllldddddddddddd");
		String tleft= (String) session.getValue("TimeLeft");
		//out.print(tleft);
		ExamTime =Integer.parseInt(tleft);
	}
    //out.print("Time left : "+ExamTime);


	//out.println("url :" +pool.getURL());
    Connection con=null;
	Connection con2=null;
	Connection con3=null;
	con3=pool.getConnection();
	Statement stmt,stmt2,stmt3,stnew,stmt4;
	stmt=stmt2=stmt3=stnew=stmt4=null;
	int tques=1;

    if(teststart.equals("start"))
    {
       if(tstatus.equals("old")&&(nrq!=0))
		{
		   //out.println("Count getting changed");
		   count=nrq+1;
		}else{ count=1;}

%>
<script language="javascript">
	parent.startQuestion=<%=count%>;
	parent.totalQuestion=<%=TotalQuestions%>
	parent.totaltime=<%=ExamTime%>;
	parent.exammode=<%=ExamMode%>
</script>
<%
	   String a="started";
	   session.putValue("start",a);

     }//end of if(teststart)
     else //of if(teststart.equals("start"))
     {
       con2 = pool.getConnection();
       if(con2==null) out.println("Connection not obtained");
	   else out.println("Connection obtained");
	   if(con2!=null)
		 {
		   	stnew=con2.createStatement();
			ResultSet rsgetcount = stnew.executeQuery("SELECT COUNT(*) FROM "+stemp);
			while(rsgetcount.next())
			{
				String counter = rsgetcount.getString(1);
				count =Integer.parseInt(counter);
		        // String getid =(String)request.getParameter("id");
				//count = Integer.parseInt(getid);
				 ++count;//incremented to get next question
			   //out.println("Getting count :" + count);
			}//end of while
		 }//if con2!=null
       }
%>
<script language="javascript">
	parent.currentQuestion=<%=count%>
</script>
<%
     String b = (String)session.getValue("start");
     //out.println("Value of start:"+b);
	 //out.println("Value of rows:"+rows);
    //Updates the last answer given in database.TotalQuestions+1 sincecount rolls over to tq+1 after last answer

  if(ExamMode!=1)
  {
	 if((b.equals("started"))&&(count<=TotalQuestions)) //1st iff
     {
        try
		 {
			 con = pool.getConnection();
             if(con==null) out.println("Connection not obtained");
			 else out.println("Connection obtained");

			if(con!=null)
            {
					//Creating the statement object for executing querry
					 //out.println("Before statement creation");
					 stmt = con.createStatement();
					 stmt2 =con.createStatement();
					 out.println("Statement created");


					 if((count==1)||(count==(nrq+1)))
			          {
      				    //out.println("Count : " +count);
						//out.println("Before bean used");

						//System.out.println("Coming in");
						//CHECKING THE CAND TABLE FOR QUESTIONS ASKED
						ResultSet rstname=stmt.executeQuery("Select * from ExamTestingDetails WHERE CandidateID="+CandidateID);


						//ResultSet rstname=stmt.executeQuery("Select * from "+stname+" WHERE ExamCode="+ExamCode);
							 if(rstname!=null)
								{
								 int i=1;
								 while(rstname.next())
								  {

									 int tQuestionID=Integer.parseInt(rstname.getString("QuestionID"));
									 Integer tv = new Integer(tQuestionID);
									 Integer tk= new Integer(i);
									 qstore.put(tk,tv);
									 ++i;
								  }//end of while(rstname)
								}//end of if(rstname)

						if(tstatus.equals("old"))
						  {

						//CHECKING THE CANDTEMP TABLE FOR QUESTIONS ASKED

							ResultSet rstnametemp=stmt.executeQuery("Select * from "+stemp+" WHERE ExamCode="+ExamCode);


							 if(rstnametemp!=null)
								{
								 int i=qstore.size();
								 while(rstnametemp.next())
								  {

									 int tQuestionID=Integer.parseInt(rstnametemp.getString("QuestionID"));
									 ++i;
									 Integer tv = new Integer(tQuestionID);
									 Integer tk= new Integer(i);
									 qstore.put(tk,tv);

								  }//end of while(rstname)

								//CHANGE THE COUNT VARIABLE
								//if(i!=0) count=i;

								}//end of if(rstnametemp)
						  }//end of if status.equals("old");




                         tques = rnd.createVal();
						 while(tques==0) tques=rnd.createVal();

		//addddddddedddddddddddddddddddddddddddddd
								// out.println("Generated1:"+tques);
								 boolean quesfound=true;

								//To check if generated question is present in Question master as per subjectid and...
								ResultSet rqexist = null;
								//int qexist=0;
								//out.print("Getting Questions");
								while((quesfound==true)&&(qstore.size()>0))
								 {
									//System.out.println("Entering search 1 ");
									//System.out.println("Subject IDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD" +SubjectID);
									for(int j=1;j<=qstore.size();++j)
									 {
										while((tques==0))//&&(count!=20)
										 {tques=rnd.createVal();}
										//out.println("generated nonzero no :"+tques);

										//out.print("In loop1:"+j);
										Integer k= new Integer(j);
										Integer tq1 = (Integer)qstore.get(k);
										//int tq1i=tq1.intValue();
										if (tques==tq1.intValue())  quesfound=true;
										else quesfound=false;
										if(quesfound) break;
									 }

										 //out.println("Before rqexist");
										 /*while(rqexist.next())
										 {
									 	  if(tques==rqexist.getInt("QuestionID"))
										  {qexist=0;}
									     }*/
										// rqexist.beforeFirst();
										//System.out.println("Tqueeeeeeeeeeeeeeeeeeeeesssssssss"+tques);
										if(!quesfound)
										{
											Statement st1 = con.createStatement();
											rqexist=st1.executeQuery("Select Count(*)  from  "+testpaper+" WHERE  SubjectID="+SubjectID+" AND QuestionID="+tques);
											while(rqexist.next())
											{
												String recs=rqexist.getString(1);
												int recsi =Integer.parseInt(recs);
												out.println("recs : "+recsi);
												if(recsi==0) quesfound=true;
												if(recsi==0) break;
											}
										}

									 if(quesfound==true) tques=rnd.createVal();
									 //if(count==20) break;

								  }//end of while(quesfound)

								//out.println("Search over 2");
//Changed here 7thapril

								if(count==1) tques=1;
                               Integer key2 = new Integer(qstore.size()+1);
							   Integer value2= new Integer(tques);
                               qstore.put(key2,value2);


			//addddddddedddddddddeddddeeddddddd



						 //out.println("pinjo");
						 //out.println(tques);
						 Integer key =new Integer(1);
						 Integer value=new Integer(tques);
						 qstore.put(key,value);
				  		 context.setAttribute("QContainer",qstore);
					  }
					  else//else of if(count==1)
            				{
								qstore =(java.util.Hashtable)getServletContext().getAttribute("QContainer");


								//update previous answer
								//out.println("getting size:"+qstore.size());
								Integer p= new Integer(qstore.size());
								Integer v = (Integer)qstore.get(p);
								int vi=v.intValue();
								//out.println("earlier ques:"+vi);
								String pqid=request.getParameter("id");
								int pqidi=Integer.parseInt(pqid);
								String ansgiven=request.getParameter("qans");
								String ttaken=request.getParameter("questimer");
								//out.println("previous ans : " + ansgiven);
								int ansgiveni=Integer.parseInt(ansgiven);
								int ttakeni=Integer.parseInt(ttaken);
								String st=stname+"temp";
								int seq = 1;
								int updated=0;
								seq=count-1;
								out.println("sequence : "+seq);
								out.println("vi : "+vi);

								if(seq==pqidi) {updated=0;}
								else {updated=1;}
								out.println("updated="+updated);
								if(updated==0)
								{
									try
									{
										stmt.executeUpdate("Update "+st+" SET  ansg="+ansgiveni+",timetaken="+ttakeni+" WHERE QuestionID="+vi);
									}catch(Exception e)
									{out.println("1 candtemp update failed"+e.getMessage());
									}
								}
								else if(updated==1)
								{
									try
									{
										stmt.executeUpdate("Update "+st+" SET  ansg=0,timetaken="+ttakeni+" WHERE QuestionID="+vi);
									}catch(Exception e)
									{out.println("2 candtemp update failed"+e.getMessage());
									}

								}

								String tleft = request.getParameter("timeleft");
								timeleft=Integer.parseInt(tleft);
								//out.print("Time Inserted : "+timeleft);
								try
								{
									stmt.executeUpdate("Update ExamStatus SET TimeLeft="+timeleft+" WHERE CandidateID="+CandidateID);
								}catch(Exception e)
								{
									out.println("ExamStatus update failed "+e.getMessage());
								}

								 tques = rnd.createVal();
								 //out.println("Generated2:"+tques);
								 boolean quesfound=true;
								 ResultSet rqexist = null;
								 while(quesfound==true)
								 {
									//System.out.println("Entering search 2 ");
									for(int j=1;j<=qstore.size();++j)
									 {
		//Changed on local server
										while(tques==0) tques=rnd.createVal();
										//out.print("In loop2:"+j);
										Integer k= new Integer(j);
										Integer tq1 = (Integer)qstore.get(k);
										//int tq1i=tq1.intValue();
										if (tques==tq1.intValue())  quesfound=true;
										else quesfound=false;
										if(quesfound) break;
									 }
									 //System.out.println("Tqueeeeeeeeeeeeeeeeeeeeesssssssss"+tques);

									 if(!quesfound)
										{
											rqexist=stmt.executeQuery("Select Count(*)  from  "+testpaper+" WHERE  SubjectID="+SubjectID+" AND QuestionID="+tques);
											while(rqexist.next())
											{
												String recs=rqexist.getString(1);
												int recsi =Integer.parseInt(recs);
												if(recsi==0) quesfound=true;
												if(recsi==0) break;
											}
										}

									 if(quesfound==true) tques=rnd.createVal();
									 //if(count==20) break;
										//System.out.println("Ques generated:"+tques);
								  }//end of while(quesfound)
								//out.print(tques);
								//System.out.println("Search over 2");
								//if(count==20) tques=20;
                               Integer key2 = new Integer(qstore.size()+1);
							   Integer value2= new Integer(tques);
                               qstore.put(key2,value2);
								//out.println("before hash");
							   for(int m=1;m<=qstore.size();++m)
									 {
										Integer k= new Integer(m);
										Integer tq2 = (Integer)qstore.get(k);
										// tq1in = tq2.intValue();
										//out.print("h");
										//out.print(tq2.intValue());
									 }
                               //out.println("after hash");

				}//end of else of if(count==1)


				// tques=1;//for testing

				ResultSet rs=null;

				//out.println(testpaper);
				//System.out.println("quesgenerated"+tques);
				//out.println("ExamID"+ExamID);
				//System.out.println("SubjectID"+SubjectID);
				try
				{
					rs = stmt.executeQuery("Select * from "+testpaper+" where QuestionID="+tques+" AND SubjectID="+SubjectID );
				}catch (SQLException e)
				{out.println(" Couldn't access Question  :"+e.getMessage());}



		        //out.println("Querry executed");
			 while(rs.next())
			  {
				 //out.println("Rs obtained");

					 //System.out.println("Entering rs of question");
					  //rs.next();
					//System.out.println("getting rs.next of question");
					  String id,ques,a1,a2,a3,a4,ans,imagename;
					  int image=0;
					  id=ques=a1=a2=a3=a4=ans=imagename="";
					  id     = rs.getString("QuestionID");
					  //out.println(id);
			          ques   = rs.getString("vQues");
					  //out.println(ques);
			          a1    = rs.getString("vA1");
			          a2    = rs.getString("vA2");
			          a3    = rs.getString("vA3");
			          a4    = rs.getString("vA4");
			          ans  = rs.getString("vAns");
			         //String exp  = rs.getString("Explanation");
			         //String level = rs.getString("cLevel");
			         int idv     = Integer.parseInt(id);
					 int ani     = Integer.parseInt(ans);
					 image =rs.getInt("Image");
					 if(image!=0)
					 {
						 ResultSet rsimg=null;
						 try
						 {
							 rsimg = stmt.executeQuery("Select * from ImageDetails WHERE QuestionID="+idv);
						 }catch (SQLException e)
						 {
							 out.println("Image details resultset not obtained"+e.getMessage());
						 }
						 if(rsimg!=null)
						 {
							//System.out.println("In Images");
							while(rsimg.next())
							{
								imagename=rsimg.getString("Image");
							 }
						 }//if(rsimg)

					 }//if(image)

					 out.println("Getting from DB :");
					 //out.println(idv);
					 //out.println(ani);
					 //String s= stname+"temp";
					  //insertion of previous question and given answer
					  try
					  {
						stmt.executeUpdate("INSERT INTO "+stemp+" VALUES ("+count+","+idv+",0,"+ani+",0,"+ExamCode+")");
					  }catch(Exception e)
						{
						  out.println(" Inserting questions error"+e.getMessage());
						}


%>
						<table  width="480" height="75">
				           <tr>
							 <td align="left" valign="top" class=qu>(<%=count%>)</td>
				             <td align="left" valign="top" class=qu><%=ques%></td>
				           </tr>
				           </table>
			           <table width="480" >
						<tr>
			             <td align="center" width="20%" class=an> (a)</td>
			             <td align="left" width="80%" class=an><%=a1%><td>
			           </tr>

						<tr>
			             <td align="center" width="20%" class=an>(b)</td>
			             <td align="left" width="80%" class=an ><%=a2%><td>
			           </tr>

			           <tr>
			             <td align="center" width="20%" class=an> (c)</td>
			             <td align="left" width="80%"  class=an><%=a3%><td>
			           </tr>

						<tr>
					     <td align="center" width="20%" class=an> (d)</td>
			             <td align="left" width="80%"  class=an><%=a4%><td>
						</tr>

						  <tr>
				            <td> </td>
				            <td align="center"> </td>
			          </tr>
			          </table>
 <%
		 if(image!=0)
				  {

%>
					<div align=center>
					<img src="../jsp/simages/<%=imagename%>"  BORDER=0 ALT="">
				    </div>
<%				  }
						 if(count<=TotalQuestions)
						    {
 %>

					          <table width=400>
							   <tr><td align="right">
					             <input type="submit" value=" Next " onClick="return  showval()">
							   </td></tr>
				              </table>

	<%
						     } //end of if(count<=TotalQuestions)
				          else{
								 out.print("<br><br><font face=\"arial,helvetica\" size=\"3\" color=red>");
								 out.println("Questions Over!!Click on \"Submit Answers\" ==> ");
								 }


				  out.println("<input type=\"hidden\" name=\"qans\" value=\"0\">");
				  out.println("<input type=\"hidden\" name=\"questimer\" value=\"0\">");
				   out.println("<input type=\"hidden\" name=\"timeleft\" value=\"0\">");
				  out.println("<input type=hidden name=id value=" + count + ">");
				  stmt.close();

		  }/*end of if(rs!=null) */
			 // else { out.print("Suitable match for generated questionid not found in 	table!!!");
		  		  // }
	   }//end of if(con!=null)
	 }//end of try
	 catch (SQLException sqle)
		 {
		   System.err.println(sqle.getMessage());
		 }

      catch (Exception e)
		 {
		   System.err.println(e.getMessage());
		 }
		 finally{
			       /*if(count==10)
					{
					  if(con!=null)
						{
						  //pool.emptyPool();
						  //out.println("Pool Emptied");
						}
					}
					else*/
					if(con!=null)
			 {pool.releaseConnection(con);
					out.println("Connection released");
			 }
					else out.println("Connection Lost");
				 }
    }//end of 1st if
	else if((b.equals("started"))&&(count==(TotalQuestions+1)))
	{

	  con = pool.getConnection();
	   stmt=con.createStatement();
	  qstore =(java.util.Hashtable)getServletContext().getAttribute("QContainer");
 	  //update previous answer
      //out.println("getting size:"+qstore.size());
	  Integer p= new Integer(qstore.size());
	  Integer v = (Integer)qstore.get(p);
	  int vi=v.intValue();
	  //out.print(vi);
	 out.print("<br><br><font face=\"arial,helvetica\" size=\"3\" color=red>");
	 out.println("Questions Over!!Click on \"Submit Answers\" ==> ");
	 String ansgiven=request.getParameter("qans");
     String ttaken=request.getParameter("questimer");
	 //out.println("previous ans : " + ansgiven);
	 int ansgiveni=Integer.parseInt(ansgiven);
	 int ttakeni=Integer.parseInt(ttaken);
	 String st=stname+"temp";
	 out.print("ques:"+vi);
	 out.print(st);
	 out.print("answer given :"+ansgiveni);
	 out.print("Timetaken :"+ttakeni);
	 try
	  {
		 String query  = "Update "+st+" SET ansg="+ansgiveni+",timetaken="+ttakeni+"   WHERE QuestionID="+vi;
		 out.println(query);
		 int i=0;
		 out.println("i= " + i);
		 i = stmt.executeUpdate(query);
		 out.println("i= " + i);
	  }catch(Exception e)
	  {
		  out.println("Candtemp update failed"+e.getMessage());
	  }
   }
    else
    {
     %>

     <script language="javascript">
       location.replace("testover.html","_top");
      </script>
   <%
     }
  }//emd of exam mode check
else if((b.equals("started"))&&(ExamMode==1))
	{

		con2=pool.getConnection();

		stmt=con2.createStatement();

	   if(con2==null) out.println("Connection not obtained");
	   else out.println("Connection obtained");
	   if(con2!=null)
		 {
			ResultSet rseq =null;
			//String testpaper2="IITQuestionMaster";
			try
			  {
				rseq = stmt.executeQuery("Select * from "+testpaper);
			  }catch (SQLException e)
			  {
				 out.println("Error getting records from DB :" + e.getMessage());
		 	  }

			out.println("Total Questions :"+TotalQuestions);
			while(rseq.next())
			 {
				  String id,ques,a1,a2,a3,a4,ans,imagename;
				  int image=0;
				  id=ques=a1=a2=a3=a4=ans=imagename="";
				  id     = rseq.getString("QuestionID");
				  out.println("id"+id);
			      ques   = rseq.getString("vQues");
				  //out.println(ques);
			      a1  = rseq.getString("vA1");
			      a2  = rseq.getString("vA2");
			      a3  = rseq.getString("vA3");
			      a4  = rseq.getString("vA4");
			      ans  = rseq.getString("vAns");
			      int idv     = Integer.parseInt(id);
				  int ani     = Integer.parseInt(ans);
				  image =rseq.getInt("Image");
				 if(image!=0)
					 {
						 ResultSet rsimg=null;
						 try
							{
							 rsimg = stmt.executeQuery("Select * from ImageDetails WHERE QuestionID="+idv);
							}catch (SQLException e)
							{
							 out.println("Image details resultset not obtained"+e.getMessage());
							}
							if(rsimg!=null)
								{
									//System.out.println("In Images");
									while(rsimg.next())
									{
										imagename=rsimg.getString("Image");
									 }
								}//if(rsimg)

					 }//if(image)

					 out.println("Getting from DB :");

%>
						<table  width="480" height="75">
				           <tr>
							 <td align="left" valign="top" class=qu>(<%=count%>)</td>
				             <td align="left" valign="top" class=qu><%=ques%></td>
				           </tr>
				           </table>
			           <table width="480" >
						<tr>
			             <td align="center" width="20%" class=an> (a)</td>
			             <td align="left" width="80%" class=an><%=a1%><td>
			           </tr>

						<tr>
			             <td align="center" width="20%" class=an>(b)</td>
			             <td align="left" width="80%" class=an ><%=a2%><td>
			           </tr>

			           <tr>
			             <td align="center" width="20%" class=an> (c)</td>
			             <td align="left" width="80%"  class=an><%=a3%><td>
			           </tr>

						<tr>
					     <td align="center" width="20%" class=an> (d)</td>
			             <td align="left" width="80%"  class=an><%=a4%><td>
						</tr>

						  <tr>
				            <td> </td>
				            <td align="center"> </td>
			          </tr>
			          </table>
 <%
		 if(image!=0)
				  {

%>
					<div align=center>
					<img src="../jsp/simages/<%=imagename%>"  BORDER=0 ALT="">
				    </div>
<%				  }
				count++;
				out.print("count"+count);
				if(count==(TotalQuestions+1)) break;
			 }	//end of while(rseq.next())
			 out.println("<input type=hidden name=id value=1>");
  			 out.println("<input type=hidden name=qans value=1>");
		 }//if (con2!=null)

	}

   %>
  </table>
  </center>
  </form>
  </body>
  </html>
