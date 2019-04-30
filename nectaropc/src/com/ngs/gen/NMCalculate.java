package com.ngs.gen;


import java.sql.*;
import java.util.*;


public class NMCalculate
{

	public int TotalOptions =0;
	public int Marks = 0;
	float PCANS =0;
	float PWANS =0;
	float RATIO =0;
	float reduceby=0;

	
	
	public NMCalculate() {}


	
	public void getQuestionDetails(int QuestionID,Connection con)
	{

		Statement s = null;
		ResultSet r = null;

		try
		{
			s = con.createStatement();

			r = s.executeQuery("Select Marks,NoOfOptions from QuestionMaster where QuestionID="+QuestionID);

			while(r.next()) 
			{
				Marks = r.getInt("Marks");
				TotalOptions = r.getInt("NoOfOptions");
			}
		}
		catch(SQLException e)
		{
			//out.println("Exception caught in getQuestionDetails :"+e.getMessaage());
		}
	}


	public int getMarks(int QuestionID,Connection con)
	{
		getQuestionDetails(QuestionID,con);
		//System.out.println("Question ID :"+QuestionID+" Marks :"+Marks);
		
		return(Marks);

	}


	public float getMarksReductionValue(int QuestionID,Connection con)
	{
		
		getQuestionDetails(QuestionID,con);
		
		PCANS  = (100/TotalOptions);//*100;
		PWANS  = 100 - PCANS;

		RATIO  = (PCANS/PWANS)*100;
		RATIO =(float)Math.floor(RATIO);

		reduceby = (float)Marks * ((float)RATIO/(float)100);
		//System.out.println("Reduce by:"+reduceby);
		if (reduceby >= 0.65 && reduceby <= 0.68)
		{
			reduceby=(float)0.67;
		}
		else if (reduceby >= 0.99 && reduceby <= 1.05)
		{
			reduceby=1;
		}
		return(reduceby);


	}

}
