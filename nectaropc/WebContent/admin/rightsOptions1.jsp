<!--
Developer    : Pinjo P Kakkassery
Organisation : Nectar Global Services
Project Code : ZALM
DOS	         : 02 - 02 - 2001
DOE          : 30 - 06 - 2001
-->




<%@ page language="java" import="java.sql.*"  session="true"%>
<jsp:useBean id="pool" scope="page" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<title> Usernames </title>

</head>
<SCRIPT LANGUAGE=JavaScript src="../jsp/common.js"></SCRIPT>
 <font size="3" face="Arial, Helvetica, sans-serif"><b><font size="3" color="#000099">Rights Revise Console</font></font></p><bgcolor="#FEF5E7">
  __________________________________________________________________________________________________
 <%
int q=0;
int rights=0;
Connection conMB,con=null;
Statement stmtMB,stmt1MB,stmt2MB,stmt3,stmt2=null;
ResultSet rsMB,rs1MB,rs2MB,rs3,rs2=null;
String username = (String) session.getValue("username");
String rightname=request.getParameter("right");
out.print("Final Menu Clone for user:   <b>"+rightname+"<b>");


String groupidMB="",menuidMB="",url="",mainGroupid="",groupxid="";
int targetFrame=0;
try{

      //If the pool is not initialised
         if(pool.getDriver()==null)	     {
            ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

          }
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
		groupxid=rs3.getString("GroupId");


rsMB =stmtMB.executeQuery("select * from MenuRights where GroupId=\'"+groupxid+"\' OR Username =\'"+username+"\' ORDER BY MenuID ASC");
		while(rsMB.next()){
		groupidMB=rsMB.getString("MenuID");

		//SELECT * FROM MenuRights WHERE GroupId='00' ORDER BY MenuID ASC
		stmt2MB = conMB.createStatement();
rs2MB = stmt2MB.executeQuery("SELECT * FROM MenuMaster WHERE MenuID=\'"+groupidMB+"\' ORDER BY MenuID ASC");
				while(rs2MB.next()){
				menuidMB=rs2MB.getString("MenuName");
				url=rs2MB.getString("Command");
			%>

menuArray[<%out.print(q);%>]="<%out.print(groupidMB);%> <%out.print(menuidMB);%>;;";


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
		sss+="<td><applet width='90' height='22' archive=PopupNavigator.jar code='PopupNavigator/PopupNavigatorApplet.class'>"+ss(popArray)+"<param name='DelimiterChar' value=';'><param name='EscapeChar' value='\\'><param name='DefaultFontName' value='Courier'><param name='StatusText' value='Please select from the dropdown menu'><param name='MouseOverImage' value='/zalm/images/down_arrow3.gif'><param name='MouseOverImagePosition' value='LEFT;8'><param name='DefaultFontStyle' value='PLAIN'><param name='DefaultFontSize' value='11'><param name='Label' value='"+urls[0].substr(6,urls[0].length)+"';;RED;8;0 0 0;176 185 180'><param name='MouseoverLabel' value=';;;;GRAY;210 210 210'><param name='DefaultFrame' value='mainFrame'><param name='Selection' value='RECURSIVE'><param name='ShowStatus' value=''></applet></td>";
	}
	else {
		if ( i  >= menuArray.length  )
			i--
			urls=menuArray[i].split(";");

		sss+="<td><applet width='90' height='22' archive=PopupNavigator.jar code='PopupNavigator/PopupNavigatorApplet.class'><param name='MissingUrl' value='IGNORE'><param name='Label' value='"+urls[0].substr(8,urls[0].length)+"';;RED;8;0 0 0;176 185 180'><param name='DefaultFontName' value='Courier'><param name='DefaultFontStyle' value='PLAIN'><param name='DefaultFontSize' value='11'><param name='MouseoverLabel' value=';;;;GRAY;210 210 210'></applet></td>";
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
________________________________________________________________________________________________________
<body bgcolor="#FEF5E7">
<%

// pinjo changes has been made befor this quarter of the line only
String GroupName=null;
String groupid=null;
String Username=null;
String CandidateID=null;
String menuid=null;

//String rightname=request.getParameter("right");
%>
<table width="100%" cellspacing="0">
<tr bgcolor=#FACFAE>
<td>
Alloted ID
</td><td>
<%
out.print(rightname);
%>
</td>
</table>

<%
 session.putValue("rightname",rightname);
try{

      //If the pool is not initialised
         if(pool.getDriver()==null)	     {
            ServletContext context = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

          }
		 con = pool.getConnection();
 	 stmt2 = con.createStatement();

 rs2 = stmt2.executeQuery("SELECT * FROM CandidateMaster where Username='"+rightname+"'");
			while(rs2.next()){
				%>
				<br>
					<table width="100%" cellspacing="0">

</table>
<%
		}
%>	<table width="100%" cellspacing="0">
	<tr bgcolor=#FACFAE><td>
<%
out.print("Alloted Rights :");
%>
	</td><td>

<%


	Statement stmt = con.createStatement();
ResultSet rs =stmt.executeQuery("select * from UserGroupXRef where Username='"+rightname+"'");
		while(rs.next()){
		groupid=rs.getString("GroupId");


rs2 = stmt2.executeQuery("SELECT * FROM GroupMaster WHERE GroupId=\'"+groupid+"\'");


	while(rs2.next()){
			menuid=rs2.getString("GroupName");

	  %>
		  </td></tr></table>
 	<table width="30%" cellspacing="0" align="centre">
	<tr bgcolor="#FEF5E7"><td>
<%
 out.print(menuid);
%>
</td>
</tr>
</table>

<%
		}
	}
 %>

<%


//this is for catching exceptions dont touch
        }
    catch (Exception e)
		{
		   out.print("Exception pinjo!!!!!!  "+e);
		}
		{
        if (con != null)
            pool.releaseConnection(con);
        else
            out.println ("Error while Connecting to Database.");
        }
%>


<Form name=form1  action=backThrowSwap.jsp method=get>
<SCRIPT LANGUAGE="JavaScript">

function SelectAllOptions(box)
{
	for (var i=0;i < box.options.length; i++)
	{
		box.options[i].selected = true;
	}
}

<!-- This script and many more are available free online at -->
<!-- The JavaScript Source!! http://javascript.internet.com -->

<!-- Begin
sortitems = 1;  // Automatically sort items within lists? (1 or 0)

function move(fbox,tbox) {
for(var i=0; i<fbox.options.length; i++) {
if(fbox.options[i].selected && fbox.options[i].value != "") {
var no = new Option();
no.value = fbox.options[i].value;
no.text = fbox.options[i].text;
tbox.options[tbox.options.length] = no;
fbox.options[i].value = "";
fbox.options[i].text = "";
   }
}
BumpUp(fbox);
if (sortitems) SortD(tbox);
}
function BumpUp(box)  {
for(var i=0; i<box.options.length; i++) {
if(box.options[i].value == "")  {
for(var j=i; j<box.options.length-1; j++)  {
box.options[j].value = box.options[j+1].value;
box.options[j].text = box.options[j+1].text;
}
var ln = i;
break;
   }
}
if(ln < box.options.length)  {
box.options.length -= 1;
BumpUp(box);
   }
}

function SortD(box)  {
var temp_opts = new Array();
var temp = new Object();
for(var i=0; i<box.options.length; i++)  {
temp_opts[i] = box.options[i];
}
for(var x=0; x<temp_opts.length-1; x++)  {
for(var y=(x+1); y<temp_opts.length; y++)  {
if(temp_opts[x].text > temp_opts[y].text)  {
temp = temp_opts[x].text;
temp_opts[x].text = temp_opts[y].text;
temp_opts[y].text = temp;
temp = temp_opts[x].value;
temp_opts[x].value = temp_opts[y].value;
temp_opts[y].value = temp;
      }
   }
}
for(var i=0; i<box.options.length; i++)  {
box.options[i].value = temp_opts[i].value;
box.options[i].text = temp_opts[i].text;
   }
}
function x()
		{
	document.form1.list2.select();
	alert();
	document.form1.submit();
		}
// End -->
</script>

<!-- STEP TWO: Copy this code into the BODY of your HTML document  -->

<center>

<table border="0" bgcolor="#FEF5E7">
<tr>
<td><h4>Groups Available</h4><select multiple size="15" name="list1">
<%
Statement stmt1 = con.createStatement();
ResultSet rs1 =stmt1.executeQuery("select * from GroupMaster");
while(rs1.next()){
	 groupid=rs1.getString("GroupId");
	 GroupName=rs1.getString("GroupName");
	 %>

<option  value="<%=groupid%>"><%=GroupName%></option>
	 <%
}
	 %>
</select></td>
<td>
<input type="button" value="   >>  " onclick="move(this.form.list1,this.form.list2)" name="B1"><br>
<input type="button" value="   <<  " onclick="move(this.form.list2,this.form.list1)" name="B2">
</td>
<td><h4>Groups Alotted</h4><select multiple size="15" name="list2">
<%


	Statement stmt = con.createStatement();
	ResultSet rs =stmt.executeQuery("select * from UserGroupXRef where Username='"+rightname+"'");
		while(rs.next()){
		groupid=rs.getString("GroupId");


rs2 = stmt2.executeQuery("SELECT * FROM GroupMaster WHERE GroupId=\'"+groupid+"\'");


	while(rs2.next()){
			menuid=rs2.getString("GroupName");
			groupid=rs2.getString("GroupId");
	  %>
<option value="<%=groupid%>" selected ><%=menuid%></option>
<%

		}
	}
	%>
	</form><br>
	 <input type="image" src="../jsp/simages/reset2.gif" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver = "MM_swapImage('Image1','','../jsp/simages/reset1.gif',1)" OnClick = "SelectAllOptions(this.form.list2);">
</select></td>
</tr>
</table>
</form>
</html>

