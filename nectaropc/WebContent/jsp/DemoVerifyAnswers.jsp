
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<HTML>
<HEAD>
<TITLE> New Document </TITLE>
<link rel="stylesheet" href="../alm.css" type="text/css">

</HEAD>

<%@ page language="java" import="java.util.*" session="true"%>


<BODY>
<br><br>

<%

    String lang = (String)session.getValue("lang");
    //System.out.println("lang :"+lang);

	Hashtable QAnswers=new Hashtable();
	Hashtable QACorrect = new Hashtable();
	Locale locale=null;
     if (lang.equals("German")) {
       locale=Locale.GERMANY;
     } else if (lang.equals("French")) {
         locale=Locale.FRANCE;
     } else if (lang.equals("Spanish")) {
       	 locale=new Locale("es","ES");
     } else {
         locale=Locale.US;
 
     }
     session.putValue("myLocale",locale);
     ResourceBundle bundle = ResourceBundle.getBundle("Message",locale);
     /*for (Enumeration e = bundle.getKeys();e.hasMoreElements();) {
         String key = (String)e.nextElement();
         String msg = bundle.getString(key);
         System.out.println("key :"+key);
         System.out.println("msg :"+msg);
         session.putValue(key,msg);
     }*/


	try
	{
		
		QAnswers = (Hashtable) session.getAttribute("QAnswers");
		QACorrect = (Hashtable) session.getAttribute("QACorrect");
		int right = 0;
		int wrong =0;
		int unatt=0;
		int total=0;
		float score=0;
		float scorep=0;
		int result=0;
		
		//System.out.println("QAnswers :"+QAnswers);
		//System.out.println("QAnswers size:"+QAnswers.size());

		for(int i=1;i<=QAnswers.size()-1;++i)
		{
			int ansg=0;
			int cans=0;

			ansg = ((Integer)QAnswers.get(new Integer(i))).intValue();
			cans = ((Integer)QACorrect.get(new Integer(i))).intValue();
			
			if(ansg==0) unatt++;
			else
			{
				if(ansg==cans) right++;
				else if(ansg!=cans) wrong++;
			}
			//System.out.println("ansg :"+ansg);
			//System.out.println("cans :"+cans);
			//System.out.println("unatt :"+unatt);
			

		}
		
		//score = (float)right-(float)(wrong*0.33);
		
		score = (float)right;

		if(score<0) score=0;
		scorep = (score*100)/5;

		if(scorep>=50) result=1;

		String sp = ""+scorep;


	
%>

<div align="center">
  
    <p>&nbsp;</p>
    <table border=0 cellspacing=1 cellpadding=0 align="center" width="70%">
      <tr> 
        <th  bgcolor=#330099>Result of the Demo Test</th>
      </tr>
      <tr> 
        <td  bgcolor=#330099 align="center"><br>
          <table border="0" cellspacing="1" cellpadding="1" class="result">
            <tr> 
              <td align="right" width="60%"><%=bundle.getString("exam")%> :</td>
              <td width="40%">Demo</td>
            </tr>
            <tr> 
              <td align="right"><%=bundle.getString("tq")%> :</td>
              <td>5</td>
            </tr>
            <tr> 
              <td align="right"><%=bundle.getString("noca")%> :</td>
              <td><%=right%></td>
            </tr>
            <tr> 
              <td align="right"><%=bundle.getString("noia")%> :</td>
              <td><%=wrong%></td>
            </tr>
            <tr> 
              <td align="right"><%=bundle.getString("nouq")%> :</td>
              <td><%=unatt%></td>
            </tr>
            <tr>
              <td align="right"><%=bundle.getString("pso")%> :</td>
              <td><%if(sp.length()>5)
			  out.println(sp.substring(0,5)+"%");
			  else out.println(sp+"%");%></td>
            </tr>
            <tr>
              <td align="right"><%=bundle.getString("result")%> :</td>
              <td><%if(result==1) out.println(bundle.getString("pass")); else out.println(bundle.getString("fail"));%></td>
            </tr>
          </table>
          <br>
		  <%//request.getParameter("score")%>
        </td>
      </tr>
      <tr> 
        <th align="center"> 
          <!--<input type="submit" name="Submit" value="Close">-->
        </th>
      </tr>
    </table>
<br><br><br>
 
</div>
<%
	}
	catch( Exception e)
	{
		out.println("Exception caught :"+e.getMessage());
	}
%>
</BODY>
</HTML>
