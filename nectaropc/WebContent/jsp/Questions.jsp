<%@page import="java.sql.*,java.util.Vector,com.ngs.gen.*" session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<%! 
Connection conn = null;
Statement stmt = null;
%>
<%
try{
	pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
    conn = pool.getConnection();
	stmt = conn.createStatement();
}catch(Exception e){
	out.println(e);
//	response.sendRedirect("Login.jsp");
}
%>
<html>
<head>
<title>Question Data Entry</title>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache">
<LINK REL="stylesheet" TYPE="text/css" HREF="../alm.css">
</head>
<body leftmargin="0" topmargin="0">
<%
String action = request.getParameter("action");
String q = request.getParameter("q");
String examid = request.getParameter("ExamID");

System.out.println("action :"+action);
System.out.println("q :"+q);
System.out.println("ExamID :"+examid);

String query = "";
if(q==null || q=="" || q.equals("")){
	q = "";
	query = "";
}else{
	query = "and Question like '%" + q + "%'";
}
if (action == null || action == ""){
  try{
	String countRec = "select count(*) As TotalRec from QuestionMaster "+
			" where ExamID="+examid+" "+query;	
			
	String sql = "select Question,QuestionID from QuestionMaster " +
			" where ExamID="+examid+" "+query;
	String chapterId = request.getParameter("chapter");	
	if(chapterId==null || chapterId=="" || chapterId.equals("") || chapterId.equals("all")){
		sql += " order by QuestionID";
		chapterId="all";
	}else{
		countRec += " and CodeID="+chapterId;
		sql += " and CodeID="+chapterId + " order by QuestionID";
	}
	int currentPage = 1;
	int totalPages = 1;
	int pageSize = 10;
	int totalRec = 0;

	String strPage = request.getParameter("page");
	currentPage = (strPage == "" || strPage == null || strPage.equals("") || strPage.equals(null) ) ? currentPage : Integer.parseInt(strPage);

	String strPageSize = request.getParameter("pagesize");
	pageSize = (strPageSize == "" || strPageSize == null || strPageSize.equals("") || strPageSize.equals(null) ) ? pageSize : Integer.parseInt(strPageSize);

	ResultSet rs = stmt.executeQuery(countRec);
	if(rs.next()){
		totalRec = rs.getInt("TotalRec");
	}
	totalPages = (int)Math.ceil(totalRec/(double)pageSize);
	if(totalPages<=0) totalPages=1;
	rs = stmt.executeQuery(sql);
	rs.setFetchSize(pageSize);
%>
<form action="?" method="post" name="frmView">
<table width="100%" border="0" cellspacing="0" cellpadding="0" bgcolor="#000000">
<tr>
  <td align="center">
        <table width="100%" border="0" cellspacing="1" cellpadding="0">
          <tr align="center"> 
            <td colspan=5>
				<table width=100% cellspacing=0 cellpadding=0 border=0>
					<tr>
						<th colspan="2" align="left">Questions (Page <%= currentPage%> Of 
              						<%= totalPages%>)</th>
            			<th align="right" colspan="3">
              			<table border="0" cellspacing="0" cellpadding="0" align="right">
                		<tr>
                  			<th align="right">Chapter &nbsp;</th>
                  			<th align="center">&nbsp;
                    			<select name="chapter" onchange="document.frmView.submit()">
							<%
								String sqlChap = "select * from CodeMaster where ExamID="+examid+" order by Description";
								ResultSet rsChap = conn.createStatement().executeQuery(sqlChap);
								while(rsChap.next()){
									String codeId = rsChap.getString("CodeID");
							%>
								<option value="<%= codeId%>"
									<%= (chapterId.equals(codeId)?"selected":"")%>
									><%= rsChap.getString("Description")%></option>
							<%  }%>
								<option value="all" 
									<%= (chapterId.equals("all")?"selected":"")%>>-All-</option>
								</select>&nbsp;
							  </th>
							  <th>Search</th>
							  <th><Input type="text" name="q" value="" size=20>
							  <input type=hidden name=ExamID value="<%=examid%>">
							  </th>
							  <th><Input type="submit" name="searchSubmit" value="Go"></th>
						</tr>
						</table>
						</th>					
					</tr>
				</table>
			</td>
          </tr>
		  <% if(q.length()>0){%>
		  <tr>
			<th colspan=5 align=left height="88">Search 
              by : <I><%=q.toUpperCase()%></I></th>
		  </tr>
		  <%}%>
          <tr> 
            <th width="5%">S.No.</th>
            <th colspan="2">Question</th>
            <th width="6%">Modify</th>
            <th width="6%">Delete</th>
          </tr>
          <!--  HERE THE JSP LOOP STARTS FOR QUESTIONS -->
          <%
			int count = 1;
			int recordCount = 0;
			count = (currentPage-1)*pageSize +1;
			if(currentPage>1)
				rs.absolute(count-1);
			while(rs.next() && recordCount < pageSize){
		%>
          <tr> 
            <td width="5%" align="right">
			<A href="?action=view&qid=<%= rs.getInt("QuestionID")%>&ExamID=<%=examid%>&page=<%=currentPage%>&chapter=<%=chapterId%>&q=<%=q%>"><%= count%></A>&nbsp;&nbsp;</td>
            <td colspan="2"><%= rs.getString("Question")%></td>
            <td width="6%" align=center>
				<A HREF="?action=modify&qid=<%=rs.getInt("QuestionID")%>&ExamID=<%=examid%>&page=<%=currentPage%>&chapter=<%=chapterId%>">Modify</A></td>
            <td width="6%" align="center"><A HREF="?action=delete&ExamID=<%=examid%>&qid=<%= rs.getInt("QuestionID")%>&page=<%=currentPage%>&chapter=<%=chapterId%>&q=<%=q%>">Delete</A></td>
          </tr>
          <%		count++;
				recordCount++;
			}
		%>
          <!-- HERE THE JSP LOOP ENDS FOR QUESTIONS -->
          <tr> 
            <th align=center nowrap width="5%"> 
              <% if(currentPage>1){%>
              <A title="First" HREF="?page=1&ExamID=<%=examid%>&chapter=<%=chapterId%>&q=<%=q%>"><B>|<<</B></A>&nbsp; 
			  <A title="Previous 10 Questions" HREF="?ExamID=<%=examid%>&page=<%=currentPage-1%>&chapter=<%=chapterId%>&q=<%=q%>"><B><-</B></a> 
              <%}%>
            </th>
            <th colspan=3 align=center> 
              <Input type="button" name="Add" value="Add More" onclick="javascript:window.location='QuestionMaster.jsp?ExamID=<%=examid%>&page=<%=currentPage%>&chapter=<%=chapterId%>'">
            </th>
            <th align=center nowrap width="6%"> 
              <% if(currentPage<totalPages){%>
              <A title="Next 10 Questions" HREF="?ExamID=<%=examid%>&page=<%=currentPage+1%>&chapter=<%=chapterId%>&q=<%=q%>"><B>-></B></a> 
              &nbsp; <A HREF="?page=<%= totalPages%>&ExamID=<%=examid%>&chapter=<%=chapterId%>&q=<%=q%>" title="Last"><B>>>|</B></A> 
              <%}%>
            </th>
          </tr>
        </table>
    </td>
  </tr>
</table>
</form>
<%}catch(Exception e){
	out.println(e);
	response.sendRedirect("Login.jsp");
  }finally{
  	if(conn!=null) pool.releaseConnection(conn);
  }
}else if(action.equalsIgnoreCase("delete") || action.equalsIgnoreCase("view")){ 
  boolean isDelete = (action.equalsIgnoreCase("delete"))?true:false;
  String chapterId = request.getParameter("chapter");
  try{
	String sql = "select Question,Option1,Option2,Option3,Option4,Answer from QuestionMaster where QuestionID="+request.getParameter("qid");
	ResultSet rs = stmt.executeQuery(sql);
	Vector vOption = new Vector();
	if(rs.next()){
		vOption.add(rs.getString("Option1").trim());
		vOption.add(rs.getString("Option2").trim());
		vOption.add(rs.getString("Option3").trim());
		vOption.add(rs.getString("Option4").trim());
%>
<BR>
<BR>
<form action="?action=confirm&qid=<%= request.getParameter("qid")%>&ExamID=<%=examid%>&page=<%=request.getParameter("page")%>&chapter=<%=chapterId%>" method="post" >
<table width="400" border="0" cellspacing="0" cellpadding="0" align=center bgcolor="black">
  <tr><td>
        <table width="100%" border="0" cellspacing="1" cellpadding="0" align=center>
          <tr>
    		<th colspan=2><%= isDelete?"Confirm Delete?":"Question" %></th>
		  </tr>
		  <tr>
    		<td colspan=2>
				<table width=100% cellspacing=1 cellpadding=0 border=0>
				<tr>
					<td colspan=2><B>Ques.</B> <%= rs.getString("Question")%></td></tr>
				<% for(int i=0,count=0;i<vOption.size();i++){
						String opt = (String)vOption.elementAt(i);
						if(opt.length()==0 || opt.toLowerCase().indexOf("no option")!=-1){
							continue;
						}
						count++;
				%>
				<tr>
					
                  <td width="8%"><%=count%>. </TD>
                  <TD width="92%"><%= (String)vOption.elementAt(i)%></td>
                </tr>
				<%}%>
				<tr>
					
                  <td width="8%"><B>Ans.</B></TD>
                  <TD width="92%"><%= rs.getInt("Answer")%></td>
                </tr>
				</table>
			</td>
  		  </tr>
  		  <tr>
            <th align=center colspan=2> 
			<% if(isDelete){%>
              <INPUT type="submit" name="submit" value="Delete">
			 <%}%>
              <Input type="button" name="cancel" value="Cancel" 
			  	onclick="javascript:window.location='Questions.jsp?ExamID=<%=examid%>&page=<%=request.getParameter("page")%>&chapter=<%=chapterId%>&q=<%=q%>'"></th>
  </tr>
</table>
</td></tr></table>
</form>
<%	
	}else{
		response.sendRedirect("?page=" + request.getParameter("page"));
	}
  }catch(Exception e){
  	out.println(e);
//	response.sendRedirect("Login.jsp");
  }finally{
  	if(conn!=null) pool.releaseConnection(conn);
  }
%>
<%}else if (action.equalsIgnoreCase("confirm")){
  	try{
  		String sql = "delete from QuestionMaster where QuestionID="+request.getParameter("qid");
		int rec =   stmt.executeUpdate(sql);
	}catch(Exception e){
		out.println("Error : " + e.getMessage());
		return;
	}
	response.sendRedirect("Questions.jsp?page=" + request.getParameter("page"));
}else if(action.equalsIgnoreCase("modify")){
	response.sendRedirect("QuestionMaster.jsp?action=modify&ExamID="+examid+"&page="+request.getParameter("page")+
				 "&qid="+request.getParameter("qid") +
				 "&chapter="+request.getParameter("chapter"));
}%>
</body>
</html>
