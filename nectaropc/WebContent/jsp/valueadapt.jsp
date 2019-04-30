
<!--
Tampered by Pinjo from testmain.jsp line 105
-->

<%
try
	{
	int truecount = ((Integer)session.getValue("true_count")).intValue();
	/*	if (!truecount){
			session.putValue("true_count",new Integer("1"));		
		}*/
	int falsecount = ((Integer)session.getValue("false_count")).intValue();
	/*	if (!falsecount){
			session.putValue("false_count",new Integer("1"));		
		}*/
	int level = ((Integer)session.getValue("level")).intValue();
	/*	if (!level){
			session.putValue("level",new Integer("1"));		
		}*/
	int adaptive = Integer.parseInt((String)session.getValue("adaptive"));
	/*	if (!adaptive){
			session.putValue("adaptive",new Integer("1"));		
		}*/
	int uplimit = Integer.parseInt((String)session.getValue("uplimit"));
	/*	if (!uplimit){
			session.putValue("uplimit",new Integer("1"));		
		}*/
	int downlimit = Integer.parseInt((String)session.getValue("downlimit"));
	/*	if (!downlimit){
			session.putValue("downlimit",new Integer("1"));		
		}*/


	if(AnsFlag)
	{
		truecount++;
		session.putValue("true_count",new Integer(truecount));
		if(truecount==uplimit)
		{
			level++;
			session.putValue("level",new Integer(level));
			session.putValue("true_count",new Integer("0"));
		}
	}else if(AnsFlag==false)
			{
				falsecount++;
				session.putValue("false_count",new Integer(falsecount));
				if(falsecount>=downlimit)

				if ((level-1)<1)
				{
					session.putValue("false_count",new Integer("1"));
					//out.print("Pinjo is in then part");
				}else
				{
					//out.print("Pinjo is in elses part");
					level--;
					session.putValue("level",new Integer(level));
					session.putValue("false_count",new Integer("0"));
		
				}

			}

	/* 
	out.print("truecount :"+truecount);
	out.print("falsecount :"+falsecount);
	out.print("level :"+level);
	out.print("adaptive :"+adaptive);
	out.print("uplimit :"+uplimit);
	out.print("downlimit :"+downlimit);	
	*/ 
	

	}catch(Exception e)
	{
		out.println("Exception in adaptive"+e.getMessage());
	}

					
			
%>