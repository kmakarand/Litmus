import java.io.*;
import java.sql.*;
import java.util.Vector;
import javax.servlet.*;
import javax.servlet.http.*;
import com.ngs.gbl.*;
import com.ngs.gbl.ConnectionPool;
import com.ngs.gen.*;

public class ClientRegistrationForm extends HttpServlet
{
	com.ngs.gbl.ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null,rs1 = null,rs2 = null;
	Vector vlocationid = new Vector();

	public void init()
	{
		try
		{
			pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		}
		catch(Exception e)
		{
			//System.out.println("Connection Error : " + e.getMessage());
		}
	}

	public void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		PrintWriter out = res.getWriter();
		String action = req.getParameter("action");
		String sql="";
		int cid = 32,lid=0;
		HttpSession session=req.getSession(true);
		try
		{
			if (action == null || action == "")
			{
				View(req,res);
			}
			else
			{
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
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}

	}
	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Registration Confirmation</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		try
		{
			String action = req.getParameter("action");
			if (action.equalsIgnoreCase("doNewClient"))
			{
				NewClient(req,res);
			}
			if (action.equalsIgnoreCase("doAdd"))
			{
				Add(req,res);
			}
			if (action.equalsIgnoreCase("doModify"))
			{
				Modify(req,res);
			}
			if (action.equalsIgnoreCase("doModifySave"))
			{
				ModifySave(req,res);
			}
			if (action.equalsIgnoreCase("doConfirmDelete"))
			{
				ConfirmDelete(req,res);
			}
			if (action.equalsIgnoreCase("doDelete"))
			{
				Delete(req,res);
			}
//			if (action.equalsIgnoreCase("doView"))
//			{
//				View(req,res);
//			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}

	public String AddressVerify(HttpServletRequest req,HttpServletResponse res,int areaID,int stateID,int cityID,int countryID )
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = null;
		String sql = null,returnstr = "";
		int LocationID =0;
		try
		{
			out = res.getWriter();
			con = pool.getConnection();
			//out.println("Address Verify");
			int CountryID=0,StateID=0,AreaID=0,CityID=0;
			boolean Countrycheck = true,Statecheck = true,Citycheck = true,Areacheck = true;

			sql = "SELECT CountryID FROM LocationMaster WHERE LocationID=" + countryID;
//out.println("<br>" + sql);
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				CountryID = rs.getInt("CountryID");
				Countrycheck = true;
			}
			sql = "SELECT StateID FROM LocationMaster WHERE LocationID=" + stateID + " and CountryID=" + CountryID;
//out.println("<br>" + sql);
  			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				StateID= rs.getInt(1);
				Statecheck = true;
			}
			else
			{
				Statecheck = false;
			}

			sql = "SELECT CityID FROM LocationMaster WHERE LocationID=" + cityID + " and CountryID=" + CountryID + " and StateID=" + StateID;
//out.println("<br>" + sql);
  			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				CityID= rs.getInt(1);
				Citycheck = true;
			}
			else
			{
				Citycheck = false;
			}

			sql = "SELECT AreaID FROM LocationMaster WHERE LocationID=" + areaID + " and CountryID=" + CountryID + " and StateID=" + StateID + " and CityID=" + CityID;
//out.println("<br>" + sql);
  			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next())
			{
				AreaID= rs.getInt(1);
				Areacheck = true;
			}
			else
			{
				Areacheck = false;//areaID=1;
			}
			sql = "SELECT LocationID FROM LocationMaster WHERE CountryID=" + countryID + " and StateID=" + StateID + " and CityID=" + CityID + " and AreaID=" + AreaID;
//out.println("<br>"+sql);
//out.println("<br>Area : "+Areacheck + " state : " + Statecheck + " city : " + Citycheck + " Country : " + Countrycheck +"<br>");
  			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next() && Countrycheck==true && Statecheck==true && Citycheck==true && Areacheck==true)
			{
				LocationID= rs.getInt(1);
				String lid = ""+LocationID;
				returnstr = "match found";
				vlocationid.add(0,lid);
//out.println("<br>et : " + returnstr);
			}
			else if (AreaID == 0 && Areacheck == false && Countrycheck==true && Statecheck==true && Citycheck==true )
			{
				LocationID=CityID;
				returnstr = "Confirm your Area for the Exam from Admin !!";
				out.println(returnstr);
			}
			else if (Countrycheck==false || Statecheck==false || Citycheck==false || Areacheck==false && areaID>1)
			{
				returnstr = "Area does not match with City/State/Country !!";
				out.println(returnstr);
//				out.println("<br><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'>");
			}
		}
		catch(Exception e)
		{
			out.println("LocationID Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
		return returnstr;
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

//			int cid = Integer.parseInt(req.getParameter("cid"));
			String clientname = req.getParameter("clientname");
			session.setAttribute("clientname",clientname);

			String cusername = req.getParameter("cusername");
			session.setAttribute("cusername",cusername);
//out.println("client : " + clientname);
			int areaID = Integer.parseInt(req.getParameter("areaID"));
			String SareaID = "" + areaID;
			session.setAttribute("SareaID",SareaID);

			int cityID = Integer.parseInt(req.getParameter("cityID"));
			String ScityID = "" + cityID;
			session.setAttribute("ScityID",ScityID);

			int stateID = Integer.parseInt(req.getParameter("stateID"));
			String SstateID = "" + stateID;
			session.setAttribute("SstateID",SstateID);

			int countryID = Integer.parseInt(req.getParameter("countryID"));
			String ScountryID = "" + countryID;
			session.setAttribute("ScountryID",ScountryID);
//out.println("country "+ countryID);
			int ctype = Integer.parseInt(req.getParameter("ClientType"));
			String add = req.getParameter("add");
			session.setAttribute("add",add);
			String seats = req.getParameter("seats");
			session.setAttribute("seats",seats);
			String pin = req.getParameter("pin");
			session.setAttribute("pin",pin);
			String phone1 = req.getParameter("phone1");
			session.setAttribute("phone1",phone1);
			String phone2 = req.getParameter("phone2");
			session.setAttribute("phone2",phone2);
			String fax = req.getParameter("fax");
			session.setAttribute("fax",fax);
//out.println("off " + fax);
			String email = req.getParameter("email");
			session.setAttribute("email",email);
			String url = req.getParameter("url");
			session.setAttribute("url",url);
//out.println("examil : " + email);
			String code= "";

			String checkadd = AddressVerify(req,res,areaID,stateID,cityID,countryID );
//out.println("<br>ret : " + checkadd);

			if (checkadd.equals("match found"))
			{
				String usepass = Utils.GenerateString(cusername,5,5);
				sql ="SELECT Username From UserGroupXRef Where Username='" + cusername +"'";
				pstmt = con.prepareStatement(sql);
				rs1 = pstmt.executeQuery();
				if (!rs1.next())
				{
					String lid = (String) vlocationid.get(0);
					sql = "SELECT Code FROM LocationMaster WHERE LocationID=" + lid;
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next())
					{
						code = rs.getString("Code");
					}
					NextValues nvClientID    =   new NextValues("ClientMaster", "ClientID");
					int nextclientid    =    nvClientID.getNextValue();
					boolean val    =    nvClientID.setNextValue();


					sql = "INSERT INTO ClientMaster (ClientID,ClientCode,ClientName,Username,Password,Address,Pincode,LocationID,Phone1,Phone2,Fax,Email,Url,AvailableSeats,ClientType) VALUES ("+nextclientid+",'"+code+"','" +  clientname + "','" + usepass + "','" + usepass + "','" + add + "','" + pin + "','" +	lid + "','" + phone1 + "','"  + phone2 +"','"  + fax +"','" + email + "','" + url +"','"+ seats + "'," + ctype + ")";

	//out.println("<br>"+sql);
					pstmt = con.prepareStatement(sql);
					int confirm = pstmt.executeUpdate();
					sql = "INSERT INTO UserGroupXRef (Username,GroupID) VALUES ('" + usepass + "',15)";
//out.println(sql);
					pstmt = con.prepareStatement(sql);
					confirm = pstmt.executeUpdate();
					if (confirm > 0)
					{
						sql = "SELECT * from ClientMaster WHERE ClientID=" + nextclientid;
						out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
						out.println("<TR><TH COLSPAN=2>Client Details</TH></TR>");
						pstmt = con.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while (rs.next())
						{
						String link = req.getRequestURI() + "?action=doModify&clientid="+nextclientid;
							int type = rs.getInt("ClientType");
							String cltype = "";
							if (type==1){cltype="ZedCA Centre";}else cltype="Client";

	//						out.println("<TR><TD>" + rs.getString("ClientName") + "</TD><TD>" + code + "</TD><TD>" + rs.getString("Address") + "</TD><TD>" + rs.getString("Pincode") + "</TD><TD>" + rs.getString("Phone1") + " " + rs.getString("Phone2") + "</TD><TD>" + rs.getString("Fax") + "</TD><TD>" + rs.getString("Email") + "</TD><TD>" + rs.getString("Url") + "</TD><TD>" + cltype + "</TD><TD><a href='"+link+"'>Modify</a></TD><TD>Delete</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Client Name :</TD><TD>" + rs.getString("ClientName") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Code :</TD><TD>" + code + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Username :</TD><TD>" + rs.getString("Username") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Password :</TD><TD>" + rs.getString("Password") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Address :</TD><TD>" + rs.getString("Address") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Total Seats Available :</TD><TD>" + rs.getInt("AvailableSeats") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Pincode :</TD><TD>" + rs.getString("Pincode") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Telephone :</TD><TD>" + rs.getString("Phone1")+ " " + rs.getString("Phone2") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Fax :</TD><TD>" + rs.getString("Fax") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>E-mail :</TD><TD>" + rs.getString("Email") + "</TD></TR>");
							out.println("<TR><TD ALIGN=RIGHT>Client Type :</TD><TD>" + cltype+ "</TD></TR>");
						}
						out.println("</TABLE>");
						session.removeAttribute("clientname");
						session.removeAttribute("cusername");
						session.removeAttribute("SareaID");
						session.removeAttribute("ScityID");
						session.removeAttribute("SstateID");
						session.removeAttribute("ScountryID");
						session.removeAttribute("add");
						session.removeAttribute("seats");
						session.removeAttribute("pin");
						session.removeAttribute("phone1");
						session.removeAttribute("phone2");
						session.removeAttribute("fax");
						session.removeAttribute("email");
						session.removeAttribute("url");
						res.sendRedirect("ScheduleClient?clientid=" + nextclientid);
					}
				}
				else
				{
					errorstr = "Username already exist !!";
					session.setAttribute("errorstr",errorstr);
					res.sendRedirect(req.getRequestURI());
				}
			}
			else
			{
				errorstr = checkadd;
				session.setAttribute("errorstr",errorstr);
				res.sendRedirect(req.getRequestURI());
			}
		}
		catch(Exception e)
		{
			//out.println("Add Mod Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
	}

	public void Modify(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			int clientid = Integer.parseInt(req.getParameter("clientid"));
//out.println(clientid);
			out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
				out.println("<script language=javascript>");
				out.println("function checkVal(){");
				out.println("var a='document.form2.clientname';");
				out.println("var b='document.form2.add';");
				out.println("var c='document.form2.pin';");
				out.println("var d='document.form2.phone1';");
				out.println("var e='document.form2.phone2';");
				out.println("var f='document.form2.fax';");
				out.println("var g='document.form2.email';");
				out.println("var h='document.form2.url';");
				out.println("var i='document.form2.seats';");


				out.println("if (!isnulls(a)){");
				out.println("	alert('Clien Name Field cannot be Empty !!');");
				out.println("	eval(a).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (eval(a).value.length>20){");
				out.println("	alert('Client Name cannot be more than 20 characters !!');");
				out.println("	eval(a).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!isnulls(b)){");
				out.println("	alert('Address Field cannot be Empty !!');");
				out.println("	eval(b).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!isnulls(i)){");
				out.println("	alert('Total Seats Avaliable Field cannot be Empty !!');");
				out.println("	eval(i).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(i),'Total Seats Avaliable is a Numeric Field')){");
				out.println("	eval(i).value='';");
				out.println("	eval(i).focus();");
				out.println("	return false;}");
				out.println("else if (!checkNumeric(eval(c),'Pincode is a Numeric Field')){");
				out.println("	eval(c).value='';");
				out.println("	eval(c).focus();");
				out.println("	return false;}");
				out.println("else if (!isnulls(c)){");
				out.println("	alert('Pincode Field cannot be Empty !!');");
				out.println("	eval(c).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("if (eval(c).value.length>6){");
				out.println("	alert('Pincode Number should be atlest 6 digits !!');");
				out.println("	eval(c).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(d),'Telephone1 is a Numeric Field')){");
				out.println("	eval(d).value='';");
				out.println("	eval(d).focus();");
				out.println("	return false;}");
				out.println("else if (eval(d).value.length>7){");
				out.println("	alert('Telephone1 cannot be more than 6 digits !!');");
				out.println("	eval(d).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!isnulls(d)){");
				out.println("	alert('Telephone1 Field cannot be Empty !!');");
				out.println("	eval(d).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(e),'Telephone2 is a Numeric Field')){");
				out.println("	eval(e).value='';");
				out.println("	eval(e).focus();");
				out.println("	return false;}");
				out.println("else if (eval(e).value.length>7){");
				out.println("	alert('Telephone2 cannot be more than 6 digits !!');");
				out.println("	eval(e).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(f),'Fax is a Numeric Field')){");
				out.println("	eval(f).value='';");
				out.println("	eval(f).focus();");
				out.println("	return false;}");
				out.println("else if (!isnulls(g)){");
				out.println("	alert('Email Field cannot be Empty !!');");
				out.println("	eval(g).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkEmail(eval(g))){");
				out.println("	eval(g).focus();");
				out.println("	return false;}");
				out.println("else");
				out.println("	document.form2.submit();");
				out.println("}");
				out.println("</script>");
				errorstr = (String) session.getAttribute("errorstr");
				if (errorstr==null){errorstr="";}
				else{out.println("<FONT COLOR=RED>warning !! "+errorstr +" !!</FONT>");}

				out.println("<FORM METHOD=POST NAME=form2 action="+req.getRequestURI()+">");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");

				sql = "SELECT * FROM ClientMaster WHERE ClientID=" + clientid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{


				out.println("<TR><TH COLSPAN=2>Client REGISTRATION FORM FOR BCDE PROGRAME</TH></TR>");
				out.println("<TR><TD align=right>Client Name :</TD><TD><INPUT TYPE=TEXT NAME=clientname VALUE='"+rs.getString("ClientName")+"'><FONT COLOR=red>*</FONT></TD></TR>");


				out.println("<TR><TD ALIGN=RIGHT VALIGN=TOP>Address :</TD><TD><TEXTAREA NAME=add ROWS=5 COLS=20>"+rs.getString("Address")+"</TEXTAREA><FONT COLOR=red>*</FONT></TD></TR>");

				sql = "SELECT LocationID FROM ClientMaster WHERE ClientID=" + clientid;
				int lid =0,areaID=0,cityID=0,stateID=0,countryID=0;
				pstmt = con.prepareStatement(sql);
				rs2 = pstmt.executeQuery();
				while (rs2.next())
				{
					lid = rs2.getInt("LocationID");
				}
				sql = "SELECT AreaID,CityID,StateID,CountryID FROM LocationMaster WHERE LocationID=" + lid;
				pstmt = con.prepareStatement(sql);
				rs2 = pstmt.executeQuery();
				while (rs2.next())
				{
					areaID = rs2.getInt("AreaID");
					cityID = rs2.getInt("CityID");
					stateID = rs2.getInt("StateID");
					countryID = rs2.getInt("CountryID");
				}

					out.println("<TR><TD align=right>Nearest Area:</TD><TD><SELECT NAME=areaID>");
					sql = "SELECT * FROM LocationMaster WHERE AreaID>=1";
					//out.println(sql);
					pstmt = con.prepareStatement(sql);
					rs2 = pstmt.executeQuery();
					while (rs2.next())
					{
						int tempid = rs2.getInt("LocationID");
						if (tempid == lid)
						{
							out.println("<option value="+tempid+" SELECTED>"+rs2.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+tempid+">"+rs2.getString("LocationName")+"</option>");
					}
//				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>City :</TD><TD><SELECT NAME=cityID>");
					sql ="select * from LocationMaster where CityID>=1 and AreaID=1";
//out.println(sql);
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						int templid = rs1.getInt("LocationID");
						int tempsid = rs1.getInt("StateID");
						int tempcityid = rs1.getInt("CityID");
						int tempcoutid = rs1.getInt("CountryID");
//out.println("temp: " + templid + " lid : " + lid);
						if (tempsid == stateID && tempcityid == cityID && tempcoutid == countryID)
						{
							out.println("<option value="+templid+" SELECTED>"+rs1.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+templid+">"+rs1.getString("LocationName")+"</option>");
					}
//				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>State :</TD><TD><SELECT NAME=stateID>");
					sql ="select * from LocationMaster where StateID>=1 and CityID=0 and AreaID=0";
//out.println(sql);
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						int templid = rs1.getInt("LocationID");
						int tempsid = rs1.getInt("StateID");
						int tempcityid = rs1.getInt("CityID");
						int tempcoutid = rs1.getInt("CountryID");
//out.println("temp: " + templid + " lid : " + lid);
						if (tempsid == stateID && tempcoutid == countryID)
						{
							out.println("<option value="+templid+" SELECTED>"+rs1.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+templid+">"+rs1.getString("LocationName")+"</option>");
					}
//				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Country :</TD><TD><SELECT NAME=countryID>");
//				sql = "select distinct(CountryID),LocationID FROM LocationMaster GROUP BY CountryID";
//				rs=stmt.executeQuery(sql);
//				while (rs.next())
//				{
//					int countryid = rs.getInt(1);
//					lid = rs.getInt(2);
					sql = "SELECT * FROM LocationMaster WHERE CountryID>=0 and StateID=0 and CityID=0 and AreaID=0";
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						int tempid = rs1.getInt("LocationID");
						int templid = rs1.getInt("LocationID");
						int tempsid = rs1.getInt("StateID");
						int tempcityid = rs1.getInt("CityID");
						int tempcoutid = rs1.getInt("CountryID");
//out.println("temp: " + templid + " lid : " + lid);
						if (tempcoutid == countryID)
						{
							out.println("<option value="+tempid+" SELECTED>"+rs1.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+tempid+">"+rs1.getString("LocationName")+"</option>");
					}
//				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				int clienttype = rs.getInt("ClientType");
				out.println("<TR><TD align=right>ZedCA Centre :</TD><TD><SELECT NAME=ClientType>");
				if (clienttype==1)
				{
					out.println("<option value=1 selectes>ZedCA Centre</option><option value=2>Client</option></SELECT><FONT COLOR=red>*</FONT></TD></TR>");
				}
				else
				{
					out.println("<option value=1>Type of Client</option><option value=2 selected>Client</option></SELECT><FONT COLOR=red>*</FONT></TD></TR>");
				}

				out.println("<TR><TD align=right>Total Seats Available :</TD><TD><INPUT TYPE=TEXT NAME=seats VALUE="+rs.getInt("AvailableSeats")+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Pincode :</TD><TD><INPUT TYPE=TEXT NAME=pin VALUE="+rs.getString("Pincode")+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Telephone 1 :</TD><TD><INPUT TYPE=TEXT NAME=phone1 VALUE="+rs.getString("Phone1")+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Telephone 2 :</TD><TD><INPUT TYPE=TEXT NAME=phone2 VALUE="+rs.getString("Phone2")+"></TD></TR>");

				out.println("<TR><TD align=right>Fax :</TD><TD><INPUT TYPE=TEXT NAME=fax VALUE="+rs.getString("Fax")+"></TD></TR>");

				out.println("<TR><TD align=right>Email :</TD><TD><INPUT TYPE=TEXT NAME=email VALUE="+rs.getString("Email")+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>URL :</TD><TD><INPUT TYPE=TEXT NAME=url VALUE="+rs.getString("Url")+"></TD></TR>");

				out.println("<TH COLSPAN=4><INPUT TYPE=BUTTON VALUE=Modify onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset></TH>");
				out.println("</TABLE>");
				out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doModifySave'><INPUT TYPE=HIDDEN NAME=clientid VALUE="+clientid+">");
				}
				out.println("</FORM>");
				out.println("</BODY>");
				out.println("</HTML>");
		}
		catch(Exception e)
		{
			out.println("Modification Module Error : " + e.getMessage());
		}
		finally
		{
			if (con != null)
				pool.releaseConnection(con);
	        else
		        out.println("<CENTER><P><BR><B>Error while Releasing Connection from Database.</B>");
		}
	}

	public void ModifySave(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);

//			int cid = Integer.parseInt(req.getParameter("cid"));
			int clientid = Integer.parseInt(req.getParameter("clientid"));
			String clientname = req.getParameter("clientname");

//out.println("action in ModifySave<br>");
//out.println("client : " + clientname);
			int areaID = Integer.parseInt(req.getParameter("areaID"));
			String SareaID = "" + areaID;


			int cityID = Integer.parseInt(req.getParameter("cityID"));
			String ScityID = "" + cityID;

			int stateID = Integer.parseInt(req.getParameter("stateID"));
			String SstateID = "" + stateID;

			int countryID = Integer.parseInt(req.getParameter("countryID"));
			String ScountryID = "" + countryID;
//out.println("country "+ countryID);
			int ctype = Integer.parseInt(req.getParameter("ClientType"));
			String add = req.getParameter("add");
			int seats = Integer.parseInt(req.getParameter("seats"));
			String pin = req.getParameter("pin");
			String phone1 = req.getParameter("phone1");
			String phone2 = req.getParameter("phone2");
			String fax = req.getParameter("fax");
//out.println("off " + fax);
			String email = req.getParameter("email");
			String url = req.getParameter("url");
//out.println("examil : " + email);
			String code= "";

			String checkadd = AddressVerify(req,res,areaID,stateID,cityID,countryID );
//out.println("<br>ret : " + checkadd);

			if (checkadd.equals("match found"))
			{
				String lid = (String) vlocationid.get(0);
				sql = "SELECT Code FROM LocationMaster WHERE LocationID=" + lid;
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					code = rs.getString("Code");
				}

				sql = "UPDATE ClientMaster SET ClientCode='"+ code + "',ClientName='"+clientname+"',Address='" + add +"',Pincode='" + pin + "',LocationID=" + lid + ",Phone1='" + phone1 + "',Phone2='" + phone2 + "',Fax='" + fax +"',Email='" + email +"',Url='" +url + "',AvailableSeats=" + seats +",ClientType="+ ctype +" WHERE ClientID=" +clientid;
//out.println(sql);
//				sql = "INSERT INTO ClientMaster (ClientID,ClientCode,ClientName,Address,Pincode,LocationID,Phone1,Phone2,Fax,Email,Url,ClientType) VALUES ("+nextclientid+",'"+code+"','" +  clientname + "','" + add + "','" + pin + "','" +	lid + "','" + phone1 + "','"  + phone2 +"','"  + fax +"','" + email + "','" + url +"',"  + ctype + ")";

//out.println("<br>"+sql);
 				pstmt = con.prepareStatement(sql);
				int confirm = pstmt.executeUpdate();
				if (confirm > 0)
				{
					sql = "SELECT * from ClientMaster WHERE ClientID=" + clientid;
					out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
					out.println("<TR><TH>Client Name</TH><TH>Client Code</TH><TH>Address</TH><TH>Total Seats Available</TH><TH>Pincode</TH><TH>Phone</TH><TH>Fax</TH><TH>E-mail</TH><TH>URL</TH><TH>Client Type</TH><TH>&nbsp;</TH><TH>&nbsp;</TH></TR>");
					pstmt = con.prepareStatement(sql);
					rs = pstmt.executeQuery();
					while (rs.next())
					{
					String link = req.getRequestURI() + "?action=doModify&clientid="+clientid;
						int type = rs.getInt("ClientType");
						String cltype = "";
						if (type==1){cltype="ZedCA Centre";}else cltype="Others";

						out.println("<TR><TD>" + rs.getString("ClientName") + "</TD><TD>" + code + "</TD><TD>" + rs.getString("Address") + "</TD><TD>" + rs.getString("AvailableSeats") + "</TD><TD>" + rs.getString("Pincode") + "</TD><TD>" + rs.getString("Phone1") + " " + rs.getString("Phone2") + "</TD><TD>" + rs.getString("Fax") + "</TD><TD>" + rs.getString("Email") + "</TD><TD>" + rs.getString("Url") + "</TD><TD>" + cltype + "</TD><TD><a href='"+link+"'>Modify</a></TD><TD>Delete</TD></TR>");
					}
					out.println("</TABLE>");
				}
			}
			else
			{
				errorstr = checkadd;
				session.setAttribute("errorstr",errorstr);
				res.sendRedirect(req.getRequestURI());
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

	public void ConfirmDelete(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			int clientid = Integer.parseInt(req.getParameter("ClientID"));
			int lid=0;
			String code="";
			sql = "SELECT LocationID FROM ClientMaster WHERE ClientID=" + clientid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				lid = rs.getInt("LocationID");
			}
			sql = "SELECT Code FROM LocationMaster WHERE LocationID=" + lid;
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next())
			{
				code = rs.getString("Code");
			}
			sql = "SELECT * from ClientMaster WHERE ClientID=" + clientid;
			out.println("<BR><B>Are you Sure you want to DELETE the Client Details ?</B><BR>");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH>Client Name</TH><TH>Client Code</TH><TH>Address</TH><TH>Total Seats Avaliable</TH><TH>Pincode</TH><TH>Phone</TH><TH>Fax</TH><TH>E-mail</TH><TH>URL</TH><TH>Client Type</TH></TR>");
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			String username = "";
			while (rs.next())
			{
//				String link = req.getRequestURI() + "?action=doModify&clientid="+clientid;
				int type = rs.getInt("ClientType");
				username = rs.getString("Username");
				String cltype = "";
				if (type==1){cltype="Others";}else cltype="ZedCA Centre";

				out.println("<TR><TD>" + rs.getString("ClientName") + "</TD><TD>" + code + "</TD><TD>" + rs.getString("Address") + "</TD><TD>" + rs.getString("AvailableSeats") + "</TD><TD>" + rs.getString("Pincode") + "</TD><TD>" + rs.getString("Phone1") + " " + rs.getString("Phone2") + "</TD><TD>" + rs.getString("Fax") + "</TD><TD>" + rs.getString("Email") + "</TD><TD>" + rs.getString("Url") + "</TD><TD>" + cltype + "</TD></TR>");
			}
			out.println("</TABLE>");
			out.println("<FORM NAME=frmdelete METHOD=POST action="+req.getRequestURI()+">");

			out.println("<INPUT TYPE=SUBMIT VALUE=Delete>&nbsp;<INPUT TYPE=BUTTON VALUE=Back onclick=javascript:history.back();>");
			out.println("<INPUT TYPE=HIDDEN NAME=action VALUE=doDelete><INPUT TYPE=HIDDEN NAME=ClientID VALUE="+clientid+"><INPUT TYPE=HIDDEN NAME=username value="+username+">");
			out.println("</FORM>");
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

	public void Delete(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			int clientid = Integer.parseInt(req.getParameter("ClientID"));
			String username = req.getParameter("username");
			sql = "DELETE FROM ClientMaster WHERE ClientID=" + clientid;
			pstmt = con.prepareStatement(sql);
			int confirm = pstmt.executeUpdate();
			if (confirm>0)
			{
				sql = "DELETE FROM UserGroupXRef WHERE username='" + username + "'";
				pstmt = con.prepareStatement(sql);
				confirm = pstmt.executeUpdate();
				if (confirm>0)
				{
					out.println("Client successfully deleted !!");
				}

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

	public void NewClient(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
				res.setContentType("text/html");
				out.println("<HTML><HEAD><TITLE>Client Registration Form</TITLE>");
				out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
				out.println("<BODY><CENTER>");
				out.println("<script language='javascript' src='../js/validatefunction.js'></script>");
				out.println("<script language=javascript>");
				out.println("function checkVal(){");
				out.println("var a='document.form1.clientname';");
				out.println("var b='document.form1.add';");
				out.println("var c='document.form1.pin';");
				out.println("var d='document.form1.phone1';");
				out.println("var e='document.form1.phone2';");
				out.println("var f='document.form1.fax';");
				out.println("var g='document.form1.email';");
				out.println("var h='document.form1.url';");
				out.println("var i='document.form1.seats';");
				out.println("var j='document.form1.cusername';");

				out.println("if (!isnulls(a)){");
				out.println("	alert('Clien Name Field cannot be Empty !!');");
				out.println("	eval(a).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (eval(a).value.length>20){");
				out.println("	alert('Client Name cannot be more than 20 characters !!');");
				out.println("	eval(a).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!isnulls(j)){");
				out.println("	alert('Username Field cannot be Empty !!');");
				out.println("	eval(j).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!isnulls(b)){");
				out.println("	alert('Address Field cannot be Empty !!');");
				out.println("	eval(b).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!isnulls(i)){");
				out.println("	alert('Total Seats Avaliable Field cannot be Empty !!');");
				out.println("	eval(i).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(i),'Total Seats Avaliable is a Numeric Field')){");
				out.println("	eval(i).value='';");
				out.println("	eval(i).focus();");
				out.println("	return false;}");
				out.println("else if (!checkNumeric(eval(c),'Pincode is a Numeric Field')){");
				out.println("	eval(c).value='';");
				out.println("	eval(c).focus();");
				out.println("	return false;}");
				out.println("else if (!isnulls(c)){");
				out.println("	alert('Pincode Field cannot be Empty !!');");
				out.println("	eval(c).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("if (eval(c).value.length>6){");
				out.println("	alert('Pincode Number should be atlest 6 digits !!');");
				out.println("	eval(c).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(d),'Telephone1 is a Numeric Field')){");
				out.println("	eval(d).value='';");
				out.println("	eval(d).focus();");
				out.println("	return false;}");
				out.println("else if (eval(d).value.length>7){");
				out.println("	alert('Telephone1 cannot be more than 6 digits !!');");
				out.println("	eval(d).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!isnulls(d)){");
				out.println("	alert('Telephone1 Field cannot be Empty !!');");
				out.println("	eval(d).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(e),'Telephone2 is a Numeric Field')){");
				out.println("	eval(e).value='';");
				out.println("	eval(e).focus();");
				out.println("	return false;}");
				out.println("else if (eval(e).value.length>7){");
				out.println("	alert('Telephone2 cannot be more than 6 digits !!');");
				out.println("	eval(e).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkNumeric(eval(f),'Fax is a Numeric Field')){");
				out.println("	eval(f).value='';");
				out.println("	eval(f).focus();");
				out.println("	return false;}");
				out.println("else if (!isnulls(g)){");
				out.println("	alert('Email Field cannot be Empty !!');");
				out.println("	eval(g).focus();");
				out.println("	return false;");
				out.println("}");
				out.println("else if (!checkEmail(eval(g))){");
				out.println("	eval(g).focus();");
				out.println("	return false;}");
				out.println("else");
				out.println("	document.form1.submit();");
				out.println("}");
				out.println("</script>");

				String clientname = (String) session.getAttribute("clientname");
				if (clientname==null){clientname="";}
				String cusername = (String) session.getAttribute("cusername");
				if (cusername==null){cusername="";}
				String add = (String) session.getAttribute("add");
				if (add==null){add="";}
				String seats = (String) session.getAttribute("seats");
				if (seats==null){seats="";}
				String pin = (String) session.getAttribute("pin");
				if (pin==null){pin="";}
				String phone1= (String) session.getAttribute("phone1");
				if (phone1==null){phone1="";}
				String phone2= (String) session.getAttribute("phone2");
				if (phone2==null){phone2="";}
				String fax = (String) session.getAttribute("fax");
				if (fax==null){fax="";}
				String email = (String) session.getAttribute("email");
				if (email==null){email="";}
				String url= (String) session.getAttribute("url");
				if (url==null){url="";}

				String SareaID = (String) session.getAttribute("SareaID");
				int areaID =0;
				if (SareaID != null)
				{
//out.println("Sareaid "+ SareaID);
					areaID = Integer.parseInt(SareaID);
//out.println("area "+ areaID);
				}
				String ScityID = (String)session.getAttribute("ScityID");
				int cityID =0;
				if (ScityID != null)
				{
					cityID = Integer.parseInt(ScityID);
//out.println("city "+ cityID);
				}
				String SstateID = (String)session.getAttribute("SstateID");
				int stateID =0;
				if (SstateID !=null)
				{
					stateID = Integer.parseInt(SstateID);
//out.println("state "+ stateID);
				}
				String ScountryID = (String)session.getAttribute("ScountryID");
				int countryID=0;
				if (ScountryID != null)
				{
					countryID = Integer.parseInt(ScountryID);
//out.println("country "+ countryID);
				}

				errorstr = (String) session.getAttribute("errorstr");
				if (errorstr==null){errorstr="";}
				else{out.println("Warning !! "+errorstr +" !!");}

				out.println("<FORM METHOD=POST NAME=form1 action="+req.getRequestURI()+">");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH COLSPAN=2>Client REGISTRATION FORM FOR BCDE PROGRAME</TH></TR>");
				out.println("<TR><TD align=right>Client Name :</TD><TD><INPUT TYPE=TEXT NAME=clientname VALUE="+clientname+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>User name :</TD><TD><INPUT TYPE=TEXT NAME=cusername VALUE="+cusername+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD ALIGN=RIGHT VALIGN=TOP>Address :</TD><TD><TEXTAREA NAME=add ROWS=5 COLS=20>"+add+"</TEXTAREA><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Nearest Area:</TD><TD><SELECT NAME=areaID>");
				sql = "select distinct(CountryID),LocationID,StateID,AreaID FROM LocationMaster where StateID != 0 and CityID != 0 and AreaID!=0 GROUP BY CountryID,StateID,CityID,AreaID";
				pstmt = con.prepareStatement(sql);
				rs=pstmt.executeQuery();
				int lid=0;
				while (rs.next())
				{
					int countryid = rs.getInt(1);
					lid = rs.getInt("LocationID");
					sql = "SELECT * FROM LocationMaster WHERE CountryID=" + countryid + " AND LocationID=" + lid ;//+ "AND StateID=" + stateid + " AND CityID=" +  areaid ;
//out.println(sql);
					pstmt = con.prepareStatement(sql);
					rs1=pstmt.executeQuery();
					while (rs1.next())
					{
						int tempid = rs1.getInt("LocationID");
						if (tempid == areaID)
						{
							out.println("<option value="+lid+" SELECTED>"+rs1.getString("LocationName")+"</option>");
						}
						else
						out.println("<option value="+lid+">"+rs1.getString("LocationName")+"</option>");
					}
				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>City :</TD><TD><SELECT NAME=cityID>");
				sql = "select distinct(CountryID),LocationID,StateID,CityID FROM LocationMaster where StateID != 0 and CityID != 0 GROUP BY CountryID,StateID,CityID";
				pstmt = con.prepareStatement(sql);
				rs=pstmt.executeQuery(sql);
				while (rs.next())
				{
					int countryid = rs.getInt(1);
					lid = rs.getInt(2);
					sql = "SELECT * FROM LocationMaster WHERE CountryID=" + countryid + " AND LocationID=" + lid;
					pstmt = con.prepareStatement(sql);
					rs1 = pstmt.executeQuery();
					while (rs1.next())
					{
						int tempid = rs1.getInt("LocationID");
						if (tempid == cityID)
						{
							out.println("<option value="+lid+" SELECTED>"+rs1.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+lid+">"+rs1.getString("LocationName")+"</option>");
					}
				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>State :</TD><TD><SELECT NAME=stateID>");
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
						int tempid = rs1.getInt("LocationID");
						if (tempid == stateID)
						{
							out.println("<option value="+lid+">"+rs1.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+lid+">"+rs1.getString("LocationName")+"</option>");
					}
				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Country :</TD><TD><SELECT NAME=countryID>");
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
						int tempid = rs1.getInt("LocationID");
						if (tempid == countryID)
						{
						out.println("<option value="+lid+">"+rs1.getString("LocationName")+"</option>");
						}
						else
							out.println("<option value="+lid+">"+rs1.getString("LocationName")+"</option>");
					}
				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Type of Client :</TD><TD><SELECT NAME=ClientType><option value=1 SELECTED>ZedCA Centre</option><option value=2>Client</option></SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Total Seats Avaliable :</TD><TD><INPUT TYPE=TEXT NAME=seats VALUE="+seats+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Pincode :</TD><TD><INPUT TYPE=TEXT NAME=pin VALUE="+pin+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Telephone 1 :</TD><TD><INPUT TYPE=TEXT NAME=phone1 VALUE="+phone1+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Telephone 2 :</TD><TD><INPUT TYPE=TEXT NAME=phone2 VALUE="+phone2+"></TD></TR>");

				out.println("<TR><TD align=right>Fax :</TD><TD><INPUT TYPE=TEXT NAME=fax VALUE="+fax+"></TD></TR>");

				out.println("<TR><TD align=right>Email :</TD><TD><INPUT TYPE=TEXT NAME=email VALUE="+email+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>URL :</TD><TD><INPUT TYPE=TEXT NAME=url VALUE="+url+"></TD></TR>");

				out.println("<TH COLSPAN=4><INPUT TYPE=BUTTON VALUE=Submit onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset>&nbsp;<INPUT TYPE=BUTTON VALUE=Close onclick='javascript:window.close();'></TH>");
				out.println("</TABLE>");
				out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doAdd'>");//<INPUT TYPE=HIDDEN NAME=cid VALUE="+cid+">
				out.println("</FORM>");
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

	public void View(HttpServletRequest req,HttpServletResponse res) throws ServletException,IOException
	{
		res.setContentType("TEXT/HTML");
		PrintWriter out = res.getWriter();
		out.println("<HTML><HEAD><TITLE>Registration Confirmation</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		String sql = null,errorstr="";
		try
		{
			con = pool.getConnection();
			HttpSession session=req.getSession(true);
			int clientid=0,lid=0,count=1;
			String code ="";
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH>Sr. No.</TH><TH>Client Name</TH><TH>Client Code</TH><TH>Address</TH><TH>Total Seats Available</TH><TH>E-mail</TH><TH>Client Type</TH><TH>&nbsp;</TH><TH>&nbsp;</TH></TR>");
			sql = "SELECT * FROM ClientMaster ORDER BY ClientID" ;
//out.println(sql);
  			pstmt = con.prepareStatement(sql);
	  		rs = pstmt.executeQuery();
			while (rs.next())
			{
				clientid = rs.getInt("ClientID");
				lid = rs.getInt("LocationID");
//				sql = "SELECT Code FROM LocationMaster WHERE LocationID=" + lid;
//				rs1 = stmt1.executeQuery(sql);
//				while (rs1.next())
//				{
					code = rs.getString("ClientCode");
//				}
				int type = rs.getInt("ClientType");
				String cltype = "";
				if (type==1){cltype="ZedCA Centre";}else cltype="Others";

				String link = req.getRequestURI() + "?action=doModify&clientid="+clientid;
				String dellink = req.getRequestURI() + "?action=doConfirmDelete&ClientID="+clientid;
				out.println("<TR><TD ALIGN=RIGHT>"+count+"</TD><TD>" + rs.getString("ClientName") + "</TD><TD ALIGN=CENTER>" + code + "</TD><TD>" + rs.getString("Address") + "</TD><TD ALIGN=CENTER>" + rs.getString("AvailableSeats") + "</TD><TD>" + rs.getString("Email") + "</TD><TD>" + cltype + "</TD><TD><a href='"+link+"'>Modify</a></TD><TD><a href='"+dellink+"'>Delete</A></TD></TR>");
				count++;
			}
			out.println("<TR><Th COLSPAN=9	align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
			out.println("</TABLE><BR>");
			out.println("<FORM NAME=frmnewclient action="+req.getRequestURI()+">");
			out.println("<INPUT TYPE=SUBMIT VALUE='New Client'>");
			out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doNewClient'");
			out.println("</FORM>");
			out.println("</BODY>");
			out.println("</HTML>");
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
}
