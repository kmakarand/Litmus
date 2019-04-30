
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->



<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper,org.apache.commons.io.filefilter.WildcardFileFilter"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<html>
<head>
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<%
EntityManager em = 	EntityManagerHelper.getEntityManager();
Query query = null;String varExamID ="";String flag="";String filename="";String fileList="";
String action = request.getParameter("action");String filepath ="";
//System.err.println("*** Requested By : " + request.getRequestURI() + " *** Action : " + action);


if (action == null || action == "")
{
%>
<CENTER>
  <form name="f1" method=POST action="/nectar/admin/AddQuestionBank.jsp">
    <table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
      <tr><BR/><BR/>
          <td align="center" colspan="2"><font family=gorgia size=3>Add Question Bank</font></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="center"> <br>
          <table border="0" cellspacing="1" cellpadding="1" align="center">
          <tr>
						<td>Select Exam to Add Question:</td>
						<td><select name=ExamID>
<%
					    ExammasterDAO exmDAO = new ExammasterDAO();
						List<Exammaster> exmList = exmDAO.findAll();
						String examId = "";String exam ="";
						for(Exammaster exm:exmList)
						{
						   examId = String.valueOf(exm.getExamId());
						   exam = exm.getExam();
						   //System.out.println(" examId :"+examId);
						   //System.out.println(" exam :"+exam);
						   
%>
						   <option value=<%=examId%>><%= exam%></option>
						
<%
						}
%>
						</select></td>
		 	</tr>
		 	<tr><td>SQL Script File Name: (ex. nectar.sql)</td><td><input type=text name="filename" width=5></td></tr><br>
			<tr><td>Select the file to be uploaded:</td><td><INPUT TYPE="FILE" NAME="fileList"></td></tr> <BR>
		 	<tr>
              <input type=hidden name=flag value="AddQuestion">
              <input type=hidden name=action value="AddQuestion">
              <th colspan="2" valign="top">
                <input type=submit value="ADD EXAM" name="submit">
              </th>
            </tr>
          	</table>
          	 </tr>
          	</table>	
          	</form>
          	<form>	
		 	<table width=38% border="0" cellspacing="1" cellpadding="1" align="center">
		 	<tr><td>SQL Script File Name: (ex. nectar.sql)</td><td><input type=text name="filename" width=5></td></tr><br>
			<tr><td>Select the file to be uploaded:</td><td><INPUT TYPE="FILE" NAME="fileList"></td></tr>
            <tr>
              <th colspan="2" align="center"><input type=image src="../jsp/simages/newexam2.gif"  name='Image2' onMouseOut='MM_swapImgRestore()' onMouseOver ="MM_swapImage('Image2','','../jsp/simages/newexam1.gif',1)" border=0>				
				<input type=hidden name=flag value='doNewExam'>
				<input type=hidden name=action value="doNewExam">
			  </th>
            </tr>
            </table>
            </form>
			</CENTER>
<%
}

else
{
        flag = request.getParameter("flag");
        //System.out.println("flag :"+flag);
        
 		if(flag.equals("doNewExam"))
		{
		    query = em.createQuery("select max(exm.examId) from Exammaster exm");
		    Number exmResult = (Number) query.getSingleResult();
			varExamID = String.valueOf(exmResult.intValue() + 1);
			System.out.println("varExamID :"+varExamID);
		}
		
		else if(flag.equals("AddQuestion"))
		{
			varExamID = request.getParameter("ExamID");
			System.out.println("ExamID :"+varExamID);
		}
		
		System.out.println("Before ExamID :"+varExamID);
       	int examid=Integer.parseInt(varExamID);
		int queNumber=0;
		QuestionmasterDAO queDAO = new QuestionmasterDAO();
		query = em.createQuery("select max(qm.questionId) from Questionmaster qm where qm.examId =?1");
		query.setParameter(1, examid);
		Number result = null;
		if(EntityManagerHelper.getSingleResult(query)!=null)
		{
			result = (Number) query.getSingleResult();
			queNumber = result.intValue() + 1;
		}
		else
		{
		    queNumber = 1;
		}
		
		System.out.println("queNumber........... :"+queNumber);

		
  	 	int rowcount=0;
	 	String queId="";
	 	int PartyID=6,ExamType=1,NoOfOptions=0,Answer=0,NewAnswer=0,LevelID=1,ExamID=examid,Marks=1,Image=0,Status=2,ResonableTime=127,count=0;
	 	String Question="",Option1="",Option2="",Option3="",Option4="",Option5="",Explanation="NA",RRN="NA",QuestionID="",CodeID="01000000";
	 	String InsertionDate=null;
	 	String UpdateValidityDate=null;Timestamp tm=null;HashMap hm = new HashMap();
	 	
	 	try{
	 	
	 	    javax.servlet.ServletConfig myconf = getServletConfig();
			String fDir = myconf.getServletContext().getRealPath( request.getServletPath() );
			System.out.println("fDir :"+fDir);
			System.out.println("request.getServletPath() :"+request.getServletPath());
			fDir = fDir.substring(0, fDir.lastIndexOf( System.getProperty( "file.separator") ) );
			filepath = fDir + System.getProperty("file.separator");
			System.out.println("filepath :"+filepath);
  			// Open the file that is the first 
  			// command line parameter
  			filename=request.getParameter("filename");
		    fileList=request.getParameter("fileList");
			System.out.println("filename	:"+filename);
 			System.out.println("fileList	:"+fileList);
            //File f=new File("/opt/tomcat/webapps/nectar"+fileList);
            File f=new File(filepath+"upload/"+fileList);
            FileInputStream fs = new FileInputStream(f);
            InputStreamReader in = new InputStreamReader(fs);
            BufferedReader br = new BufferedReader(in);
  			File file = new File(filename);
  			System.out.println("file path	:"+file.getAbsolutePath());
  			BufferedWriter bw = new BufferedWriter(new FileWriter(filepath+"download/"+file));
  			String strLine;
			StringBuffer sb = new StringBuffer();
  			//Read File Line By Line
  			String que="";String que1="";
			int k=0;
  			while ((strLine = br.readLine()) != null)   
  			{
				rowcount++;Vector vec=new Vector();
				//System.out.println("rowcount :"+rowcount);
				////System.out.println("strLine :"+strLine);
	 			////System.out.println (strLine);
     			// Print the content on the console
      			StringTokenizer st2 = new StringTokenizer(strLine, ":");
      			//k=0;
	  			while (st2.hasMoreElements()) 
	  			{
  	 				que = (String)st2.nextElement();
  	  				vec.add(que);
				  	////System.out.println("que :"+que);
					////System.out.println("InsertionDate :"+tm);
			  	 }
				
				hm.put(String.valueOf(rowcount),vec);
				
  			}
				////System.out.println("Hash size :"+hm.size());
				int i=1;
				if(queNumber>0)
				{
				  i=queNumber;
				}
				for(i=1;i<=hm.size();i++)
				{
					//System.out.println("hash "+i+":"+hm.get(String.valueOf(i)));
					Vector vec = (Vector)hm.get(String.valueOf(i));
					//System.out.println("vec size"+vec.size());
					//System.out.println("hash ele at 0"+((String)vec.get(0)));
					//System.out.println("hash ele at 1:"+((String)vec.get(1)));
					for(int l=0;l<vec.size();l++)
					{
						switch(l)
						{
							case 0:
							Question = (String)vec.get(0);
							case 1:
							NoOfOptions = (Integer.parseInt((String)vec.get(1)));
							case 2:
							Option1 = (String)vec.get(2);
							case 3:
							Option2 = (String)vec.get(3);
							/*if(NoOfOptions<3)
							//System.out.println("NoOfOptions :"+NoOfOptions);
							//System.out.println("Option2 :"+Option2);*/
							break;
							case 4:
							Option3 = (String)vec.get(4);
							case 5:
							Option4 = (String)vec.get(5);
							case 6:
							Option5 = (String)vec.get(6);
							case 7:
							Answer = (Integer.parseInt((String)vec.get(7)));
							NewAnswer = Answer;
							//case 8:
							//NewAnswer = (String)vec.get(8);
						}
						
						count=i;
						//System.out.println("value of examid :"+examid);
						//System.out.println("value of flag :"+flag);
						
										
						if(flag.equals("doNewExam"))
						{
						    if(count<=9)
							{
							   QuestionID = String.valueOf(examid) + "00"+queNumber;
							   //System.out.println("doNewExam if(count<=9) queNumber :"+queNumber);
							}
							else
							{
							    QuestionID = String.valueOf(examid) + "0"+queNumber;
							    //System.out.println("doNewExam In else queNumber :"+queNumber);
							}
							
						}
						else if (flag.equals("AddQuestion"))
						{
						        if(examid>=10500)
						        {
							        if((examid-10500)<=9)
									{
									   QuestionID = String.valueOf(examid) + "00"+queNumber;
									   //System.out.println("AddQuestion if(count<=9) queNumber :"+queNumber);
									}
									else
									{
									    //QuestionID = String.valueOf(examid) + "0"+queNumber;
									    QuestionID = String.valueOf(queNumber);
									    //System.out.println("AddQuestion In else queNumber :"+QuestionID);
									}
								}else
								{
									QuestionID = String.valueOf(queNumber);
								}
						 }
						
						//System.out.println("value of QuestionID :"+QuestionID);
						
					}
					queNumber++;
					
					//System.out.println("k :"+k);
				  	//System.out.println("Question :"+Question);
				  	//System.out.println("NoOfOptions :"+NoOfOptions);
				  	//System.out.println("Option1 :"+Option1);
				  	//System.out.println("Option2 :"+Option2);
				  	//System.out.println("Option3 :"+Option3);
				  	//System.out.println("Option4 :"+Option4);
				  	//System.out.println("Option5 :"+Option5);
				  	//System.out.println("Answer :"+Answer);
				  	//System.out.println("NewAnswer :"+NewAnswer);
					
					  java.util.Date date1= new java.util.Date();
					  tm=new Timestamp(date1.getTime());
					  
					  sb.append("INSERT INTO questionmaster(QuestionID,CodeID,PartyID,Question,ExamType,NoOfOptions,Option1," +
								"Option2,Option3,Option4,Option5,Answer,NewAnswer,Explanation,LevelID,ExamID,InsertionDate," +
								"UpdateValidityDate,Status,Image,ResonableTime,Marks,RRN)");


						  sb.append(" VALUES ('"+QuestionID+"','"+CodeID+"',"+PartyID+",'"+Question+"','"+ExamType+"',"+NoOfOptions+","+
							   "'"+Option1+"','"+Option2+"','"+Option3+"','"+Option4+"','"+Option5+"',"+Answer+","+NewAnswer+"," +
								"'"+Explanation+"','"+LevelID+"','"+ExamID+"','"+tm+"','"+tm+"'," +
								""+Status+","+Image+","+ResonableTime+","+Marks+",'"+RRN+"');");
					  sb.append("\n");
					 
					 
					}
			//System.out.println("Question :"+sb);
			bw.write(sb.toString());
			bw.newLine();
		    in.close();
  			bw.close();
		 }catch (Exception e){//Catch exception if any
  		
  		System.err.println("Error: " + e.getMessage());
  		
  }%>
            <div align="center">
		    <br/><br/>
		    <font align="center">The generated sql script can be download from following links  </font><br/><br/>
			<table align="center">
			<tr><th>File Name</th><th>Download File</th>
			<%
					//File f = new File("/opt/tomcat/temp/");
					File f = new File(filepath+"download/");
			        FileFilter fileFilter = new WildcardFileFilter("*.sql");
					File[] files = f.listFiles(fileFilter);
			        for(int i=0;i<files.length;i++){
			        String name=files[i].getName();
			        String path=files[i].getPath();
			%><tr><td><%=name%></td><td><a href="download.jsp?f=<%=path%>">Download File</a></td></tr>
		    <%}%>
		</table>
  <%} %>
</body>
</html>
