
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->

<%@ page import="java.util.*,com.ngs.gen.*" %>

<% 
out.println("printing date");
Calendar calendar = new GregorianCalendar();
String strcurDate= calendar.get(Calendar.YEAR)+"-"+calendar.get(Calendar.MONTH)+"-"+calendar.get(Calendar.DATE);
out.println("Current Date: " +strcurDate);
 
%>
 
