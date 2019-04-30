
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->



<%@ page language="java" import="javax.persistence.*,com.ngs.entity.*,com.ngs.dao.*,com.ngs.security.*,com.ngs.gbl.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
 <%@ page import ="javax.sql.*" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<%@page import="menu.JDBCMenuTag"%>

 <jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
    String fDir = ""; boolean doLogin = true;ExpiryValidation ev=null;
    		
    
			try
			{
					 ResourceBundle bundle = ResourceBundle.getBundle("ngs");
					 String welcomecontent ="";
				     for (Enumeration e = bundle.getKeys();e.hasMoreElements();) 
				     {
				         String key = (String)e.nextElement();
				         String msg = bundle.getString(key);
				         //System.out.println("key :"+key);
				         //System.out.println("msg :"+msg);
				         
				         //if(key.equals("email.welcome.subject")){welcomecontent=msg;}
				         session.setAttribute(key,msg);
				         
			          }
			          
				}catch (Exception e)
				{
				 	throw new IOException("Could not read properties file");
				}

	// expiry validation code added by bhaskar tennety
	//used to check expiry
	javax.servlet.ServletConfig myconf = getServletConfig();
	fDir = myconf.getServletContext().getRealPath( request.getServletPath() );
	//System.out.println("fDir :"+fDir);
	fDir = fDir.substring(0, fDir.lastIndexOf( System.getProperty( "file.separator") ) );
	
	String filepath = fDir + System.getProperty("file.separator");
	//System.out.println("filepath :"+filepath);
	
	
	ServletContext context = getServletContext();
	Logger log = Logger.getLogger("Login.jsp");
	

	if(doLogin)  // to check for valid period
	{
	    //System.out.println("Inside dblogin");
		context.setAttribute("ConPoolbse", pool);
		//If the pool is not initialised
		if(pool.getDriver()== null)
		{
			String driver = (String)session.getAttribute("db.setDriver");
			String url = (String)session.getAttribute("db.setURL");
			
			//System.out.println("driver :"+driver);
			//System.out.println("url :"+url);
			
			pool.setDriver(driver);
			pool.setURL(url);
			pool.setUsername("nectar");
			pool.setPassword("nec76tar");
			pool.setSize(50);
			pool.initializePool();
		}
		
	}
	else
	{
		out.println("Software Expired");
//		out.close();
//		response.sendRedirect("/zalm/jsp/errorpage.jsp");
	}

%>
<html>
<head>
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<SCRIPT LANGUAGE=JavaScript src="common.js">
if (top.mainFrame)
{
	top.location.href = "Login.jsp"
}

function PopWindow(url)
{
	window.open(url, "new", "width=400,height=200,left=200,top=100,resizable=0");
}
</script>
</head>
<body topmargin="0" leftmargin="0" marginwidth="0" marginheight="0">
<%
String resultMessage="";
String action = request.getParameter("action");
if(null == request.getParameter("resultMessage"))
{
}else
{
resultMessage = request.getParameter("resultMessage");
}
System.err.println("*** Requested By : " + request.getRequestURI() + " *** Action : " + action+resultMessage);

if (action == null || action == "")
{
%>
<CENTER>
  <form name="f1" method=POST>
    <table border="0" cellspacing="0" cellpadding="0" leftmargin="0" topmargin="0">
      <tr>
        <td align="center"><img src="simages/logoN1.jpg" width="320" height="120">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
        <td align="center"><img src="simages/newlogo.jpg"></td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="center"> <br>
          <table border="0" cellspacing="1" cellpadding="1" align="center">
            <tr>
              <th colspan="2">Login</th>
            </tr>
            <tr>
              <td align="right">Username : </td>
              <td>
                <input type="text" name="Username">
              </td>
            </tr>
            <tr>
              <td align="right">Passcode : </td>
              <td>
                <input type="password" name="Password">
              </td>
            </tr>
            <tr>
            	<TD align=right>Choose Test or Module:</TD>
            	<TD><SELECT NAME="testormod">
            	<OPTION VALUE="module">Module</OPTION><OPTION VALUE="exam">Examination</OPTION>
				</SELECT></TD>
            </tr>
            <tr>
              <input type=hidden name=action value="doLogin">
              <th colspan="2" valign="top">
                <input type=submit value="Login" name="submit">
              </th>
            </tr>
           
<!--
			<tr>
              <td colspan="2"> <br>
                <ul>
                  <li> <a href='../servlet/RegistrationForm'>New User? Sign Up
                    Now!</a><br>
                    <br>
                  </li>
                  <li> <a href="javascript:PopWindow('forgotpassword.jsp')">Forgot
                    Passcode?</a> </li>
                </ul>
              </td>
			</tr>
-->
          </table>
         <!-- <p><img src="simages/Nectar_Logo.jpg" width="780" height="319"><br></p> -->
          </td>
      </tr>
      <tr>
        <td align="center">&nbsp;</td>
        <td align="center"></td>
      </tr>
<!-- <tr>
        <td align="right">&nbsp;</td>
        <td align="right"><img src="../simages/zils_logo_small.jpg" width="324" height="48"></td>
      </tr>
-->
    </table>
    </form>
</CENTER>
<%
}
else if(action.equals("doLogin"))
{
		Connection con = null;
		PreparedStatement psmt=null;
		String username = request.getParameter("Username");
		String password = request.getParameter("Password");
		//System.out.println("check username :"+username);
		//System.out.println("check password :"+password);
		EntityManager em = EntityManagerHelper.getEntityManager();
		JDBCMenuTag.loginuser = username;
		//System.out.println("check1 user :"+JDBCMenuTag.loginuser);
		int CID = 0;
		String Name = null;
		Integer CandidateID = new Integer(0);
		String TypeOfUser = null;
		String isTableCreated = null;
		String ClientID = null;
		int modulelevel=0,examid =0,result=0;
		
		ServletContext context2 = getServletContext();
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		
		try
		{
			con = pool.getConnection();
			if(username.equals("") || username==null)
			username="NA";String sql ="";String adminflag="";
			if( username.equals("cso") || username.equals("admin") || username.equals("zedca") || username.equals("deo") || username.equals("demo") || username.equals("zils"))
			{
				sql = "select username,password,status,firstname,lastname,candidateid,clientid,typeofuser,istablecreated "+ 
					  "from CandidateMaster where username=?";
					  adminflag="admin";
			}
			else if(username.equals("realdmin"))
			{
				modulelevel = 5;
				sql = "select username,password,status,firstname,lastname,candidateid,clientid,typeofuser,istablecreated "+ 
					  "from CandidateMaster where username=?";
					  adminflag="admin";
			}
			else
			{
				sql = "select username,password,status,firstname,lastname,cm.candidateid,clientid,typeofuser,istablecreated,LevelID,ModuleCount,Language,ud.examid "+ 
					  "from CandidateMaster cm,UserDetails ud where cm.candidateid=ud.candidateid and cm.username=?";
					  adminflag="user";
			}
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1,username);
			//log.info("sql CandidateMaster :"+psmt);
			ResultSet rs = psmt.executeQuery();
			boolean userfound = false;
			boolean isValidUser = false;
			int userStatus = 0;
			String decryptedPassword="";

			if(rs.next())
			{
			    log.info("sql CandidateMaster:");
			    //log.debug("password 1:"+rs.getString("Password"));
			    decryptedPassword = Encrypter.decrypt(rs.getString("Password")).trim();
			    //log.debug("password 2:"+decryptedPassword);
			    
				userStatus = rs.getInt("Status");
				userfound = true;
				
				log.info("sql CandidateMaster userStatus:"+userStatus);
				int lang = 0;
				if(adminflag.equals("user"))
				{
				lang = rs.getInt("Language");
				//System.out.println("langauge..............	:"+lang);
				//log.info("sql CandidateMaster lang:"+lang);
				}
				
				if(rs.getString("Username").equalsIgnoreCase(username)  && decryptedPassword.equals(password))
				isValidUser = true;
				Name = rs.getString("FirstName") + " " + rs.getString("LastName");

				CID = rs.getInt("CandidateID");
				CandidateID = new Integer(CID);

				ClientID = rs.getString("ClientID");
				TypeOfUser = rs.getString("TypeOfUser");
				isTableCreated = rs.getString("isTableCreated");
				String testormod = request.getParameter("testormod");
				
				 
				
				if( adminflag.equals("user") )
				{
					int modulecount = rs.getInt("ModuleCount");	
					examid = Integer.parseInt(rs.getString("examid"));
					//System.out.println("testormod..............	:"+testormod);
					//System.out.println("modulelevel..............	:"+modulelevel);
					//System.out.println("before modulecount..............	:"+modulecount);
					//System.out.println("examid..............	:"+examid);
					
					if(testormod.equals("module") && examid==10533 || examid==10534 || examid==10535)
					{
						/*if(modulecount>0)
						{
							modulecount = modulecount-1;
							//System.out.println("after modulecount..............	:"+modulecount);
							EntityManagerHelper.beginTransaction();
							UserdetailsDAO obUserdetailsDAO = new UserdetailsDAO();
							Userdetails objUserdetails=obUserdetailsDAO.findById(CID);
							objUserdetails.setModuleCount(modulecount);
							obUserdetailsDAO.update(objUserdetails);
							EntityManagerHelper.commit();*/
							NewperformancemasterDAO objNewperformancemasterDAO = new NewperformancemasterDAO();
							if (null == objNewperformancemasterDAO.findById(CID))
							{
								modulelevel = 1;
								if(username.equals("realadmin"))
								{
									modulelevel = 5;
									//System.out.println("check username 111:::::"+username);
								}
								//System.out.println("check username :::::"+username);
							  	//System.out.println("check :"+modulelevel);
							  	//System.out.println("lang :"+lang);
							}
							else
							{
								EntityManagerHelper.beginTransaction();
								CandidatedetailsDAO objCandidatedetailsDAO = new CandidatedetailsDAO();
								Candidatedetails objCandidatedetails = objCandidatedetailsDAO.findById(CID);
								
								Newperformancemaster objNewperformancemaster=objNewperformancemasterDAO.findById(CID);
								examid = objNewperformancemaster.getExamId();
								result = objNewperformancemaster.getResult();
								
								if(examid==10535 && result==1){
								modulelevel = 4;
								}
								else if(examid==10535 && result==0){
								modulelevel = 3;objCandidatedetails.setExamId(10535);
								}
								if(examid==10534 && result==1){
								modulelevel = 3;objCandidatedetails.setExamId(10535);
								}
								else if(examid==10534 && result==0){
								modulelevel = 2;objCandidatedetails.setExamId(10534);
								}
								if(examid==10533 && result==1){
								modulelevel = 2;objCandidatedetails.setExamId(10534);
								}
								else if(examid==10533 && result==0){
								modulelevel = 1;objCandidatedetails.setExamId(10533);
								}
								//System.out.println("check examid :"+examid);
								//System.out.println("check result :"+result);
								
								objCandidatedetailsDAO.save(objCandidatedetails);
								EntityManagerHelper.commit();
							
							}
							
							
							if(modulelevel==1 && lang==1)
							{
							    
							    //System.out.println("check username :"+username);
								//System.out.println("check password :"+password);%>
								<jsp:forward page="basicDemoPresentation.jsp"> 
								<jsp:param name="username" value="<%=username%>"/> 
								<jsp:param name="password" value="<%=password%>"/> 
								<jsp:param name="candidateid" value="<%=CID%>"/> 
								<jsp:param name="action" value="basic"/> 
								</jsp:forward> 
							<%}else	if(modulelevel==1 && lang==2)
							{
							    
							    //System.out.println("check username :"+username);
								//System.out.println("check password :"+password);%>
								<jsp:forward page="mbasicDemoPresentation.jsp"> 
								<jsp:param name="username" value="<%=username%>"/> 
								<jsp:param name="password" value="<%=password%>"/> 
								<jsp:param name="candidateid" value="<%=CID%>"/> 
								<jsp:param name="action" value="basic"/> 
								</jsp:forward> 
							<%}else if(modulelevel==2)
							{
							    //System.out.println("check username :"+username);
								//System.out.println("check password :"+password);%>
								<jsp:forward page="basicDemoPresentation.jsp"> 
								<jsp:param name="username" value="<%=username%>"/> 
								<jsp:param name="password" value="<%=password%>"/>
								<jsp:param name="candidateid" value="<%=CID%>"/> 
								<jsp:param name="action" value="intermediate"/>
								</jsp:forward> 
							<%}else if(modulelevel==3)
							{
							    //System.out.println("check username :"+username);
								//System.out.println("check password :"+password);%>
								<jsp:forward page="basicDemoPresentation.jsp"> 
								<jsp:param name="username" value="<%=username%>"/> 
								<jsp:param name="password" value="<%=password%>"/> 
								<jsp:param name="candidateid" value="<%=CID%>"/> 
								<jsp:param name="action" value="advance"/>
								</jsp:forward> 
							<%}else if(modulelevel==5)
							{
							    //System.out.println("check username :"+username);
								//System.out.println("check password :"+password);%>
								<jsp:forward page="basicDemoPresentation.jsp"> 
								<jsp:param name="username" value="<%=username%>"/> 
								<jsp:param name="password" value="<%=password%>"/> 
								<jsp:param name="candidateid" value="<%=CID%>"/> 
								<jsp:param name="action" value="realestate"/>
								</jsp:forward> 
							<%}
							/*} 
							else 
							{
								userStatus=0;
							}*/
						}
					}
				
					ev = new ExpiryValidation();
					if(ev.LicenceValidation(ClientID))
					{
						out.println(ev.getMessage());
						out.close();
					}
			}
			else
			{
			    if(username.equals("") || username==null)
				username="NA";
				psmt = con.prepareStatement("SELECT Username,Password,ClientName,ClientID FROM ClientMaster WHERE Username=?");
				psmt.setString(1,username);
				rs = psmt.executeQuery();
				log.info("sql psmt :"+psmt);
				if (rs.next())
				{
					//userStatus = rs.getInt("Status");
					userfound = true;
					userStatus = 1;
					decryptedPassword = Encrypter.decrypt(rs.getString("Password"));
										
					if(rs.getString("Username").equalsIgnoreCase(username)  && decryptedPassword.trim().equals(password))
					{
					    //System.out.println("Check Password");
						isValidUser = true;
						Name = rs.getString("ClientName") ;
						ClientID = rs.getString("ClientID");
						TypeOfUser = "0";
						isTableCreated = "0";
						ev = new ExpiryValidation();
						if(ev.LicenceValidation(ClientID))
						{
							out.println(ev.getMessage());
						}
					}
					else
					{
						userStatus =0;
					}
				}
			}

			if (userStatus == 0)
			{
%>
			<CENTER>
			<P>&nbsp;</P>
			<TABLE BORDER=0 CELLSPACING='1' CELLPADDING='1'>
			<TR><TH>WARNING</TH></TR>
			<TR><TD><P><br><B>Your account is temporarily deactivated.</B></P>
			<P>Contact our <a href="mailto:info@nectaredutech.com"> Helpdesk</a> for more details.
			</TD></TR>
			<TR><TH><INPUT TYPE=Button VALUE='Back to Login Page' Onclick='history.back()'></TH></TR>
			</TABLE>
<%
			}
			else if(isValidUser)
			{
				session.setAttribute("username", username);
				session.setAttribute("Name", Name);
				session.setAttribute("CandidateID", CandidateID);
				session.setAttribute("TypeOfUser", TypeOfUser);
				session.setAttribute("isTableCreated", isTableCreated);
				session.setAttribute("ClientID", ClientID);

				// Call Procedure to store ColorScemes for this user in the Session.

				response.sendRedirect("mainmenu.jsp");
			}
			else
			{
				if (userfound)
				{
%>
					<CENTER><TABLE BORDER=0>
					<TR><TH>ERROR</TH></TR>
					<TR><TD><P><br><B>Invalid Passcode.</B></P>
					<P>Go <A href="javascript:history.back();">back and Try again ...</A><BR><BR>
		<!--
					<a href="forgetpassword.jsp">Forgot Passcode ?</a>
		-->
					</P>
					</TD></TR>
					</TABLE>
<%
				}
				else
				{
%>
					<CENTER><TABLE BORDER=0>
					<TR><TD bgcolor='#FEEEC8'><font color='#960317'><B>ERROR</B></font></TD></TR>
					<TR><TD><P><br><font color='#960317'><B>User ( <%=username%> ) not Found.</B></P>
					<P>If you are not registered, then <a href='Register.jsp'>Register here</a>.</font>
					</TD></TR>
					</TABLE>
<%
				}
			}
		}
		catch(Exception ex)
		{
%>
			<CENTER><TABLE BORDER=0>
			<TR><TD bgcolor='#FEEEC8'><font color='#960317'><B>ERROR</B></font></TD></TR>
			<TR><TD><P><br><font color='#960317'><B><%=ex.toString()%></B>
			<BR><BR><B><B><BR>
			<%
			%>
			</font></P>
			</TD></TR>
			</TABLE>
<%
		}
	    finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println ("Error while Connecting to Database.");
	    }
}
%>
</body>
</html>
