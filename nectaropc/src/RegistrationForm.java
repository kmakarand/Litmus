import java.sql.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.*;
import com.ngs.security.Encrypter;
import com.ngs.security.ExpiryValidation;
import java.io.IOException;
import java.io.PrintWriter;
import java.security.GeneralSecurityException;
import java.security.spec.KeySpec;
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import org.apache.log4j.FileAppender;
import org.apache.log4j.Logger;
import org.apache.log4j.PatternLayout;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


public class RegistrationForm extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null,rs1 = null;
	Vector vlocationid = new Vector();
	static Logger log = Logger.getLogger(RegistrationForm.class);
	
	public void init()
	{
		try{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
			
		}catch(Exception e){
			//System.out.println("Connection Error : " + e.getMessage());
		}
	}
	
	public void doGet(HttpServletRequest req,HttpServletResponse res)
			throws ServletException,IOException{
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		HttpSession session=req.getSession(true);
		String sql="";
		int cid = 0,lid=0;
		int totLic=0,totReg=0;

		
		try{
			if (action == null || action == ""){
				con = pool.getConnection();
				String ClientID = (String) session.getAttribute("ClientID");
				//FileAppender fileappender = new FileAppender(new PatternLayout(),"ztest.log");
				//log.addAppender(fileappender);
				log.info("Welcome to logging :"+ClientID);
				ExpiryValidation ev = new ExpiryValidation();
				if(ev.LicenceValidation(ClientID))
				{
					out.println(ev.getMessage());
					out.close();
				}
				
				res.setContentType("text/html");
				out.println("<HTML><HEAD><TITLE>Registration Form</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
				out.println("<script language=javascript>");
				out.println("function checkVal(){");
				out.println("var a='document.form1.firstname';");
				out.println("var b='document.form1.homeadd';");
				out.println("var c='document.form1.homephone';");
				out.println("var d='document.form1.offpin';");
				out.println("var e='document.form1.homepin';");
				out.println("var f='document.form1.offfax';");
				out.println("var g='document.form1.homefax';");
				out.println("var h='document.form1.cell';");
				out.println("var i='document.form1.pager';");
				out.println("var j='document.form1.email';");
				out.println("var k='document.form1.experience';");
				out.println("var l='document.form1.homephone';");
				out.println("var m='document.form1.lastname';");
				out.println("var n='document.form1.offcityID';");
				out.println("var o='document.form1.homecityID';");
				out.println("var p='document.form1.offadd';");

				out.println("var birthdate =self.document.form1.bdate.options[self.document.form1.bdate.selectedIndex].value+self.document.form1.bmonth.options[self.document.form1.bmonth.selectedIndex].value+self.document.form1.byear.options[self.document.form1.byear.selectedIndex].value;");

				out.println("if (!isnulls(a)){");
				out.println("	alert('First Name Field cannot be Empty !!');");
				out.println("	eval(a).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (eval(a).value.length>20){");
				out.println("	alert('First Name cannot be more than 20 characters !!');");
				out.println("	eval(a).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!isnulls(m)){");
				out.println("	alert('Last Name Field cannot be Empty !!');");
				out.println("	eval(m).focus();");
				out.println("	return false;");
				out.println("}");
///########## Mailing Validation #########////
				out.println("var mailadd =document.form1.mailadd[0].checked;");
				out.println("if (mailadd == true || mailadd == 'True'){");
				out.println("	if (!isnulls(b)){");
				out.println("		alert('Home Address Field cannot be Empty !!');");
				out.println("		eval(b).focus();");
				out.println("		return false;");
				out.println("	}");
				out.println("	else if (!isnulls(o)){");
				out.println("		alert('Home City Field cannot be Empty !!');");
				out.println("		eval(o).focus();");
				out.println("		return false;");
				out.println("	}");
				out.println("	else if (!isnulls(e)){");
				out.println("		alert('Home Pincode Field cannot be Empty !!');");
				out.println("		eval(e).focus();");
				out.println("		return false;");
				out.println("	}");
				out.println("}");
				out.println("else{");
				out.println("	if (!isnulls(p)){");
				out.println("		alert('Office Address Field cannot be Empty !!');");
				out.println("		eval(p).focus();");
				out.println("		return false;");
				out.println("	}");
				out.println("	else if (!isnulls(n)){");
				out.println("		alert('Office City Field cannot be Empty !!');");
				out.println("		eval(n).focus();");
				out.println("		return false;");
				out.println("	}");
				out.println("	else if (!isnulls(d)){");
				out.println("		alert('Office Pincode Field cannot be Empty !!');");
				out.println("		eval(d).focus();");
				out.println("		return false;");
				out.println("	}");
				out.println("}");
///########## Mailing Validation #########////

				out.println("if (!checkNumeric(eval(c),'Telephone is a Numeric Field')){");
				out.println("	eval(c).value='';");
				out.println("	eval(c).focus();");
				out.println("	return false;}");
				out.println("else if (!checkNumeric(eval(l),'Telephone is a Numeric Field')){");
				out.println("	eval(l).value='';");
				out.println("	eval(l).focus();");
				out.println("	return false;}");
				out.println("else if (eval(c).value.length>15){");
				out.println("	alert('Telephone Number cannot be more than 15 digits !!');");
				out.println("	eval(c).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(d),'Pincode is a Numeric Field')){");
				out.println("	eval(d).value='';");
				out.println("	eval(d).focus();");
				out.println("	return false;}");
				out.println("else if (eval(d).value.length>6){");
				out.println("	alert('Pincode cannot be more than 6 digits !!');");
				out.println("	eval(d).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(e),'Pincode is a Numeric Field')){");
				out.println("	eval(e).value='';");
				out.println("	eval(e).focus();");
				out.println("	return false;}");
				out.println("else if (eval(e).value.length>6){");
				out.println("	alert('Pincode cannot be more than 6 digits !!');");
				out.println("	eval(e).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(f),'Fax is a Numeric Field')){");
				out.println("	eval(f).value='';");
				out.println("	eval(f).focus();");
				out.println("	return false;}");
				out.println("else if (!checkNumeric(eval(g),'Fax is a Numeric Field')){");
				out.println("	eval(g).value='';");
				out.println("	eval(g).focus();");
				out.println("	return false;}");
				out.println("else if (!checkNumeric(eval(h),'Cell is a Numeric Field')){");
				out.println("	eval(h).value='';");
				out.println("	eval(h).focus();");
				out.println("	return false;}");
				out.println("else if (eval(h).value.length>10){");
				out.println("	alert('Cell Number cannot be more than 10 digits !!');");
				out.println("	eval(h).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(i),'Pager is a Numeric Field')){");
				out.println("	eval(i).value='';");
				out.println("	eval(i).focus();");
				out.println("	return false;}");
				out.println("else if (!checkNumeric(eval(k),'Experience is a Numeric Field')){");
				out.println("	eval(k).value='';");
				out.println("	eval(k).focus();");
				out.println("	return false;}");
				out.println("if (!isnulls(j)){");
				out.println("	alert('Email Field cannot be Empty !!');");
				out.println("	eval(j).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if ( !checkDate(birthdate) ) ");
				out.println("	{");
				out.println("	self.document.form1.bmonth.focus();");
				out.println("	return false; }");
				out.println("else if (!checkEmail(eval(j))){");
				out.println("	eval(j).focus();");
				out.println("	return false;}");
				out.println("else");
				out.println("	document.form1.submit();");
				out.println("}");
				out.println("</script>");

				String firstname = (String) session.getAttribute("firstname");
				if (firstname==null){firstname="";}
				String lastname = (String) session.getAttribute("lastname");
				if (lastname==null){lastname="";}
				String offadd = (String) session.getAttribute("offadd");
				if (offadd==null){offadd="";}
				String homeadd = (String) session.getAttribute("homeadd");
				if (homeadd==null){homeadd="";}

				String offpin = (String) session.getAttribute("offpin");
				if (offpin==null){offpin="";}
				String homepin = (String) session.getAttribute("homepin");
				if (homepin==null){homepin="";}

				String offphone = (String) session.getAttribute("offphone");
				if (offphone==null){offphone="";}
				String homephone = (String) session.getAttribute("homephone");
				if (homephone==null){homephone="";}
				String offfax = (String) session.getAttribute("offfax");
				if (offfax==null){offfax="";}
				String homefax = (String) session.getAttribute("homefax");
				if (homefax==null){homefax="";}
				String cell = (String) session.getAttribute("cell");
				if (cell==null){cell="";}
				String pager = (String) session.getAttribute("pager");
				if (pager==null){pager="";}
				String email = (String) session.getAttribute("email");
				if (email==null){email="";}
				String experience = (String) session.getAttribute("experience");
				if (experience==null){experience="";}

				String errorstr = (String) session.getAttribute("errorstr");
				if (errorstr==null){errorstr="";}
				else{out.println("warning : "+errorstr +" !!");}

				int clientid=0;

				if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
				{
//					clientid =1;
					res.sendRedirect("../jsp/Login.jsp");
				}
				else
					clientid = Integer.parseInt(ClientID);

				out.println("<FORM METHOD=POST NAME=form1>");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=5>REGISTRATION FORM FOR TRAINING PROGRAME</TH></TR>");
				out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>First Name :</TD><TD><INPUT TYPE=TEXT NAME=firstname VALUE="+firstname+"></TD><TD align=right><FONT COLOR=red>*</FONT>Last Name :</TD><TD><INPUT TYPE=TEXT NAME=lastname VALUE="+lastname+"></TD></TR>");

				out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Birth Date :</TD><TD><SELECT NAME=bdate>");
				for (int i=1;i<=31 ;i++ )
				{
					if (i<10)
					{
						out.println("<OPTION VALUE=0"+i+">"+i+"</OPTION>");
					}
					else
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
				}
				out.println("</SELECT>-<SELECT NAME=bmonth>");
				out.println("<OPTION VALUE=01>Jan</OPTION>");
				out.println("<OPTION VALUE=02>Feb</OPTION>");
				out.println("<OPTION VALUE=03>Mar</OPTION>");
				out.println("<OPTION VALUE=04>Apr</OPTION>");
				out.println("<OPTION VALUE=05>May</OPTION>");
				out.println("<OPTION VALUE=06>Jun</OPTION>");
				out.println("<OPTION VALUE=07>Jul</OPTION>");
				out.println("<OPTION VALUE=08>Aug</OPTION>");
				out.println("<OPTION VALUE=09>Sep</OPTION>");
				out.println("<OPTION VALUE=10>Oct</OPTION>");
				out.println("<OPTION VALUE=11>Nov</OPTION>");
				out.println("<OPTION VALUE=12>Dec</OPTION>");
				out.println("</SELECT>-<SELECT NAME=byear>");
				for (int i=1940;i<=1994 ;i++ )
				{
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
				}
				out.println("</SELECT></TD><TD align=right>Sex:</TD><TD><SELECT NAME=sex>");
				out.println("<OPTION VALUE=1>Male</OPTION><OPTION VALUE=0>Female</OPTION>");
				out.println("</SELECT></TD></TR>");

				out.println("<TR><TD align=right>Mailing Address :</TD><TD><input type='radio' name=mailadd value=0 CHECKED> Home Address Details </TD><TD align=center COLSPAN=2><input type='radio' name=mailadd value=1>Office Address Details </TD></TR>");

				out.println("<TR><TD align=right valign=top><FONT COLOR=red>*</FONT>Address :</TD><TD><TEXTAREA NAME=homeadd rows=3 cols=25>"+homeadd+"</TEXTAREA></TD><TD align=right valign=top>Address :</TD><TD><TEXTAREA NAME=offadd rows=3 cols=25>"+offadd+"</TEXTAREA></TD></TR>");

//				out.println("<TR><TD align=right>City :</TD><TD><INPUT TYPE=TEXT NAME=offcityID maxlength=20><FONT COLOR=red>*</FONT></TD><TD align=right>City :</TD><TD><INPUT TYPE=TEXT NAME=homecityID maxlength=20></TD></TR>");
				out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>City :</TD><TD><INPUT TYPE=TEXT NAME=homecityID maxlength=20></TD><TD align=right>City :</TD><TD><INPUT TYPE=TEXT NAME=offcityID maxlength=20></TD></TR>");

				out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>State :</TD><TD><SELECT NAME=homestateID>");
				sql = "SELECT LocationID FROM ClientMaster WHERE ClientID=" + clientid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int slid =0;
				while (rs.next())
				{
					slid = rs.getInt("LocationID");
				}
				sql = "SELECT CountryID,StateID FROM LocationMaster WHERE LocationID=" + slid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				int ctid=0,stateid=0;
				while (rs.next())
				{
					ctid = rs.getInt("CountryID");
					stateid = rs.getInt("StateID");
				}
				String locationname ="";
				sql = "SELECT LocationName FROM LocationMaster WHERE CountryID=" + ctid + " AND StateID=" + stateid + " AND CityID=0 AND AreaID=0";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					locationname = rs.getString("LocationName");
				}
				sql = "select distinct(CountryID),LocationID,StateID FROM LocationMaster where StateID != 0 GROUP BY CountryID,StateID";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					int countryid = rs.getInt(1);
					lid = rs.getInt(2);
					sql = "SELECT * FROM LocationMaster WHERE CountryID=" + countryid + " AND LocationID=" + lid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						String lname = rs1.getString("LocationName");
						if (locationname.equals(lname))
						{
							out.println("<option value="+lid+" SELECTED>"+lname+"</option>");
						}
						else
							out.println("<option value="+lid+">"+lname+"</option>");
					}
				}
				out.println("</SELECT></TD><TD align=right>State :</TD><TD><SELECT NAME=offstateID>");
				sql = "select distinct(CountryID),LocationID,StateID FROM LocationMaster where StateID != 0 GROUP BY CountryID,StateID";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					int countryid = rs.getInt(1);
					lid = rs.getInt(2);
					sql = "SELECT * FROM LocationMaster WHERE CountryID=" + countryid + " AND LocationID=" + lid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						String lname = rs1.getString("LocationName");
						if (locationname.equals(lname))
						{
							out.println("<option value="+lid+" SELECTED>"+lname+"</option>");
						}
						else
							out.println("<option value="+lid+">"+lname+"</option>");
					}
				}
				out.println("</SELECT></TD></TR>");

				out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Country :</TD><TD><SELECT NAME=homecountryID>");
				sql = "select distinct(CountryID),LocationID FROM LocationMaster GROUP BY CountryID";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					int countryid = rs.getInt(1);
					lid = rs.getInt(2);
					sql = "SELECT * FROM LocationMaster WHERE CountryID=" + countryid + " AND LocationID=" + lid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						int temp = rs1.getInt("CountryID");
						if (temp == 99)
						{
							out.println("<option value="+lid+" SELECTED>"+rs1.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+lid+">"+rs1.getString("LocationName")+"</option>");
					}
				}
				out.println("</SELECT></TD><TD align=right>Country :</TD><TD><SELECT NAME=offcountryID>");
				sql = "select distinct(CountryID),LocationID FROM LocationMaster GROUP BY CountryID";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					int countryid = rs.getInt(1);
					lid = rs.getInt(2);
					sql = "SELECT * FROM LocationMaster WHERE CountryID=" + countryid + " AND LocationID=" + lid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						int temp = rs1.getInt("CountryID");
						if (temp == 99)
						{
							out.println("<option value="+lid+" SELECTED>"+rs1.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+lid+">"+rs1.getString("LocationName")+"</option>");
					}
				}
				out.println("</SELECT></TD></TR>");

				out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Pincode :</TD><TD><INPUT TYPE=TEXT NAME=homepin VALUE="+homepin+"></TD><TD align=right>Pincode :</TD><TD><INPUT TYPE=TEXT NAME=offpin VALUE="+offpin+"></TD></TR>");

				out.println("<TR><TD align=right>Telephone :</TD><TD><INPUT TYPE=TEXT NAME=homephone VALUE="+homephone+"></TD><TD align=right>Telephone :</TD><TD><INPUT TYPE=TEXT NAME=offphone VALUE="+offphone+"></TD></TR>");

				out.println("<TR><TD align=right>Fax :</TD><TD><INPUT TYPE=TEXT NAME=homefax VALUE="+homefax+"></TD><TD align=right>Fax :</TD><TD><INPUT TYPE=TEXT NAME=offfax VALUE="+offfax+"></TD></TR>");

				out.println("<TR><TD align=right>Cell :</TD><TD><INPUT TYPE=TEXT NAME=cell  VALUE="+cell+"></TD><TD align=right>Pager :</TD><TD><INPUT TYPE=TEXT NAME=pager VALUE="+pager+"></TD></TR>");

				out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Email :</TD><TD><INPUT TYPE=TEXT NAME=email VALUE="+email+"></TD><TD align=right>Experience (yrs) :</TD><TD><INPUT TYPE=TEXT NAME=experience VALUE="+experience+"></TD></TR>");
				
				out.println("<TR><TD><FONT COLOR=red>*</FONT>Examination :</TD>");			
				/* New Code Added for selection of Examination start here*/
				
				out.println("<TD><SELECT NAME=ExamID>");
								
				//String pql = "SELECT DISTINCT(ExamID),TestName FROM NewExamDetails ORDER BY ExamID";
				String pql = "SELECT DISTINCT(ExamID),TestName FROM NewExamDetails where examid in"+
							 "(SELECT examid FROM Schedule WHERE ClientID=6	and ScheduleDate >= CURRENT_DATE)";
				log.info(pql);
				pstmt = con.prepareStatement(pql);
				rs1 = pstmt.executeQuery();
				String testName="";
				int iExamID = 0;
				while (rs1.next())
				{
					testName = rs1.getString("TestName");
					iExamID = rs1.getInt("ExamID");
					if(iExamID == 10531)
					{
						out.println("<OPTION VALUE="+iExamID+" SELECTED>"+testName+"</OPTION>");
					}
					else
						out.println("<OPTION VALUE="+iExamID+">"+testName+"</OPTION>");
				}
				
				
				out.println("</SELECT></TD><TD align=right>Choose Level:</TD><TD><SELECT NAME=LevelID>");
				out.println("<OPTION VALUE=1>Simple</OPTION><OPTION VALUE=2>Medium</OPTION>");				out.println("<OPTION VALUE=3>Difficult</OPTION><OPTION VALUE=4>Mixed</OPTION>");
				out.println("</SELECT></TD>");
				out.println("</TR>");
				
				/* New Code Added for selection of Examination end here*/					

				out.println("<TR><TH COLSPAN=4><FONT COLOR=red>*</FONT> Indicates compulsory Fields !!</TH></TR>");

				out.println("<TR><TH COLSPAN=4><INPUT TYPE=BUTTON VALUE=Submit onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset>&nbsp;<INPUT TYPE=BUTTON VALUE=Back onclick='javascript:history.back();'></TH><TR>");
				
				out.println("</TABLE>");
				out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doAdd'><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"><INPUT TYPE=HIDDEN NAME=ClientID VALUE="+clientid+">");
				out.println("</FORM>");
			}
			else
			{
				System.err.println("RegistrationForm:  before doPost");
				doPost(req,res);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());

		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
			{
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
				res.sendRedirect("../jsp/Login.jsp");
			}
		}

	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession(true);
		out.println("<HTML><HEAD><TITLE>Registration Confirmation</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		try
		{
			String action = req.getParameter("action");
			if (action.equalsIgnoreCase("doAdd"))
			{
				Add(req,res);
			}
			else if (action.equalsIgnoreCase("doAddQualification"))
			{
				AddQualification(req,res);
			}
			else if (action.equalsIgnoreCase("doSaveQualification"))
			{
				SaveQualification(req,res);
			}
			else if (action.equalsIgnoreCase("doAddMoreQualification"))
			{
				MoreQualification(req,res);
			}
			else if (action.equalsIgnoreCase("doPaymentDetails"))
			{
				PaymentDetails(req,res);
			}
			else if (action.equalsIgnoreCase("doSavePaymentDetails"))
			{
				SavePaymentDetails(req,res);
			}
			else if (action.equalsIgnoreCase("doScheduleTime"))
			{
				ScheduleTime(req,res);
			}
			else if (action.equalsIgnoreCase("doAddScheduleTime"))
			{
				AddScheduleTime(req,res);
			}
		}
		catch(Exception e)
		{
			//out.println("Error : " + e.getMessage());
		}
	}

	public void Add(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			session.setAttribute("regcon",con);
			int examid = Integer.parseInt(req.getParameter("ExamID"));
			System.err.println("RegistrationForm:doADD ExamID:"+examid);
			int levelid = Integer.parseInt(req.getParameter("LevelID"));
			System.err.println("RegistrationForm:doADD levelid:"+levelid);
			int clientid = Integer.parseInt(req.getParameter("ClientID"));
			System.err.println("RegistrationForm:doADD clientid:"+clientid);
			String firstname = req.getParameter("firstname");
			session.setAttribute("firstname",firstname);
			String lastname = req.getParameter("lastname");
			session.setAttribute("lastname",lastname);
			int bdate = Integer.parseInt(req.getParameter("bdate"));
			String dt = "",mt= "";
			if (bdate<10){dt = "0" + bdate;}
			int bmonth = Integer.parseInt(req.getParameter("bmonth"));
			if (bmonth<10){mt = "0" + bmonth;}
			int byear = Integer.parseInt(req.getParameter("byear"));
			int sex = Integer.parseInt(req.getParameter("sex"));

			String dob = "" + byear + "-" + mt + "-" + dt ;
//out.println("DOB : " + dob);

//out.println("ceid " + CentreID);
			int mailadd = Integer.parseInt(req.getParameter("mailadd"));
out.println("mailadd : " + mailadd);
			String offadd = req.getParameter("offadd");
			session.setAttribute("offadd",offadd);
//out.println("offadd "+offadd);
			String offcityID = req.getParameter("offcityID");
			int offstateID = Integer.parseInt(req.getParameter("offstateID"));
//out.println("stateid "+offstateID);
			int offcountryID = Integer.parseInt(req.getParameter("offcountryID"));
//out.println("count "+offcountryID);
			String offpin = req.getParameter("offpin");
			session.setAttribute("offpin",offpin);
			String offphone = req.getParameter("offphone");
			session.setAttribute("offphone",offphone);
			String offfax = req.getParameter("offfax");
			session.setAttribute("offfax",offfax);
//out.println("off " + offfax);
			String homeadd = req.getParameter("homeadd");
			session.setAttribute("homeadd",homeadd);
			String homecityID = req.getParameter("homecityID");
			int homestateID = Integer.parseInt(req.getParameter("homestateID"));
			int homecountryID = Integer.parseInt(req.getParameter("homecountryID"));
//out.println("homecountryid  " + homecountryID);
			String homepin = req.getParameter("homepin");
			session.setAttribute("homepin",homepin);
			String homephone = req.getParameter("homephone");
			session.setAttribute("homephone",homephone);
			String homefax = req.getParameter("homefax");
			session.setAttribute("homefax",homefax);
//out.println("home " + homefax);
			String cell = req.getParameter("cell");
			session.setAttribute("cell",cell);
			String pager = req.getParameter("pager");
			session.setAttribute("pager",pager);
//out.println("pager	 " + pager);
			String email = req.getParameter("email");
			session.setAttribute("email",email);
//out.println("examil : " + email);
			int experience = 0;
			String exp = req.getParameter("experience");
			if (exp == null || exp == "" || exp.equals(null) || exp.equals("")){
				experience = 0;}
			else
				experience = Integer.parseInt(exp);
//out.println("exp :" + experience+"<br>");
			exp = ""+ experience;
			session.setAttribute("experience",exp);

			String checkoffadd ="",checkhomeadd="";
			int LocationID = 0;
			boolean check = true;

//			RegistrationKey regkey = new RegistrationKey (con,cid);
			String username = Utils.GenerateString(firstname,5,5);
			sql = "SELECT FirstName from CandidateMaster WHERE FirstName='" + username +"'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				while (check==true)
				{
					username = Utils.GenerateString(firstname,5,5);
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					if (!rs1.next()){check=false;}
				}
			}
			check=true;
			String password = Utils.GenerateString(lastname,5,5);
			sql = "SELECT LastName from CandidateMaster WHERE LastName='" + password +"'";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				while (check==true)
				{
					password = Utils.GenerateString(lastname,5,5);
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					if (!rs1.next()){check=false;}
				}
			}
			
			//System.out.println("Original password: " + password);
			String encryptedPassword =  Encrypter.encrypt(password);
			password = encryptedPassword;
			//System.out.println("Encrypted password: " + encryptedPassword);
			String decryptedPassword =  Encrypter.decrypt(encryptedPassword);
			//System.out.println("Decrypted password: " + decryptedPassword);
			
			System.err.println("RegistrationForm:Add  before nvcanID:");
			NextValues nvcanID    =   new NextValues("CandidateMaster", "CandidateID");

			int nextcandID    =    nvcanID.getNextValue();
			System.err.println("RegistrationForm:Add  nextcandID:"+nextcandID);
			boolean val    =    nvcanID.setNextValue();
			System.err.println("RegistrationForm:Add  val:"+val);
			nextcandID    =    nvcanID.getNextValue();

//->			checkoffadd = AddressVerify(req,res,offareaID,offstateID,offcityID,offcountryID );
			//checkhomeadd = AddressVerify(req,res,homeareaID,homestateID,homecityID,homecountryID );
//out.println("<br>ret : " + checkhomeadd);
//			if (checkoffadd.equals("match found"))
//			{
//				String lid = (String) vlocationid.get(0);
				int homemail = 0,offmail=0;
				if (mailadd == 0){	homemail = 0; offmail=1;	}
				else
				{homemail =1;offmail=0;}

						sql = "INSERT INTO AddressDetails (CandidateID,TypeOfAddress,MailAddress,Address,StateID,CountryID,Pincode,Phone,Fax,MobileNo) VALUES (" + nextcandID + ",1,"+ homemail +",'" +  homeadd + " -> " + homecityID+ "',"+homestateID+","+homecountryID+",'" + homepin + "','" +	homephone + "','" + homefax + "','" + cell + "')";
  						pstmt = con.prepareStatement(sql);
				  		int confirm = pstmt.executeUpdate();
						sql = "INSERT INTO UserDetails (CandidateID,ExamID,LevelID) VALUES (" + nextcandID +"," + examid + "," + levelid + ")";
//out.println("<br>"+sql);
					  	pstmt = con.prepareStatement(sql);
					 	confirm = pstmt.executeUpdate();
						sql = "INSERT INTO AddressDetails (CandidateID,TypeOfAddress,MailAddress,Address,StateID,CountryID,Pincode,Phone,Fax,MobileNo) VALUES (" + nextcandID + ",2," + offmail + ",'" +  offadd + " -> " + offcityID + "'," + offstateID + "," + offcountryID +",'" + offpin + "','" +	offphone + "','" + offfax + "','" + pager + "')";
//out.println("<br>"+sql);
  						pstmt = con.prepareStatement(sql);
  						confirm = pstmt.executeUpdate();
						if (confirm > 0)
						{
							sql = "INSERT INTO CandidateMaster (CandidateID, Username, Password, FirstName, LastName, DateOfBirth, Sex, ClientID, Email, Experience, DateOfRegistration) VALUES (" +nextcandID+ ",'" +username+ "','" +password+ "','" +firstname+ "','" +lastname+ "','" +dob+ "'," +sex + "," + clientid + ",'" +email+ "'," +experience+ ",CURRENT_DATE())";
//out.println("<br>"+sql);
							pstmt = con.prepareStatement(sql);
							confirm = pstmt.executeUpdate();
							if (confirm  > 0)
							{
								sql = "INSERT INTO CandidateDetails (CandidateID, ExamID) VALUES (" + nextcandID +"," + examid + ")";
//out.println(sql);
								pstmt = con.prepareStatement(sql);
								confirm = pstmt.executeUpdate();
								sql = "INSERT INTO UserGroupXRef (Username,GroupID) VALUES ('" + username + "',20)";
//out.println(sql);
								pstmt = con.prepareStatement(sql);
								confirm = pstmt.executeUpdate();

								sql="SELECT DISTINCT(SectionID),CodeGroupID FROM NewExamDetails WHERE ExamID=" + examid;
								out.println("<BR>.....1");
//out.println(sql);
  								pstmt = con.prepareStatement(sql);
								ResultSet rs2 = pstmt.executeQuery();
								out.println("<BR>.....2.1");
								try {
								while (rs2.next())
								{
									int tempsecid = rs2.getInt("SectionID");
									int tempcgid = rs2.getInt("CodeGroupID");
									sql = "INSERT INTO NewTestStatusDetails (CandidateID, ExamID, SectionID, CodeGroupID, TestMode, Status, SequenceID, AttemptNo) VALUES (" + nextcandID + "," + examid + "," + tempsecid + "," + tempcgid + ",0,0,0,0)";
//out.println(sql);
									pstmt = con.prepareStatement(sql);
									confirm = pstmt.executeUpdate();
									if (confirm<=0)
									{
										out.println("Error in Inserting NewTestStatusDetails !!");
									}
								}
								}catch(Exception e) {
									e.printStackTrace();
									throw e;
								}

								out.println("</BODY></HTML>");
								session.removeAttribute("firstname");
								session.removeAttribute("lastname");
								session.removeAttribute("offadd");
								session.removeAttribute("offpin");
								session.removeAttribute("offphone");
								session.removeAttribute("offfax");
								session.removeAttribute("homeadd");
								session.removeAttribute("homepin");
								session.removeAttribute("homephone");
								session.removeAttribute("homefax");
								session.removeAttribute("cell");
								session.removeAttribute("pager");
								session.removeAttribute("email");
								session.removeAttribute("experience");
								session.removeAttribute("errorstr");

								String schedulelink = ""+req.getRequestURI()+"?action=doAddQualification&CandidateID="+nextcandID+"&ExamID="+examid;
								res.sendRedirect(schedulelink);
							}
						}
//					}
//					else
//					{
//						errorstr = checkoffadd;
//						errorstr="Nearest Office Area does not match with City/State/Country !!";
//						session.setAttribute("errorstr",errorstr);
//						res.sendRedirect(req.getRequestURI());
//					}
//				}
//			}
//			else
//			{
//				errorstr = checkhomeadd;
//				errorstr="Nearest Home Area does not match with City/State/Country !!";
//				session.setAttribute("errorstr",errorstr);
//				res.sendRedirect(req.getRequestURI());
//			}

		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}

	public void destroy()
	{
	}

	public void AddQualification(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession(true);
		String sql = null,errorstr="";
		try
		{
			System.err.println("Inside Add qualification");
			int examid = Integer.parseInt(req.getParameter("ExamID"));
			System.err.println("RegistrationForm:AddQualification ExamID:"+examid);
	
			con = pool.getConnection();
			int cid = Integer.parseInt(req.getParameter("CandidateID"));
			boolean repeatcheck = false;
System.err.println(repeatcheck);
			String check = req.getParameter("MoreCheck");
//out.println(check);
			if (check == null || check == "" || check.equals("") || check.equals(null) || check.equals("null"))
			{
				repeatcheck=true;
			}

			out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
			out.println("<script language=javascript>");

			out.println("function checkAction(str){");
			out.println("	if (checkVal() == true) {");
			out.println("		if (str == 'save'){");
			out.println("			document.form1.action='?action=doSaveQualification';");
			out.println("			document.form1.submit();");
			out.println("			return true;}");
			out.println("		else {");
			out.println("			document.form1.action='?action=doAddMoreQualification';");
			out.println("			document.form1.submit();");
			out.println("			return true;}");
			out.println("	}else{ return false;}}");

			out.println("function Next(){");
			out.println("			document.form1.action='?action=doPaymentDetails&CandidateID="+cid+"'");
			out.println("			document.form1.submit();");
			out.println("			return true;}");

			out.println("function checkVal(){");
			out.println("var x='document.form1.passyr';");
			out.println("var y='document.form1.percent';");
			out.println("var z='document.form1.university';");
			out.println("var a='document.form1.qualification';");
			out.println("if (!isnulls(a)){");
			out.println("	alert('Qualification Field cannot be Empty !!');");
			out.println("	eval(a).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (!isnulls(x) || !checkNumeric(eval(x),'Year of Passing is a Numeric Field')){");
			out.println("	alert('Year of Degree Field cannot be Empty !!');");
			out.println("	eval(x).focus();");
			out.println("	return false;");
			out.println("}");
			out.println("else if (eval(x).value<=1950 || eval(x).value>=2002){");
			out.println("	alert('Year of Degree cannot be less than 1950 or more than 2001');");
			out.println("	eval(x).value='';");
			out.println("	eval(x).focus();");
			out.println("	return false;}");
			out.println("else if (!isnulls(y)){");
			out.println("	alert('Percentage/Grade field cannot be Empty');");
			out.println("	eval(y).focus();");
			out.println("	return false;}");
			out.println("else if (!isnulls(z)){");
			out.println("	alert('University field cannot be Empty');");
			out.println("	eval(z).focus();");
			out.println("	return false;}");
			out.println("else");
			out.println("	return true;");
			out.println("}");


			out.println("</script>");

			out.println("Additional Qualifiaction <HR SIZE=1>");
			out.println("<FORM METHOD=POST NAME=form1 action="+req.getRequestURI()+">");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=2>Enter your Qualification Details</TH></TR>");
			out.println("<TR><TD>Degree/Diploma</TD><TD><INPUT TYPE=TEXT NAME=qualification></TD></TR>");
			out.println("<TR><TD>Year of Passing</TD><TD><INPUT TYPE=TEXT NAME=passyr></TD></TR>");
			out.println("<TR><TD>Percent/Grade</TD><TD><INPUT TYPE=TEXT NAME=percent></TD></TR>");
			out.println("<TR><TD>University</TD><TD><INPUT TYPE=TEXT NAME=university></TD></TR>");
			out.println("<TR><TH COLSPAN=2><INPUT TYPE=Button onclick=\"return checkAction('MoreQualification');\" VALUE='Add More Qualification'>");
			if (repeatcheck == false)
			{
				out.println("<INPUT TYPE=BUTTON VALUE='Next' onclick=\"return Next();\">");
			}
			else
			{
				out.println("<INPUT TYPE=BUTTON VALUE='Save and Proceed' onclick=\"return checkAction('save');\">");
			}
			out.println("<INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"></TH></TR>");
			out.println("<INPUT TYPE=HIDDEN NAME=ExamID VALUE="+examid+"></TH></TR>");
			out.println("</TABLE>");
			out.println("</FORM>");
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}

	public void SaveQualification(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
			HttpSession session=req.getSession(true);
			con = pool.getConnection();
			int examid = Integer.parseInt(req.getParameter("ExamID"));
			System.err.println("RegistrationForm:SaveQualification ExamID:"+examid);
			String qualification = req.getParameter("qualification");
//out.println(qid);
			String passyr = req.getParameter("passyr");
//out.println(passyr);
			String percent = req.getParameter("percent");
//out.println(percent);
			String university = req.getParameter("university");
//out.println(university);
			int cid = Integer.parseInt(req.getParameter("cid"));
//out.println(cid);

			sql = "SELECT * FROM QualificationsDetails WHERE CandidateID=" + cid + " and Qualification='"+ qualification +"'";
out.println(sql);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				out.println("This Qualification already exist");
				out.println("<BR><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'>");
			}
			else
			{
				sql = "INSERT INTO QualificationsDetails (CandidateID ,Qualification,YearOfPassing,Percent,university) VALUES (" + cid + ",'" + qualification +"','" + passyr + "','" + percent + "','" + university + "')";
//out.println("sql");
				pstmt = con.prepareStatement(sql);
				int confirm = pstmt.executeUpdate();
				if (confirm > 0)
				{
					out.println("New Degree Succesfully Added !!");
					String schedulelink = ""+req.getRequestURI()+"?action=doPaymentDetails&CandidateID="+cid+"&ExamID="+examid;
					res.sendRedirect(schedulelink);
//					out.println("<BR><INPUT TYPE=BUTTON VALUE='Close Window' onclick='javascript: window.close();'>");
				}
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}

	public void MoreQualification(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
out.println("mo0re qual");
			HttpSession session=req.getSession(true);
			con = pool.getConnection();
			int examid = Integer.parseInt(req.getParameter("ExamID"));
			System.err.println("RegistrationForm:MoreQualification ExamID:"+examid);
			session.setAttribute("ExamID",String.valueOf(examid));
			String qualification = req.getParameter("qualification");
			String passyr = req.getParameter("passyr");
			String percent = req.getParameter("percent");
			String university = req.getParameter("university");
			int cid = Integer.parseInt(req.getParameter("cid"));

			sql = "SELECT * FROM QualificationsDetails WHERE CandidateID=" + cid + " and Qualification='"+ qualification+ "'";
//out.println(sql);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				out.println("This Qualification already exist");
				out.println("<BR><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'>");
			}
			else
			{
				sql = "INSERT INTO QualificationsDetails (CandidateID ,Qualification,YearOfPassing,Percent,university) VALUES (" + cid + ",'" + qualification +"','" + passyr + "','" + percent + "','" + university + "')";
//out.println("sql");
  				pstmt = con.prepareStatement(sql);
				int confirm = pstmt.executeUpdate();
				if (confirm > 0)
				{
					out.println("New Degree Succesfully Added !!");
					String schedulelink = ""+req.getRequestURI()+"?action=doAddQualification&CandidateID="+cid+"&MoreCheck=check"+"&ExamID="+examid;
					res.sendRedirect(schedulelink);
				}
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}

	public void PaymentDetails(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		HttpSession session=req.getSession(true);
		int iexamid = Integer.parseInt(req.getParameter("ExamID"));
		int examid=0;
		System.err.println("RegistrationForm:PaymentDetails ExamID:"+iexamid);
		int cid = Integer.parseInt(req.getParameter("CandidateID"));
		int clientid = 0;
		String ClientID = (String) session.getAttribute("ClientID");
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);
		try
		{
			con = pool.getConnection();
			res.setContentType("text/html");
			out.println("<HTML><HEAD><TITLE>Payment Details Form</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
			out.println("<script language=javascript>");
			out.println("function checkVal(){");
//			out.println("var a='document.form1.amount';");
			out.println("var b='document.form1.ddno';");
			out.println("var c='document.form1.drawnbank';");
			out.println("var d='document.form1.branchname';");
			out.println("var paymode =self.document.form1.paymode.options[self.document.form1.paymode.selectedIndex].value;");

			out.println("if (paymode == \"Cheque\" || paymode == \"DDt\"){");
			out.println("	if (!isnulls(b)){");
			out.println("		alert('Cheque/DD No. Field cannot be Empty !!');");
			out.println("		eval(b).focus();");
			out.println("		return false;");
			out.println("	}");
			out.println("	else if (!isnulls(c)){");
			out.println("		alert('Drawn on Bank Field cannot be Empty !!');");
			out.println("		eval(c).focus();");
			out.println("		return false;");
			out.println("	}");
			out.println("	else if (!isnulls(d)){");
			out.println("		alert('Branch name Field cannot be Empty !!');");
			out.println("		eval(d).focus();");
			out.println("		return false;");
			out.println("	}");
			out.println("}");


			out.println("var chequedate =self.document.form1.dddate.options[self.document.form1.dddate.selectedIndex].value+self.document.form1.ddmonth.options[self.document.form1.ddmonth.selectedIndex].value+self.document.form1.ddyear.options[self.document.form1.ddyear.selectedIndex].value;");

//			out.println("else if (!isnulls(b)){");
//			out.println("	alert('Cheque/DD No. Field cannot be Empty !!');");
//			out.println("	eval(b).focus();");
//			out.println("	return false;");
//			out.println("}");
			out.println("if (!checkNumeric(eval(b),'Cheque/DD No. is a Numeric Field')){");
			out.println("	eval(b).value='';");
			out.println("	eval(b).focus();");
			out.println("	return false;}");
			out.println("else if ( !checkDate(chequedate) ) ");
			out.println("	{");
			out.println("	self.document.form1.bmonth.focus();");
			out.println("	return false; }");
			out.println("else");
			out.println("	document.form1.submit();");
			out.println("}");
			out.println("</script>");

			String firstname = "" , lastname ="",sql="";

			sql = "SELECT FirstName,LastName FROM CandidateMaster WHERE CandidateID=" + cid;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
  			rs = pstmt.executeQuery();
			while (rs.next())
			{
				firstname = rs.getString("FirstName");
				lastname = rs.getString("LastName");
			}

			sql = "SELECT ExamID FROM CandidateDetails WHERE CandidateID=" + cid;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
  			rs = pstmt.executeQuery();
			while (rs.next())
			{
				examid = rs.getInt("ExamID");
			}


				out.println("<FORM METHOD=POST NAME=form1 action="+req.getRequestURI()+">");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Payment Details : " + firstname + " " +lastname+"</TH></TR>");
				out.println("<TR><TD align=right>Mode of Payment :</TD><TD><SELECT NAME=paymode>");
				out.println("<OPTION VALUE=Cash>Cash</OPTION><OPTION VALUE='DDt'>Demand Draft</OPTION></SELECT></TD></TR>");

				out.println("<TR><TD align=right>Amount :</TD><TD>Rs. &nbsp;&nbsp;&nbsp;600</TD></TR>");

				out.println("<TR><TD align=right>DD No. :</TD><TD><INPUT TYPE=TEXT NAME=ddno align=right></TD></TR>");

				out.println("<TR><TD align=right>DD Date :</TD><TD><SELECT NAME=dddate>");
				for (int i=1;i<=31 ;i++ )
				{
					if (i<10)
					{
						out.println("<OPTION VALUE=0"+i+">"+i+"</OPTION>");
					}
					else
					out.println("<OPTION VALUE="+i+">"+i+"</OPTION>");
				}
				out.println("</SELECT>-<SELECT NAME=ddmonth>");
				out.println("<OPTION VALUE=01>Jan</OPTION>");
				out.println("<OPTION VALUE=02>Feb</OPTION>");
				out.println("<OPTION VALUE=03>Mar</OPTION>");
				out.println("<OPTION VALUE=04>Apr</OPTION>");
				out.println("<OPTION VALUE=05>May</OPTION>");
				out.println("<OPTION VALUE=06>Jun</OPTION>");
				out.println("<OPTION VALUE=07>Jul</OPTION>");
				out.println("<OPTION VALUE=08>Aug</OPTION>");
				out.println("<OPTION VALUE=09>Sep</OPTION>");
				out.println("<OPTION VALUE=10>Oct</OPTION>");
				out.println("<OPTION VALUE=11>Nov</OPTION>");
				out.println("<OPTION VALUE=12>Dec</OPTION>");
				out.println("</SELECT>-<SELECT NAME=ddyear>");
				out.println("<OPTION VALUE=2012>2012</OPTION></SELECT></TD></TR>");

				out.println("<TR><TD align=right>Drawn on Bank :</TD><TD><INPUT TYPE=TEXT NAME=drawnbank></TD></TR>");

				out.println("<TR><TD align=right>Branch Name :</TD><TD><INPUT TYPE=TEXT NAME=branchname></TD></TR>");

				out.println("<TH COLSPAN=2><INPUT TYPE=BUTTON VALUE=Submit onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset></TH>");
				out.println("</TABLE>");
				out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doSavePaymentDetails'><INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+"><INPUT TYPE=HIDDEN NAME=ExamID VALUE="+iexamid+">");
				out.println("</FORM>");

				out.println("</BODY></HTML>");

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}

	public void SavePaymentDetails(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			int cid = Integer.parseInt(req.getParameter("cid"));
out.println("<br>cid : " + cid);
			int examid = Integer.parseInt(req.getParameter("ExamID"));
			System.err.println("RegistrationForm:SavePaymentDetails ExamID:"+examid);
			session.setAttribute("ExamID",String.valueOf(examid));
			out.println("<br>examid : " + examid);
			String paymode = req.getParameter("paymode");
out.println("<br>paymode : " + paymode);
//			int amount = Integer.parseInt(req.getParameter("amount"));
//out.println("<br>amount : " + amount);
			String currency = "Rs.";//req.getParameter("currency");
out.println("<br>currency : " + currency);
			int ddno = 0;
			String ddnum = req.getParameter("ddno");

			if (ddnum == null || ddnum == "" || ddnum.equals("") || ddnum.equals(null)){
				ddno = 0;}
			else
				ddno = Integer.parseInt(ddnum);
out.println("<br>ddno : " + ddno);

			int dddate = Integer.parseInt(req.getParameter("dddate"));
out.println("<br>dt : " + dddate);
			String dt = "",mt= "";
			if (dddate<10){dt = "0" + dddate;}
			int ddmonth = Integer.parseInt(req.getParameter("ddmonth"));
out.println("<br>mon : " + ddmonth);
			if (ddmonth<10){mt = "0" + ddmonth;}
			int ddyear = Integer.parseInt(req.getParameter("ddyear"));
out.println("<br>year : " + ddyear);
			String chdate = "" + ddyear + "-" + mt + "-" + dt ;
out.println("ch date : " + chdate);

			String drawnbank = req.getParameter("drawnbank");
out.println("<br>bank : " + drawnbank);
			if (drawnbank == null || drawnbank == "")
			{
				drawnbank = "";
			}
			String branchname = req.getParameter("branchname");
out.println("<br>bname : " + branchname);
			if (branchname == null || branchname == "")
			{
				branchname = "";
			}

			sql = "INSERT INTO PaymentDetails (ExamID,CandidateID,Amount,Currency,Date,modeOfPayment,Bank,Branch,ChequeNo) VALUES (" + examid + "," + cid + ",600,'" + currency + "','" + chdate + "','" + paymode + "','"  + drawnbank + "','" + branchname + "'," + ddno + ")" ;
//out.println(sql);
  			//System.err.println("INSERT INTO PaymentDetails before");
			pstmt = con.prepareStatement(sql);
			int confirm = pstmt.executeUpdate();
			//System.err.println("INSERT INTO PaymentDetails after");
			if (confirm>0)
			{
				out.println("Payments Details Added Sucessfully !!");
				//System.err.println("Payments Details Added Sucessfully !!");
				String schedulelink = ""+req.getRequestURI()+"?action=doScheduleTime&CandidateID="+cid+"&ExamID="+examid;
				res.sendRedirect(schedulelink);
			}
			else
			//System.err.println("Payment Updation Problem !! before");
			out.println("Payment Updation Problem !!");
			//System.err.println("Payment Updation Problem !! after");

		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}

	public void ScheduleTime(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		int clientid = 0,examid=0,cid=0;
		HttpSession session=req.getSession(true);
		String ClientID = (String) session.getAttribute("ClientID");
		System.err.println("ScheduleTime 1:ClientID"+ClientID);
		if (ClientID == null || ClientID.equals("") || ClientID.equals(null) || ClientID=="")
		{
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			clientid = Integer.parseInt(ClientID);

		String CandidateID = req.getParameter("CandidateID");
		int ExamID = Integer.parseInt(req.getParameter("ExamID"));
		System.err.println("RegistrationForm:ScheduleTime ExamID:"+ExamID);
		if (CandidateID == null || CandidateID.equals("") || CandidateID.equals(null) || CandidateID=="")
		{
			//cid = 1;
			res.sendRedirect("../jsp/Login.jsp");
		}
		else
			cid = Integer.parseInt(CandidateID);
			System.err.println("ScheduleTime 2:cid"+cid);
		try
		{
			con = pool.getConnection();
				out.println("<HTML><HEAD><TITLE>Exam Time</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				sql = "SELECT * FROM Schedule "+
					"WHERE ClientID="+clientid+
					" and ExamId="+ExamID+
					" and ScheduleDate >= CURRENT_DATE " +
					" ORDER BY  ScheduleDate,TimeFrom,TimeTo";
System.out.println("schedule query :"+sql);
  				System.err.println("ScheduleTime req.getRequestURI()"+req.getRequestURI());
				out.println("<FORM METHOD=POST NAME=form1 action="+req.getRequestURI()+">");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Select Exam Date and Time </TH></TR>");
				out.println("<TR><TD>Select</TD><TD><SELECT NAME=scheduleid>");
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
//				String timefrom
				while (rs.next())
				{
					String timefrom = rs.getString("TimeFrom");
					System.err.println("ScheduleTime 3:timefrom"+timefrom);
					timefrom = timefrom.substring(0,5);
					System.err.println("ScheduleTime 4:timefrom"+timefrom);
					String timeto = rs.getString("TimeTo");
					System.err.println("ScheduleTime 5:timeto"+timeto);
					timeto = timeto.substring(0,5);
					System.err.println("ScheduleTime 6:timeto"+timeto);
					String date = rs.getString("ScheduleDate");
					System.err.println("ScheduleTime 7:date"+date);
					Utils myUtil = new Utils();
					date = myUtil.getDate(date);
					System.err.println("ScheduleTime 8:date"+date);
//					Date date = rs.getDate("ScheduleDate");
//out.println("Date : " + date);
//					String scdate = dt.format(date);
//out.println(scdate);
					out.println("<OPTION VALUE="+rs.getInt("ScheduleID")+">"+date+"  "+ timefrom +"-"+timeto+"</OPTION>");
				}
				out.println("</SELECT></TD></TR>");
				out.println("<TR><TH COLSPAN=2><INPUT TYPE=SUBMIT VALUE=Details><INPUT TYPE=HIDDEN NAME=action Value=doAddScheduleTime><INPUT TYPE=HIDDEN NAME=examid Value="+examid+"><INPUT TYPE=HIDDEN NAME=ClientID Value="+clientid+"><INPUT TYPE=HIDDEN NAME=cid Value="+cid+"></TH></TR>");
				out.println("</TABLE>");
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
	}

	public void AddScheduleTime(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null;
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			int cid = Integer.parseInt(req.getParameter("cid"));
			int clientid = Integer.parseInt(req.getParameter("ClientID"));
			int examid = Integer.parseInt(req.getParameter("examid"));
			int scheduleid = Integer.parseInt(req.getParameter("scheduleid"));
			int totalseats = 0,seatsreserved =0;
			String shdate = "";

			sql = "SELECT ScheduleDate FROM Schedule WHERE ScheduleID=" + scheduleid;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				shdate = rs.getString("ScheduleDate");
			}

			sql = "SELECT AvailableSeats FROM ClientMaster WHERE ClientID=" + clientid;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
  			rs = pstmt.executeQuery();
			while (rs.next())
			{
				totalseats = rs.getInt("AvailableSeats");
			}
			sql = "SELECT count(*) FROM SlotRegisteration WHERE ScheduleID=" + scheduleid;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
  			rs = pstmt.executeQuery();
			while (rs.next())
			{
				seatsreserved = rs.getInt(1);
			}
			
			if (seatsreserved < totalseats)
			{
				sql = "UPDATE CandidateMaster SET ScheduleID=" + scheduleid + " WHERE CandidateID=" + cid;
	//out.println(sql);
				pstmt = con.prepareStatement(sql);
				int confirm = pstmt.executeUpdate();
				if (confirm>0)
				{
					sql = "SELECT * FROM  SlotRegisteration WHERE ScheduleID=" + scheduleid + " and CandidateID=" + cid ;
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					if (!rs.next())
					{
						sql = "INSERT INTO SlotRegisteration (ScheduleID,CandidateID,Attended) VALUES (" + scheduleid + "," + cid + "," + "0)";
	//out.println(sql);
						pstmt = con.prepareStatement(sql);
						confirm = pstmt.executeUpdate();
						if (confirm>0)
						{
							sql = "UPDATE CandidateMaster SET ScheduleID=" + scheduleid + " WHERE CandidateID="+ cid;
							pstmt = con.prepareStatement(sql);
							confirm = pstmt.executeUpdate();
							if (confirm >0)
							{
								sql = "SELECT * from CandidateMaster WHERE CandidateID=" + cid;
	//out.println(sql);
								out.println("<BR><TABLE BORDER=0>");
								out.println("<TR><TH>Reg. No.</TH><TH>First Name</TH><TH>Last Name</TH><TH>Username Name</TH></TR>");
								pstmt = con.prepareStatement(sql);
								rs = pstmt.executeQuery();
								while (rs.next())
								{
									RegistrationKey regkey = new RegistrationKey (cid);
									String tpkey = regkey.KeyCode();
									out.println("<TR><TD>" + regkey.getKeyCode() +  "</TD><TD>" + rs.getString("FirstName") + "</TD><TD>" + rs.getString("LastName") + "</TD><TD>" + rs.getString("Username") + "</TD></TR>");
								}
								out.println("</TABLE>");

								out.println("Candidate Sucessfully Registered here !!");
							}
						}
//						else
//						{
//							out.println("All Seats f this Schedule has been booked !! <BR><BR>Please Selected another slot for your Test.");
//							out.println("<INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'>");
//						}
					}
	//				else
	//					out.println("Candidate Already Registered for this Schedule !!");
				}
				else
					out.println("Schedule Registration Problem !!");
			}
			else
			{
				out.println("All Seats for this Schedule has been booked !! <BR><BR>Please Select another slot for your Test.");
				out.println("<INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'>");
			}
		}
		catch(Exception e)
		{
			out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}

}
