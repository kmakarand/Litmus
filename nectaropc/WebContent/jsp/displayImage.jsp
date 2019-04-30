<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.gen.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="com.ngs.ReadExcelFile"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html><head><title>Student Profile</title></head><body width=50%>
<!--<img src="studimages/maknsap.jpg" width="100" height="100"/>-->
<style type="text/css">
<!--
.style1 {
font-family: Georgia, "Times New Roman", Times, serif;
color: #FF0000;
}
-->
</style>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js"></SCRIPT>

<%
String action = request.getParameter("action");
String sql="";Query query=null;
Integer CandidateID = (Integer) session.getAttribute("CandidateID");
int cid = 0,lid=0,examid=0;
cid = CandidateID.intValue();
ResultSet rst=null;
List<Object[]> objList=null;
PreparedStatement pstmt=null;
EntityManager em = EntityManagerHelper.getEntityManager();
Logger log = Logger.getLogger("analysis.jsp");
CandidatemasterDAO cmDAO = new CandidatemasterDAO();
ClientmasterDAO clmDAO = new ClientmasterDAO();
pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
Connection con = pool.getConnection();
cid = Integer.parseInt(request.getParameter("candrollno"));
//System.out.println("candrollno :"+cid);

sql = "select cm.firstName,cm.lastName,cm.dateOfBirth,cm.sex,cm.email,cm.clientId,ad.address,ad.city,ad.stateId,"+
"ad.countryId,ad.pincode,ad.mobileNo,ad.typeOfAddress,ad.fax from Candidatemaster cm,Addressdetails ad where "+
"cm.candidateId=ad.candidateId and ad.typeOfAddress=1 and cm.candidateId=?1";


/*sql = "select cm from Candidatemaster cm,Addressdetails ad where "+
"cm.candidateId=ad.candidateId and ad.typeOfAddress=1 and cm.candidateId=?1";

String sql1 = "select * from CandidateMaster cm,AddressDetails ad where cm.candidateid=ad.candidateid and ad.TypeOfAddress=1 and cm.candidateid="+cid;
pstmt = con.prepareStatement(sql1);
System.out.println("ExamTestDetails pstmt :"+pstmt);
rst=pstmt.executeQuery();*/


query = em.createQuery(sql);
query.setParameter(1, cid);
objList = query.getResultList();
for(Object[] obj:objList)
{
String firstName = (String)obj[0];
String lastName = (String)obj[1];
String dateOfBirth = Utils.getFullDate(Utils.ConvertDateToString((java.util.Date)obj[2]));
int sex = (Integer)obj[3];
String email = (String)obj[4];
int clientID = (Integer)obj[5];
String address = (String)obj[6];
String city = (String)obj[7];
int state =(Integer)obj[8];
int country =(Integer)obj[9];
String picode = (String)obj[10];
String mobileNo = (String)obj[11];
int typeOfAddress =(Integer)obj[12];
String adhar = (String)obj[13];

/*System.out.println("displayImage firstName :"+firstName);
System.out.println("displayImage lastName :"+lastName);
System.out.println("displayImage dateOfBirth :"+dateOfBirth);
System.out.println("displayImage sex :"+sex);
System.out.println("displayImage email :"+email);
System.out.println("displayImage clientID :"+clientID);
System.out.println("displayImage address :"+address);
System.out.println("displayImage city :"+city);
System.out.println("displayImage state :"+state);
System.out.println("displayImage country :"+country);
System.out.println("displayImage picode :"+picode);
System.out.println("displayImage mobileNo :"+mobileNo);
System.out.println("displayImage typeOfAddress :"+typeOfAddress);*/
%>
<body>
<h2><p align="center" class="style1">STUDENT PROFILE </p></h2>
<p align="center"><img src="../jsp/studimages/maknsap.jpg" width="150" height="150" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src="../jsp/thumbimages/makthumb.jpg" width="150" height="150" /></p>
<hr/>
<table align="center" width="631">
<tr>
<th width="178" scope="row"><div align="left">Name :</div></th>
<td width="441"><div align="left"><%=firstName%>&nbsp;&nbsp;<%=lastName%></div></td>
</tr>
<tr>
<th scope="row"><div align="left">Address :</div></th>
<td width="441"><div align="left"><%=address%>,<%=city%>-<%=picode%>&nbsp;&nbsp;</div></td>
</tr>
<tr>
<th scope="row"><div align="left">Date of Birth :</div></th>
<td><div align="left"><%=dateOfBirth%></div></td>
</tr>
<tr>
<th scope="row"><div align="left">Contact No :</div></th>
<td><div align="left"><%=mobileNo%> </div></td>
</tr>
<tr>
<th scope="row"><div align="left">Email :</div></th>
<td><div align="left"><%=email%> </div></td>
</tr>
<tr>
<th scope="row"><div align="left">Adhar Card (If Available) :</div></th>
<td><div align="left"><%=adhar%></div></td>
</tr>
<tr>
<th scope="row" colspan=2><div align="center"><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></div></th>
</tr>


</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp; </p>
<%} %>
</body>
</html>

