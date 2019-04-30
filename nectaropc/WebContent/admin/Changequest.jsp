<%@ page language = "java" import = "java.sql.*,java.util.Enumeration" session="true"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<jsp:useBean id="checker" scope="page" class="com.ngs.gbl.specialChars"/>

<HTML>
<TITLE>Exam </TITLE>
<HEAD>
<style>td{font-family:arial;font-size:10pt;} body{font-family:arial;font-size:11pt;} b{font-family:arial;font-size:11pt;}</style>
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>
</HEAD>
<script language="javascript" src='validateexammasterold.js'></script>

<BODY bgcolor='#FEF9E2' onLoad="MM_preloadImages('../jsp/simages/modify2.gif', '../jsp/simages/delete2.gif', '../jsp/simages/save2.gif', '../jsp/simages/cancel2.gif', '../jsp/simages/reset2.gif')" >
<%
	Connection conn=null;
	Connection conn1=null;
	Connection conn2=null;

	int count=0;
	Statement stmt=null,stmt1=null,stmt2=null;
	ResultSet rs  = null,rs1=null,rs2=null;
	ServletContext context   =   getServletContext();
	pool		  =    (com.ngs.gbl.ConnectionPool)  getServletContext().getAttribute("ConPoolbse");

	String action=request.getParameter("action");
	if (action == "" || action == null )
	{
			conn = pool.getConnection();
			conn1 = pool.getConnection();
			conn2 = pool.getConnection();
			//System.out.println(conn);

			stmt = conn.createStatement();
			stmt1 = conn1.createStatement();
			stmt2 = conn2.createStatement();

			String sql="SELECT max(QuestionID) FROM QuestionMasterBK";
			rs=stmt.executeQuery(sql);

			int rec=0;
			while(rs.next())
			{
				count=rs.getInt(1);
			}
			String sqlstring="select * from QuestionMasterBK where ExamID=24";

				try
				{
					rs1=stmt1.executeQuery(sqlstring);
				}
				catch(Exception e1)
				{
					out.println("Insertion Error : " + e1.getMessage());
				}
			String space=new String(" ");
			while(rs1.next())
			{
				//System.out.println("Enter");
				count++;
sql =sql="insert into QuestionMasterBK (QuestionID,CodeID,PartyID,Question,ExamType,NoOfOptions,Option1,Option2,Option3,Option4,Option5,Answer,NewAnswer,Explanation,LevelID,ExamID,ResonableTime,Status) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";

PreparedStatement pst1 = conn.prepareStatement(sql);

String pid = rs1.getString("PartyID");
String Question = rs1.getString("Question");
String Option1 = rs1.getString("Option1");
String Option2 = rs1.getString("Option2");
String Option3 = rs1.getString("Option3");
String Option4 = rs1.getString("Option4");
String Option5 = rs1.getString("Option5");
String Exp = rs1.getString("Explanation");

//System.out.println(pid);
//System.out.println(Question);
//System.out.println(Option1);
//System.out.println(Option2);
//System.out.println(Option3);
//System.out.println(Option4);
//System.out.println(Option5 );
//System.out.println(Exp);
//System.out.println();
//System.out.println();
pst1.setInt(1,count);
pst1.setString(2,"04000000");

if(pid!=null) pst1.setString(3,pid);
else pst1.setString(3,"");
if(Question!=null)	pst1.setString(4,Question);
else pst1.setString(4,"");

pst1.setInt(5,rs1.getInt("ExamType"));
pst1.setInt(6,rs1.getInt("NoOfOptions"));

if(Option1!=null) pst1.setString(7,Option1);
else pst1.setString(7,"");
if(Option2!=null) pst1.setString(8,Option2);
else pst1.setString(8,"");
if(Option3!=null) pst1.setString(9,Option3);
else pst1.setString(9,"");
if(Option4!=null) pst1.setString(10,Option4);
else pst1.setString(10,"");
if(Option5!=null) pst1.setString(11,Option5);
else pst1.setString(11,"");

pst1.setInt(12,rs1.getInt("Answer"));
pst1.setInt(13,rs1.getInt("NewAnswer"));

if(Exp!=null) pst1.setString(14,Exp);
else  pst1.setString(14,"");

pst1.setInt(15,rs1.getInt("LevelID"));
pst1.setInt(16,27);
pst1.setInt(17,150);
pst1.setInt(18,rs1.getInt("Status"));


				try
				{

					 pst1.executeQuery();
				}
				catch(Exception e)
				{
					out.println("Error : " + e.getMessage());
				}

		}
	}
%>
</body>
</html>
