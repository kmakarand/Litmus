

<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>

</head>
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>
<div align="center">
  <p><br>
    <font size="3" face="Arial, Helvetica, sans-serif"><b><font size="5" color="#000099">Rights Revise Console</font></b></font></p>
  <p align="left"> ____________________________________________________________________________________________</p>
  <p align="left"> </p>

<BODY bgColor=#FEF9E2>
<%
int q=0;
int rights=0;
Connection conMB=null;
Statement stmtMB,stmt1MB,stmt2MB,stmt3=null;
ResultSet rsMB,rs1MB,rs2MB,rs3=null;
String username = (String) session.getValue("username");
String rightname=(String) session.getValue("rightname");
out.print("Final Menu Clone for user:   <b>"+rightname+"<b>");

String groupidMB="",menuidMB="",url="",mainGroupid="",groupxid="";
int targetFrame=0;
try{

      //If the pool is not initialised
        conMB = pool.getConnection();

		stmt1MB = conMB.createStatement();
	    rs1MB = stmt1MB.executeQuery("select * from CandidateMaster where Username='" +username+ "'");

		 while(rs1MB.next()){
		mainGroupid=rs1MB.getString("Username");

	    }//end of if(conMB!=null) to get the group ID
%>
<script language="javascript">

function NewWindow(url)
{

var anil = window.open(url,"HelpWindow","width=750,height=450,resizable=no,scrollbars=yes, left=20, top=20");

}




menuArray = new Array();
<%
		stmtMB = conMB.createStatement();
		stmt3 = conMB.createStatement();

rs3=stmt3.executeQuery("select * from UserGroupXRef where Username=\'"+rightname+"\' ");
	while(rs3.next()){
		groupxid=rs3.getString("GroupID");


rsMB =stmtMB.executeQuery("select * from MenuRights where GroupID=\'"+groupxid+"\' OR Username =\'"+username+"\' ORDER BY MenuID ASC");
		while(rsMB.next()){
		groupidMB=rsMB.getString("MenuID");

		//SELECT * FROM MenuRights WHERE GroupID='00' ORDER BY MenuID ASC
		stmt2MB = conMB.createStatement();
rs2MB = stmt2MB.executeQuery("SELECT * FROM MenuMaster WHERE MenuID=\'"+groupidMB+"\' ORDER BY MenuID ASC");
				while(rs2MB.next()){
				menuidMB=rs2MB.getString("MenuName");
				url=rs2MB.getString("Command");

%>

menuArray[<%out.print(q);%>]="<%out.print(groupidMB);%> <%out.print(menuidMB);%>;<%out.print(url);%>;";


<%
    q++;
			}
		 }//end of if(conMB!=null)
    }//end of try
 }//end of user groupX ref
    catch (Exception e)   {
		   out.print("Exception pinjo!!!!!!  "+e);
		}
%>

sss="<table border=0 cellspacing=2 cellpadding=2><tr valign=top>";
for ( i=0 ; i < menuArray.length ; i++ ) {
	menuid=menuArray[i].substr(0,8);
	popArray = new Array();
	maincounter=0;
	while ( i  < menuArray.length  ) {
		if ( menuid.substr(0,2) != menuArray[i].substr(0,2) ) {
			i--;
			break;
		}
		popArray[maincounter]=menuArray[i].substr(2,menuArray[i].length);
		maincounter++;
		i++;
	}
	if ( popArray.length > 1 ) {
		urls=popArray[0].split(";");
		sss+="<td><applet width='140' height='24' archive=Popup.jar code='PopupNavigator.PopupNavigatorApplet.class'>"+ss(popArray)+"<param name='DelimiterChar' value=';'><param name='EscapeChar' value='\\'><param name='DefaultFontName' value='Menu'><param name='DefaultFontStyle' value='PLAIN'><param name='DefaultFontSize' value='12'><param name='Label' value='"+urls[0].substr(6,urls[0].length)+"';;PLAIN;10;0 0 0;176 185 180'><param name='DefaultFrame' value='main'><param name='Selection' value='RECURSIVE'><param name='ShowStatus' value=''></applet></td>";
	}
	else {
		if ( i  >= menuArray.length  )
			i--
			urls=menuArray[i].split(";");

		sss+="<td><form><input type=button value='"+urls[0].substr(8,urls[0].length)+"' onClick='top.location.href=\""+urls[1]+"\";'></form></td>"
/*
		sss+="<td><form><input type=button value='"+urls[0].substr(8,urls[0].length)+"' onClick='OpenURL(\""+urls[1]+"\","+urls[2]+");'></form></td>"
*/	}
}
sss+="</tr></table>"
document.write(sss);

function ss( menuArray1 ) {
 apptag="";
 apptag=new Array(menuArray1.length);
 for ( k=1 ; k < apptag.length ; k++ )
  apptag[k]="";
 cnt=0;
 for ( increment=0 ; increment < 6 ; increment+=2 ) {
  counter=0;
  for ( j=1 ; j < menuArray1.length ; j++ ) {
   popid="00";
   while ( j  < menuArray1.length ) {
    if ( popid != menuArray1[j].substr(increment,2)) {
     if ( menuArray1[j].substr(increment,2) != "00" ) {
      apptag[j]=apptag[j]+counter+";";
      counter++;
     }
     else {
      counter=0;
     }
    }
    else {
     if ( counter > 0 ) {
      apptag[j]=apptag[j]+(counter-1)+";";
     }
    }
    popid=menuArray1[j].substr(increment,2);
    j++;
   }
  }
  cnt+=2;
 }
 tt="";
 for ( k=1 ; k < apptag.length ; k++ ) {
  if ( apptag[k].indexOf(";") == -1 )
   apptag[k]="0";
  else
   apptag[k]=apptag[k].substr(0,apptag[k].length-1);
  tt+="<param name='"+apptag[k] + "' value='" + menuArray1[k].substr(7,menuArray1[k].length) + "'>";
 }
 return tt;
}
</script>

<%


String GroupName=null;
String groupid=null;
String Username=null;
String CandidateID=null;
String menuid=null;



try{

      //If the pool is not initialised
        Connection con = pool.getConnection();
 		Statement stmt2 = con.createStatement();

ResultSet rs2 = stmt2.executeQuery("SELECT * FROM CandidateMaster where Username='"+rightname+"'");
			while(rs2.next()){
				%>
				<br><table width="100%" cellspacing="0">
					<tr bgcolor="lightgrey">
<td>
UserName
</td><td>
				<%
				out.print(rs2.getString("Username"));

%>
	</td>
</table>
	<table width="100%" cellspacing="0">
	<tr bgcolor="darkgrey"><td>
<%
	}
out.print("Alloted Rights :");

 %></td>
	 <tr>

<%


	Statement stmt = con.createStatement();
ResultSet rs =stmt.executeQuery("select * from UserGroupXRef where Username='"+rightname+"'");
		while(rs.next()){
		groupid=rs.getString("GroupID");


rs2 = stmt2.executeQuery("SELECT * FROM GroupMaster WHERE GroupID=\'"+groupid+"\'");


	while(rs2.next()){
			menuid=rs2.getString("GroupName");
	 %>
		  </table>
 	<table width="30%" cellspacing="0" align="centre">
	<tr bgcolor="grey"><td>
<%
 out.print(menuid);
%>
</td>
</tr>
</table>
<table border="1" width="300" cellspacing="0" cellpadding="1" align="center">
<%

		}
	}

Statement stmt1 = con.createStatement();
ResultSet rs1 =stmt1.executeQuery("select * from GroupMaster");
while(rs1.next()){
	 groupid=rs1.getString("GroupID");
	 GroupName=rs1.getString("GroupName");

 %>



 <form action="/zalm/admin/backThrow.jsp" method="post">
 <tr bgcolor="#FEF5E7">
        <td><%out.print(GroupName);%></td>
        <td><input type="submit" name="Submit" value="Add"></td>
        <input type="hidden" name="groupid" value="<%out.print(groupid);%>">
        <input type="hidden" name="GroupName" value="<%out.print(GroupName);%>">

 </form>

<%
}
//this is for catching exceptions dont touch
        }
    catch (Exception e)
		{
		   out.print("Exception pinjo!!!!!!  "+e);
		}
%>

 </table>

</body>
</html>
