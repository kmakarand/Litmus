<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
<title>Nectar Examination</title>
<link rel="stylesheet" href="../alm.css" type="text/css">
<%@ page import="java.util.*" %>
<%
   String lang = request.getParameter("lang");
   if (lang == null) {
%>
<body>
<hr>
<p>
Please select a language:
<form action="i18nDemo.jsp" method="post">
English <input type="radio" name="lang" value="English" checked>
Deutsch <input type="radio" name="lang" value="German">
Français <input type="radio" name="lang" value="French">
<p>
<input type="submit" value="Continue">
</form>
</body>
</html>
<%
   } else {
     Locale locale=null;
     if (lang.equals("Spanish")) {
       locale=Locale.
     } else if (lang.equals("French")) {
         locale=Locale.FRANCE;
     } else {
         locale=Locale.US;
     }
     session.putValue("myLocale",locale);
     ResourceBundle bundle = ResourceBundle.getBundle("Message",locale);
     for (Enumeration e = bundle.getKeys();e.hasMoreElements();) {
         String key = (String)e.nextElement();
         String msg = bundle.getString(key);
         System.out.println("key :"+key);
         System.out.println("msg :"+msg);
         session.putValue(key,msg);
     }
%>
<jsp:forward page="Login.jsp" />
<%
   }
%>
