<%@ page language="java" import="java.sql.*"  session="true"%>
<%@page import="org.apache.commons.lang3.StringUtils"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<!doctype html>
<html>
	<head>
		<meta charset="utf-8">
		<title>MainPage</title>
		<meta name="generator"
			content="WYSIWYG Web Builder 10 Trial Version - http://www.wysiwygwebbuilder.com">
		<link href="Nectar.css" rel="stylesheet">
		<link href="MainPage.css" rel="stylesheet">
	</head>
	<body>
		<div id="PageHeader2"
			style="position: absolute; overflow: hidden; text-align: left; left: 0px; top: 0px; width: 100%; height: 1px; z-index: 6;">
		</div>

		<iframe name="MainDisplayPage" id="InlineFrame1"
			style="position: absolute; left: 20px; top: 239px; width: 1163px; height: 459px; z-index: 2;"
			src=""></iframe>
		<div id="wb_CssMenu1"
			style="position: absolute; left: 314px; top: 78px; width: 787px; height: 29px; z-index: 3;">
			<%
			
			Class.forName("com.mysql.jdbc.Driver");
		    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nectar", "nectar", "nec76tar");
			
			Statement stmtMB,stmt1MB,stmt2MB,stmt3,stmtchecked=null;
			ResultSet rsMB,rs1MB,rs2MB,rs3,rschecked=null;
			String rightname="";
			String MenuName =null;
			String GroupName=null;
			String groupid=null;
			String Username=null;
			String CandidateID=null;
			String menuid=null;
			String MenuID=null;
			String Command=null;
			
			int integerMenuID=0;
			Statement stmt1 = con.createStatement();
			ResultSet rs1 =stmt1.executeQuery("select * from HierarchyMenu ORDER BY MenuID");
			while(rs1.next()){
				 MenuID=rs1.getString("MenuID");
				 Command=rs1.getString("url");
				 MenuName =rs1.getString("MenuName");
			     //integerMenuID=Integer.parseInt(MenuID);
			     int count = StringUtils.countMatches(MenuID, ".");%>
			     <ul>
			     <%if(count==0 && StringUtils.startsWith(MenuID,"1"))
			     {
			     System.out.println("MenuID	:"+MenuID);
			     System.out.println("MenuName	:"+MenuName);
			     System.out.println("MenuName Startswith	:"+StringUtils.startsWith(MenuID,"1"));%>
			     <%=MenuName%>
			     <li class="firstmain">
					<a class="withsubmenu" href="#" target="_self" title="<%=MenuName%>"><%=MenuName%></a><ul>
				 <%}if(count>0 && StringUtils.startsWith(MenuID,"1"))
				 {
				 System.out.println("MenuID	->"+MenuID);
			     System.out.println("MenuName	->"+MenuName);
			     System.out.println("Command	->"+Command);
			     System.out.println("count	->"+count);
			     System.out.println("MenuName Startswith	->"+StringUtils.startsWith(MenuID,"1"));
			     System.out.println("MenuName endswith	->"+StringUtils.endsWith(MenuID,"1"));
			     
			     		if(count>0 && StringUtils.startsWith(MenuID,"1") && StringUtils.endsWith(MenuID,"1")){%>
						<li class="firstitem">
							<a href="<%=Command%>"
								target="MainDisplayPage" title="<%=MenuName%>"><%=MenuName%></a>
						</li>
						<%}else{%>
						<li>
							<a href="<%=Command%>"
								target="MainDisplayPage" title="<%=MenuName%>"><%=MenuName%></a>
						</li>
						<%}%>
						
				 
				<%}%>
				
				<%}%></ul></li>
			</ul>
			<br>
		</div>
		<div id="wb_Image1"
			style="position: absolute; left: 156px; top: 12px; width: 120px; height: 120px; z-index: 4;">
			<img src="simages/logoN1.jpg" id="Image1" alt="">
		</div>
		<div id="wb_Image2"
			style="position: absolute; left: 458px; top: 27px; width: 461px; height: 26px; z-index: 5;">
			<img src="simages/newlogo.jpg" id="Image2" alt="">
		</div>
	</body>
</html>