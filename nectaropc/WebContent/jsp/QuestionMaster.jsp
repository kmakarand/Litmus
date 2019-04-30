<html>
<head>
<title>Question Data Entry</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<LINK REL="stylesheet" TYPE="text/css" HREF="../alm.css">
</head>
<body>
<center>

<%@page import="java.sql.*,com.ngs.gen.*" session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<%!
String name="",b="",first="",second="",third="",fourth="";
int fr=0,scd=0,td=0,foth=0;
String subname="",chapname="",topname="",subtopname="";
String subcode="",chapcode="",topcode="",subtopcode="";
ResultSet rs1=null,rs2=null,rs3=null,rs4=null,rs5=null;
Connection con1=null;
Statement st1=null;
String vexamid,vsubjectid,vQuestion,vansopts,vlevel1,vOption1,vOption2,vOption3,vOption4,vOption5,txaExp,vans;
int curExamId;
%>
<%
try{
	pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
    con1 = pool.getConnection();
	st1 = con1.createStatement();
}catch(Exception e){
	response.sendRedirect("Login.jsp");
}
%>

<%
String action=request.getParameter("action");
String chapterId = request.getParameter("chapter");
String username = (String)session.getValue("username");
String cpage = request.getParameter("page");
String examid = request.getParameter("ExamID");
cpage = (cpage==null || cpage=="")?"1":cpage;

if (action == null || action == "" || action.equalsIgnoreCase("modify")){
%>
<script language='JavaScript'>
var radio_selection="";
var flag=false;
function checkIfEmpty() {
	if ( document.f1.txaQuestion.value == "" ) {
		alert("Question cant be empty");
		document.f1.txaQuestion.focus();
		return false;
	}
	if ( document.f1.txtOption1.value == "" ) {
		alert("option1 cant be empty");
		document.f1.txtOption1.focus();
		return false;
	}
	if ( document.f1.txtOption2.value == "" ) {
		alert("option2 cant be empty");
		document.f1.txtOption2.focus();
		return false;
	}
	if ( document.f1.level1.value == "" ) {
		alert("Level cant be empty");
		document.f1.level1.focus();
		return false;
	}
}//Function ends Here
</script>
<%}%>

<% if (action == null || action == ""){
  try{ %>
<Form action="QuestionMaster.jsp?ExamID=<%=examid%>&chapter=<%=chapterId%>&page=<%=cpage%>" method="POST" name="f1" onsubmit="return checkIfEmpty()">
<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>
  <tr>
        <th colspan=2>Question Data Entry</th>
      </tr>
      <tr>
        <td align="right">Exam :</td>
        <td>
          <select name="examid">
          <%
	         rs1=st1.executeQuery("Select * from ExamMaster where ExamID="+examid);
	         while(rs1.next()){
	      %>
            <OPTION VALUE="<%= rs1.getString("ExamID")%>"><%= rs1.getString("Exam")%></option>
            <%}%>
          </SELECT>
        </td>
      </tr>
      <tr>
        <td align="right">Test Name :</td>
        <td>
          <select name="subjectid">
            <%
				rs2=st1.executeQuery("Select * from CodeMaster where ExamID="+examid+" ORDER BY Description asc");
				while(rs2.next()){
	   	  	%>
            <OPTION VALUE="<%= rs2.getString("CodeID")%>"
				<%= (rs2.getString("Description").equals("Introductions,Futures,Forwards"))?" SELECTED":""%>>
            <%= rs2.getString("Description")%>
            <%}%>
          </SELECT>
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">Question : </td>
        <td colspan="2">
          <textarea name="txaQuestion" rows="4" cols="50"></textarea>
        </td>
      </tr>
      <tr>
        <td align="right">No of Options : </td>
        <td colspan="2">
          <SELECT name="ansopts">
            <OPTION VALUE="2">&nbsp;2&nbsp;</OPTION>
            <OPTION VALUE="3">&nbsp;3&nbsp;</OPTION>
            <OPTION VALUE="4" Selected>&nbsp;4&nbsp;</OPTION>
          </SELECT>
          Level :
          <select name="level1">
            <% rs4=st1.executeQuery("Select * from LevelMaster where ExamID="+examid+" ORDER BY LevelID asc");
		  	while(rs4.next()){%>
            <OPTION VALUE="<%= rs4.getString("LevelID")%>"> <%=rs4.getString("Level")%>
            <%}%>
          </SELECT>
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">Option 1 :
          <input checked type="checkbox" value="1" name="radOption">
        </td>
        <td colspan="2">
          <input type="text" name="txtOption1" size="20">
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">Option 2 :
          <input type="checkbox" value="2" name="radOption">
        </td>
        <td colspan="2">
          <input type="text" name="txtOption2" size="20">
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">Option 3 :
          <input type="checkbox" value="3" name="radOption">
        </td>
        <td colspan="2">
          <input type="text" name="a31" size="20">
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">Option 4 :
          <input type="checkbox" value="4" name="radOption">
        </td>
        <td colspan="2">
          <input type="text" name="a41" size="20">
        </td>
      </tr>
      <tr>
        <td align="right" valign="top">Explanation : </td>
        <td colspan="2">
          <textarea name="exp1" rows="4" cols="50"></textarea>
        </td>
      </tr>
      <%
		    }catch (Exception e1){
			    	out.println(" Question not present for id :"+e1.getMessage());
			}finally{
				if (con1 != null)
			        pool.releaseConnection(con1);
				else
					out.println ("Error while Connecting to Database.");
			}
		%>
      <tr>
        <th colspan=2>
          <input type="submit" value="Add More"> &nbsp;
          <input type="HIDDEN" name=action value="AddQuestion">
		  <input type="HIDDEN" name=mode value="more">
          &nbsp;
          <input type="submit" value="Finish" onclick="document.f1.mode.value='finish';">
          &nbsp;
		  <input type="button" value="Cancel" onclick="javascript:window.location='Questions.jsp?ExamID=<%=examid%>&page=<%=cpage%>&chapter=<%=chapterId%>'">
          &nbsp;
          <input type="reset" value="Reset" >
        </th>
      </tr>
    </table>
	</form>
    <%}else if(action.equals("AddQuestion")){
		String sqlPstmt = "INSERT INTO QuestionMaster (`QuestionID`, `CodeID`, `PartyID`, `Question`,`ExamType`,`NoOfOptions`, `Option1`, `Option2`, `Option3`, `Option4`, `Answer`, `NewAnswer`, `Explanation`, `LevelID`, `ExamID`, `InsertionDate`, `Marks`, `RRN`) "+
					  " VALUES(?,?,NULL,?,NULL,?,?,?,?,?,?,?,?,?,?, NOW(),?,?)";
		PreparedStatement pstmt = con1.prepareStatement(sqlPstmt);

		vexamid=request.getParameter("examid");
		vsubjectid=request.getParameter("subjectid");
		vQuestion=request.getParameter("txaQuestion");
		vansopts=request.getParameter("ansopts");
		vlevel1=request.getParameter("level1");
		vOption1=request.getParameter("txtOption1");
		vOption2=request.getParameter("txtOption2");
		vOption3=request.getParameter("a31");
		vOption4=request.getParameter("a41");
		txaExp=request.getParameter("exp1");
		vans=request.getParameter("radOption");
	    NextValues nvQuestionID    =   new NextValues("QuestionMaster", "QuestionID");
      	int nextQuestionID = nvQuestionID.getNextValue();
     	boolean val    =   nvQuestionID.setNextValue();
		int ivexamid = Integer.parseInt(vexamid);
        pstmt.setInt(1,nextQuestionID);
		pstmt.setString(2,vsubjectid);
		pstmt.setString(3,vQuestion);
		pstmt.setString(4,vansopts);
		pstmt.setString(5,vOption1);
		pstmt.setString(6,vOption2);
		pstmt.setString(7,vOption3);
		pstmt.setString(8,vOption4);
		pstmt.setString(9,vans);
		pstmt.setString(10,vans);
		pstmt.setString(11,txaExp);
		pstmt.setString(12,vlevel1);
		pstmt.setInt(13,ivexamid);
		pstmt.setString(14,vlevel1);
		pstmt.setString(15,"500");

		pstmt.executeUpdate();

		if(request.getParameter("mode").equalsIgnoreCase("more")){
			response.sendRedirect("QuestionMaster.jsp?ExamID="+examid+"&page="+cpage+"&chapter="+chapterId);
		}else{
			response.sendRedirect("Questions.jsp?ExamID="+examid+"&chapter=" + chapterId);
		}
	}else if(action.equalsIgnoreCase("modify")){
			int vstr2= Integer.parseInt(request.getParameter("qid"));
			ResultSet tmpRes = con1.createStatement().executeQuery("select * from QuestionMaster where QuestionID="+vstr2);
			int examId = 0;
			String codeId = "";
			int levelId=0,noOfOptions=4;
			if(tmpRes.next()){
				examId = tmpRes.getInt("ExamID");
				codeId = tmpRes.getString("CodeID");
				levelId = tmpRes.getInt("LevelID");
				noOfOptions = tmpRes.getInt("NoOfOptions");
			}else{
				response.sendRedirect(request.getRequestURI());
			}
	%>
	    <Form action="?action=modifysubmit&ExamID=<%=examid%>&qid=<%= vstr2%>&page=<%=cpage%>&chapter=<%=chapterId%>" method="POST" name="f1">
	      <TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>
	        <tr>
	          <th colspan=2>Question Data Entry</th>
		        </tr>
		        <tr>
		          <td align="right">Exam :</td>
		          <td>
		            <select name="examid">
		              <%
		                   examid = request.getParameter("ExamID");
		              	   System.out.println("examid examid:"+examid);
						   rs2=con1.createStatement().executeQuery("Select * from ExamMaster where ExamID="+examid);
		  	             // Change ORDER BY  Exam asc
		  	             while(rs2.next()){
						 	curExamId = rs2.getInt("ExamID");
						 	
		  	          %>
		              <OPTION VALUE="<%=curExamId%> <%if(examId==curExamId){%> selected <%}%>">
		              	<%= rs2.getString("Exam") %>
		  				<%} System.out.println("curExamId:"+curExamId);%>
		            </SELECT>
		          </td>
		        </tr>
		        <tr>
		          <td align="right">Test Name :</td>
		          <td>
		            <select name="subjectid">
		              <%
		  				rs2=con1.createStatement().executeQuery("Select * from CodeMaster where ExamID="+curExamId+" ORDER BY Description asc");
		  				while(rs2.next()){
		  	   	  	%>
		              <OPTION VALUE="<%= rs2.getString("CodeID")%>"
					  <%= codeId.equals(rs2.getString("CodeID"))?" SELECTED":""%>>
		              <%= rs2.getString("Description")%></OPTION>
		              <%}%>
		            </SELECT>
		          </td>
		        </tr>
		        <%
			        rs3=st1.executeQuery("Select * from QuestionMaster where QuestionID='"+vstr2+"'");
		        %>
		        <tr>
		          <td align="right" valign="top">Question : </td>
		          <td colspan="2">
		          <%if(rs3.next()) {%>
			      <textarea name="txaQuestion" rows="4" cols="50"><%= rs3.getString("Question")%></textarea>

		          </td>
		        </tr>
		        <tr>
		          <td align="right">No of Options : </td>
		          <td colspan="2">
		            <SELECT name="ansopts">
		              <OPTION VALUE="2" <%= noOfOptions==2?"selected":""%>>&nbsp;2&nbsp;</OPTION>
		              <OPTION VALUE="3" <%= noOfOptions==3?"selected":""%>>&nbsp;3&nbsp;</OPTION>
		              <OPTION VALUE="4" <%= noOfOptions==4?"selected":""%>>&nbsp;4&nbsp;</OPTION>
		            </SELECT>
		            <%}%>
		            Level :
		            <select name="level1">
		              <% rs1=con1.createStatement().executeQuery("Select distinct(level),LevelID from LevelMaster ORDER BY LevelID asc");
							int curLevelId = 0;
		  		  		while(rs1.next()){
							curLevelId = rs1.getInt("LevelID");
						%>
		              <OPTION VALUE="<%= curLevelId%>"
					  		<%= levelId==curLevelId?" selected":""%>>
					  	<%=rs1.getString("Level")%>
		              <%}%>
		            </SELECT>
		          </td>
		        </tr>
		        <% rs4=con1.createStatement().executeQuery("Select * from QuestionMaster where QuestionID='"+vstr2+"'");
		           while(rs4.next()){
		             String vselAns = String.valueOf(rs4.getInt("Answer"));
		             String tmp1=rs4.getString("Option1");
		             String tmp2=rs4.getString("Option2");
		             String tmp3=rs4.getString("Option3");
		             String tmp4=rs4.getString("Option4");
		             if(tmp1.trim().toLowerCase().startsWith("no option") ||
					 	tmp1.trim().toLowerCase().startsWith("nooption")){
				  		tmp1="";
					}
		            if(tmp2.trim().toLowerCase().startsWith("no option") ||
						tmp2.trim().toLowerCase().startsWith("nooption")){
			     	  tmp2="";
			     	}
		             if(tmp3.trim().toLowerCase().startsWith("no option") ||
					 	tmp3.trim().toLowerCase().startsWith("nooption"))	{
			     	  tmp3="";
			     	}
		            if(tmp4.trim().toLowerCase().startsWith("no option") ||
						tmp4.trim().toLowerCase().startsWith("nooption")){
			     	  tmp4="";
			     	}
		          %>
		        <tr>
		          <td align="right" valign="top">Option 1 :
		            <input type="checkbox" value="1" name="radOption" <%= (vselAns.equals("1")?"checked":"")%>>
		          </td>
		          <td colspan="2">
		            <input type="text" name="txtOption1" value="<%= tmp1%>" size="20">
		          </td>
		        </tr>
		        <tr>
		          <td align="right" valign="top">Option 2 :
		            <input type="checkbox" value="2" name="radOption" <%= (vselAns.equals("2")?"checked":"")%>>
		          </td>
		          <td colspan="2">
		            <input type="text" name="txtOption2" value="<%= tmp2%>" size="20">
		          </td>
		        </tr>
		        <tr>
		          <td align="right" valign="top">Option 3 :
		            <input type="checkbox" value="3" name="radOption" <%= (vselAns.equals("3")?"checked":"")%>>
		          </td>
		          <td colspan="2">
		            <input type="text" name="a31" value="<%= tmp3%>" size="20">
		          </td>
		        </tr>
		        <tr>
		          <td align="right" valign="top">Option 4 :
		            <input type="checkbox" value="4" name="radOption" <%= (vselAns.equals("4")?"checked":"")%>>
		          </td>
		          <td colspan="2">
		            <input type="text" name="a41" value="<%= tmp4%>" size="20">
		          </td>
		        </tr>
		        <tr>
		          <td align="right" valign="top">Explanation : </td>
		          <td colspan="2">
		            <textarea name="exp1" rows="4" cols="50"><%= rs4.getString("Explanation")%></textarea>
					<%}%>
		          </td>
		        </tr>
		        <tr>
			        <th colspan=2>
			          <input type="submit" value="Modify" OnClick="return checkIfEmpty()">
			          <input type="Button" value="Cancel" OnClick="window.location='Questions.jsp?ExamID=<%=examid%>&&page=<%=cpage%>&chapter=<%=chapterId%>'">
			          <input type="reset" value="Reset" >
			        </th>
			      </tr>
			   </table>
			   </form>
		<% }
		  else if(action.equals("modifysubmit")) {
			try
			{
				String sqlPstmt = "Update QuestionMaster " +
						"set Question=?,CodeID=?,NoOfOptions=?,Option1=?,Option2=?,Option3=?,Option4=?,"+
						" Answer=?,NewAnswer=?,Explanation=?,LevelID=?,ExamID=?,Marks=? "+
						" where QuestionID=?";
				PreparedStatement pstmt = con1.prepareStatement(sqlPstmt);

				int vstr2= Integer.parseInt(request.getParameter("qid"));
		    	vsubjectid=request.getParameter("subjectid");
				vQuestion=request.getParameter("txaQuestion");
				vansopts=request.getParameter("ansopts");
				vlevel1=request.getParameter("level1");
				vOption1=request.getParameter("txtOption1");
				vOption2=request.getParameter("txtOption2");
				vOption3=request.getParameter("a31");
				vOption4=request.getParameter("a41");
				vOption5=request.getParameter("a51");
				txaExp=request.getParameter("exp1");
				vans=request.getParameter("radOption");
				int iexamid = Integer.parseInt(request.getParameter("ExamID"));
				
				System.out.println("modifysubmit examid :"+examid);
	
				pstmt.setString(1,vQuestion);
				pstmt.setString(2,vsubjectid);
				pstmt.setString(3,vansopts);
				pstmt.setString(4,vOption1);
				pstmt.setString(5,vOption2);
				pstmt.setString(6,vOption3);
				pstmt.setString(7,vOption4);
				pstmt.setString(8,vans);
				pstmt.setString(9,vans);
				pstmt.setString(10,txaExp);
				pstmt.setString(11,vlevel1);
				pstmt.setInt(12,iexamid);
				pstmt.setString(13,vlevel1);
				pstmt.setString(14,vstr2+"");
				pstmt.executeUpdate();

			response.sendRedirect("Questions.jsp?ExamID="+examid+"&page="+cpage + "&chapter="+chapterId);
		 }catch(Exception e){
		 	out.print("Could not update!"+e.getMessage());
		 }finally{
		 	if(con1!=null)pool.releaseConnection(con1);
		 }
		 }%>
</center>
</body>
</html>
