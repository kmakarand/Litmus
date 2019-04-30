package com.ngs.gen;

import java.io.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.StringTokenizer;
import java.util.*;

class AddQuestionBank 
{
  
 	//public static void main(String args[])
	public static void addQuestionBank(int varExamID)
  	{
  	 	int examid=varExamID;
  	 	int rowcount=0;
	 	String queId="";
	 	int PartyID=6,ExamType=1,NoOfOptions=0,Answer=0,NewAnswer=0,LevelID=1,ExamID=examid,Marks=1,Image=0,Status=2,ResonableTime=127,count=0;
	 	String Question="",Option1="",Option2="",Option3="",Option4="",Option5="",Explanation="NA",RRN="NA",QuestionID="",CodeID="01000000";
	 	String InsertionDate=null;
	 	String UpdateValidityDate=null;Timestamp tm=null;HashMap hm = new HashMap();
	 	try{
  			// Open the file that is the first 
  			// command line parameter
 			FileInputStream fstream = new FileInputStream("C:\\textfile.txt");
  			// Get the object of DataInputStream
  			DataInputStream in = new DataInputStream(fstream);
  			BufferedReader br = new BufferedReader(new InputStreamReader(in));
  			BufferedWriter bw = new BufferedWriter(new FileWriter("c:\\AddQuestion.sql"));
  			String strLine;
			StringBuffer sb = new StringBuffer();
  			//Read File Line By Line
  			String que="";String que1="";
			int k=0;
  			while ((strLine = br.readLine()) != null)   
  			{
				rowcount++;Vector vec=new Vector();
				//System.out.println("rowcount :"+rowcount);
				//System.out.println("strLine :"+strLine);
	 			//System.out.println (strLine);
     			// Print the content on the console
      			StringTokenizer st2 = new StringTokenizer(strLine, ":");
      			//k=0;
	  			while (st2.hasMoreElements()) 
	  			{
  	 				que = (String)st2.nextElement();
  	  				vec.add(que);
				  	//System.out.println("que :"+que);
					//System.out.println("InsertionDate :"+tm);
			  	 }
				
				hm.put(String.valueOf(rowcount),vec);
				
  			}
				//System.out.println("Hash size :"+hm.size());
				for(int i=1;i<=hm.size();i++)
				{
					//System.out.println("hash "+i+":"+hm.get(String.valueOf(i)));
					Vector vec = (Vector)hm.get(String.valueOf(i));
					//System.out.println("vec size"+vec.size());
					//System.out.println("hash ele at 0"+((String)vec.get(0)));
					//System.out.println("hash ele at "+i+":"+((String)vec.get(i)));
					
					for(int l=0;l<vec.size();l++)
					{
						switch(l)
						{
							case 0:
							Question = (String)vec.get(0);
							case 1:
							NoOfOptions = (Integer.parseInt((String)vec.get(1)));
							case 2:
							Option1 = (String)vec.get(2);
							case 3:
							Option2 = (String)vec.get(3);
							case 4:
							Option3 = (String)vec.get(4);
							case 5:
							Option4 = (String)vec.get(5);
							case 6:
							Option5 = (String)vec.get(6);
							case 7:
							Answer = (Integer.parseInt((String)vec.get(7)));
							NewAnswer = Answer;
							//case 8:
							//NewAnswer = (String)vec.get(8);
						}
						
						count=i;
						//System.out.println("value of count :"+count);
						if(count<=9)
						{
							QuestionID = String.valueOf(examid) + "00"+count;
						}
						else
						{
							QuestionID = String.valueOf(examid) + "0"+count;
						}
					}
					
					/*System.out.println("k :"+k);
				  	System.out.println("Question :"+Question);
				  	System.out.println("NoOfOptions :"+NoOfOptions);
				  	System.out.println("Option1 :"+Option1);
				  	System.out.println("Option2 :"+Option2);
				  	System.out.println("Option3 :"+Option3);
				  	System.out.println("Option4 :"+Option4);
				  	System.out.println("Option5 :"+Option5);
				  	System.out.println("Answer :"+Answer);
				  	System.out.println("NewAnswer :"+NewAnswer);*/
					
					  java.util.Date date1= new java.util.Date();
					  tm=new Timestamp(date1.getTime());
					  sb.append("INSERT INTO questionmaster(QuestionID,CodeID,PartyID,Question,ExamType,NoOfOptions,Option1," +
								"Option2,Option3,Option4,Option5,Answer,NewAnswer,Explanation,LevelID,ExamID,InsertionDate," +
								"UpdateValidityDate,Status,Image,ResonableTime,Marks,RRN)");


						  sb.append(" VALUES ('"+QuestionID+"','"+CodeID+"',"+PartyID+",'"+Question+"','"+ExamType+"',"+NoOfOptions+","+
							   "'"+Option1+"','"+Option2+"','"+Option3+"','"+Option4+"','"+Option5+"',"+Answer+","+NewAnswer+"," +
								"'"+Explanation+"','"+LevelID+"','"+ExamID+"','"+tm+"',"+UpdateValidityDate+"," +
								""+Status+","+Image+","+ResonableTime+","+Marks+",'"+RRN+"');");
					  sb.append("\n");
					 
					 
					}
			System.out.println("Question :"+sb);
			bw.write(sb.toString());
			bw.newLine();
		    in.close();
  			bw.close();
		 }catch (Exception e){//Catch exception if any
  System.err.println("Error: " + e.getMessage());
  }
  }
}
