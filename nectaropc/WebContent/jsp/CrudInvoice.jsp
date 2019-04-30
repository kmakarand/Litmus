<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<%
		String action = request.getParameter("action");String message=null;
		//int pdId=0;
		if(null != request.getParameter("message"))
		message = request.getParameter("message");
		Query query=null;
		pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("addscheduleform.jsp");
		Connection con = pool.getConnection();
		EntityManager em = EntityManagerHelper.getEntityManager();
		
		if (action == null || action == "")
		{
		    out.println("<tr><td colspan=4><BR></td></tr>");
		    if(null != message)
		    out.println("<font color=red> <h3 align=center> message:	"+message+"</h3></font>");
		    out.println("<HTML><HEAD><TITLE>Roots Global Estimate</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<FORM METHOD=POST NAME=searchPagosForm>");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=5>Invoice Crud Operation</TH></TR><BR></BR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Productcode :</TD>");
			out.println("<TD><select name='pmId' style='color:#2D7EE7'>");
			query = em.createQuery("select pm from Productmaster pm");
			List<Productmaster> objPmList = query.getResultList();
			for (Productmaster pmList:objPmList)
			{
			   out.println("<OPTION VALUE="+pmList.getPmId()+">"+pmList.getProductDesc()+"</OPTION>");
			}
			out.println("</select>");
			
			out.println("</TD><TD align=right><FONT COLOR=red>*</FONT>Unit Price :</TD><TD><INPUT TYPE=TEXT NAME=unitPrice VALUE=''</TD></TR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Quanity :</TD><TD><INPUT TYPE=TEXT NAME=quantity VALUE=''></TD><TD align=right><FONT COLOR=red>*</FONT>Scale :</TD><TD><INPUT TYPE=TEXT NAME=scale VALUE=''></TD></TR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Purchase Cost :</TD><TD><INPUT TYPE=TEXT NAME=purchaseCost VALUE=''></TD><TD align=right><FONT COLOR=red>*</FONT>Rental Cost :</TD><TD><INPUT TYPE=TEXT NAME=rentalCost VALUE=''></TD></TR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Product Description :</TD><TD colspan=4><INPUT TYPE=TEXT NAME=productDesc VALUE=''></TR>");
			out.println("<tr><td colspan=4><BR></BR></td></tr>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>select Product to Modify/Delete:</TD>");
			out.println("<TD colspan=4><select name='pdId' style='color:#2D7EE7'>");
			query = em.createQuery("select pd from Productdetails pd");
			List<Productdetails> objPdList = query.getResultList();
			for (Productdetails pdList:objPdList)
			{
			   out.println("<OPTION VALUE="+pdList.getPdId()+">"+pdList.getProductDesc()+"</OPTION>");
			}
			out.println("</select>");
			out.println("</TD></TR>");
		    out.println("<tr><td colspan=4><BR></BR></td></tr>");
			out.println("<tr><td colspan=4 align=center><input type=\"submit\" class=\"button\" name=\"Add\" value=\"Add Data\" onclick=\"document.searchPagosForm.action = 'CrudInvoice.jsp?action=insertData';document.searchPagosForm.submit()\" />");
            out.println("<input type=\"submit\" class=\"button\" name=\"Modify\" value=\"Modify Data\" onclick=\"document.searchPagosForm.action = 'CrudInvoice.jsp?action=modifyData';document.searchPagosForm.submit()\" />");
            out.println("<input type=\"submit\" class=\"button\" name=\"Delete\" value=\"Delete Data\" onclick=\"document.searchPagosForm.action = 'CrudInvoice.jsp?action=deleteData';document.searchPagosForm.submit()\" /></td></tr>");
            out.println("</TABLE>");
			out.println("</FORM>");
			out.println("</BODY></HTML>");
			
		}
		else if(action.equals("insertData"))
		{
		     EntityManagerHelper.beginTransaction();
			 ProductdetailsDAO objProductdetailsDAO = new ProductdetailsDAO();
			 Productdetails objProductdetails = new Productdetails();
			 objProductdetails.setPmId(Integer.parseInt(request.getParameter("pmId")));
			 objProductdetails.setProductDesc(request.getParameter("productDesc"));
			 objProductdetails.setQuantity(Integer.parseInt(request.getParameter("quantity")));
			 objProductdetails.setScale(request.getParameter("scale"));
			 objProductdetails.setUnitPrice(Integer.parseInt(request.getParameter("unitPrice")));
			 int totPrice = (Integer.parseInt(request.getParameter("quantity"))*Integer.parseInt(request.getParameter("unitPrice")));
			 objProductdetails.setTotalPrice(totPrice);
			 objProductdetails.setPurchaseCost(Integer.parseInt(request.getParameter("purchaseCost")));
			 objProductdetails.setRentalCost(Integer.parseInt(request.getParameter("rentalCost")));
			 objProductdetailsDAO.save(objProductdetails);
			 EntityManagerHelper.commit();
			 message="Product Inserted successfully";
			 response.sendRedirect("CrudInvoice.jsp?message="+message);
			 //out.println("Product Inserted successfully");
		}
		else if(action.equals("modifyData"))
		{
		    ProductdetailsDAO objProductdetailsDAO = new ProductdetailsDAO();
			int pdId = Integer.parseInt(request.getParameter("pdId"));
			System.out.println("modifyData pdId :"+pdId);
			query = em.createQuery("select pd from Productdetails pd where pd.pdId=?1");
			query.setParameter(1,pdId);
			Productdetails objProductdetails = (Productdetails)query.getSingleResult();
			 
			out.println("<HTML><HEAD><TITLE>Roots Global Estimate</TITLE>");
			out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
			out.println("<BODY><CENTER>");
			out.println("<FORM METHOD=POST NAME=searchPagosForm>");
			out.println("<TABLE BORDER=0 CELLSPACING=1 CELLPADDING=1>");
			out.println("<TR><TH COLSPAN=5>Invoice Crud Operation</TH></TR><BR></BR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Productcode :</TD>");
			out.println("<TD>");
			query = em.createQuery("select pm from Productmaster pm where pm.pmId=?1");
			query.setParameter(1,objProductdetails.getPmId());
			Productmaster objPmList = (Productmaster)query.getSingleResult();
			out.println(objPmList.getProductDesc());
			
			out.println("</TD><TD align=right><FONT COLOR=red>*</FONT>Unit Price :</TD><TD><INPUT TYPE=TEXT NAME=unitPrice VALUE="+objProductdetails.getUnitPrice()+"></TD></TR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Quanity :</TD><TD><INPUT TYPE=TEXT NAME=quantity VALUE="+objProductdetails.getQuantity()+"></TD><TD align=right><FONT COLOR=red>*</FONT>Scale :</TD><TD><INPUT TYPE=TEXT NAME=scale VALUE="+objProductdetails.getScale()+"></TD></TR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Purchase Cost :</TD><TD><INPUT TYPE=TEXT NAME=purchaseCost VALUE="+objProductdetails.getPurchaseCost()+"></TD><TD align=right><FONT COLOR=red>*</FONT>Rental Cost :</TD><TD><INPUT TYPE=TEXT NAME=rentalCost VALUE="+objProductdetails.getRentalCost()+"></TD></TR>");
			out.println("<TR><TD align=right><FONT COLOR=red>*</FONT>Product Description :</TD><TD colspan=4><INPUT TYPE=TEXT NAME=productDesc size='100%' VALUE='"+objProductdetails.getProductDesc()+"'></TR>");
			out.println("<tr><td colspan=4><BR></BR></td></tr>");
			out.println("<input type=hidden name=pdId value="+pdId+">");
			out.println("<input type=hidden name=pmId value="+objProductdetails.getPmId()+">");
			out.println("<TR><TD align=center colspan=4><input type=\"submit\" class=\"button\" name=\"Modify\" value=\"Modify Data\" onclick=\"document.searchPagosForm.action = 'CrudInvoice.jsp?action=updateData';document.searchPagosForm.submit()\" />");
			out.println("<input type='submit' class='button' name='Back' value='Back to Mainpage' onclick=\"document.searchPagosForm.action = 'CrudInvoice.jsp';document.searchPagosForm.submit()\" /></td></tr>");
            out.println("</TABLE>");
			out.println("</FORM>");
			out.println("</BODY></HTML>");
		}
		else if(action.equals("deleteData"))
		{
		     EntityManagerHelper.beginTransaction();
			 ProductdetailsDAO objProductdetailsDAO = new ProductdetailsDAO();
			 int pdId = Integer.parseInt(request.getParameter("pdId"));
			 //System.out.println("pdId :"+pdId);
			 query = em.createQuery("select pd from Productdetails pd where pd.pdId=?1");
			 query.setParameter(1,pdId);
			 Productdetails objProductdetails = (Productdetails)query.getSingleResult();
			 
			 objProductdetailsDAO.delete(objProductdetails);
			 EntityManagerHelper.commit();
			 message="Product Deleted successfully";
			 response.sendRedirect("CrudInvoice.jsp?message="+message);
			 //out.println("Product Deleted successfully");
		}
		else if(action.equals("updateData"))
		{
		     try{
		     EntityManagerHelper.beginTransaction();
			 ProductdetailsDAO objProductdetailsDAO = new ProductdetailsDAO();
			 int pdId = Integer.parseInt(request.getParameter("pdId"));
			 System.out.println("updateData pdId :"+pdId);
			 Productdetails objProductdetails = objProductdetailsDAO.findById(pdId);
			 System.out.println("updateData pmId:"+request.getParameter("pmId"));
			 //System.out.println("updateData pmId:"+Integer.parseInt(request.getParameter("pmId")));
			 objProductdetails.setPmId(Integer.parseInt(request.getParameter("pmId")));
			 objProductdetails.setProductDesc(request.getParameter("productDesc"));
			 objProductdetails.setQuantity(Integer.parseInt(request.getParameter("quantity")));
			 objProductdetails.setScale(request.getParameter("scale"));
			 objProductdetails.setUnitPrice(Integer.parseInt(request.getParameter("unitPrice")));
			 int totPrice = (Integer.parseInt(request.getParameter("quantity"))*Integer.parseInt(request.getParameter("unitPrice")));
			 objProductdetails.setTotalPrice(totPrice);
			 objProductdetails.setPurchaseCost(Integer.parseInt(request.getParameter("purchaseCost")));
			 objProductdetails.setRentalCost(Integer.parseInt(request.getParameter("rentalCost")));
			 
			 objProductdetailsDAO.update(objProductdetails);
			 EntityManagerHelper.commit();
			 message="Product Modifed successfully";
			 response.sendRedirect("CrudInvoice.jsp?message="+message);
			 //out.println("Product Modifed successfully");
			 }catch(Exception e){e.printStackTrace();}
		}
%>