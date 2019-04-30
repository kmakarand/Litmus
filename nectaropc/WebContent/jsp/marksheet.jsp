<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="com.ngs.gbl.RegistrationKey"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="com.itextpdf.text.*"%>
<%@page import="java.util.List"%>
<%@page import="com.itextpdf.text.pdf.PdfWriter"%>
<%@page import="com.itextpdf.text.pdf.PdfPTable"%>
<%@page import="com.itextpdf.text.html.simpleparser.HTMLWorker"%>
<%@page import="org.apache.commons.io.filefilter.WildcardFileFilter"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		Query query=null;
		int cid = Integer.parseInt(request.getParameter("CandidateID"));
		String fname="",lname="",clientId="";
		String candidateId = "",key="";
		CandidatemasterDAO cmDAO = new CandidatemasterDAO();
		EntityManager em = EntityManagerHelper.getEntityManager();
		Logger log = Logger.getLogger("marksheet.jsp");
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Connection con = pool.getConnection();
		
		if (action == null || action == "")
		{
			List<Candidatemaster> cmList = cmDAO.findAll();			
			out.println("<HTML><HEAD><TITLE>Mark Sheet</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<FORM NAME=form action=\"marksheet.jsp\">");
			out.println("<BR></BR><BR></BR><BR></BR>");
			out.println("<table border=\"1\" cellspacing=\"1\" cellpadding=\"1\" align=\"center\">");
			out.println("<TR><th colspan=\"2\">Candidate Marksheet Details</th></TR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Registration No -> Candidate Name :</TD><TD><SELECT NAME=CandidateID>");
			for(Candidatemaster cm:cmList)
			{
				fname = cm.getFirstName();
				lname = cm.getLastName();
				candidateId = String.valueOf(cm.getCandidateId());
				clientId = String.valueOf(cm.getClientId());
				cid = Integer.parseInt(candidateId);
				RegistrationKey regkey = new RegistrationKey(cid);
				String Regkey = regkey.getKeyCode();
				//System.out.println("RegistrationKey :"+Regkey);
									
				session.setAttribute("FirstName",fname);
				session.setAttribute("LastName",lname);
				session.setAttribute("CandidateID",candidateId);
				session.setAttribute("ClientID",clientId);
				session.setAttribute("CID",Integer.valueOf(cid));
				session.setAttribute("Regkey",Regkey);
				//System.out.println("candidateId :"+candidateId);
				//System.out.println("clientId :"+clientId);
				if (candidateId.equals("371"))
				{
					out.println("<option value='"+candidateId+"' SELECTED>"+Regkey+" -> "+fname+" "+lname+"</option>");
				}
				else
					out.println("<option value='"+candidateId+"'>"+Regkey+" -> "+fname+" "+lname+"</option>");
						
			}		
			out.println("</SELECT></TD></TR>");
			out.println("<tr><td colspan=\"2\" align=center><input type=submit value=Genmarksheet name=submit></td></tr>");
			out.println("<input type=hidden value=showmarksheet name=action>");
			out.println("</table></FORM></BODY></HTML>");
		}
		else if (action.equals("showmarksheet"))
			{
				response.setContentType("text/html");
				StringBuffer sb = new StringBuffer();
				sb.append("<HTML><HEAD><TITLE></TITLE>");
				sb.append("<LINK REL='stylesheet' TYPE='text/css' HREF='alm.css'></HEAD>");
				sb.append("<BODY><CENTER>");
				String firstname = "" , lastname ="",testname="",clientname="",date="",time="",result="",fromtime="",totime="",cityid="",areaid="";
				int totquest=0,nowrong=0,nocorrect=0,rest=0,sectionid=0,schid=0;
				float percent = 0.00f;
				float passpercent=0.00f;

				cid = Integer.parseInt(request.getParameter("CandidateID"));
				//log.info("CandidateID:"+cid);
				String sql = "SELECT cd.examId FROM Candidatedetails cd WHERE cd.candidateId=?1";
				query = em.createQuery(sql);
				query.setParameter(1,cid);
				int examid =(Integer)query.getSingleResult();

				Candidatemaster cm = cmDAO.findById(cid);
				firstname = cm.getFirstName();
				lastname = cm.getLastName();
				int clientid = cm.getClientId();
				schid = cm.getScheduleId();
				

				sql = "SELECT nxd.testName FROM Newexamdetails nxd WHERE nxd.examId=?1";
				query = em.createQuery(sql);
				query.setParameter(1,examid);
				testname =(String)query.getSingleResult();
				//log.info("testname:"+testname);
				sql = "SELECT cm.clientName FROM Clientmaster cm WHERE cm.clientId=?1";
				query = em.createQuery(sql);
				query.setParameter(1,clientid);
				clientname =(String)query.getSingleResult();
				//log.info("clientname:"+clientname);
				ScheduleDAO scDAO = new ScheduleDAO(); 
				Schedule sc = scDAO.findById(schid);
				sectionid =  sc.getSectionId();
				date = Utils.ConvertDateToString(sc.getScheduleDate());
				fromtime = sc.getTimeFrom();
				fromtime = fromtime.substring(0,5);
				totime = sc.getTimeTo();
				totime = totime.substring(0,5);
				
/*				sql = "SELECT Date,Time,TotalQuestions,NoOfWrong,NoOfCorrect,Result  FROM PerformanceMaster WHERE CandidateID=" + cid + " and ExamID=" + examid;
				rs = stmt.executeQuery(sql);

				while (rs.next())
				{
					date = rs.getString("Date");
					time = rs.getString("Time");
					totquest = rs.getInt("TotalQuestions");
					nowrong = rs.getInt("NoOfWrong");
					nocorrect = rs.getInt("NoOfCorrect");
					rest = rs.getInt("Result");
				}
*/
				float score=0.0f;
				//String tql = "SELECT sum(TotalQuestions),sum(NoOfWrong),sum(NoOfCorrect),sum(Score) FROM 	NewPerformanceMaster WHERE CandidateID=" + cid + " and ExamID=" + examid +" group by SectionID";
				
				query = em.createNamedQuery("Analysis-Newperformancemaster.sql16");
				query.setParameter(1, cid);
				query.setParameter(2, examid);
				Number rtotquest = (Number)query.getSingleResult();
				totquest = rtotquest.intValue();
				query = em.createNamedQuery("Analysis-Newperformancemaster.sql17");
				query.setParameter(1, cid);
				query.setParameter(2, examid);
				Number rnowrong = (Number)query.getSingleResult();
				nowrong = rnowrong.intValue();
				query = em.createNamedQuery("Analysis-Newperformancemaster.sql18");
				query.setParameter(1, cid);
				query.setParameter(2, examid);
				Number rnocorrect = (Number)query.getSingleResult();
				nocorrect = rnocorrect.intValue();
				query = em.createNamedQuery("Analysis-Newperformancemaster.sql19");
				query.setParameter(1, cid);
				query.setParameter(2, examid);
				Number rscore = (Number)query.getSingleResult();
				score = rscore.intValue();

				query = em.createNamedQuery("Analysis-NewexamdetailsId.sql20");
				query.setParameter(1, examid);
				query.setParameter(2, sectionid);
				List<Object[]> nxdidList = query.getResultList();
				int noofquestions=0,levelid=0;
				for(Object[] objList:nxdidList)
				{
					noofquestions = (Integer)objList[0];
					levelid = (Integer)objList[1];
				}
				int TotalMarks=0;
				{
					TotalMarks = TotalMarks +(noofquestions*levelid);
				}
				//log.info("TotalMarks:"+TotalMarks);
//				unattempted=totquest-(nocorrect+nowrong);
				DecimalFormat df = new DecimalFormat("##.##");
				percent	= ((score*100)/TotalMarks);
				
				if (percent < 0)
					percent = 0;
				String strPercent	= df.format(percent);
				//select c.CityID,c.AreaID from CandidateMaster a,ClientMaster b,LocationMaster c where a.CandidateID=1 and a.ClientID=b.ClientID and b.LocationID=c.LocationID




/*				sql = "SELECT Percentage FROM RemarkDetails WHERE ExamID=" + examid;
out.println(sql);
				rs = stmt.executeQuery(sql);
				while (rs.next())
				{
					passpercent = rs.getFloat("Percentage");
				}
*/
				sql = "SELECT npm.result FROM Newperformancemaster npm WHERE npm.candidateId=?1 and npm.examId=?2";
				query = em.createQuery(sql);
				query.setParameter(1,cid);
				query.setParameter(2,examid);
				int Result=0;
				if(EntityManagerHelper.getSingleResult(query)!=null){
					Result = (Integer)query.getSingleResult();
				}else{
					Result = -1;
				}
				if (Result == 1){result="Pass";}else{result="Fail";}
//				percent = (nocorrect*100)/totquest;
/*
				day = date.substring(8,10);
				mth = date.substring(5,7);
				yr = date.substring(0,4);
				date = day + "-" + mth + "-" + yr;
*/
//				Utils myUtil = new Utils();
//				date = myUtil.getDate(date);
               
				cid = Integer.parseInt(request.getParameter("CandidateID"));
								
				RegistrationKey regkey = new RegistrationKey(cid);
				String Regkey = regkey.getKeyCode();
				//System.out.println("RegistrationKey from bean:"+Regkey);
				
				 Document document = new Document(PageSize.A4);
				 PdfWriter pdfWriter = PdfWriter.getInstance(document, new FileOutputStream("/opt/tomcat/temp/"+Regkey+" Marksheet.pdf"));
				 //PdfWriter pdfWriter = PdfWriter.getInstance(document, new FileOutputStream("c:\\nectar\\"+Regkey+" Marksheet.pdf"));
				 document.open();
				 document.addAuthor("Makarand Kulkarni");
				 document.addCreator("Nectar Global Services");
				 document.addSubject("Thanks for your support");
				 document.addCreationDate();
				 document.addTitle("Nectar Prometric Examination");
				 HTMLWorker htmlWorker = new HTMLWorker(document);
				
				
				PdfPTable table = new PdfPTable(2);
				table.setWidthPercentage(100);
				table.getDefaultCell().setBorder(Rectangle.NO_BORDER);
				table.getDefaultCell().setHorizontalAlignment(Element.ALIGN_CENTER);
				table.getDefaultCell().setVerticalAlignment(Element.ALIGN_MIDDLE);
				table.getDefaultCell().setFixedHeight(70);
				Image image = Image.getInstance("/opt/tomcat/webapps/nectar/jsp/simages/logoN1.jpg");
				//Image image = Image.getInstance("C:\\Tomcat6\\webapps\\nectar\\jsp\\simages\\logoN1.jpg");
				table.addCell(image);
				table.addCell("NECTAR PROMETRIC EXAMINATION");
				document.add(table);
								
				sb.append("<FORM METHOD=POST NAME=form1>");
				sb.append("----------------------------------------------------------------------------------------------------------------------------------");
				sb.append("<TABLE BORDER=0 CELLSPACING=0 CELLPADDING=0 width='100%'>"+"\n");
		
				sb.append("<TR><TD COLSPAN=3></TD></TR>");
				sb.append("<TR><TD COLSPAN=3 ALIGN=CENTER><B><U><H4>MARK SHEET</H4></U></B></TD></TR>");
				
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");
				//sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");
		
				sb.append("<TR><TD ALIGN=LEFT><B>Registration No.</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+Regkey+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=LEFT><B>Candidate Name</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+firstname+" "+lastname +"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Test Name</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+testname+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Centre</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+clientname+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Date</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+Utils.getFullDate(date)+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Time</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+fromtime +" to " +totime+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Your Score</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+strPercent+"%</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Passing Score</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>50 %</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD align=left><B>Result</B></TD><TD><B>:</B></TD><TD ALIGN=LEFT>"+result+"</TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("<TR><TD COLSPAN=3></TD></TR>");
				sb.append("<TR><TD ALIGN=CENTER COLSPAN=3>&nbsp;</TD></TR>");

				sb.append("</TABLE>");
				sb.append("</FORM>");
				//sb.append("</TABLE>");
				sb.append("</BODY></HTML>");
				//sb.append("Nectar Prometric Examination");

				String pdfdoc = sb.toString();
				System.out.println(" pdf document :"+pdfdoc);
				htmlWorker.setStyleSheet(Utils.GenerateStyleSheet());
				htmlWorker.parse(new StringReader(pdfdoc));
			  	document.close();
				out.println("<HTML><HEAD><TITLE>Mark Sheet</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='alm.css'></HEAD>");
				out.println("<BODY><CENTER></BR></BR></BR></BR>");
				out.println("<div align='center'>");
				out.println("<font color=blue family=gorgia size=3>MarkSheet is generated suceesfully </font><HR><BR>");
				out.println("<table border='0' cellspacing='1' cellpadding='1' "+
									"width='30%' ALIGN='CENTER'>");
				out.println("<tr><th colspan='2'>Candidate Details</th></tr>");
				out.println("<tr><td align='right'>Registration No </td>"+"<td>"+Regkey+"</td></tr>");
				out.println("<tr><td align='right'>Candidate Name  </td>"+"<td>"+firstname+" "+lastname +"</td></tr>");
				out.println("</table></BODY></HTML>");
				out.println("<br/><br/>");
				out.println("<font align=center>The generated Marksheets can be download from following links  </font><br/><br/>");
				out.println("<table align=center>");
				out.println("<tr><th>File Name</th><th>Download File</th>");
						File f = new File("/opt/tomcat/temp/");
						//File f = new File("c:\\nectar\\");
						FileFilter fileFilter = new WildcardFileFilter("*.pdf");
						File[] files = f.listFiles(fileFilter);

				        for(int i=0;i<files.length;i++)
				        {
				            String name=files[i].getName();
				            String path=files[i].getPath();
				            out.println("<tr><td>"+name+"</td><td><a href=\"/nectar/jsp/download.jsp?f=/opt/tomcat/temp/"+name+"\">Download File</a></td></tr>");
				            //out.println("<tr><td>"+name+"</td><td><a href=\"/nectar/jsp/download.jsp?f=c:\\nectar\\"+name+"\">Download File</a></td></tr>");
				        }
				        out.println("</table>");
			}
%>