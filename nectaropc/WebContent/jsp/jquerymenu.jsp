

<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->

<%@ page language="java" import="java.sql.*,java.util.Hashtable" session="true" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<html>
<head>
<META HTTP-EQUIV="Pragma" CONTENT="no-cache"> 
<body bgcolor="#ECE9D8" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<link rel="stylesheet" href="../alm.css" type="text/css">
<link rel="stylesheet" href="menu.css" type="text/css">
<script type="text/javascript" src="jquery.js"></script>
<script type="text/javascript" src="menu.js"></script>
<style type="text/css">
* { margin:0;
    padding:0;
}
body { }
div#menu { margin:20px auto; }
div#copyright {
    font:11px 'Trebuchet MS';
    color:#222;
    text-indent:30px;
    padding:140px 0 0 0;
}
div#copyright a { color:#eee; }
div#copyright a:hover { color:#222; }
</style>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
   
   <tr align="center">
       <td align="right" width="40%"><img width="100" height="100" src="simages/logoN1.jpg"></td><td align="left">
       &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img align="top" src="simages/newlogo.jpg"></td>
   </tr>
</table>
<%
int q=0;
int rights=0;
Connection con=null;
Statement stmt,stmt1,stmt2,stmt3=null;
ResultSet rs,rs1,rs2,rs3=null; 
String username = (String) session.getValue("username");
String groupid="",menuid="",url="",mainGroupid="",groupxid="";
 
try{
		ServletContext context = getServletContext(); 
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");

		con = pool.getConnection();
 		
		stmt1 = con.createStatement();
	    rs1 = stmt1.executeQuery("select * from CandidateMaster where Username='" +username+ "'");
		
		 if(rs1.next()){
		mainGroupid=rs1.getString("Username");
		 
	    }//end of if(con!=null) to get the group ID
		else
		{	
			rs1 = stmt1.executeQuery("SELECT * FROM ClientMaster WHERE Username='" + username +"'");
			 if(rs1.next()){
				mainGroupid=rs1.getString("Username");		 
		    }//end of if(con!=null) to get the group ID
		}
%>
<script language="javascript">

function NewWindow(url)
{
 
var anil = window.open(url,"HelpWindow","width=750,height=450,resizable=no,scrollbars=yes, left=20, top=20");

}

function OpenURL(url, targetFrame)
{
	switch(targetFrame)
	{
		case 0:
			top.main.location.href = url;
			break;
		case 1:
			top.location.href = url;
			break;
		case 2:
			var testWin = window.open (url, "TestWindow", "width=750,height=500,resizable=1,status=1,scrollbars=yes,toolbar=no,locationbar=no,menubar=no, left=20, top=0");
			break;
		default:
			top.location.href = url;
	}
}


menuArray = new Array();
<%
		stmt = con.createStatement();
		stmt3 = con.createStatement();

rs3=stmt3.executeQuery("select * from UserGroupXRef where Username=\'"+mainGroupid+"\' ");
	while(rs3.next()){
		groupxid=rs3.getString("GroupID");
		

rs =stmt.executeQuery("select * from MenuRights where GroupID=\'"+groupxid+"\' OR Username =\'"+username+"\' ORDER BY MenuID ASC");
		while(rs.next()){
		groupid=rs.getString("MenuID");
		 
		//SELECT * FROM MenuRights WHERE GroupID='00' ORDER BY MenuID ASC
		stmt2 = con.createStatement();
rs2 = stmt2.executeQuery("SELECT * FROM MenuMaster WHERE MenuID=\'"+groupid+"\' ORDER BY MenuID ASC");
				while(rs2.next()){
				menuid=rs2.getString("MenuName");
				url=rs2.getString("Command"); 
%>
menuArray[<%out.print(q);%>]="<%out.print(groupid);%> <%out.print(menuid);%>;<%out.print(url);%>;";
<%
    q++;  
			}
		 }//end of if(con!=null)
    }//end of try
 }//end of user groupX ref
    catch (Exception e)   {
		   out.print("Exception pinjo!!!!!!  "+e);
		}
  finally 
    { 
        if (con != null) 
            pool.releaseConnection(con); 
        else 
            out.println ("Error while Connecting to Database."); 
    }
%>

sss="<center><table bgcolor=#FFFFFF border=0 cellspacing=0 cellpadding=0><tr valign=top>";
for ( i=0 ; i < menuArray.length ; i++ ) {
	menuid=menuArray[i].substr(0,18);
	sss+="<td><div id='menu'><ul class='menu'><li><a href='#' class='parent'><span>"+menuid+"</span></a></li></ul></div></td>";
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
		
		
    	
        
		//sss+="<td><applet width='155' height='19' archive=PopupNavigator.jar code='PopupNavigator/PopupNavigatorApplet.class'>"+ss(popArray)+"<param name='DelimiterChar' value=';'><param name='EscapeChar' value='\\'><param name='DefaultFontName' value='Verdana'><param name='StatusText' value='Please select from the dropdown menu'><param name='DefaultFontStyle' value='BOLD'><param name='MouseOverImagePosition' value='LEFT;8'><param name='DefaultFontStyle' value='PLAIN'><param name='DefaultFontSize' value='11'><param name='Label' value='"+urls[0].substr(8,urls[0].length)+";Verdana;BOLD;11;7 121 162;225 248 247'><param name='MouseoverLabel' value=';;;;54 87 126;225 248 247'><param name='DefaultFrame' value='mainFrame'><param name='Selection' value='RECURSIVE'><param name='ShowStatus' value='HI'></applet></td>";
	}
	else {
		if ( i  >= menuArray.length  ) 
			i--
			urls=menuArray[i].split(";");
 
//		sss+="<td><form><input type=button value='"+urls[0].substr(8,urls[0].length)+"' onClick='OpenURL(\""+urls[1]+"\");'></form></td>"<param name='Image' value='/zalm/simages/clouds.jpg'>'"+urls[0].substr(6,urls[0].length)+"';Courier;ITALIC;16;24 255 0;0 0 0'
		//sss+="<td ><applet width='155' height='19' archive=PopupNavigator.jar code='PopupNavigator/PopupNavigatorApplet.class'><param name='MissingUrl' value='IGNORE'><param name='Label' value='"+urls[0].substr(8,urls[0].length)+";Verdana;BOLD;11;7 121 162;225 248 247'><param name='DefaultFontName' value='Courier'><param name='DefaultFontStyle' value='PLAIN'><param name='DefaultFontSize' value='11'><param name='MouseoverLabel' value=';;;;54 87 126;225 248 247'></applet></td>";

	}
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
if (username == "" || username == null)
{
	response.sendRedirect("Login.jsp");
}
%>
</body>
</html>





<div id="menu">
    <ul class="menu">
        <li><a href="#" class="parent"><span><%=menuid%></span></a>
            <div><ul>
                <li><a href="#" class="parent"><span>Sub Item 1</span></a>
                    <div><ul>
                        <li><a href="#" class="parent"><span>Sub Item 1.1</span></a>
                            <div><ul>
                                <li><a href="#"><span>Sub Item 1.1.1</span></a></li>
                                <li><a href="#"><span>Sub Item 1.1.2</span></a></li>
                            </ul></div>
                        </li>
                        <li><a href="#"><span>Sub Item 1.2</span></a></li>
                        <li><a href="#"><span>Sub Item 1.3</span></a></li>
                        <li><a href="#"><span>Sub Item 1.4</span></a></li>
                        <li><a href="#"><span>Sub Item 1.5</span></a></li>
                        <li><a href="#"><span>Sub Item 1.6</span></a></li>
                        <li><a href="#" class="parent"><span>Sub Item 1.7</span></a>
                            <div><ul>
                                <li><a href="#"><span>Sub Item 1.7.1</span></a></li>
                                <li><a href="#"><span>Sub Item 1.7.2</span></a></li>
                            </ul></div>
                        </li>
                    </ul></div>
                </li>
                <li><a href="#"><span>Sub Item 2</span></a></li>
                <li><a href="#"><span>Sub Item 3</span></a></li>
            </ul></div>
        </li>
        <li><a href="#" class="parent"><span>Product Info</span></a>
            <div><ul>
                <li><a href="#" class="parent"><span>Sub Item 1</span></a>
                    <div><ul>
                        <li><a href="#"><span>Sub Item 1.1</span></a></li>
                        <li><a href="#"><span>Sub Item 1.2</span></a></li>
                    </ul></div>
                </li>
                <li><a href="#" class="parent"><span>Sub Item 2</span></a>
                    <div><ul>
                        <li><a href="#"><span>Sub Item 2.1</span></a></li>
                        <li><a href="#"><span>Sub Item 2.2</span></a></li>
                    </ul></div>
                </li>
                <li><a href="#"><span>Sub Item 3</span></a></li>
                <li><a href="#"><span>Sub Item 4</span></a></li>
                <li><a href="#"><span>Sub Item 5</span></a></li>
                <li><a href="#"><span>Sub Item 6</span></a></li>
                <li><a href="#"><span>Sub Item 7</span></a></li>
            </ul></div>
        </li>
        <li><a href="#"><span>Help</span></a></li>
        <li class="last"><a href="#"><span>Contacts</span></a></li>
    </ul>
</div>

<div id="copyright">Copyright &copy; 2014 <a href="http://apycom.com/">Apycom jQuery Menus</a></div>

<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />

</body>
</html>