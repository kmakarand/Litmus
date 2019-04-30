<%@ page language="java" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>

<HTML>
<TITLE>Exam </TITLE>
</HEAD>
<style>td{font-family:arial;font-size:10pt;} body{font-family:arial;font-size:11pt;} b{font-family:arial;font-size:11pt;}</style>
</HEAD>
<script language="javascript">
var records = 0;
function closes()
{
	history.back();
}
function check()
{
	for (i=0;i<10;i++)
	{
		var x = "document.frminsert.code" + i;

		if(!isnulls(x))
		{
//			Value has not been entered in this field
		}
		else
		{
			if (eval(x).value.length>255)
			{
				alert("Code cannot be more than 255 character long !! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.testname" + i;
			if (!isnulls(x))
			{
				alert("Test Name is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>25)
			{
				alert("Test name cannot be more than 25 characters long !! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.noquestions" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Number of Questions is a Numeric Field"))
			{
				alert("Number of questions is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>3)
			{
				alert("Number of Questions cannot be more than 999 per Exam!! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.responsetime" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Response Time is a Numeric Field"))
			{
				alert("Response Time is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>3)
			{
				alert("Response Time cannot be more than 999 per question !! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.nobreaks" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Number of Breaks is a Numeric Field"))
			{
				alert("Number of Breaks Allowed is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>1)
			{
				alert("Number of Breaks cannot be more than 9 times per Exam !! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.nointerval" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Number of Interval is a Numeric Field"))
			{
				alert("Break Interval is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>4)
			{
				alert("Break Interval cannot be more than 9,999 seconds per Exam!! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.criteria" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Criteria is a Numeric Field"))
			{
				alert("Criteria is a compulsory Field");
				eval(x).focus();
				return false;
			}
//			alert(eval(x).value)
			if (eval(x).value>100)
			{
				alert("Criteria cannot be more than 100.00 !! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.examtime" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Exam Time is a Numeric Field"))
			{
				alert("ExamTime is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>5)
			{
				alert("Exam Time cannot be more than 99,999 per Exam !! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.sequenceid" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Sequence Id is a Numeric Field"))
			{
				alert("Sequence is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>99)
			{
				alert("Sequence Id cannot be more than 99 !! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.nemarks" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Negative Marks is a Numeric Field"))
			{
				alert("Negative Marks is compulsory Field");
				eval(x).focus();

				return false;
			}
			if (eval(x).value.length>4)
			{
				alert("Negative marks cannot be more than 9,999.99 marks per question  !! ");
				eval(x).focus();
				return false;
			}
			x="document.frminsert.noattempts" + i;
			if (!isnulls(x)|| !checkNumeric(eval(x),"Number of Attempts Allowed is a Numeric Field"))
			{
				alert("Number of Attempts is compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>1)
			{
				alert("Number of Attempts cannot be more than 9 times per Exam !! ");
				eval(x).focus();
				return false;
			}
		/*	x="document.frminsert.levelid" + i;
			if (!isnulls(x)|| !checkNumeric(eval(x),"Level Id Id is a Numeric Field"))
			{
				alert("Level id is a compulsory Field");
				eval(x).focus();
				return false;
			}*/
			x="document.frminsert.prerequisite"+i;
			if (eval(x).value.length>8)
			{
				alert("Prerequisite cannot be more than 8 characters long !! ");
				eval(x).focus();
				return false;
			}
		}
	}

// for record count
	for (i=0;i<10;i++)
	{
		var x = "document.frminsert.code" + i;
		if(!isnulls(x))
		{
//			Value has not been entered in this field
		}
		else
		{
			records = records + 1;
		}
	}
//	alert(records);
	if (records==0)
	{
		alert("Atleast one record should be inserted");
	}
	else
	{
		document.frminsert.norecords.value=records;
		document.frminsert.submit();
		return true;
	}
}

function checkEdit()
{
	var rec=document.frmchange.records.value;

	for (i=0;i<rec;i++)
	{
		var x="document.frmchange.testname" + i;
		if (!isnulls(x))
			{
				alert("Test Name is a compulsory Field");
				eval(x).focus();
				return false;
			}
		if (eval(x).value.length>25)
			{
				alert("Test Name cannot be more 25 characters long !! ");
				eval(x).focus();
				return false;
			}
		x="document.frmchange.noquest" + i;
		if (!isnulls(x) || !checkNumeric(eval(x),"Number of Questions is a Numeric Field"))
			{
				alert("Number of questions is a compulsory Field");
				eval(x).focus();
				return false;
			}
		if (eval(x).value.length>3)
		{
			alert("Number of Questions cannot be more than 999 !! ");
			eval(x).focus();
			return false;
		}
		x="document.frmchange.responsetime" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Response Time is a Numeric Field"))
			{
				alert("Response Time is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>3)
			{
				alert("Response Time cannot be more than 999 seconds per question !! ");
				eval(x).focus();
				return false;
			}
			x="document.frmchange.nobreaks" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Number of Breaks is a Numeric Field"))
			{
				alert("Number of Breaks Allowed is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>1)
			{
				alert("Number of breaks cannot be more than 9 times!! ");
				eval(x).focus();
				return false;
			}
			x="document.frmchange.breakinterval" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Number of Interval is a Numeric Field"))
			{
				alert("Break Interval is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>4)
			{
				alert("Break Interval cannot be more than 9,999 seconds !! ");
				eval(x).focus();
				return false;
			}
			x="document.frmchange.criteria" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Criteria is a Numeric Field"))
			{
				alert("Criteria is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value>100)
			{
				alert("Criteria cannot be more than 100 !! ");
				eval(x).focus();
				return false;
			}
			x="document.frmchange.examtime" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Exam Time is a Numeric Field"))
			{
				alert("ExamTime is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>5)
			{
				alert("Exam Time cannot be more than 99,999 seconds per Exam !! ");
				eval(x).focus();
				return false;
			}
			x="document.frmchange.sequenceid" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Sequence Id is a Numeric Field"))
			{
				alert("Sequence is a compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>2)
			{
				alert("Sequence Id cannot be more than 99 !! ");
				eval(x).focus();
				return false;
			}
			x="document.frmchange.nemarks" + i;
			if (!isnulls(x) || !checkNumeric(eval(x),"Negative Marks is a Numeric Field"))
			{
				alert("Negative Marks is compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>4)
			{
				alert("Negative Marks cannot be more than 9,999.99 per question !! ");
				eval(x).focus();
				return false;
			}
			x="document.frmchange.noattempts" + i;
			if (!isnulls(x)|| !checkNumeric(eval(x),"Number of Attempts Allowed is a Numeric Field"))
			{
				alert("Number of Attempts is compulsory Field");
				eval(x).focus();
				return false;
			}
			if (eval(x).value.length>1)
			{
				alert("Numer of Attempts cannot be more than 9 per Exam !! ");
				eval(x).focus();
				return false;
			}
			x="document.frmchange.prerequisite"+i;
			if (eval(x).value.length>8)
			{
				alert("Prerequisite cannot be more than 8 characters !! ");
				eval(x).focus();
				return false;
			}
	}

/*		x="document.frmchange.frequency" ;
		alert("xy "+x);
		if (!isnulls(x)|| !checkNumeric(eval(x),"Frequency  is a Numeric Field"))
		{
			alert("Frequency is a compulsory Field");
			eval(x).focus();
			return false;
		}
*/
	/*	startdate=self.document.frmmaster.stdate.options[self.document.frmmaster.stdate.selectedIndex].value+self.document.frmmaster.stmonth.options[self.document.frmmaster.stmonth.selectedIndex].value+self.document.frmmaster.styear.options[self.document.frmmaster.styear.selectedIndex].value;
		*/	startdates=self.document.frmchange.dt.options[self.document.frmchange.dt.selectedIndex].value+self.document.frmchange.mt.options[self.document.frmchange.mt.selectedIndex].value+self.document.frmchange.yr.options[self.document.frmchange.yr.selectedIndex].value;
		if ( !checkDate(startdates) )
		{
			self.document.frmchange.mt.focus();
			return false;
		}
		enddates=self.document.frmchange.eddt.options[self.document.frmchange.eddt.selectedIndex].value+self.document.frmchange.edmt.options[self.document.frmchange.edmt.selectedIndex].value+self.document.frmchange.edyr.options[self.document.frmchange.edyr.selectedIndex].value;
		if ( !checkDate(enddates) )
		{
			self.document.frmchange.edmt.focus();
			return false;
		}
		if (startdates==enddates)
		{
			alert("Exam Start Date and End Date cannot be same !! ");
			return false;
		}
/*		if (startdates<enddates)
		{
			alert("Start Date cannot be after  End Date !! ");
			return false;
		}*/
		document.frmchange.submit();
}

function isnulls(name)
{

	if (eval(name).value=="")
	{
		return false;
	}
	else
		return true;
}
function notNull(x,msg)
{
	if (!isnulls(x))
	{
		alert(msg);
		x.focus();
		x.select();
		return false;
	}
	else
		return true;
}

function checkDate(str_val){
	month_val=str_val.substr(2,2);
	day_val=str_val.substring(0,2);
	year_val=str_val.substring(4,4);
	mondays=new Array('0','31','28','31','30','31','30','31','31','30','31','30','31');
	if ( year_val%4 == 0  && (year_val %100 != 0  || year_val % 400 == 0) )
		mondays[2]='29';
//	if ( str_val.length < 8 ) {
//		alert("Invalid Date format");
//		return false; }
//	if(month_val < 1 || month_val > 12) {
//		alert("Invalid Date format");
//		return false; }
//	if(day_val < 1 || day_val >31) {
//		alert("Invalid Date format");
//		return false;  }
	if( day_val > mondays[eval(month_val)] ) {
		alert("No. of days exceeds from No. of days allowed in Month");
		return false;  	 }
	return true;
}

function checkNumber()
{
	startdate=self.document.frmmaster.stdate.options[self.document.frmmaster.stdate.selectedIndex].value+self.document.frmmaster.stmonth.options[self.document.frmmaster.stmonth.selectedIndex].value+self.document.frmmaster.styear.options[self.document.frmmaster.styear.selectedIndex].value;
//	alert(startdate);
	if ( !checkDate(startdate) )
	{
		self.document.frmmaster.stmonth.focus();
		return false;
	}
	enddate=self.document.frmmaster.eddate.options[self.document.frmmaster.eddate.selectedIndex].value+self.document.frmmaster.edmonth.options[self.document.frmmaster.edmonth.selectedIndex].value+self.document.frmmaster.edyear.options[self.document.frmmaster.edyear.selectedIndex].value;
//	alert(enddate);
	if ( !checkDate(enddate) ) {
				self.document.frmmaster.edmonth.focus();
			return false;
		}

	if (startdate==enddate)
	{
		alert("Exam Start Date and End Date cannot be same !! ");
		return false;
	}
	if (self.document.frmmaster.styear.value > self.document.frmmaster.edyear.value)
	{
		alert("End Year cannot be before Start Year !! ");
		return false;
	}
	if (self.document.frmmaster.stmonth.value > self.document.frmmaster.edmonth.value)
	{
		alert("End month cannot be before Start month !! ");
		return false;
	}
	if (self.document.frmmaster.stdate.value > self.document.frmmaster.eddate.value)
	{
		alert("End date cannot be before Start Date !! ");
		return false;
	}
	if(! notNull(self.document.frmmaster.examname,"Exam Name cannot be empty"))
	{
		return false;
	}
	if(! notNull(self.document.frmmaster.frequency,"Frequency cannot be empty"))
	{
		return false;
	}
	if(!checkNumeric(self.document.frmmaster.frequency,"Frequency is a Numeric Field"))
	{
		return false;
	}
	if (self.document.frmmaster.frequency.value.length>1)
	{
		alert("Frequency cannot be more than 9 per Year !!");
		self.document.frmmaster.frequency.value="";
		self.document.frmmaster.frequency.focus();
		return false;
	}
	if (self.document.frmmaster.examname.value.length>10)
	{
		alert("Exam Name cannot be more than 10 characters !!");
		self.document.frmmaster.examname.focus();
		return false;
	}
	if (self.document.frmmaster.conductedby.value.length>250)
	{
		alert("Conducted by Field cannot be more than 250 characters !!");
		self.document.frmmaster.conducted.focus();
		return false;
	}
	if (self.document.frmmaster.centre.value.length>250)
	{
		alert("Centre Field cannot be more than 250 characters !!");
		self.document.frmmaster.centre.focus();
		return false;
	}
	if (self.document.frmmaster.country.value.length>25)
	{
		alert("Country Field cannot be more than 25 characters !!");
		self.document.frmmaster.country.focus();
		return false;
	}
	document.frmmaster.submit();

}


function checkNumeric(field,msg)
{
	var strString = field.value;
	var strValidChars = "0123456789.-";
	var strChar;
//	var blnResult = true;
//	for (i = 0; i < strString.length && blnResult == true; i++)

	for (a = 0; a < strString.length ; a++)
	{
		strChar = strString.charAt(a);
		if (strValidChars.indexOf(strChar) == -1)
		{
			alert(msg);
			field.value="";
			field.focus();
			return false;
		}
	}
	return true;
}
function deletes(val)
{
	var id = val.value;
	if (id==null || id == "")
	{
		alert("Please inset valid Exam Number !!");
		return false;
	}
	else if(!checkNumeric(self.document.frmdelmaster.examid,"Frequency is a Numeric Field"))
	{
		return false;
	}
	else
	{
		var get=confirm("Are you Sure you want to delete !! \n Corresponding Details will also be deleted !! ");
		if (get)
		{
			document.frmdelmaster.submit();
		}
	}
}
function deletes1()
{
	var get=confirm("Are you Sure you want to delete !! ");
	if (get)
	{
		document.frmdeldetails.submit();
	}
}
function backs()
{
	history.back();
}
function changes(val)
{
	var id = val.value;
	if (id==null || id == "")
	{
		alert("Please inset valid Exam Number !!");
		return false;
	}
	else if(!checkNumeric(self.document.frmchanges.examid,"Frequency is a Numeric Field"))
	{
		return false;
	}
	else
		document.frmchanges.submit();
}

</script>

<BODY bgcolor='#FEF9E2'>
<%
	Connection conn = null;
	int count=0;

	String action=request.getParameter("action");
	if (action == "" || action == null )
	{
//		action="Nothing ";
	out.println("<center>");
	out.println("<h4>Nectar Global Services Ltd.</h4><hr>");
	out.println("<form method=post name=frminput>");
	out.println("<INPUT TYPE=HIDDEN  name=action value='doMaster'>");
	out.println("<input type=submit value='Add Records'>");
	out.println("</form>");

	out.println("<form method='POST'>");
	out.println("<INPUT TYPE=HIDDEN  name=action value='doEdit'>");
	out.println("<input type=submit value='Edit Records'>");
	out.println("</form>");


	out.println("<form method='POST'>");
	out.println("<INPUT TYPE=HIDDEN  name=action value='doDelete'>");
	out.println("<input type=submit value='Delete Records'>");
	out.println("</form>");

	out.println("<form method='POST'>");
	out.println("<INPUT TYPE=HIDDEN  name=action value='doView'>");
	out.println("<input type=submit value='View Records'>");
	out.println("</form>");

	out.println("</center>");

	}
// doMaster
	else if (action.equals("doMaster") )
	{
		try
		{
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			String sql="select count(*) from ExamMaster ";
			rs = stmt.executeQuery(sql);
			int examid=0;
			int totrecords=0;
			if (rs.next())
			{
				totrecords = Integer.parseInt(rs.getString(1));
			}

			sql = "select * from ExamMaster order by ExamID";
			rs= stmt.executeQuery(sql);
			int a=0;
			while(rs.next())
			{
				a= rs.getInt("ExamID");
			}

			if (totrecords==0){	examid =1;	}
			else
			{
				examid= a + 1;
			}


//			out.println("<FORM method=POST name=frmmaster onSubmit='return checkNumber(); return notNull();'>");
			out.println("<center>");
			out.println("<FORM method=POST name=frmmaster >");
			out.println("<h4><center>Enter Exam Master </center></h4><hr>");
			out.println("<table border=0 bgcolor='#FEEEC8'>");

			out.println("<tr><td><font color='#960317'>Exam Id</font></td>");
			out.println("<td>"+examid+"</td></tr>");

			out.println("<tr><td><font color='#960317'>Exam Name : </font></td>");
			out.println("<td><INPUT TYPE=TEXT name=examname SIZE=6></td></tr>");

			out.println("<tr><td><font color='#960317'>Exam Mode : </font></td>");
			out.println("<td><select name=exammode>");
			out.println("<option value=0>Random</option>");
			out.println("<option value=1>Sequencial</option>");
			out.println("</select>");

			out.println("<tr><td><font color='#960317'>Start Date :</font></td>");

			out.println("<td><select name=stdate>");
			out.println("<option value=01>1</option>");
			out.println("<option value=02>2</option>");
			out.println("<option value=03>3</option>");
			out.println("<option value=04>4</option>");
			out.println("<option value=05>5</option>");
			out.println("<option value=06>6</option>");
			out.println("<option value=07>7</option>");
			out.println("<option value=08>8</option>");
			out.println("<option value=09>9</option>");
			out.println("<option value=10>10</option>");
			out.println("<option value=11>11</option>");
			out.println("<option value=12>12</option>");
			out.println("<option value=13>13</option>");
			out.println("<option value=14>14</option>");
			out.println("<option value=15>15</option>");
			out.println("<option value=16>16</option>");
			out.println("<option value=17>17</option>");
			out.println("<option value=18>18</option>");
			out.println("<option value=19>19</option>");
			out.println("<option value=20>20</option>");
			out.println("<option value=21>21</option>");
			out.println("<option value=22>22</option>");
			out.println("<option value=23>23</option>");
			out.println("<option value=24>24</option>");
			out.println("<option value=25>25</option>");
			out.println("<option value=26>26</option>");
			out.println("<option value=27>27</option>");
			out.println("<option value=28>28</option>");
			out.println("<option value=29>29</option>");
			out.println("<option value=30>30</option>");
			out.println("<option value=31>31</option>");
			out.println("</select></td>");

			out.println("<td><select name=stmonth>");
			out.println("<option value=01>January</option>");
			out.println("<option value=02>Feburary</option>");
			out.println("<option value=03>March</option>");
			out.println("<option value=04>April</option>");
			out.println("<option value=05>May</option>");
			out.println("<option value=06>June</option>");
			out.println("<option value=07>July</option>");
			out.println("<option value=08>Agust</option>");
			out.println("<option value=09>September</option>");
			out.println("<option value=10>October</option>");
			out.println("<option value=11>November</option>");
			out.println("<option value=12>December</option>");
			out.println("</select></td>");

			out.println("<td><select name=styear>");
			out.println("<option value=2000>2000</option>");
			out.println("<option value=2001>2001</option>");
			out.println("<option value=2002>2002</option>");
			out.println("<option value=2003>2003</option>");
			out.println("<option value=2004>2004</option>");
			out.println("<option value=2005>2005</option>");
			out.println("<option value=2006>2006</option>");
			out.println("<option value=2007>2007</option>");
			out.println("<option value=2008>2008</option>");
			out.println("<option value=2009>2009</option>");
			out.println("<option value=2010>2010</option>");
			out.println("</select></td>");

			out.println("<tr><td><font color='#960317'>End Date : </font> </td>");

			out.println("<td><select name=eddate>");
			out.println("<option value=01>1</option>");
			out.println("<option value=02>2</option>");
			out.println("<option value=03>3</option>");
			out.println("<option value=04>4</option>");
			out.println("<option value=05>5</option>");
			out.println("<option value=06>6</option>");
			out.println("<option value=07>7</option>");
			out.println("<option value=08>8</option>");
			out.println("<option value=09>9</option>");
			out.println("<option value=10>10</option>");
			out.println("<option value=11>11</option>");
			out.println("<option value=12>12</option>");
			out.println("<option value=13>13</option>");
			out.println("<option value=14>14</option>");
			out.println("<option value=15>15</option>");
			out.println("<option value=16>16</option>");
			out.println("<option value=17>17</option>");
			out.println("<option value=18>18</option>");
			out.println("<option value=19>19</option>");
			out.println("<option value=20>20</option>");
			out.println("<option value=21>21</option>");
			out.println("<option value=22>22</option>");
			out.println("<option value=23>23</option>");
			out.println("<option value=24>24</option>");
			out.println("<option value=25>25</option>");
			out.println("<option value=26>26</option>");
			out.println("<option value=27>27</option>");
			out.println("<option value=28>28</option>");
			out.println("<option value=29>29</option>");
			out.println("<option value=30>30</option>");
			out.println("<option value=31>31</option>");
			out.println("</select></td>");

			out.println("<td><select name=edmonth>");
			out.println("<option value=01>January</option>");
			out.println("<option value=02>Feburary</option>");
			out.println("<option value=03>March</option>");
			out.println("<option value=04>April</option>");
			out.println("<option value=05>May</option>");
			out.println("<option value=06>June</option>");
			out.println("<option value=07>July</option>");
			out.println("<option value=08>Agust</option>");
			out.println("<option value=09>September</option>");
			out.println("<option value=10>October</option>");
			out.println("<option value=11>November</option>");
			out.println("<option value=12>December</option>");
			out.println("</select></td>");

			out.println("<td><select name=edyear>");
			out.println("<option value=2000>2000</option>");
			out.println("<option value=2001>2001</option>");
			out.println("<option value=2002>2002</option>");
			out.println("<option value=2003>2003</option>");
			out.println("<option value=2004>2004</option>");
			out.println("<option value=2005>2005</option>");
			out.println("<option value=2006>2006</option>");
			out.println("<option value=2007>2007</option>");
			out.println("<option value=2008>2008</option>");
			out.println("<option value=2009>2009</option>");
			out.println("<option value=2010>2010</option>");
			out.println("</select></td>");

			out.println("<tr><td><font color='#960317'>Conducted By :</font></td>");
			out.println("<td><INPUT TYPE=TEXT name=conductedby SIZE=6></td></tr>");

			out.println("<tr><td><font color='#960317'>Center : </font> </td>");
			out.println("<td><INPUT TYPE=TEXT name=centre SIZE=6></td></tr>");

			out.println("<tr><td><font color='#960317'>Country : </font> </td>");
			out.println("<td><INPUT TYPE=TEXT name=country SIZE=6></td><tr>");
			out.println("<tr><td><font color='#960317'>Frequency : </font></td>");
			out.println("<td><INPUT TYPE=TEXT name=frequency SIZE=6></td></tr>");
			out.println("</TABLE>");

			out.println("<br><INPUT TYPE='button'  value='Insert' onclick='checkNumber();'>");
			out.println("<INPUT TYPE='button'  value='cancel' onclick='closes();'>");
			out.println("<INPUT TYPE=HIDDEN  name=examid value="+examid+">");
			out.println("<INPUT TYPE=HIDDEN  name=action value='doInsert'>");
			out.println("</FORM>");

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
// doInsert
	else if (action.equals("doInsert"))
	{

		out.println("Enter Details in ExamDetails <hr>");
		try
		{
			conn = pool.getConnection();
			Statement stmt,stmt1 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1=conn.createStatement();
			String sql="";
			int examid=Integer.parseInt(request.getParameter("examid"));
			String examname=request.getParameter("examname");
			int exammode=Integer.parseInt(request.getParameter("exammode"));
			int styear=Integer.parseInt(request.getParameter("styear"));
			String stmonth = request.getParameter("stmonth");
			int stdate = Integer.parseInt(request.getParameter("stdate"));
			String startdate=styear+"-"+stmonth+"-"+stdate;

			int edyear=Integer.parseInt(request.getParameter("edyear"));
			String edmonth = request.getParameter("edmonth");
			int eddate = Integer.parseInt(request.getParameter("eddate"));
			String enddate=edyear+"-"+edmonth+"-"+eddate;

			String conductedby=request.getParameter("conductedby");
			String centre=request.getParameter("centre");
			String country=request.getParameter("country");
			int frequency=Integer.parseInt(request.getParameter("frequency"));
			String done=request.getParameter("done");

			if (done == null || done == "")
			{
				sql="INSERT INTO ExamMaster (ExamID,Exam,ExamMode,StartDate,EndDate,ConductedBy,Centre,Country,Frequency) values(" + examid + ",'" + examname + "'," + exammode + ",'" + startdate + "','" + enddate + "','" +conductedby + "','" + centre + "','" + country + "'," + frequency + ") ";
				int records = stmt.executeUpdate(sql);
			}

			sql = "SELECT * FROM ExamMaster where ExamID = " + examid;
			rs=stmt.executeQuery(sql);
			out.println("<TABLE width='100%' bgcolor='#FEEEC8'> ");
			out.println("<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </TD></font><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD></TR>");
			while(rs.next())
			{
				out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD></TR>");

			}
			int i=0;
			out.println("</TABLE>");
			out.println("<FORM method=post name=frminsert>");
			out.println("<TABLE width='100%' border=0 bgcolor='#FEEEC8'> ");
			out.println("<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Sr. No.</font></TD><TD><font color='#960317'>Code</font></TD><TD><font color='#960317'>Test Name</font></TD><TD><font color='#960317'>Number of Questions </font></TD><TD><font color='#960317'>Question Timer</font></TD><TD><font color='#960317'>Response Time</font></TD><TD><font color='#960317'>Number of Breaks allowed</font></TD><TD><font color='#960317'>Break Interval</font></TD><TD><font color='#960317'>Criteria</font></TD><TD><font color='#960317'>Examtime</font></TD><TD><font color='#960317'>Sequence Id</font></TD><TD><font color='#960317'>Negative Marks</font></TD><TD><font color='#960317'>Number of Attempts Allowed</font></TD><TD><font color='#960317'>Prerequisite</font></TD><TD><font color='#960317'>Level Id</font></TD><TD><font color='#960317'>Include SubLevels</font></TD></TR>");
			while (i<10)
			{
				out.println("<TR bgcolor='#FFF5E7'><TD>"+(i+1)+"</TD><TD><INPUT TYPE=TEXT SIZE='7' name=code" +i+ "></TD><TD><INPUT TYPE=TEXT SIZE='6' name=testname" +i+ "></TD> <TD><INPUT TYPE=TEXT SIZE='5' name=noquestions" + i +"></TD><TD><select name=isquesttimer"+i+"><option value=1>True</option><option value=0>False</option></select></TD><TD><INPUT TYPE=TEXT SIZE='5' name=responsetime"+i+"></TD><TD><INPUT TYPE=TEXT SIZE='5' name=nobreaks"+i+" value=0></TD><TD><INPUT TYPE=TEXT SIZE='5' name=nointerval"+i+" value=0></TD><TD><INPUT TYPE=TEXT SIZE='5' name=criteria"+i+"></TD><TD><INPUT TYPE=TEXT SIZE='5' name=examtime"+i+"></TD><TD><INPUT TYPE=TEXT SIZE='5' name=sequenceid"+i+"></TD><TD><INPUT TYPE=TEXT SIZE='5' name=nemarks"+i+" value=0.00></TD><TD><INPUT TYPE=TEXT SIZE='5' name=noattempts"+i+" value=0></TD><TD><INPUT TYPE=TEXT SIZE='7' name=prerequisite"+i+" ></TD><TD>");
				out.print("<SELECT name=levelid"+i+">one");
				String pql="select * from LevelMaster";
				rs1=stmt1.executeQuery(pql);
				while(rs1.next())
					{
						String lvl=rs1.getString("Level");
						int lid = rs1.getInt("LevelID");
						out.print("<option value="+lid+">"+lvl+"</option>");
					  }
				out.print("</select></TD><TD><select name=includesublevels" +i+"><option value=1>Yes</option><option value=0>No</option></select></TD></TR>");
				++i;
			}
			out.println("</TABLE> ");
			out.println("<INPUT TYPE=HIDDEN name=\"action\" value='doFeed' >");
			out.println("<INPUT TYPE=HIDDEN name=norecords value='' >");
			out.println("<INPUT TYPE=HIDDEN name=examid value="+examid+" >");
			out.println("<INPUT TYPE=HIDDEN name=examname value="+examname+" >");
			out.println("<INPUT TYPE=HIDDEN name=exammode value="+exammode+">");
			out.println("<INPUT TYPE=HIDDEN name=stdate value="+stdate+">");
			out.println("<INPUT TYPE=HIDDEN name=styear value="+styear+">");
			out.println("<INPUT TYPE=HIDDEN name=stmonth value="+stmonth+">");
			out.println("<INPUT TYPE=HIDDEN name=eddate value="+eddate+">");
			out.println("<INPUT TYPE=HIDDEN name=edmonth value="+edmonth+">");
			out.println("<INPUT TYPE=HIDDEN name=edyear value="+edyear+">");
			out.println("<INPUT TYPE=HIDDEN name=conductedby value="+conductedby+">");
			out.println("<INPUT TYPE=HIDDEN name=centre value="+centre+">");
			out.println("<INPUT TYPE=HIDDEN name=country value="+country+">");
			out.println("<INPUT TYPE=HIDDEN name=frequency value="+frequency+">");
			out.println("<br><INPUT TYPE='button' value='Insert' OnClick='return check();'>");
			out.println("<INPUT TYPE='button' value='Cancel' OnClick='closes();'>");
			out.println("</FORM>");
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
// doFeed
	else if(action.equals("doFeed"))
	{
		try
		{
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			int norecords=Integer.parseInt(request.getParameter("norecords"));
			int examid=Integer.parseInt(request.getParameter("examid"));
			int exammode=Integer.parseInt(request.getParameter("exammode"));
			String stdate=request.getParameter("stdate");
			String examname=request.getParameter("examname");
			String stmonth=request.getParameter("stmonth");
			String styear=request.getParameter("styear");
			String eddate=request.getParameter("eddate");
			String edmonth=request.getParameter("edmonth");
			String edyear=request.getParameter("edyear");
			String conductedby=request.getParameter("conductedby");
			String centre=request.getParameter("centre");
			String country=request.getParameter("country");
			int frequency=Integer.parseInt(request.getParameter("frequency"));
			out.println("<center><h4>Exam Details <h4><hr></center>");

			for (count=0;count<norecords;count++)
			{
				String code= request.getParameter("code"+count);
				code=code.trim();
				String testname = request.getParameter("testname"+count);
				int noquest = Integer.parseInt(request.getParameter("noquestions"+count+""));
				int responsetime = Integer.parseInt(request.getParameter("responsetime"+count+""));
				int isquesttimer = Integer.parseInt(request.getParameter("isquesttimer"+count+""));
				int nobreaks = Integer.parseInt(request.getParameter("nobreaks"+count+""));
				int breakinterval = Integer.parseInt(request.getParameter("nointerval"+count+""));
				Float cri = new Float(request.getParameter("criteria"+count+""));
				float criteria = cri.floatValue();
				int examtime = Integer.parseInt(request.getParameter("examtime"+count+""));
				int sequenceid = Integer.parseInt(request.getParameter("sequenceid"+count+""));
				Float abc = new Float(request.getParameter("nemarks"+count+""));
				float nemarks = abc.floatValue();
				int noattempts = Integer.parseInt(request.getParameter("noattempts"+count+""));
				String prerequisite = request.getParameter("prerequisite"+count+"");
				int levelid = Integer.parseInt(request.getParameter("levelid"+count+""));
				int includesublevels = Integer.parseInt(request.getParameter("includesublevels"+count));

				if(prerequisite.equals(null) || prerequisite.equals(""))
					prerequisite="N.A";
				if(nobreaks==0)
					breakinterval=0;

				String sql="insert into ExamDetails (ExamId,Code,TestName,NoOfQuestions,isQuestionTimer,ResponseTime,NoOfBreaksAllowed,BreakInterval,Criteria,ExamTime,SequenceId,NegativeMarks,NoOfAttemptsAllowed,Prerequisite,LevelID,IncludeSubLevels) values ("+examid+",'"+code+"','"+testname+"',"+noquest+","+isquesttimer+","+responsetime+","+nobreaks+","+breakinterval+","+criteria+","+examtime+","+sequenceid+","+nemarks+","+noattempts+",'"+prerequisite+"',"+levelid+","+includesublevels+")";
//out.println(sql);
				int record = stmt.executeUpdate(sql);
		}

			out.println("Exam Master <br>");
			String sql = "SELECT * FROM ExamMaster where ExamID = " + examid;
			rs=stmt.executeQuery(sql);
			out.println("<TABLE width='100%' border=0 bgcolor='#FEEEC8'> ");
			out.println("<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </font></TD><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD></TR>");
			while(rs.next())
			{
				out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD></TR>");

			}
			out.println("</table>");
			out.println("<br><h4>Exam Details<h4>");
			sql="select * from ExamDetails where ExamID =" + examid ;
			rs= stmt.executeQuery(sql);

			out.println("<TABLE border=0 width='100%' bgcolor='#FEEEC8'>");
			out.println("<tr bgcolor='#FEEEC8'><td>Sr. No.</td><td><font color='#960317'>Code</font></td><td><font color='#960317'>Test Name</font></td><td><font color='#960317'>Number of Questions</font></td><td><font color='#960317'>Question Timer</font></td><td><font color='#960317'>Response Time</font></td><td><font color='#960317'>Number of Breaks Allowed</font></td><td><font color='#960317'>Break Interval</font></td><td><font color='#960317'>Criteria</font></td><td><font color='#960317'>Exam Time</font></td><td><font color='#960317'>Sequence Id</font></td><td><font color='#960317'>Negative Marks</font></td><td><font color='#960317'>Number of Attempts Allowed</font></td><td><font color='#960317'>Prerequisite</code></td><td><font color='#960317'>Level ID</font></td></td><td><font color='#960317'>Include Sub Levels</font></td></tr>");
			int x=1;
			while (rs.next())
			{
				out.println("<tr bgcolor='#FFF5E7'><td>"+x +"</td><td>"+rs.getString("Code") +"</td><td>"+rs.getString("TestName") +"</td><td>"+rs.getInt("NoOfQuestions") +"</td><td>"+rs.getInt("isQuestionTimer") +"</td><td>"+rs.getInt("ResponseTime") +"</td><td>"+rs.getInt("NoOfBreaksAllowed") +"</td><td>"+rs.getInt("BreakInterval") +"</td><td>"+rs.getFloat("Criteria") +"</td><td>"+rs.getInt("ExamTime") +"</td><td>"+rs.getInt("SequenceID") +"</td><td>"+rs.getFloat("NegativeMarks") +"</td><td>"+rs.getInt("NoOfAttemptsAllowed") +"</td><td>"+rs.getString("Prerequisite") +"</td><td>"+rs.getInt("LevelID") +"</td><td>"+rs.getInt("IncludeSubLevels") +"</td></tr>");
				x++;
			}
			out.println("</table>");
			String done="yes";
			out.println("<form method=post>");
			out.println("<input type=submit value='Insert more Records'>");
			out.println("<input type='button' value =Cancel onclick='closes();'>");
			out.println("<INPUT TYPE=HIDDEN name=examid value="+examid+">");
			out.println("<INPUT TYPE=HIDDEN name=exammode value="+exammode+">");
			out.println("<INPUT TYPE=HIDDEN name=exammode value="+examname+">");
			out.println("<INPUT TYPE=HIDDEN name=stdate value="+stdate+">");
			out.println("<INPUT TYPE=HIDDEN name=styear value="+styear+">");
			out.println("<INPUT TYPE=HIDDEN name=stmonth value="+stmonth+">");
			out.println("<INPUT TYPE=HIDDEN name=eddate value="+eddate+">");
			out.println("<INPUT TYPE=HIDDEN name=edmonth value="+edmonth+">");
			out.println("<INPUT TYPE=HIDDEN name=edyear value="+edyear+">");
			out.println("<INPUT TYPE=HIDDEN name=conductedby value="+conductedby+">");
			out.println("<INPUT TYPE=HIDDEN name=centre value="+centre+">");
			out.println("<INPUT TYPE=HIDDEN name=country value="+country+">");
			out.println("<INPUT TYPE=HIDDEN name=frequency value="+frequency+">");
			out.println("<INPUT TYPE=HIDDEN name=done value="+done+">");
			out.println("<INPUT TYPE=HIDDEN name=action value='doInsert'>");
			out.println("</form>");
			out.println("<form method=post action='MainForm.jsp'>");
			out.println("<input type=submit value='Home'>");
			out.println("</form>");
		}
		catch(SQLException e)
		{
			out.println("Error : Possibily duplicate records " + e.getMessage());
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
//doFeed
	else if(action.equals("doEdit"))
	{
		out.println("<center><h4>View Exam Master </h4><hr>");
		try
		{
			out.println("<br> Enter Exam Id : ");
			out.println("<form method=post name=frmchanges>");
			out.println("<input type=text name=examid >");
			out.println("<INPUT TYPE=HIDDEN name=action value='doChange' >");
			out.println("<input type=button value=Edit onclick='changes(examid);'>");
			out.println("<input type='button' value =Cancel onclick='backs();'>");
			out.println("</form>");
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
//doChange
	else if(action.equals("doChange"))
	{

		int examid=Integer.parseInt(request.getParameter("examid"));
		out.println("<h4>Edit for ExamID :" + examid +"</h4><hr size=1>");

		try
		{
			conn = pool.getConnection();
			Statement stmt,stmt1 = null;
			ResultSet rs,rs1 = null;
			stmt = conn.createStatement();
			stmt1 = conn.createStatement();

			String sql="select count(*) from ExamDetails where ExamId = " + examid;
			int records=0;
			rs=stmt.executeQuery(sql);

			while(rs.next())
			{	records=rs.getInt(1);}

			if (records==0)
				out.println("<h4>No matching record found !! </h4>");
			else
			{
				out.println("<form method=post name=frmchange>");
				sql="select * from ExamMaster where ExamID=" + examid;
				String exam="",conductedby="",country="",centre="",startdate="",enddate="";
				int exammode=0,frequency=0;
				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
					exam= rs.getString("Exam");
					exammode=rs.getInt("ExamMode");
					startdate=rs.getString("StartDate");
					enddate=rs.getString("EndDate");
					conductedby=rs.getString("ConductedBy");
					centre=rs.getString("Centre");
					country=rs.getString("Country");
					frequency=rs.getInt("Frequency");
				}

				int stdate=Integer.parseInt(startdate.substring(8,10));
				int stmonth=Integer.parseInt(startdate.substring(5,7));
				int styear=Integer.parseInt(startdate.substring(1,4));
				int eddate=Integer.parseInt(enddate.substring(8,10));
				int edmonth=Integer.parseInt(enddate.substring(5,7));
				int edyear=Integer.parseInt(enddate.substring(1,4));

				out.println("Exam Mater Record");
				out.println("<TABLE bgcolor='#FEEEC8'> ");
				out.println("<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Sr. No.</font></TD><TD><font color='#960317'>Exam Name </font></TD><TD><font color='#960317'>Exam Mode</font></TD><TD><font color='#960317'>Start Date</font></TD><TD><font color='#960317'>End Date</font></TD><TD><font color='#960317'>Conducted By</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD></TR>");
				int c=1;

				rs=stmt.executeQuery(sql);
				while(rs.next())
				{
					out.println("<TR bgcolor='#FFF5E7'><TD>"+c+"</TD> <TD><input type=text size=3 	value="+ exam + " name =examname></TD> <TD><select><option value=0>Random</option><option value=01>Sequencial</option></select> <TD><select name=dt><option value=1>1</option><option value=02>2</option><option value=03>3</option><option value=04>4</option><option value=05>5</option><option value=06>6</option><option value=07>7</option><option value=08>8</option><option value=09>9</option><option value=10>10</option><option value=11>11</option><option value=12>12</option><option value=13>13</option><option value=14>14</option><option value=15>15</option><option value=16>16</option><option value=17>17</option><option value=18>18</option><option value=19>19</option><option value=20>20</option><option value=21>21</option><option value=22>22</option><option value=23>23</option><option value=24>24</option><option value=25>25</option><option value=26>26</option><option value=27>27</option><option value=28>28</option><option value=29>29</option><option value=30>30</option><option value=31>31</option></select> <select name=mt><option value=01>Janurary</option><option value=02>Feburary</option><option value=03>March</option><option value=04>April</option><option value=05>May</option><option value=06>June</option><option value=07>July</option><option value=08>August</option><option value=09>September</option><option value=10>October</option><option value=11>November</option><option value=12>December</option></select> <select name=yr><option value=2000>2000</option><option value=2001>2001</option><option value=2002>2002</option><option value=2003>2003</option><option value=2004>2004</option><option value=2005>2005</option><option value=2006>2006</option><option value=2007>2007</option><option value=2008>2008</option><option value=2009>2009</option><option value=2010>2010</option></select><script language=javascript>document.frmchange.dt.selectedIndex="+(stdate-1)+";document.frmchange.mt.selectedIndex="+(stmonth-1)+";document.frmchange.yr.selectedIndex="+styear+"; </script> </TD> <TD><select name=eddt><option value=01>1</option><option value=02>2</option><option value=03>3</option><option value=04>4</option><option value=05>5</option><option value=06>6</option><option value=07>7</option><option value=08>8</option><option value=09>9</option><option value=10>10</option><option value=11>11</option><option value=12>12</option><option value=13>13</option><option value=14>14</option><option value=15>15</option><option value=16>16</option><option value=17>17</option><option value=18>18</option><option value=19>19</option><option value=20>20</option><option value=21>21</option><option value=22>22</option><option value=23>23</option><option value=24>24</option><option value=25>25</option><option value=26>26</option><option value=27>27</option><option value=28>28</option><option value=29>29</option><option value=30>30</option><option value=31>31</option></select> <select name=edmt><option value=01>Janurary</option><option value=02>Feburary</option><option value=03>March</option><option value=04>April</option><option value=05>May</option><option value=06>June</option><option value=07>July</option><option value=08>August</option><option value=09>September</option><option value=10>October</option><option value=11>November</option><option value=12>December</option></select> <select name=edyr><option value=2000>2000</option><option value=2001>2001</option><option value=2002>2002</option><option value=2003>2003</option><option value=2004>2004</option><option value=2005>2005</option><option value=2006>2006</option><option value=2007>2007</option><option value=2008>2008</option><option value=2009>2009</option><option value=2010>2010</option></select><script language=javascript>document.frmchange.eddt.selectedIndex="+(eddate-1)+";document.frmchange.edmt.selectedIndex="+(edmonth-1)+";document.frmchange.edyr.selectedIndex="+(edyear)+"; </script></TD> <TD><input type=text size=3 value="+ conductedby + " name=conductedby></TD> <TD><input type=text size=3 value="+ centre + " name=country></TD> <TD><input type=text size=3 value="+ country + " name=country></TD> <TD><input type=text size=3 value="+ frequency + " name=frequency></TD></TR>");
					++c;
				}
				out.println("</TABLE>");
				out.println("<br>Exam Details Record");
				sql="select * from ExamDetails where ExamID="+examid+"";
				rs=stmt.executeQuery(sql);

				String[] code=new String[records];
				String[] testname=new String [records];
				String[] prerequisite=new String[records];
				int[] noquest = new int[records];
				int[] isquesttimer = new int[records];
				int[] responsetime = new int[records];
				int[] nobreaks = new int[records];
				int[] breakinterval = new int[records];
				float[] criteria = new float[records];
				int[] examtime = new int[records];
				int[] sequenceid = new int[records];
				float[] nemarks = new float[records];
				int[] noattempts = new int[records];
				int[] levelid = new int[records];
				int[] includesublevels = new int[records];
				int i=0;
				while(rs.next())
				{
					code[i]=rs.getString("Code");
					code[i]=code[i].trim();
					testname[i]=rs.getString("TestName");
					noquest[i]=rs.getInt("NoOfQuestions");
					isquesttimer[i]=rs.getInt("isQuestionTimer");
					responsetime[i]=rs.getInt("ResponseTime");
					nobreaks[i]=rs.getInt("NoOfBreaksAllowed");
					breakinterval[i]=rs.getInt("BreakInterval");
					criteria[i]=rs.getFloat("Criteria");
					examtime[i]=rs.getInt("ExamTime");
					sequenceid[i]=rs.getInt("SequenceID");
					nemarks[i]=rs.getFloat("NegativeMarks");
					noattempts[i]=rs.getInt("NoOfAttemptsAllowed");
					prerequisite[i]=rs.getString("Prerequisite");
					levelid[i]=rs.getInt("LevelID");
					includesublevels[i]=rs.getInt("IncludeSubLevels");
					++i;
				}
				out.println("<TABLE width='100%' bgcolor='#FEEEC8'> ");
				out.println("<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Sr. No. </font></TD><TD><font color='#960317'>Code </font></TD><TD><font color='#960317'>Test Name</font></TD><TD><font color='#960317'>Number of Questions</font></TD><TD><font color='#960317'>Question Timer</font></TD><TD><font color='#960317'>Response Time</font></TD><TD><font color='#960317'>Number of Breaks Allowed</font></TD><TD><font color='#960317'>Break Interval</font></TD><TD><font color='#960317'>Criteria</font></TD><TD><font color='#960317'>Exam Time</font></TD><TD><font color='#960317'>Sequence Id</font></TD><TD><font color='#960317'>Negative Marks</font></TD><TD><font color='#960317'>Number Of Attempts Allowed</font></TD><TD><font color='#960317'>Prerequisite</font></TD><TD><font color='#960317'>Level Id</font></TD><TD><font color='#960317'>Include Sub Levels</font></TD></TR>");
				String pql="select * from LevelMaster";
				rs1=stmt1.executeQuery(pql);
				//while(rs1.next()){rs1.getString("Level");}
				for (int x=0,y=1; x<records;x++,y++)
				{
					out.println("<TR bgcolor='#FFF5E7' width='100%'><TD>"+y+"</TD><TD><input type=text size=4 value="+ code[x] + " name = code"+x+" ></td><TD><input type=text size=4 value="+ testname[x] + " name = testname"+x+"></td><TD><input type=text size=4 value="+ noquest[x] + " name = noquest"+x+"></td><TD><select name=isquesttimer"+x+"><option value=1>True</option><option value=0>False</option></select></TD><TD><input type=text size=4 value="+ responsetime[x] + " name = responsetime"+x+"></td><TD><input type=text size=4 value="+ nobreaks[x] + " name = nobreaks"+x+"></td><TD><input type=text size=4 value="+ breakinterval[x] + " name = breakinterval"+x+"></td><TD><input type=text size=4 value="+ criteria[x] + " name = criteria"+x+"></td><TD><input type=text size=4 value="+ examtime[x] + " name = examtime"+x+"></td><TD><input type=text size=4 value="+ sequenceid[x] + " name = sequenceid"+x+"></td><td><input type=text size=4 value="+ nemarks[x] + " name = nemarks"+x+"></td><td><input type=text size=4 value="+ noattempts[x] + " name = noattempts"+x+"></td><td><input type=text size=4 value="+ prerequisite[x] + " name = prerequisite"+x+"></td><td>");
					out.print("<select name = levelid"+x+">");
					rs1.beforeFirst();
					while(rs1.next())
					{
						String lvl=rs1.getString("Level");
						int lid = rs1.getInt("LevelID");
						out.print("<option value="+lid+">"+lvl+"</option>");
					  }
					  out.print("</select></td><td><select name=includesublevels"+x+"><option value=1>Yes</option><option value=0>No</option></select></td></tr>");
				}
				out.println("</TABLE>");
				int recount=code.length;
				out.println("<input type='button' value =Save onclick='checkEdit();'>");
				out.println("<input type='button' value =Cancel onclick='closes();'>");
				out.println("<input type=hidden name=action value='doSave'>");
				out.println("<input type=hidden name=records value="+records+">");
				out.println("<input type=hidden name=recount value="+recount+">");
				out.println("<INPUT TYPE=HIDDEN name=examid value="+examid+">");
				out.println("<INPUT TYPE=HIDDEN name=exammode value="+exammode+">");
				out.println("<INPUT TYPE=HIDDEN name=exammode value="+exam+">");
				out.println("<INPUT TYPE=HIDDEN name=stdate value="+stdate+">");
				out.println("<INPUT TYPE=HIDDEN name=styear value="+styear+">");
				out.println("<INPUT TYPE=HIDDEN name=stmonth value="+stmonth+">");
				out.println("<INPUT TYPE=HIDDEN name=eddate value="+eddate+">");
				out.println("<INPUT TYPE=HIDDEN name=edmonth value="+edmonth+">");
				out.println("<INPUT TYPE=HIDDEN name=edyear value="+edyear+">");
				out.println("<INPUT TYPE=HIDDEN name=conductedby value="+conductedby+">");
				out.println("<INPUT TYPE=HIDDEN name=centre value="+centre+">");
				out.println("<INPUT TYPE=HIDDEN name=country value="+country+">");
				out.println("<INPUT TYPE=HIDDEN name=frequency value="+frequency+">");

				out.println("</form>");

				out.println("<form method=post >");
				String done="yes";
				out.println("<input type=submit value='Insert more Records'>");
				out.println("<INPUT TYPE=HIDDEN name=examid value="+examid+">");
				out.println("<INPUT TYPE=HIDDEN name=exammode value="+exammode+">");
				out.println("<INPUT TYPE=HIDDEN name=exammode value="+exam+">");
				out.println("<INPUT TYPE=HIDDEN name=stdate value="+stdate+">");
				out.println("<INPUT TYPE=HIDDEN name=styear value="+styear+">");
				out.println("<INPUT TYPE=HIDDEN name=stmonth value="+stmonth+">");
				out.println("<INPUT TYPE=HIDDEN name=eddate value="+eddate+">");
				out.println("<INPUT TYPE=HIDDEN name=edmonth value="+edmonth+">");
				out.println("<INPUT TYPE=HIDDEN name=edyear value="+edyear+">");
				out.println("<INPUT TYPE=HIDDEN name=conductedby value="+conductedby+">");
				out.println("<INPUT TYPE=HIDDEN name=centre value="+centre+">");
				out.println("<INPUT TYPE=HIDDEN name=country value="+country+">");
				out.println("<INPUT TYPE=HIDDEN name=frequency value="+frequency+">");
				out.println("<INPUT TYPE=HIDDEN name=done value="+done+">");
				out.println("<INPUT TYPE=HIDDEN name=action value='doInsert'>");
				out.println("</form>");

				out.println("<form name=frmdeldetails method=post>");
				out.println("Enter code to be deleted : ");
				out.println("<INPUT TYPE=HIDDEN name=action value='doDelDetails' >");
				out.println("<input type=text name=code>");
				out.println("<input type='button' value=Delete onclick='deletes1();'>");
				out.println("</form>");
				out.println("</form>");
				out.println("<form method=post action='MainForm.jsp'>");
				out.println("<input type=submit value='Home'>");
				out.println("</form>");

			}

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
// doSave
	else if(action.equals("doSave"))
	{
		out.println("<center><h4>Record Saved </h4><hr></center>");
		int recount = Integer.parseInt(request.getParameter("recount"));
		int examid=Integer.parseInt(request.getParameter("examid"));
		String examname=request.getParameter("examname");
		int exammode=Integer.parseInt(request.getParameter("exammode"));
		String stdate=request.getParameter("dt");
		String stmonth=request.getParameter("mt");
		String styear=request.getParameter("yr");
		String startdate=styear+"-"+stmonth+"-"+stdate;
		String eddate=request.getParameter("eddt");
		String edmonth=request.getParameter("edmt");
		String edyear=request.getParameter("edyr");
		String enddate = edyear+"-"+edmonth+"-"+eddate;
		String conductedby=request.getParameter("conductedby");
		String centre=request.getParameter("centre");
		String country=request.getParameter("country");
		int frequency=Integer.parseInt(request.getParameter("frequency"));

		try
		{
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String sql = "update ExamMaster set Exam='" + examname + "',ExamMode="+ exammode+ ",StartDate='"+ startdate + "',EndDate='"+ enddate+ "',ConductedBy='"+conductedby +"',Centre='"+ centre + "',Country='"+country + "',Frequency="+frequency +" where ExamID="+ examid;
			int record = stmt.executeUpdate(sql);

			for(int counts=0;counts<recount;counts++)
			{

				String code= request.getParameter("code"+counts);
				String testname = request.getParameter("testname"+counts);
				int noquest = Integer.parseInt(request.getParameter("noquest"+counts+""));
				int isquesttimer = Integer.parseInt(request.getParameter("isquesttimer"+counts+""));
				int responsetime = Integer.parseInt(request.getParameter("responsetime"+counts+""));
				int nobreaks = Integer.parseInt(request.getParameter("nobreaks"+counts+""));
				int breakinterval = Integer.parseInt(request.getParameter("breakinterval"+counts+""));
				Float cri = new Float(request.getParameter("criteria"+count+""));
				float criteria = cri.floatValue();
				int examtime = Integer.parseInt(request.getParameter("examtime"+counts+""));
				int sequenceid = Integer.parseInt(request.getParameter("sequenceid"+counts+""));
				Float abc = new Float(request.getParameter("nemarks"+counts+""));
				float nemarks = abc.floatValue();
				int noattempts = Integer.parseInt(request.getParameter("noattempts"+counts+""));
				String prerequisite = request.getParameter("prerequisite"+counts+"");
				int levelid = Integer.parseInt(request.getParameter("levelid"+counts+""));
				int includesublevels = Integer.parseInt(request.getParameter("includesublevels"+counts));


				 sql="update ExamDetails set TestName='" + testname + "',NoOfQuestions="+ noquest + ",isQuestionTimer=" + isquesttimer+ ",ResponseTime=" + responsetime + ",NoOfBreaksAllowed="+nobreaks + ",BreakInterval=" + breakinterval +",Criteria=" + criteria + ",ExamTime=" + examtime + ",SequenceID="+ sequenceid + ",NegativeMarks="+ nemarks + ",NoOfAttemptsAllowed=" + noattempts + ",Prerequisite='" + prerequisite + "',LevelId=" + levelid + ",IncludeSubLevels=" + includesublevels + " where ExamID=" + examid + " and Code='" + code+ "'";
				int record1 = stmt.executeUpdate(sql);

			}
			out.println("<br>Exam Master");
			sql = "SELECT * FROM ExamMaster where ExamID = " + examid;
			rs=stmt.executeQuery(sql);
			out.println("<TABLE width='100%' border=1 bgcolor='#FEEEC8'> ");
			out.println("<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </font></TD><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD></TR>");

			while(rs.next())
			{
				out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD></TR>");
			}
			out.println("</TABLE>");

			out.println("<br> Exam Details");
			sql="select * from ExamDetails where ExamID =" + examid ;
			rs= stmt.executeQuery(sql);

			out.println("<TABLE border=1 width='100%' bgcolor='#FEEEC8'>");
			out.println("<tr bgcolor='#FEEEC8'><td><font color='#960317'>Exam Id</font></td><td><font color='#960317'>Code</font></td><td><font color='#960317'>Test Name</font></td><td><font color='#960317'>Number of Questions</font></td><td><font color='#960317'>Question Timer</font></td><td><font color='#960317'>Response Time</font></td><td><font color='#960317'>Number of Breaks Allowed</font></td><td><font color='#960317'>Break Interval</font></td><td><font color='#960317'>Criteria</font></td><td><font color='#960317'>Exam Time</font></td><td><font color='#960317'>Sequence Id</font></td><td><font color='#960317'>Negative Marks</font></td><td><font color='#960317'>Number of Attempts Allowed</font></td><td><font color='#960317'>Prerequisite</font></td><td><font color='#960317'>Level ID</font></td></td><td><font color='#960317'>Include Sub Levels</font></td></tr>");
			while (rs.next())
			{
				out.println("<tr bgcolor='#FFF5E7'><td>"+rs.getInt("ExamID") +"</td><td>"+rs.getString("Code") +"</td><td>"+rs.getString("TestName") +"</td><td>"+rs.getInt("NoOfQuestions") +"</td><td>"+rs.getInt("isQuestionTimer") +"</td><td>"+rs.getInt("ResponseTime") +"</td><td>"+rs.getInt("NoOfBreaksAllowed") +"</td><td>"+rs.getInt("BreakInterval") +"</td><td>"+rs.getFloat("Criteria") +"</td><td>"+rs.getInt("ExamTime") +"</td><td>"+rs.getInt("SequenceID") +"</td><td>"+rs.getFloat("NegativeMarks") +"</td><td>"+rs.getInt("NoOfAttemptsAllowed") +"</td><td>"+rs.getString("Prerequisite") +"</td><td>"+rs.getInt("LevelID") +"</td><td>"+rs.getInt("IncludeSubLevels") +"</td></tr>");
			}
			out.println("</table>");
				out.println("<form method=post action='MainForm.jsp'>");
			out.println("<input type=submit value='Home'>");
			out.println("</form>");

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
//doDelete
	else if(action.equals("doDelete"))
	{
		out.println("<center><h4>Delete Record </h4><hr></center>");
		try
		{
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			out.println("<center>");
			out.println("<form method=post name=frmdelmaster> ");
			out.println("<br> Enter Exam Id : ");
			out.println("<form method=post>");
			out.println("<input type=text name=examid >");
			out.println("<INPUT TYPE=HIDDEN name=action value='doDelMaster' >");
			out.println("<input type='button' value=Delete onclick='deletes(examid);'>");
			out.println("<input type='button' value =Cancel onclick='closes();'>");
			out.println("</form>");

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
// doDelMaster
	else if(action.equals("doDelMaster"))
	{
		try
		{
			conn = pool.getConnection();
			Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			int examid=Integer.parseInt(request.getParameter("examid"));
			String sql="select ExamID from ExamMaster where ExamId =" +examid;
			rs= stmt.executeQuery(sql);
			out.println("<h4> Delete Recor for ExamId : " + examid + "<hr size=1>");
			if(!rs.next())
				out.println("<h4>No matching record found !!");
			else
			{
	//Check here
				sql="delete from ExamMaster where ExamID=" + examid;
				int norecmaster = stmt.executeUpdate(sql);
				sql = "delete from ExamDetails where ExamID=" + examid;
				int norecdetails = stmt.executeUpdate(sql);
				out.println("Record Sucessufully Deleted in  ExamMaster : " + norecmaster);
				out.println("<br>Record Sucessufully Deleted in  ExamDetails : " + norecdetails);
			}
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
//doDelDetails
	else if(action.equals("doDelDetails"))
	{
		try
		{
			conn = pool.getConnection();Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			String code=request.getParameter("code");
			String sql = "select * from ExamDetails where Code='" + code +"'";
			rs=stmt.executeQuery(sql);
			if (rs.next())
			{
				sql="delete from ExamDetails where Code='" + code+"'";
				int norec = stmt.executeUpdate(sql);
				out.println("Number of Records Deleted from ExamDetails : " + norec);
			}
			else
			{
				out.println("<h4>No matching Record Found !!</h4>");
			}
			out.println("<form>");

		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}
	else if(action.equals("doView"))
	{
		out.println("<center><h4>View Exam Master </h4><hr>");
		try
		{
			conn = pool.getConnection();Statement stmt = null;
			ResultSet rs = null;
			stmt = conn.createStatement();
			out.println("<br>Exam Master");
			String sql = "SELECT * FROM ExamMaster order by ExamId";
			rs=stmt.executeQuery(sql);
			out.println("<TABLE width='100%' border=0 bgcolor='#FEEEC8'> ");
			out.println("<TR bgcolor='#FEEEC8'><TD><font color='#960317'>Exam ID</font></TD><TD><font color='#960317'>Exam </font></TD><TD><font color='#960317'>ExamMode</font></TD><TD><font color='#960317'>StartDate</font></TD><TD><font color='#960317'>EndDate</font></TD><TD><font color='#960317'>ConductedBy</font></TD><TD><font color='#960317'>Centre</font></TD><TD><font color='#960317'>Country</font></TD><TD><font color='#960317'>Frequency</font></TD></TR>");

			while(rs.next())
			{
				out.println("<TR bgcolor='#FFF5E7'><TD>"+ rs.getInt("ExamID")+"</TD><TD>"+ rs.getString("Exam") + "</TD><TD>" + rs.getInt("ExamMode")+"</TD><TD>"+ rs.getString("StartDate")+"</TD><TD>"+ rs.getString("EndDate")+"</TD><TD>"+ rs.getString("ConductedBy")+"</TD><TD>"+ rs.getString("Centre")+"</TD><TD>"+ rs.getString("Country")+"</TD><TD>"+ rs.getInt("Frequency")+"</TD></TR>");
			}
			out.println("</TABLE>");

			out.println("<br> Exam Details");
			sql="select * from ExamDetails order by ExamID";
			rs= stmt.executeQuery(sql);

			out.println("<TABLE border=0 width='100%' bgcolor='#FEEEC8'>");
			out.println("<tr bgcolor='#FEEEC8'><td><font color='#960317'>Exam Id</font></td><td><font color='#960317'>Code</font></td><td><font color='#960317'>Test Name</font></td><td><font color='#960317'>Number of Questions</font></td><td><font color='#960317'>Question Timer</font></td><td><font color='#960317'>Response Time</font></td><td><font color='#960317'>Number of Breaks Allowed</font></td><td><font color='#960317'>Break Interval</font></td><td><font color='#960317'>Criteria</font></td><td><font color='#960317'>Exam Time</font></td><td><font color='#960317'>Sequence Id</font></td><td><font color='#960317'>Negative Marks</font></td><td><font color='#960317'>Number of Attempts Allowed</font></td><td><font color='#960317'>Prerequisite</font></td><td><font color='#960317'>Level ID</font></td></td><td><font color='#960317'>Include Sub Levels</font></td></tr>");
			while (rs.next())
			{
				out.println("<tr bgcolor='#FFF5E7'><td>"+rs.getInt("ExamID") +"</td><td>"+rs.getString("Code") +"</td><td>"+rs.getString("TestName") +"</td><td>"+rs.getInt("NoOfQuestions") +"</td><td>"+rs.getInt("isQuestionTimer") +"</td><td>"+rs.getInt("ResponseTime") +"</td><td>"+rs.getInt("NoOfBreaksAllowed") +"</td><td>"+rs.getInt("BreakInterval") +"</td><td>"+rs.getFloat("Criteria") +"</td><td>"+rs.getInt("ExamTime") +"</td><td>"+rs.getInt("SequenceID") +"</td><td>"+rs.getFloat("NegativeMarks") +"</td><td>"+rs.getInt("NoOfAttemptsAllowed") +"</td><td>"+rs.getString("Prerequisite") +"</td><td>"+rs.getInt("LevelID") +"</td><td>"+rs.getInt("IncludeSubLevels") +"</td></tr>");
			}
			out.println("</table>");
		}
		catch(Exception e)
		{
			out.println("Error : " + e.getMessage());
		}
	}

%>
</BODY>
</TITLE>
