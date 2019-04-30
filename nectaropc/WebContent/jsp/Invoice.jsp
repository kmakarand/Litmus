<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,
com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger,com.ngs.gen.*" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<HTML><HEAD><TITLE>Roots Global Invoice</TITLE>
<link rel="stylesheet" href="../alm.css" type="text/css">
<script language="javascript" src="quiz.js"></script>
</HEAD>

<%
		EntityManager em = EntityManagerHelper.getEntityManager();
		String message =null;int pdId =0;
		
		String action = request.getParameter("action");
		if(null != request.getParameter("message"))
		message = request.getParameter("message");
		if(null != request.getParameter("product"))
		pdId = Integer.parseInt(request.getParameter("product"));
		else
		pdId = 1;
		Query query=null;
		int clientId=1;String[] sports =null;InvoiceDAO objInvoiceDAO=null;List<Invoice> objListInvoice =null;
		Invoice objInvoice = null;int i=0;
		//int cid = Integer.parseInt(request.getParameter("CandidateID"));
		//pool = (com.ngs.gbl.ConnectionPool) getServletContext().getAttribute("ConPoolbse");
		Logger log = Logger.getLogger("addscheduleform.jsp");
		//Connection con = pool.getConnection();
		
		//out.println("<META HTTP-EQUIV='Pragma' CONTENT='no-cache'>");
		//out.println("<LINK REL='stylesheet' TYPE='text/css' HREF='../alm.css'></HEAD>");
		out.println("<BODY><CENTER>");
		out.println("<FONT style='color:#2D7EE7'><H2>Roots Global Estimate</H2></FONT><HR SIZE=1>");
		out.println("<FORM NAME=searchPagosForm METHOD=POST >");
		
		////System.out.println("action	value:"+action);
		////System.out.println("action	pdId:"+pdId);
		
		if (action == null || action == "")
		{
			out.println("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"30%\">");
			out.println("<tr><td><BR></BR></td></tr>");
			out.println("<tr><td><select name='client' style='color:#2D7EE7'>");
			query = em.createQuery("select clm from Clientmaster clm");
			List<Clientmaster> objclmList = query.getResultList();
			for (Clientmaster clmList:objclmList)
			{
			   out.println("<OPTION VALUE="+clmList.getClientId()+">"+clmList.getClientName()+"</OPTION>");
			}
			out.println("</select></TD></TR>");
			out.println("<tr><td><BR></BR></td></tr>");
			out.println("<tr><td><select name='product' style='color:#2D7EE7'>");
			query = em.createQuery("select pm from Productmaster pm");
			List<Productmaster> qmList = query.getResultList();
			for (Productmaster qmid:qmList)
			{
			   out.println("<OPTION VALUE="+qmid.getPmId()+">"+qmid.getProductDesc()+"</OPTION>");
			}
			out.println("</select></TD></TR>");
			out.println("<tr><td><BR></BR></td></tr>");
			out.println("<tr><td><input type=\"submit\" class=\"button\" name=\"Add\" value=\"Add Data\" onclick=\"document.searchPagosForm.action = 'Invoice.jsp?action=GetData';document.yourForm.submit()\" />");
            //out.println("<tr><td><BR></td></tr>");
            out.println("<input type=\"submit\" class=\"button\" name=\"Delete\" value=\"Delete Data\" onclick=\"document.searchPagosForm.action = 'Invoice.jsp?action=ModifyData';document.yourForm.submit()\" />");
            out.println("<input type=\"submit\" class=\"button\" name=\"Report\" value=\"Show Estimate\" onclick=\"document.searchPagosForm.action = 'InvoiceReport.jsp';document.yourForm.submit()\" /></td></tr>");
			out.println("<input type=hidden name=pdId value="+pdId+">");
			out.println("</TABLE>");
					
		}
		else if(action.equals("GetData"))
		{
		    //out.println("GetData exist"+pdId);
		    out.println("message :"+message);
		    ProductdetailsDAO objProductdetailsDAO = new ProductdetailsDAO();
			List<Productdetails> objListPD = objProductdetailsDAO.findAll();
			objInvoiceDAO = new InvoiceDAO();
			List<Invoice> listInv =  null;
			
			clientId = Integer.parseInt(request.getParameter("client"));
			out.println("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"50%\">");
			out.println("<tr><td><BR></BR></td></tr>");
			if(pdId==1)
			out.println("<TR><TH><B>FLOORING</B></TH></TR>");
			else if(pdId==2)
			out.println("<TR><TH><B>STRUCTURE</B></TH></TR>");
			else if(pdId==3)
			out.println("<TR><TH><B>MEZZANINE</B></TH></TR>");
			else if(pdId==4)
			out.println("<TR><TH><B>FURNITURE</B></TH></TR>");
			else if(pdId==5)
			out.println("<TR><TH><B>ELECTRICALS</B></TH></TR>");
			else if(pdId==6)
			out.println("<TR><TH><B>GRAPHICS</B></TH></TR>");
			else if(pdId==7)
			out.println("<TR><TH><B>ACCESSORIES</B></TH></TR>");
			else if(pdId==8)
			out.println("<TR><TH><B>TRANSPORTATION</B></TH></TR>");
			else if(pdId==9)
			out.println("<TR><TH><B>DESIGN\\EXECUTION\\MAINTENANCE\\DISMANTING</B></TH></TR>");
			
			out.println("<tr><td><BR></td></tr>");
			int pmId=0;
			for (Productdetails listPD:objListPD)
			{
			    ////System.out.println("GetData clientId	:"+clientId);
			    ////System.out.println("GetData PdId	:"+listPD.getPdId());
			    query = em.createQuery("select inv from Invoice inv where inv.clientId=?1 and inv.pdId=?2");
				query.setParameter(1,clientId);
				query.setParameter(2,listPD.getPdId());
				listInv = query.getResultList();
			    pmId=listPD.getPmId();
				out.println("<tr>");
				if(pmId==pdId)
				    {
				        if(listInv.isEmpty())
				    	out.println("<td><input name=\"demotest\" type=\"checkbox\" value="+listPD.getPdId()+"><a>"+listPD.getProductDesc()+"</a></td>");
				    	else
				    	out.println("<td><input name=\"demotest\" type=\"checkbox\" value="+listPD.getPdId()+" checked><a>"+listPD.getProductDesc()+"</a></td>");
				    	
				    }
				out.println("</tr>");
			}
			out.println("<tr><td><BR></BR></td></tr>");
			out.println("<tr><td><input type=\"submit\" class=\"button\" name=\"AddData\" value=\"Add Data\" onclick=\"document.searchPagosForm.action = 'Invoice.jsp?action=AddData';document.yourForm.submit()\" />");
			out.println("<INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'></td></tr>");
			out.println("</TABLE>");
			out.println("<input type=hidden name=pdId value="+pdId+">");
			out.println("<input type=hidden name=clientId value="+clientId+">");
		}
		else if(action.equals("AddData"))
		{
		  try{
			  ////System.out.println("AddData start");
			  clientId = Integer.parseInt(request.getParameter("clientId"));
			  sports = request.getParameterValues("demotest");
			  ProductdetailsDAO objProductdetailsDAO = new ProductdetailsDAO();
			  //Productdetails objProductdetails =null;
			  objInvoiceDAO = new InvoiceDAO();
			  List<Invoice> listInv =  null;
			  
			  for(i=0;i<sports.length;i++)
			  {
			      
		   		  if (sports != null) 
		   		   {
		   		      objInvoice = new Invoice();
		   		      EntityManagerHelper.beginTransaction();
		   		      int sportsid = Integer.parseInt(sports[i]);
		   		      ////System.out.println ("<b>"+sportsid+"<b>");
		   		      Productdetails objProductdetails = objProductdetailsDAO.findById(sportsid);
		   		      ////System.out.println("AddData clientId	:"+clientId);
					  ////System.out.println("AddData PdId	:"+sportsid);
					  query = em.createQuery("select inv from Invoice inv where inv.clientId=?1 and inv.pdId=?2");
				      query.setParameter(1,clientId);
					  query.setParameter(2,sportsid);
					  listInv = query.getResultList();
		   		      if(listInv.isEmpty())
		   		      {
		   		          objInvoice.setClientId(clientId);
			   		      ////System.out.println("AddData PmId:"+objProductdetails.getPmId());
			   		      objInvoice.setPmId(objProductdetails.getPmId());
			   		      ////System.out.println("AddData PdId:"+objProductdetails.getPdId());
			   		      objInvoice.setPdId(objProductdetails.getPdId());
			   		      //objInvoice.setPdId(sportsid);
			   		      objInvoiceDAO.save(objInvoice);
			   		      
			   		   }
			   		   else
			   		   {
			   		       //objInvoiceDAO.update(objInvoice);
			   		   	   ////System.out.println("AddData exist");
			   		   }
			   		   message = "Data added succesfully";
		   		       EntityManagerHelper.commit();
		   		   }
		      	   else
			       {
			      	  out.println ("<b>none<b>");
			       }
			      
			   }
			   
			 }catch(Exception e){e.printStackTrace();}
	      	
	      	response.sendRedirect("Invoice.jsp");
  		 }
  		else if(action.equals("ModifyData"))
		{
		    //out.println("GetData exist"+pdId);
		    ProductdetailsDAO objProductdetailsDAO = new ProductdetailsDAO();
			List<Productdetails> objListPD = objProductdetailsDAO.findAll();
			objInvoiceDAO = new InvoiceDAO();
			List<Invoice> listInv =  null;
			
			clientId = Integer.parseInt(request.getParameter("client"));
			out.println("<table border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"50%\">");
			out.println("<tr><td><BR></BR></td></tr>");
			if(pdId==1)
			out.println("<TR><TH><B>FLOORING</B></TH></TR>");
			else if(pdId==2)
			out.println("<TR><TH><B>STRUCTURE</B></TH></TR>");
			else if(pdId==3)
			out.println("<TR><TH><B>MEZZANINE</B></TH></TR>");
			else if(pdId==4)
			out.println("<TR><TH><B>FURNITURE</B></TH></TR>");
			else if(pdId==5)
			out.println("<TR><TH><B>ELECTRICALS</B></TH></TR>");
			else if(pdId==6)
			out.println("<TR><TH><B>GRAPHICS</B></TH></TR>");
			else if(pdId==7)
			out.println("<TR><TH><B>ACCESSORIES</B></TH></TR>");
			else if(pdId==8)
			out.println("<TR><TH><B>TRANSPORTATION</B></TH></TR>");
			else if(pdId==9)
			out.println("<TR><TH><B>DESIGN\\EXECUTION\\MAINTENANCE\\DISMANTING</B></TH></TR>");
			
			out.println("<tr><td><BR></td></tr>");
			int pmId=0;
			for (Productdetails listPD:objListPD)
			{
			    //System.out.println("GetData clientId	:"+clientId);
			    //System.out.println("GetData PdId	:"+listPD.getPdId());
			    query = em.createQuery("select inv from Invoice inv where inv.clientId=?1 and inv.pdId=?2");
				query.setParameter(1,clientId);
				query.setParameter(2,listPD.getPdId());
				listInv = query.getResultList();
			    pmId=listPD.getPmId();
				out.println("<tr>");
				if(pmId==pdId)
				    {
				        if(listInv.isEmpty())
				    	out.println("<td><input name=\"demotest\" type=\"checkbox\" value="+listPD.getPdId()+"><a>"+listPD.getProductDesc()+"</a></td>");
				    	else
				    	out.println("<td><input name=\"demotest\" type=\"checkbox\" value="+listPD.getPdId()+" checked><a>"+listPD.getProductDesc()+"</a></td>");
				    	
				    }
				out.println("</tr>");
			}
			out.println("<tr><td><BR></BR></td></tr>");
			out.println("<input type=hidden name=pdId value="+pdId+">");
			out.println("<input type=hidden name=client value="+clientId+">");
			out.println("<tr><td><input type=\"submit\" class=\"button\" name=\"DeleteData\" value=\"Delete Data\" onclick=\"document.searchPagosForm.action = 'Invoice.jsp?action=DeleteData';document.searchPagosForm.submit()\" />");
			out.println("<INPUT TYPE=BUTTON VALUE='Go Back' onclick='javascript:history.back();'></td></tr>");
			out.println("</TABLE>");
			
		}
		else if(action.equals("DeleteData"))
		{
		  try{
			  
			  if(null != request.getParameterValues("demotest"))
			  {
			  //System.out.println("DeleteData start");
			  out.println("message :"+message);
			  sports = request.getParameterValues("demotest");
			  clientId = Integer.parseInt(request.getParameter("client"));
			  //System.out.println("DeleteData clientId	:"+clientId);
			  ProductdetailsDAO objProductdetailsDAO = new ProductdetailsDAO();
			  //Productdetails objProductdetails =null;
			  objInvoiceDAO = new InvoiceDAO();
			  List<Invoice> listInv =  null;
			  
			  for(i=0;i<sports.length;i++)
			  {
			      
		   		  if (sports != null) 
		   		   {
		   		      int sportsid = Integer.parseInt(sports[i]);
		   		      ////System.out.println ("<b>"+sportsid+"<b>");
		   		      //System.out.println("DeleteData PdId	:"+sportsid);
		   		      //Productdetails objProductdetails = objProductdetailsDAO.findById(sportsid);
		   		      query = em.createNamedQuery("InvoiceReport-Invoice.sql2");
					  query.setParameter(1, sportsid);
					  query.setParameter(2, clientId);
					  if(null != query.getSingleResult())
					  {
						  EntityManagerHelper.beginTransaction();
						  objInvoice = (Invoice)query.getSingleResult();
						  //System.out.println("Delete exist PdId"+objInvoice.getPdId());
				   		  objInvoiceDAO.delete(objInvoice);
				   		  EntityManagerHelper.commit();
				   		  message="Data deleted Successfully";
			   		  }
			   		  
		   		   }
		      	   else
			       {
			      	  out.println ("<b>none<b>");
			       }
			      
			   }
			   
			   }else
			   {
			   	  out.println ("<b>none<b>");
			   }
			   
			 }catch(Exception e){e.printStackTrace();}
			 em.close();
			 response.sendRedirect("Invoice.jsp");
			 
  		 }
		
	   out.println("</FORM>");
	   out.println("</BODY></HTML>");



%>