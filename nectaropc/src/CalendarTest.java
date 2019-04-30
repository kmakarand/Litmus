import java.util.Calendar;
import java.util.Date;
import java.text.DateFormat;

class CalendarTest
{
	int date = 1;
	int month = 2;
	int year = 2002;
	int newdate = 0;
//	int firstday=0;

	public int  getDateForDay(int firstday,int day)
	{
		int tdate=0;

		if(firstday<day)
		{
			//tdate = (7-firstday) ; //nov - sat
			if (day == 7)
			{
				tdate = (7-firstday)+1 ;
//System.out.println("if(firstday<day) (7-firstday)+1 ");
			}
			else
			{
				tdate = (7-firstday)-1 ;
//System.out.println("if(firstday<day) (7-firstday)-1 ");
			}
//System.out.println(" < firstday : " + firstday +" day : " + day );

		}
		else if (firstday > day)
		{
			tdate = (7 - firstday) + (day) +1 ;
//System.out.println(" > firstday : " + firstday + " day : " + day );
//System.out.println("else if (firstday > day)   (7 - firstday) + (day) +1");
		}
		else if (firstday==day)
		{
			tdate =1;
		}
//System.out.println("tdate : " + tdate);			
		return tdate;

	}


	public CalendarTest()
	{
		Calendar today = Calendar.getInstance();

//		Date mydate = new Date();
//		mydate = today.getTime();
//		//System.out.println("system date : " + mydate);
//		DateFormat df = DateFormat.getDateInstance();
//		String myString = df.format(mydate);
//		//System.out.println("formated system date : " + myString);
		today.set(year, month, date);

//		//System.out.println("First day1111 of the week:  " + today.getFirstDayOfWeek());

		//System.out.println("DATE: " +today.get(Calendar.DATE) );
		//System.out.println("Month :"+today.get(Calendar.MONTH));
		//System.out.println("YEAR :"+today.get(Calendar.YEAR));
		//System.out.println("CURRENT TIME :"+today.getTime());
		Date dt = today.getTime();
		String time = dt.toString();
		time = time.substring(11,20);

		//System.out.println("TODAY :"+today.get(Calendar.DATE) + " " + today.get(Calendar.MONTH) + " " + today.get(Calendar.YEAR)+ " " + time);

		int dayofweek = today.get(Calendar.DAY_OF_WEEK);
		int maxdays = today.getMaximum(Calendar.DATE);
		int thursday = Calendar.FRIDAY;
//		int thursday = 4;
		//System.out.println("day number of required date thur : " + thursday);
		//System.out.println("firstday on whhich 1 date falls : " + dayofweek);

//		//System.out.println("First Day of week on which date 1 falls : " + dayofweek);
//		//System.out.println("Max Days: " + maxdays);

		int newdate = getDateForDay(dayofweek,thursday);
/*
		if (dayofweek < 5)
		{
			int temp = (5 - dayofweek);
			newdate = 1 + temp;
			//System.out.println("<5");
		}
		else if (dayofweek > 5)
		{
			if (dayofweek == 6)
			{
				newdate = (1+6);
			}
			else if (dayofweek == 7)
			{
				newdate = (1+5);
			}
			//System.out.println(">5");
		}
		else if (dayofweek ==5)
		{
			newdate = 1;
		}
*/
		int weekcount = 0;
		int count = newdate;
		
		while (count <= maxdays)
		{
			weekcount++;
			count = count + 7;
		}

		//System.out.println("first day of month which falls on thursday : " + newdate);
		//System.out.println("number of weeks : " + weekcount);
	}
 

	public static void main(String[] args) 
	{
		//System.out.println("Hello World!");
		CalendarTest c1 = new CalendarTest();
	}
}
