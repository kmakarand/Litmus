<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		Vector vlocationid = new Vector();
		EntityManager em = EntityManagerHelper.getEntityManager();
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("clientregistrationform.jsp");
		Connection con = pool.getConnection();
		log.info("clientregistrationform start 	:");
		String action = request.getParameter("action");
		log.info("clientregistrationform start 	action:"+action);
		out.println("<HTML><HEAD><TITLE>Registration Confirmation</TITLE>");
		out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		
		if (action == null || action == "")
		{
			try
			{
				int clientid=0,lid=0,count=1;
				String code ="";
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<br><br><TR><TH COLSPAN=9>CLIENT INFORMATION FOR NECTAR EXAMINATION PROGRAM</TH></TR>");
				out.println("<TR><TH>Sr. No.</TH><TH>Client Name</TH><TH>Client Code</TH><TH>Address</TH><TH>Total Seats Available</TH><TH>E-mail</TH><TH>Client Type</TH><TH>&nbsp;</TH><TH>&nbsp;</TH></TR>");
				ClientmasterDAO clmDAO = new ClientmasterDAO();
				List<Clientmaster> clmList = clmDAO.findAll();
				for (Clientmaster clm:clmList)
				{
					clientid = clm.getClientId();
					lid = clm.getLocationId();
					code = clm.getClientCode();
					int type = clm.getClientType();
					String cltype = "";
					if (type==1){cltype="ZedCA Centre";}else cltype="Others";
	
					String link = request.getRequestURI() + "?action=doModify&clientid="+clientid;
					String dellink = request.getRequestURI() + "?action=doConfirmDelete&ClientID="+clientid;
					out.println("<TR><TD ALIGN=center>"+count+"</TD><TD>" + clm.getClientName() + "</TD><TD ALIGN=CENTER>" + code + "</TD><TD>" + clm.getAddress() + "</TD><TD ALIGN=CENTER>" + clm.getAvailableSeats() + "</TD><TD>" + clm.getEmail() + "</TD><TD>" + cltype + "</TD><TD><a href='"+link+"'>Modify</a></TD><TD><a href='"+dellink+"'>Delete</A></TD></TR>");
					count++;
				}
				out.println("<TR><Th COLSPAN=9 align=center><INPUT TYPE=BUTTON Value='Go Back' onclick='history.back();'></Th></TR>");
				out.println("</TABLE><BR>");
				out.println("<FORM NAME=frmnewclient action="+request.getRequestURI()+">");
				out.println("<INPUT TYPE=SUBMIT VALUE='New Client'>");
				out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doNewClient'>");
			}catch(Exception e)		{
				out.println("Add Mod Error : " + e.getMessage());
			}
			finally	{	
			}
			
		}
		else if (action.equalsIgnoreCase("doNewClient"))
		{
			String sql = null,errorstr="";
			try
			{
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
					out.println("else if (eval(a).value.length>30){");
					out.println("	alert('Client Name cannot be more than 30 characters !!');");
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
					out.println("if (eval(c).value.length>11){");
					out.println("	alert('Pincode Number should be atlest 10 digits !!');");
					out.println("	eval(c).focus();");
					out.println("	return false;");
					out.println("}");
					out.println("else if (!checkNumeric(eval(d),'Telephone1 is a Numeric Field')){");
					out.println("	eval(d).value='';");
					out.println("	eval(d).focus();");
					out.println("	return false;}");
					out.println("else if (eval(d).value.length>12){");
					out.println("	alert('Telephone1 cannot be more than 12 digits !!');");
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
					out.println("else if (eval(e).value.length>12){");
					out.println("	alert('Telephone2 cannot be more than 12 digits !!');");
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
	
					out.println("<FORM METHOD=POST NAME=form1 action="+request.getRequestURI()+">");
					out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
					out.println("<BR><BR><TR><TH COLSPAN=2>CLIENT REGISTRATION FORM FOR NECTAR EXAMINATION PROGRAM</TH></TR>");
					out.println("<TR><TD align=right>Client Name :</TD><TD><INPUT TYPE=TEXT NAME=clientname VALUE="+clientname+"><FONT COLOR=red>*</FONT></TD></TR>");
					out.println("<TR><TD align=right>User name :</TD><TD><INPUT TYPE=TEXT NAME=cusername VALUE="+cusername+"><FONT COLOR=red>*</FONT></TD></TR>");
					out.println("<TR><TD ALIGN=RIGHT VALIGN=TOP>Address :</TD><TD><TEXTAREA NAME=add ROWS=5 COLS=20>"+add+"</TEXTAREA><FONT COLOR=red>*</FONT></TD></TR>");
					out.println("<TR><TD align=right>Nearest Area:</TD><TD><SELECT NAME=areaID>");
				
					//sql = "select distinct(lm.countryId),lm.localtionId,lm.stateId,lm.cityId,lm.areaId Locationmaster lm where lm.stateId != 0 and lm.cityId != 0 and lm.areaId!=0 GROUP BY lm.countryId,lm.localtionId,lm.stateId,lm.cityId,lm.areaId";
					/*sql = "select distinct(lm.countryId),lm.locationId,lm.stateId,lm.cityId,lm.areaId "+ 
						  "from Locationmaster lm where lm.stateId <>0 and lm.cityId <> 0 and lm.areaId<>0 GROUP BY "+
						  "lm.countryId,lm.locationId,lm.stateId,lm.cityId,lm.areaId";*/
					//sql ="select distinct(lm.countryId) from Locationmaster lm";
					query = em.createNamedQuery("ClientRegistrationForm-Locationmaster1.sql2");
					List<Object[]> objList = query.getResultList();
					int lid=0;
					for(Object[] obj:objList)
					{
						int CountryId = (Integer) obj[0];
						lid = (Integer) obj[1];
						String locationName = (String) obj[2];
						////log.info("countryid	:"+CountryId);
						////log.info("locationId:"+lid);
						////log.info("loationName:"+locationName);
						int tempid = lid;
						if (tempid == areaID)
						{
							out.println("<option value="+lid+" SELECTED>"+locationName+"</option>");
						}
						else
						out.println("<option value="+lid+">"+locationName+"</option>");
						}
					
					out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");
	
					out.println("<TR><TD align=right>City :</TD><TD><SELECT NAME=cityID>");
					List<Locationmaster> lmList=null;
					sql ="select lm from Locationmaster lm where lm.cityId>0";
					query = em.createQuery(sql);
					lmList = query.getResultList();
					for (Locationmaster citylml:lmList)
					{
						int tempcityid = citylml.getCityId();
						out.println("<option value="+tempcityid+" SELECTED>"+citylml.getLocationName()+"</option>");
						//System.out.println("city temp: " + tempcityid + " lml.getLocationName() : " + citylml.getLocationName());
					}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");
				out.println("<TR><TD align=right>State :</TD><TD><SELECT NAME=stateID>");
					sql ="select lm from Locationmaster lm where lm.stateId>0 and lm.cityId=0";
					query = em.createQuery(sql);
					lmList = query.getResultList();
					for (Locationmaster statelml:lmList)
					{
						int tempsid = statelml.getStateId();
						out.println("<option value="+tempsid+" SELECTED>"+statelml.getLocationName()+"</option>");
						//System.out.println("state temp: " + tempsid + " lml.getLocationName() : " + statelml.getLocationName());
					}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");
	
				out.println("<TR><TD align=right>Country :</TD><TD><SELECT NAME=countryID>");
					sql = "SELECT lm FROM Locationmaster lm WHERE lm.countryId>0 and lm.stateId=0 and lm.cityId=0 and lm.areaId=0";
					query = em.createQuery(sql);
					lmList = query.getResultList();
					for (Locationmaster countrylml:lmList)
					{
						int tempcntryid = countrylml.getCountryId();
						out.println("<option value="+tempcntryid+" SELECTED>"+countrylml.getLocationName()+"</option>");
						//System.out.println("country temp: " + tempcntryid + " lml.getLocationName() : " + countrylml.getLocationName());
					}
	//			}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");
	
					out.println("<TR><TD align=right>Type of Client :</TD><TD><SELECT NAME=ClientType><option value=1 SELECTED>Owner</option><option value=2>Client</option></SELECT><FONT COLOR=red>*</FONT></TD></TR>");
	
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
				
			}
			
		}
		else if (action.equalsIgnoreCase("doAdd"))
		{
			String sql = null,errorstr="";
			try
			{
				//int cid = Integer.parseInt(request.getParameter("cid"));
				////log.info("Add cid:"+cid);
				String clientname = request.getParameter("clientname");
				session.setAttribute("clientname",clientname);
	
				String cusername = request.getParameter("cusername");
				session.setAttribute("cusername",cusername);
	//out.println("client : " + clientname);
				int areaID = Integer.parseInt(request.getParameter("areaID"));
				String SareaID = "" + areaID;
				session.setAttribute("SareaID",SareaID);
	
				int cityID = Integer.parseInt(request.getParameter("cityID"));
				String ScityID = "" + cityID;
				session.setAttribute("ScityID",ScityID);
	
				int stateID = Integer.parseInt(request.getParameter("stateID"));
				String SstateID = "" + stateID;
				session.setAttribute("SstateID",SstateID);
	
				int countryID = Integer.parseInt(request.getParameter("countryID"));
				String ScountryID = "" + countryID;
				session.setAttribute("ScountryID",ScountryID);
	//out.println("country "+ countryID);
				int ctype = Integer.parseInt(request.getParameter("ClientType"));
				String add = request.getParameter("add");
				session.setAttribute("add",add);
				int seats = Integer.parseInt(request.getParameter("seats"));
				session.setAttribute("seats",seats);
				String pin = request.getParameter("pin");
				session.setAttribute("pin",pin);
				String phone1 = request.getParameter("phone1");
				session.setAttribute("phone1",phone1);
				String phone2 = request.getParameter("phone2");
				session.setAttribute("phone2",phone2);
				String fax = request.getParameter("fax");
				session.setAttribute("fax",fax);
	//out.println("off " + fax);
				String email = request.getParameter("email");
				session.setAttribute("email",email);
				String url = request.getParameter("url");
				session.setAttribute("url",url);
	//out.println("examil : " + email);
				String code= "";
				//log.info("areaID"+areaID);
				//log.info("stateID"+stateID);
				//log.info("cityID"+cityID);
				//log.info("countryID"+countryID);
				String locID = Utils.AddressVerify(areaID,stateID,cityID,countryID );
	//out.println("<br>ret : " + checkadd);
				//log.info("Add checkadd"+checkadd);
				if (locID != null)
				{
					String username ="";
					String usepass = Utils.GenerateString(cusername,5,5);
					sql ="SELECT ugf.username From Usergroupxref ugf Where ugf.username=?1";
					query = em.createQuery(sql);
					query.setParameter(1, cusername);
					//log.info("Add cusername"+cusername);
					if (EntityManagerHelper.getSingleResult(query)!=null)
					{
						log.info("Username already exist !!");
						errorstr = "Username already exist !!";
						session.setAttribute("errorstr",errorstr);
						response.sendRedirect(request.getRequestURI());
					}
					else{
						username = cusername;
						log.info("Register new Client "+username+"-"+locID);
						//String locID = (String)session.getAttribute("seslocationid");
						//log.info("locID :"+locID);
						int lid = Integer.parseInt(locID);
						//log.info("Add lid"+lid);
						sql ="SELECT lm.code from Locationmaster lm where lm.locationId=?1";
						query = em.createQuery(sql);
						query.setParameter(1, lid);
						code = (String)query.getSingleResult();
						//log.info("Add code"+code);
						NextValues nvClientID    =   new NextValues("ClientMaster","ClientID");
						int nextclientid    =    nvClientID.getNextValue();
						boolean val    =    nvClientID.setNextValue();
						nextclientid    =    nvClientID.getNextValue();
						//log.info("Add val"+val);
						Clientmaster clm = new Clientmaster();
						ClientmasterDAO clmDAO = new ClientmasterDAO();
						clm.setClientId(nextclientid);
						clm.setClientCode(code);
						clm.setClientName(clientname);
						clm.setUsername(username);
						clm.setPassword(Encrypter.encrypt(usepass));
						clm.setAddress(add);
						clm.setPincode(pin);
						clm.setLocationId(lid);
						clm.setPhone1(phone1);
						clm.setPhone2(phone2);
						clm.setFax(fax);
						clm.setEmail(email);
						clm.setUrl(url);
						clm.setAvailableSeats(seats);
						clm.setClientType(ctype);
						EntityManagerHelper.beginTransaction();
						clmDAO.save(clm);
						EntityManagerHelper.commit();
						Usergroupxref ugx = new Usergroupxref();
						UsergroupxrefDAO ugxDAO = new UsergroupxrefDAO();
						
						ugx.setUsername(username);
						ugx.setGroupId("15");
						EntityManagerHelper.beginTransaction();
						boolean confirm = ugxDAO.save(ugx);
						EntityManagerHelper.commit();
						log.info("confirm  ugx saved successfully"+confirm);
						if (confirm)
						{
							ClientmasterDAO cmDAO = new ClientmasterDAO();
							Clientmaster cm = cmDAO.findById(nextclientid);
							if(cm!=null)
							{
								String link = request.getRequestURI() + "?action=doModify&clientid="+nextclientid;
								int type = cm.getClientType();
								String cltype = "";
								if (type==1)
								{
									cltype="ZedCA Centre";}else cltype="Client";
								    out.println("<BR></BR><BR></BR>");
									out.println("<TR><h4>Client Registered Successfully</h4></TR>");
			//						out.println("<TR><TD>" + rs.getString("ClientName") + "</TD><TD>" + code + "</TD><TD>" + rs.getString("Address") + "</TD><TD>" + rs.getString("Pincode") + "</TD><TD>" + rs.getString("Phone1") + " " + rs.getString("Phone2") + "</TD><TD>" + rs.getString("Fax") + "</TD><TD>" + rs.getString("Email") + "</TD><TD>" + rs.getString("Url") + "</TD><TD>" + cltype + "</TD><TD><a href='"+link+"'>Modify</a></TD><TD>Delete</TD></TR>");
									/*out.println("<TR><TD ALIGN=RIGHT>Client Name :</TD><TD>" + cm.getClientName() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Code :</TD><TD>" + code + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Username :</TD><TD>" + cm.getUsername() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Password :</TD><TD>" + cm.getPassword() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Address :</TD><TD>" + cm.getAddress() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Total Seats Available :</TD><TD>" + cm.getAvailableSeats() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Pincode :</TD><TD>" + cm.getPincode() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Telephone :</TD><TD>" + cm.getPhone1()+ " " + cm.getPhone2() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Fax :</TD><TD>" + cm.getFax() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>E-mail :</TD><TD>" + cm.getEmail() + "</TD></TR>");
									out.println("<TR><TD ALIGN=RIGHT>Client Type :</TD><TD>" + cltype+ "</TD></TR>");*/
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
								//response.sendRedirect("ScheduleClient?clientid=" + nextclientid);
							}
					}
					
				}
				else
				{
					errorstr = "checkadd";
					session.setAttribute("errorstr",errorstr);
					response.sendRedirect(request.getRequestURI());
				}
			}
			catch(Exception e)
			{
				out.println("Add Mod Error : " + e.getMessage());
			}
			finally
			{
				
			}
		}
		else if (action.equalsIgnoreCase("doModify"))
		{
			String sql = null,errorstr="";
			try
			{
				int clientid = Integer.parseInt(request.getParameter("clientid"));
				//log.info("Modify clientid"+clientid);
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
				out.println("else if (eval(a).value.length>30){");
				out.println("	alert('Client Name cannot be more than 30 characters !!');");
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
				out.println("else if (eval(d).value.length>12){");
				out.println("	alert('Telephone1 cannot be more than 12 digits !!');");
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
				out.println("else if (eval(e).value.length>12){");
				out.println("	alert('Telephone2 cannot be more than 12 digits !!');");
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

				out.println("<FORM METHOD=POST NAME=form2 action="+request.getRequestURI()+">");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				
				ClientmasterDAO clmDAO = new ClientmasterDAO();
				Clientmaster clm = clmDAO.findById(clientid);
				if(clm!=null)
				{
				out.println("<br><br><TR><TH COLSPAN=2>CLIENT REGISTRATION FORM FOR NECTAR EXAMINATION PROGRAM</TH></TR>");
				out.println("<TR><TD align=right>Client Name :</TD><TD><INPUT TYPE=TEXT NAME=clientname VALUE='"+clm.getClientName()+"'><FONT COLOR=red>*</FONT></TD></TR>");
				out.println("<TR><TD ALIGN=RIGHT VALIGN=TOP>Address :</TD><TD><TEXTAREA NAME=add ROWS=5 COLS=20>"+clm.getAddress()+"</TEXTAREA><FONT COLOR=red>*</FONT></TD></TR>");
				//log.info("CLIENT REGISTRATION FORM");
				//System.out.println("CLIENT REGISTRATION FORM");
				sql = "SELECT clm.locationId FROM Clientmaster clm WHERE clm.clientId=?1";
				int lid =0,areaID=0,cityID=0,stateID=0,countryID=0;
				query = em.createQuery(sql);
				query.setParameter(1, clientid);
				if(EntityManagerHelper.getSingleResult(query)!=null)
				{
					lid = (Integer)query.getSingleResult();
					//log.info("CLIENT REGISTRATION FORM lid"+lid);
				}
				sql = "SELECT lm FROM Locationmaster lm WHERE lm.locationId=?1";
				query = em.createQuery(sql);
				query.setParameter(1, lid);
				Locationmaster lm = null;
				if(EntityManagerHelper.getSingleResult(query)!=null)
				{
					lm = (Locationmaster)query.getSingleResult();
					areaID = lm.getAreaId();
					cityID = lm.getCityId();
					stateID = lm.getStateId();
					countryID = lm.getCountryId();
				}
				

				out.println("<TR><TD align=right>Nearest Area:</TD><TD><SELECT NAME=areaID>");
				sql ="select lm from Locationmaster lm where lm.locationId=?1 and lm.areaId=?2";
				query = em.createQuery(sql);
				query.setParameter(1, lid);
				query.setParameter(2, areaID);
				List<Locationmaster> lmList = query.getResultList();
				for (Locationmaster arealml:lmList)
				{
					int tempareaid = arealml.getAreaId();
					out.println("<option value="+tempareaid+" SELECTED>"+arealml.getLocationName()+"</option>");
					//System.out.println("area temp: " + tempareaid + " lml.getLocationName() : " + arealml.getLocationName());
				}
//			}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");
				out.println("<TR><TD align=right>City :</TD><TD><SELECT NAME=cityID>");
					sql ="select lm from Locationmaster lm where lm.cityId=?1 and lm.areaId=?2";
					query = em.createQuery(sql);
					query.setParameter(1, cityID);
					query.setParameter(2, areaID);
					lmList = query.getResultList();
					for (Locationmaster citylml:lmList)
					{
						int tempcityid = citylml.getCityId();
						out.println("<option value="+tempcityid+" SELECTED>"+citylml.getLocationName()+"</option>");
						//System.out.println("city temp: " + tempcityid + " lml.getLocationName() : " + citylml.getLocationName());
					}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");
				out.println("<TR><TD align=right>State :</TD><TD><SELECT NAME=stateID>");
					sql ="select lm from Locationmaster lm where lm.stateId=?1 and lm.cityId=0 and lm.areaId=0";
					query = em.createQuery(sql);
					query.setParameter(1, stateID);
					lmList = query.getResultList();
					for (Locationmaster statelml:lmList)
					{
						int tempsid = statelml.getStateId();
						out.println("<option value="+tempsid+" SELECTED>"+statelml.getLocationName()+"</option>");
						//System.out.println("state temp: " + tempsid + " lml.getLocationName() : " + statelml.getLocationName());
					}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Country :</TD><TD><SELECT NAME=countryID>");
					sql = "SELECT lm FROM Locationmaster lm WHERE lm.countryId=?1 and lm.stateId=0 and lm.cityId=0 and lm.areaId=0";
					query = em.createQuery(sql);
					query.setParameter(1, countryID);
					lmList = query.getResultList();
					for (Locationmaster countrylml:lmList)
					{
						int tempcntryid = countrylml.getCountryId();
						out.println("<option value="+tempcntryid+" SELECTED>"+countrylml.getLocationName()+"</option>");
						//System.out.println("country temp: " + tempcntryid + " lml.getLocationName() : " + countrylml.getLocationName());
					}
//				}
				out.println("</SELECT><FONT COLOR=red>*</FONT></TD></TR>");

				int clienttype = clm.getClientType();
				out.println("<TR><TD align=right>ZedCA Centre :</TD><TD><SELECT NAME=ClientType>");
				if (clienttype==1)
				{
					out.println("<option value=1 selected>ZedCA Centre</option><option value=2>Client</option></SELECT><FONT COLOR=red>*</FONT></TD></TR>");
				}
				else
				{
					out.println("<option value=1>Type of Client</option><option value=2 selected>Client</option></SELECT><FONT COLOR=red>*</FONT></TD></TR>");
				}

				out.println("<TR><TD align=right>Total Seats Available :</TD><TD><INPUT TYPE=TEXT NAME=seats VALUE="+clm.getAvailableSeats()+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Pincode :</TD><TD><INPUT TYPE=TEXT NAME=pin VALUE="+clm.getPincode()+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Telephone 1 :</TD><TD><INPUT TYPE=TEXT NAME=phone1 VALUE="+clm.getPhone1()+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>Telephone 2 :</TD><TD><INPUT TYPE=TEXT NAME=phone2 VALUE="+clm.getPhone2()+"></TD></TR>");

				out.println("<TR><TD align=right>Fax :</TD><TD><INPUT TYPE=TEXT NAME=fax VALUE="+clm.getFax()+"></TD></TR>");

				out.println("<TR><TD align=right>Email :</TD><TD><INPUT TYPE=TEXT NAME=email VALUE="+clm.getEmail()+"><FONT COLOR=red>*</FONT></TD></TR>");

				out.println("<TR><TD align=right>URL :</TD><TD><INPUT TYPE=TEXT NAME=url VALUE="+clm.getUrl()+"></TD></TR>");

				out.println("<TH COLSPAN=4><INPUT TYPE=BUTTON VALUE=Modify onclick='return checkVal();'>&nbsp;<INPUT TYPE=RESET VALUE=Reset></TH>");
				out.println("</TABLE>");
				out.println("<INPUT TYPE=HIDDEN NAME=action VALUE='doModifySave'><INPUT TYPE=HIDDEN NAME=clientid VALUE="+clientid+">");
				}
				
			}
			catch(Exception e)
			{
				out.println("Modification Module Error : " + e.getMessage());
				
			}
			finally
			{
				
			}
		}
		else if (action.equalsIgnoreCase("doModifySave"))
		{
			String sql = null,errorstr="";
			try
			{
					
	//			int cid = Integer.parseInt(request.getParameter("cid"));
				int clientid = Integer.parseInt(request.getParameter("clientid"));
				String clientname = request.getParameter("clientname");
	
	System.out.println("action in ModifySave<br>");
	System.out.println("client : " + clientname);
				int areaID = Integer.parseInt(request.getParameter("areaID"));
				String SareaID = "" + areaID;
				//System.out.println("client areaID: " + areaID);
				int cityID = Integer.parseInt(request.getParameter("cityID"));
				String ScityID = "" + cityID;
				//System.out.println("client ScityID: " + cityID);
				int stateID = Integer.parseInt(request.getParameter("stateID"));
				String SstateID = "" + stateID;
				//System.out.println("client SstateID: " + stateID);
				int countryID = Integer.parseInt(request.getParameter("countryID"));
				String ScountryID = "" + countryID;
	//out.println("country ScountryID"+ countryID);
				int ctype = Integer.parseInt(request.getParameter("ClientType"));
				String add = request.getParameter("add");
				int seats = Integer.parseInt(request.getParameter("seats"));
		System.out.println("seats : " + seats);
				String pin = request.getParameter("pin");
				String phone1 = request.getParameter("phone1");
				String phone2 = request.getParameter("phone2");
				String fax = request.getParameter("fax");
	//out.println("off " + fax);
				String email = request.getParameter("email");
				String url = request.getParameter("url");
	//out.println("examil : " + email);
				String code= "";
	
				String checkadd = Utils.AddressVerify(areaID,stateID,cityID,countryID );
	System.out.println("<br>ret : " + checkadd);
	
				if (null != checkadd)
				{
					sql = "SELECT clm.locationId FROM Clientmaster clm WHERE clm.clientId=?1";
					int lid =0;
					query = em.createQuery(sql);
					query.setParameter(1, clientid);
					if(EntityManagerHelper.getSingleResult(query)!=null)
					{
						lid = (Integer)query.getSingleResult();
						//log.info("CLIENT REGISTRATION FORM lid"+lid);
					}
					sql = "SELECT lm.code FROM Locationmaster lm WHERE lm.locationId=?1";
					query = em.createQuery(sql);
					query.setParameter(1, lid);
					code = (String)query.getSingleResult();
					log.info("CLIENT REGISTRATION FORM code"+code);
					ClientmasterDAO clmDAO = new ClientmasterDAO();
					Clientmaster clm = clmDAO.findById(clientid);
					EntityManagerHelper.beginTransaction();
					clm.setClientCode(code);
					clm.setClientName(clientname);
					clm.setAddress(add);
					clm.setPincode(pin);
					clm.setLocationId(lid);
					clm.setPhone1(phone1);
					clm.setPhone2(phone2);
					clm.setFax(fax);
					clm.setEmail(email);
					clm.setUrl(url);
					clm.setAvailableSeats(seats);
					clm.setClientType(ctype);
					clmDAO.update(clm);
					EntityManagerHelper.commit();
					log.info("CLIENT REGISTRATION FORM seats"+clm.getAvailableSeats());
					//if (confirm)
					{
						log.info("cofifn");
						clm = clmDAO.findById(clientid);
						out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
						out.println("<TR><TH>Client Name</TH><TH>Client Code</TH><TH>Address</TH><TH>Total Seats Available</TH><TH>Pincode</TH><TH>Phone</TH><TH>Fax</TH><TH>E-mail</TH><TH>URL</TH><TH>Client Type</TH><TH>&nbsp;</TH><TH>&nbsp;</TH></TR>");
						if(clm!=null)
						{
						String link = request.getRequestURI() + "?action=doModify&clientid="+clientid;
							int type = clm.getClientType();
							String cltype = "";
							if (type==1){cltype="ZedCA Centre";}else cltype="Others";
							//System.out.println("<TR><TD>" + clm.getClientName() + "</TD><TD>" + code + "</TD><TD>" + clm.getAddress() + "</TD><TD>" + clm.getAvailableSeats() + "</TD><TD>" + clm.getPincode() + "</TD><TD>" + clm.getPhone1() + " " + clm.getPhone2() + "</TD><TD>" + clm.getFax() + "</TD><TD>" + clm.getEmail() + "</TD><TD>" + clm.getUrl() + "</TD><TD>" + cltype + "</TD><TD><a href='"+link+"'>Modify</a></TD><TD>Delete</TD></TR>");
							out.println("<TR align='center'><TD>" + clm.getClientName() + "</TD><TD>" + code + "</TD><TD>" + clm.getAddress() + "</TD><TD>" + clm.getAvailableSeats() + "</TD><TD>" + clm.getPincode() + "</TD><TD>" + clm.getPhone1() + " " + clm.getPhone2() + "</TD><TD>" + clm.getFax() + "</TD><TD>" + clm.getEmail() + "</TD><TD>" + clm.getUrl() + "</TD><TD>" + cltype + "</TD><TD><a href='"+link+"'>Modify</a></TD><TD>Delete</TD></TR>");
						}
						out.println("</TABLE>");
					}
				}
				else
				{
				    log.info("esle");
					errorstr = String.valueOf(checkadd);
					session.setAttribute("errorstr",errorstr);
					response.sendRedirect(request.getRequestURI());
				}
			}
			catch(Exception e)
			{
				out.println("Add Mod Error : " + e.getMessage());
				e.printStackTrace();
			}
			finally
			{
				
			}
		}
		else if (action.equalsIgnoreCase("doConfirmDelete"))
		{
			String sql = null,errorstr="";
			try
			{
				int clientid = Integer.parseInt(request.getParameter("ClientID"));
				System.out.println("ConfirmDelete	clientid:"+clientid);
				int lid=0;
				String code="";
				sql = "SELECT clm.locationId FROM Clientmaster clm WHERE clm.clientId=?1";
				query = em.createQuery(sql);
				query.setParameter(1, clientid);
				lid = (Integer) query.getSingleResult();
				System.out.println("ConfirmDelete	lid:"+lid);
				sql = "SELECT lm.code FROM Locationmaster lm WHERE lm.locationId=?1";
				query = em.createQuery(sql);
				query.setParameter(1, lid);
				code = (String) query.getSingleResult();
				System.out.println("ConfirmDelete	code:"+code);
				ClientmasterDAO clmDAO = new ClientmasterDAO();
				Clientmaster clm = clmDAO.findById(clientid);
				out.println("<BR><B>Are you Sure you want to DELETE the Client Details ?</B><BR>");
				out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
				out.println("<TR><TH>Client Name</TH><TH>Client Code</TH><TH>Address</TH><TH>Total Seats Avaliable</TH><TH>Pincode</TH><TH>Phone</TH><TH>Fax</TH><TH>E-mail</TH><TH>URL</TH><TH>Client Type</TH></TR>");
				String username = "";
				if(clm!=null)
				{
	//				String link = request.getRequestURI() + "?action=doModify&clientid="+clientid;
					int type = clm.getClientType();
					username = clm.getUsername();
					String cltype = "";
					if (type==1){cltype="Others";}else cltype="ZedCA Centre";
	
					out.println("<TR><TD>" + clm.getClientName() + "</TD><TD>" + code + "</TD><TD>" + clm.getAddress() + "</TD><TD>" + clm.getAvailableSeats() + "</TD><TD>" + clm.getPincode() + "</TD><TD>" + clm.getPhone1() + " " + clm.getPhone2() + "</TD><TD>" + clm.getFax() + "</TD><TD>" + clm.getEmail() + "</TD><TD>" + clm.getUrl() + "</TD><TD>" + cltype + "</TD></TR>");
				}
				out.println("</TABLE>");
				out.println("<FORM NAME=frmdelete METHOD=POST action="+request.getRequestURI()+">");
	
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
				
			}
		}
		else if (action.equalsIgnoreCase("doDelete"))
		{
			String sql = null,errorstr="";
			try
			{
				int clientid = Integer.parseInt(request.getParameter("ClientID"));
				String username = request.getParameter("username");
				EntityManagerHelper.beginTransaction();
				ClientmasterDAO clmDAO = new ClientmasterDAO();
				Clientmaster clm = clmDAO.findById(clientid);
				boolean confirm = clmDAO.delete(clm);
				if (confirm)
				{
					UsergroupxrefDAO ugxDAO = new UsergroupxrefDAO();
					Usergroupxref ugx = ugxDAO.findByUsername(username);
					confirm = ugxDAO.delete(ugx);
					if (confirm)
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
				
			}
		}
		
		out.println("</BODY>");
		out.println("</HTML>");
%>

