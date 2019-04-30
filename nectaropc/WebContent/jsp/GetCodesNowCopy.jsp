
<!--
Developer    : Makarand G. Kulkarni
Organisation : Nectar Global Services
Project Code : Nectar Examination
DOS	         : 15 - 02 - 2002 
DOE          : 03 - 03 - 2002
-->


<%@ page import="java.sql.*"%>
<!--errorPage="errortest.jsp"-->

<%
	////System.out.println("asdfsadf");

	Statement stm1,stm2,stm3,stm4,stm5;
			  stm1=stm2=stm3=stm4=stm5=null;	
	ResultSet rst1,rst2,rst3,rst4,rst5;
			  rst1=rst2=rst3=rst4=rst5=null;
	int NoOfCodes,z;
		NoOfCodes=z=0;
	String AllCodes="";
	boolean codechange = false;
	String sws = (String) session.getAttribute("switchsections");

    //System.out.println("In file");
	if(con==null) out.println("Connection not obtained in included JSP");
	
	if(con!=null)
	{
				stm1	=	con.createStatement();
				stm2	=	con.createStatement();
				stm3	=	con.createStatement();
				stm4	=	con.createStatement();
				stm5	=	con.createStatement();

				//System.out.println("after stmt");

				String GetCodesCount = "Select Count(*) from CodeGroupDetails where CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID;

				System.out.println("CodeGroupID :"+CodeGroupID);
				System.out.println("ExamID :"+ExamID);

				try
				{
					rst1 = stm1.executeQuery(GetCodesCount);
				}
				catch (SQLException e)
				{
					out.println("Get Code Count Error in included JSP" +e.getMessage());
				}
				
				while(rst1.next())		
				{
				    if(String.valueOf(rst1.getInt(1)) != null)
					NoOfCodes = rst1.getInt(1);	
					else
					NoOfCodes = 1;
				}

			    System.out.println("NoOfCodes :"+NoOfCodes);
				
				String CodeID[]		=	new String[NoOfCodes];
				String TempCodeID[]	=	new String[NoOfCodes];
				
			
				
				String GetCodes = "Select * from CodeGroupDetails where CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID+" order by CodeID";
				try
				{
					rst2 = stm2.executeQuery(GetCodes);
				}
				catch (SQLException e)
				{
					out.println("Get Code Error in included JSP" +e.getMessage());
				}

				
				while(rst2.next())	 
				{
					
					CodeID[z]	= rst2.getString("CodeID");
					
					//System.out.println("CodeIDz :"+CodeID[z]);
					if((teststart.equals("start"))||((sws!=null)&&(sws.equals("true"))))
					{
						CurrentCodeCount.put(CodeID[z],new Integer(rst2.getInt("NoOfQuestions")));
					}
					++z;
				}

				//System.out.println("Getcodenow tstatus :"+tstatus);
				//System.out.println("Getcodenow teststart :"+teststart);
				if((tstatus.equals("old"))&&(teststart.equals("start")))
				{	
					int tempcount=0;
					Integer codecount = new Integer(0);

					for(int i=0;i<NoOfCodes;++i)
					{
						try
						{
							rst4 = stm4.executeQuery("Select Count(*) from "+stemp+" where CodeGroupID="+CodeGroupID+" and CodeID='"+CodeID[i]+"'");
						}
						catch (SQLException e)
						{
							out.println("Exception caught");
						}

						while(rst4.next()) tempcount=rst4.getInt(1);
						
						//out.println("Code Before :"+CodeID[i]);
						codecount = (Integer)CurrentCodeCount.get(CodeID[i]);

						//out.println("<BR>Code :"+CodeID[i]);
						//out.println("code count :"+codecount+"tempcount :"+tempcount);

						if((tempcount<codecount.intValue())&&(tempcount>0))
						{
							CurrentCodeCount.put(CodeID[i],new Integer((codecount.intValue()-tempcount)));

						}else if(tempcount==codecount.intValue())
						{
							
							CurrentCodeCount.put(CodeID[i],new Integer(0));
						}

					}

				}

				if((sws!=null)&&(sws.equals("true"))) session.setAttribute("switchsections","false");

				if((teststart.equals("start"))||((sws!=null)&&(sws.equals("true"))))
				{
					//System.out.println("Coming in if");
					//System.out.println("AllCodes obtainbed:"+AllCodes);
					session.setAttribute("CurrentCodeCount",CurrentCodeCount);
					for(int j=0;j<NoOfCodes;++j)
					{
						int count1 =0;
						
						if(CurrentCodeCount.containsKey(CodeID[j]))
						count1 = ((Integer)CurrentCodeCount.get(CodeID[j])).intValue();

						//out.println(" Code count obtainbed:"+count1);
						if(count1>0) 
						{
							AllCodes = CodeID[j];
							//System.out.println("AllCodes obtainbed:"+AllCodes);
							//System.out.println("CodeID[j] obtainbed:"+CodeID[j]);
							session.setAttribute("CurrentCode",AllCodes);
							CurrentCode =AllCodes;
						}
						if(count1>0) break;
						 
					}


					if((tstatus.equals("old"))&&(AllCodes.equals("")))
					{
						AllCodes = CodeID[NoOfCodes-1];
						CurrentCode = AllCodes;
					}
					
				}
				else
				{
					
					//System.out.println("Coming in else");
					CurrentCode = (String)session.getAttribute("CurrentCode");
					//System.out.println("Before CurrentCode :"+CurrentCode);

					CurrentCodeCount = (Hashtable)session.getAttribute("CurrentCodeCount");
					for(int j=0;j<NoOfCodes;++j)
					{
						int count2 =0;
						
						if(CurrentCodeCount.containsKey(CodeID[j]))
						count2 = ((Integer)CurrentCodeCount.get(CodeID[j])).intValue();

						if(count2>0) 
						{
							AllCodes = CodeID[j];
							session.setAttribute("CurrentCode",AllCodes);
							//System.out.println("Setting CurrentCode :"+AllCodes);
							CurrentCode = AllCodes;
						}
						else 
						{
							CurrentCodeCount.remove(CodeID[j]);
							codechange = true;

						}
						if(count2>0) break;
					}

				}
				
				
				//System.out.println("CurrentCodeCount.size:"+CurrentCodeCount.size());
				//System.out.println("sws:"+sws);

				//System.out.println("Reaching here");
				//System.out.println("Allcode:"+AllCodes);
				
				System.err.println("teststart:"+teststart);
				System.err.println("codechange:"+codechange);
				
				
				
				
					
				if((teststart.equals("start"))||((codechange)&&(CurrentCodeCount.size()>0))||((sws!=null)&&(sws.equals("true"))))
				{
					
					ResultSet rc = null;
					//System.out.println("Reaching here inside loop");
					String Query = "Select QuestionID from QuestionMaster where CodeID=? and LevelID =? and ExamID=?";
					String varQuery = "Select QuestionID from QuestionMaster where CodeID="+AllCodes+" and LevelID ="+LevelID+" and ExamID="+ExamID;
					//System.out.println("Query :"+varQuery);
					/*PreparedStatement psc  = con.prepareStatement("Select QuestionID from QuestionMaster where CodeID=? and LevelID =? and ExamID=?");
					psc.setString(1,AllCodes);
					psc.setInt(2,LevelID);
					psc.setInt(3,ExamID);*/
					
					rst5 = stm5.executeQuery(varQuery);

					//rc = psc.executeQuery();
					int k=0;
					//System.out.println("Reaching here before loop");
					while(rst5.next())
					{
					    //System.out.println("Reaching here .....QCodeBank"+QCodeBank);
						QCodeBank.add(k,new Integer(rst5.getInt("QuestionID")));
						++k;
						//System.out.println("Reaching here QCodeBank"+QCodeBank);
					}

					session.putValue("QCodeBank",QCodeBank);
				}
				


					
				if(adaptcust==1)
				{
			

					for(int j=0;j<NoOfCodes;++j)
					{
						int n	=	CodeID[j].length()-1;
						TempCodeID[j]="";
						while(n>=0)
						{
							int check=0;
							for(int i=n;i>=n-1;--i)
							{
								if(CodeID[j].charAt(i)=='0') check++;
							}
							if(check!=2) TempCodeID[j]=CodeID[j].substring(n-1,n+1)+TempCodeID[j];
							//out.println("Sub string : "+sCode.substring(n-1,n+1));
							//out.println("tpCode : "+tempcode);
							n=n-2;
						}
								if(j==0)	AllCodes = AllCodes + "\'"+TempCodeID[j]+"%\'";
								else		AllCodes = AllCodes +" OR CodeID LIKE \'"+ TempCodeID[j]+"%\'";
					}
				}
					
			}
		//System.out.println("QCODEBANK Created :"+QCodeBank.toString());
%>
