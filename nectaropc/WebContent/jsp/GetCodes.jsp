
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
	//System.out.println("asdfsadf");

	Statement stm1,stm2;
			  stm1=stm2=null;	
	ResultSet rst1,rst2;
			  rst1=rst2=null;
	int NoOfCodes,z;
		NoOfCodes=z=0;
	String AllCodes="";
	
	//System.out.println("In file");
	if(con3==null) out.println("Connection not obtained in included JSP");
	
	if(con3!=null)
			{
				stm1	=	con3.createStatement();
				stm2	=	con3.createStatement();
				//System.out.println("after stmt");

				String GetCodesCount = "Select Count(*) from CodeGroupDetails where CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID;

				String GetCodes = "Select * from CodeGroupDetails where CodeGroupID="+CodeGroupID+" AND ExamID="+ExamID;

				try
					{
						rst1 = stm1.executeQuery(GetCodesCount);
					}
					catch (SQLException e)
						{
							out.println("Get Code Count Error in included JSP" +e.getMessage());
						}

				while(rst1.next())		NoOfCodes = rst1.getInt(1);	

				//System.out.println("NoOfCodes :"+NoOfCodes);
				String CodeID[]		=	new String[NoOfCodes];
				String TempCodeID[]	=	new String[NoOfCodes];
				
				try
					{
						rst2 = stm2.executeQuery(GetCodes);
					}
					catch (SQLException e)
						{
							out.println("Get Code Error in included JSP" +e.getMessage());
						}

				
				while(rst2.next())	 {CodeID[z]	= rst2.getString("CodeID");++z;}

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

%>
