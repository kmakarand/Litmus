package com.ngs;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateTest {
	
	public static void main(String args[]) throws ParseException
	{
		int i=2;
		
		while(i>0)
		{
		String ScheduleDate = "2014-03-17";
		SimpleDateFormat sdfSource =new SimpleDateFormat("yyyy-MM-dd");
		Date newDate = (Date)sdfSource.parse(ScheduleDate);
		System.out.println("newDate	:"+newDate);
		SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd");
		ScheduleDate = sdfDest.format(newDate);
		System.out.println("ScheduleDate	:"+ScheduleDate);
		System.out.println("i	:"+i);
		i--;
		}
		
		String Question = "An increase in a firm's expectedgrowth rate would normally causethe firm's required rate of return to";
		Question=Question.replace("'", "\\'");
		System.out.println("i	Question:"+Question);
	    
	}

}
