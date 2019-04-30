<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");
		int clientId = Integer.parseInt(request.getParameter("client"));
		//System.out.println("clientId	:"+clientId);
		Query query=null;
		//int cid = Integer.parseInt(req.getParameter("CandidateID"));
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("InvoiceReport.jsp");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		int totPrice=0,totPurCost=0,totRentCost=0;
		
		if (action == null || action == "")
		{
			out.println("\n</BR>");
			out.println("<HTML><HEAD><TITLE>Roots Global Estimate Report</TITLE>");
			out.println("<FONT COLOR=red><B><h3 ALIGN='CENTER'>Roots Global Estimate Report</h3></B></FONT>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<TABLE BORDER='0' CELLSPACING='0' CELLPADDING='0' ALIGN='CENTER' width='80%'>");
			
			query = em.createQuery("select clm from Clientmaster clm where clm.clientId=?1");
			query.setParameter(1,clientId);
			Clientmaster objClientmaster = (Clientmaster) query.getSingleResult();
			out.println("<TR style='color:#2D7EE7'><font ><TD>To</TD><TD>"+objClientmaster.getClientName()+"</TD><TD colspan=4></TD><TD>Budget No</TD><TD>B123445</TD></FONT></TR>");
			out.println("<TR style='color:#2D7EE7'><TD>Address</TD><TD>"+objClientmaster.getAddress()+"</TD><TD colspan=4></TD><TD>Budget Date</TD><TD>20/03/2014</TD></TR>");
			out.println("<TR style='color:#2D7EE7'><TD></TD><TD></TD><TD colspan=4><TD>Vendor Code</TD></TD><TD>V12345</TD></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR style='color:#2D7EE7'><TD>Sub:</TD><TD colspan=7>Budget For Booth Construction</TD></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TD colspan=8><HR SIZE=1></TD></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR style='color:BROWN'><TH>Sr. No.</TH>"+"<TH>Product Description</TH>"+"<TH>Quantity</TH>"+"<TH>Scale</TH>"+"<TH>Unit Price</TH>"+"<TH>Price</TH>"+"<TH>Purchase Cost</TH>"+"<TH>Rental Cost</TH></TR></FONT>");
			query = em.createNamedQuery("InvoiceReport-Invoice.sql1");
			query.setParameter(1,clientId);
			List<Productdetails> qmList = query.getResultList();
			int rowcount=0;
			
			/*
			query = em.createQuery("select pm from Productmaster pm");
			List<Productmaster> pmList = query.getResultList();
			*/
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>FLOORING</TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==1)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
					////System.out.println("totPricetotPricetotPrice	: "+totPrice);
					//out.println("totPricetotPricetotPrice	: "+totPrice);
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>STRUCTURE</TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==2)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>MEZZANINE</TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==3)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>FURNITURE</TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==4)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>ELECTRCALS</TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==5)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>GRAPHICS</TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==6)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>ACCESSORIES</TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==7)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>TRANSPORTATION</TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==8)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TH colspan=8 ALIGN=LEFT>DESIGN\\EXECUTION\\MAINTENANCE\\DISMANTING </TH></TR>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			for (Productdetails qmid:qmList)
			{
			    if(qmid.getPmId()==9)
				{
				    rowcount++;
					out.println("<TR align=center><TD>"+rowcount+"</TD><TD ALIGN=LEFT>"+qmid.getProductDesc()+
					"</TD><TD>"+qmid.getQuantity()+"</TD><TD>"+qmid.getScale()+"</TD><TD>"+qmid.getUnitPrice()+"</TD><TD>"+
					qmid.getTotalPrice()+"</TD><TD>"+qmid.getPurchaseCost()+"</TD><TD>"+qmid.getRentalCost()+"</TD>");
					totPrice = totPrice + qmid.getTotalPrice();
					totPurCost = totPurCost + qmid.getPurchaseCost();
					totRentCost = totRentCost + qmid.getRentalCost();
				}
			}
			
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			//out.println("<TR><TD colspan=4></TD><TD>Invoice Total</TD><TD>totPrice</TD><TD>totPurCost</TD><TD>totRentCost</TD>");
			out.println("<TR align=center><TH colspan=4></TH><TH>Invoice Total</TH><TH>"+totPrice+"</TH><TH>"+totPurCost+"</TH><TH>"+totRentCost+"</TH>");
			//out.println("<TR align=center><TD colspan=4></TD><TD>Invoice Total</TD><TD>"+totPrice+"</TD><TD>"+totPurCost+"</TD><TD>"+totRentCost+"</TD>");
			out.println("<TR><TD colspan=8><BR></TD></TR>");
			out.println("<TR><TD colspan=8 align=center><INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'></td></tr>");
			out.println("</TABLE>");
			out.println("</FORM>");
		}
		
%>