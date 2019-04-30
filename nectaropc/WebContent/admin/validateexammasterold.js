function checkMasterModify()
{
	if(! notNull(self.document.frmmastermodify.examname,"Exam Name cannot be empty !!"))
	{
		return false;
	}
	if (self.document.frmmastermodify.examname.value.length>50)
	{
		alert("Exam Name cannot be more than 50 characters !!");
		self.document.frmmastermodify.examname.focus();
		return false;
	}
	startdate=self.document.frmmastermodify.stdate.options[self.document.frmmastermodify.stdate.selectedIndex].value+self.document.frmmastermodify.stmonth.options[self.document.frmmastermodify.stmonth.selectedIndex].value+self.document.frmmastermodify.styear.options[self.document.frmmastermodify.styear.selectedIndex].value;

	if ( !checkDate(startdate) ) 
	{
		self.document.frmmastermodify.stmonth.focus();
		return false; 
	}

	enddate=self.document.frmmastermodify.eddate.options[self.document.frmmastermodify.eddate.selectedIndex].value+self.document.frmmastermodify.edmonth.options[self.document.frmmastermodify.edmonth.selectedIndex].value+self.document.frmmastermodify.edyear.options[self.document.frmmastermodify.edyear.selectedIndex].value;


	if ( !checkDate(enddate) ) {
			self.document.frmmastermodify.edmonth.focus();
			return false; 
		}

	if (startdate==enddate)
	{
		alert("Exam Start Date and End Date cannot be same !! ");
		return false;
	}
/*	alert(self.document.frmmaster.styear.value +" " +self.document.frmmaster.edyear.value)
	if (self.document.frmmaster.styear.value > self.document.frmmaster.edyear.value)
	{
		alert("End Year cannot be before Start Year !! ");
		return false;
	}
	alert(self.document.frmmaster.stmonth.value +" " +self.document.frmmaster.edmonth.value)
	if (self.document.frmmaster.stmonth.value < self.document.frmmaster.edmonth.value)
	{
		alert("End month cannot be before Start month !! ");
		return false;
	}
	alert(self.document.frmmaster.stdate.value +" " +self.document.frmmaster.eddate.value)
	if (self.document.frmmaster.stdate.value > self.document.frmmaster.eddate.value)
	{
		alert("End date cannot be before Start Date !! ");
		return false;
	}*/
	
	if(! notNull(self.document.frmmastermodify.conductedby,"Conducted By cannot be empty !!"))
	{
		return false;
	}
	if (self.document.frmmastermodify.conductedby.value.length>250)
	{
		alert("Conducted by Field cannot be more than 250 characters !!");
		self.document.frmmastermodify.conducted.focus();
		return false;
	}

	if(! notNull(self.document.frmmastermodify.centre,"Center cannot be empty"))
	{
		return false;
	}
	if (self.document.frmmastermodify.centre.value.length>250)
	{
		alert("Centre Field cannot be more than 250 characters !!");
		self.document.frmmastermodify.centre.focus();
		return false;
	}
	
	if(! notNull(self.document.frmmastermodify.country,"Country cannot be empty"))
	{
		return false;
	}
	if (self.document.frmmastermodify.country.value.length>25)
	{
		alert("Country Field cannot be more than 25 characters !!");
		self.document.frmmastermodify.country.focus();
		return false;
	}

	if(! notNull(self.document.frmmastermodify.frequency,"Frequency cannot be empty"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmmastermodify.frequency,"Frequency is a Numeric Field"))
	{
		return false;
	}
	if (self.document.frmmastermodify.frequency.value.length>1)
	{
		alert("Frequency cannot be more than 9 per Year !!");
		self.document.frmmaster.frequency.value="";
		self.document.frmmaster.frequency.focus();
		return false;
	}
	if(self.document.frmmastermodify.frequency.value==0)
	{ 
		alert("Frequency cannot be 0 but atleast 1 !!");
		return false;
	}
	return true;
}
function checkModifyDetails()
{
	if(! notNull(self.document.frmmoddet.testname,"Exam Name cannot be empty !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.testname.value.length>25)
	{
		alert("Exam Name cannot be more than 25 characters !!");
		self.document.frmmoddet.testname.focus();
		return false;
	}
	if(! notNull(self.document.frmmoddet.noquest,"# of Questions cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.noquest,"# of Questions is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.noquest.value.length>3)
	{
		alert("# of Questions cannot be more than 999 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmmoddet.noquest.focus();
		return false;
	}
	if(! notNull(self.document.frmmoddet.responsetime,"Response Time per Question cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.responsetime,"Response Time per Question is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.responsetime.value.length>3)
	{
		alert("# of Questions cannot be more than 999 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmmoddet.responsetime.focus();
		return false;
	}
	if(! notNull(self.document.frmmoddet.nobreaksallowed,"# of Breaks Allowed  cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.nobreaksallowed,"# of Breaks Allowed is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.nobreaksallowed.value.length>3)
	{
		alert("# of Breaks Allowed cannot be more than 999 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.nobreaksallowed.focus();
		return false;
	}
	if(! notNull(self.document.frmmoddet.breakinterval,"Break Interval cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.breakinterval,"Break Interval is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.breakinterval.value.length>4)
	{
		alert("Break Interval cannot be more than 9999 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmmoddet.breakinterval.focus();
		return false;
	}
	if(! notNull(self.document.frmmoddet.criteria,"Passing Percentage cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.criteria,"Passing Percentage is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.criteria.value>99.99)
	{
		alert("Passing Percentage cannot be more than 99.99 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmmoddet.criteria.focus();
		return false;
	}
	if(! notNull(self.document.frmmoddet.hours,"hours cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.hours,"hours is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.hours.value>100)
	{
		alert("hours cannot be more than 100 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmmoddet.hours.focus();
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.minutes,"Minute is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.minutes.value>60)
	{
		alert("Minute cannot be more than 60 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.minutes.focus();
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.minutes,"Minute is a Numeric Field !!"))
	{
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.seconds,"Seconds is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.seconds.value>60)
	{
		alert("Minute cannot be more than 60 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.seconds.focus();
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.nemarks,"Negative Marks is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.nemarks.value>999.99)
	{
		alert("Negative Marks cannot be more than 999.99 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmmoddet.nemarks.focus();
		return false;
	}
	if(!checkNumeric(self.document.frmmoddet.noattempts,"# of Attempts Allowed is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmmoddet.noattempts.value>999)
	{
		alert("# of Attempts Allowed cannot be more than 999 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmmoddet.noattempts.focus();
		return false;
	}
	document.frmmoddet.submit();
}
/*function ResetForm() 
{ 
 document.frmdetinsert.reset(); 
 return false; 
}*/
function ResetForm(formname) 
{ 
	var a=eval("document."+formname);
	 a.reset(); 
	 return false; 
}

function checkTotSection()
{
	if(! notNull(self.document.frmCount.sectioncount,"Number of Sections cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmCount.sectioncount,"Number of Sections is a Numeric Field !!"))
	{
		return false;
	}
	if(self.document.frmCount.sectioncount.value<1)
	{
		alert("Number of Sections should be atleast 1 !!");
		self.document.frmCount.sectioncount.value="";
		self.document.frmCount.sectioncount.focus();
		return false;
	}
	if(self.document.frmCount.sectioncount.value>5)
	{
		alert("Number of Sections cannot be more than 5 !!");
		self.document.frmCount.sectioncount.value="";
		self.document.frmCount.sectioncount.focus();
		return false;
	}
	if(! notNull(self.document.frmCount.tname,"Exam Name cannot be empty !!"))
	{
		return false;
	}
	if (self.document.frmCount.tname.value.length>25)
	{
		alert("Exam Name cannot be more than 25 characters !!");
		self.document.frmCount.tname.focus();
		return false;
	}
}

function checkdetailsinsert()
{
//	alert("checklatter");
	if(self.document.frmdetinsert.codegroupid.selectedIndex==-1)
	{
		alert("Select atleast one Defined Subject !!");
		self.document.frmdetinsert.codegroupid.focus();
		return false;
	}
	
	if(! notNull(self.document.frmdetinsert.testname,"Test Name cannot be empty !!"))
	{
		return false;
	}
	if (self.document.frmdetinsert.testname.value.length>25)
	{
		alert("Test Name cannot be more than 25 characters !!");
		self.document.frmdetinsert.testname.focus();
		return false;
	}
	if(! notNull(self.document.frmdetinsert.noquest,"# of Questions cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.noquest,"# of Questions is a Numeric Field !!"))
	{
		return false;
	}
	if(self.document.frmdetinsert.noquest.value<5)
	{
		alert("No of Questions should be atleast 5 !!");
		self.document.frmdetinsert.noquest.focus();
		return false;
	}
	if(self.document.frmdetinsert.noquest.value>500)
	{
		alert("No of Questions cannot be more than 500 !!");
		self.document.frmdetinsert.noquest.focus();
		return false;
	}	
	if(!checkNumeric(self.document.frmdetinsert.responsetime,"Response Time per Question is a Numeric Field !!"))
	{
		return false;
	}
	
	if(self.document.frmdetinsert.isquesttimer.value==1)
	{
		if(! notNull(self.document.frmdetinsert.responsetime,"Response Time per Question cannot be empty !!"))
		{ 
			return false;
		}
		if(self.document.frmdetinsert.responsetime.value==0)
		{
			alert("Response Time per Question cannot be 0 if question timer Question is yes !!");
			self.document.frmdetinsert.responsetime.focus();
			return false;
		}
		if(self.document.frmdetinsert.responsetime.value>600)
		{
			alert("Response Time per Question cannot be more than 600 per seconds !!");
			self.document.frmdetinsert.responsetime.focus();
			return false;
		}
	}
	else
	{
		if(self.document.frmdetinsert.responsetime.value>600)
		{
			alert("Response Time per Question cannot be more than 600 per seconds !!");
			self.document.frmdetinsert.responsetime.focus();
			return false;
		}
	}

		if(! notNull(self.document.frmdetinsert.hours,"hours cannot be empty but can be 0 !!"))
		{ 
			return false;
		}


		if(!checkNumeric(self.document.frmdetinsert.hours,"hours is a Numeric Field !!"))
		{
			return false;
		}
		if (self.document.frmdetinsert.hours.value>10)
		{
			alert("hours cannot be more than 10 !!");
		//	self.document.frmdetinsert.noquest.value="";
			self.document.frmdetinsert.hours.focus();
			return false;
		}
		if(!checkNumeric(self.document.frmdetinsert.min,"Minute is a Numeric Field !!"))
		{	
			return false;
		}
		if(! notNull(self.document.frmdetinsert.min,"Minutes cannot be empty but can be 0 !!"))
		{ 
			return false;
		}
		if(self.document.frmdetinsert.hours.value==0 && self.document.frmdetinsert.min.value==0)
		{
			alert("Hours and Minutes cannot be 0 !!");
			self.document.frmdetinsert.hours.focus();
			return false;
		}
		if (self.document.frmdetinsert.min.value>60)
		{
			alert("Minute cannot be more than 60 !!");
	//	self.document.frmdetinsert.noquest.value="";
			self.document.frmdetinsert.min.focus();
			return false;
		}
		
	if(! notNull(self.document.frmdetinsert.nobreaksallowed,"# of Breaks Allowed  cannot be empty but can be 0!!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.nobreaksallowed,"# of Breaks Allowed is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmdetinsert.nobreaksallowed.value>10)
	{
		alert("# of Breaks Allowed cannot be more than 10 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.nobreaksallowed.focus();
		return false;
	}
	if(! notNull(self.document.frmdetinsert.breakinterval,"Break Interval cannot be empty but van be 0 !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.breakinterval,"Break Interval is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmdetinsert.breakinterval.value>15)
	{
		alert("Break Interval cannot be more than 15 minutes !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.breakinterval.focus();
		return false;
	}
	if (self.document.frmdetinsert.criteria.value<10)
	{
		alert("Passing Percentage cannot be less than 10 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.criteria.focus();
		return false;
	}
	if (self.document.frmdetinsert.criteria.value>99.99)
	{
		alert("Passing Percentage cannot be more than 99.99 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.criteria.focus();
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.criteria,"Passsing Percentage(%) is a Numeric Field !!"))
	{
		return false;
	}
	if(! notNull(self.document.frmdetinsert.criteria,"Passing Percentage(%) cannot be empty !!"))
	{ 
		return false;
	}
	if(! notNull(self.document.frmdetinsert.hours,"hours cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.hours,"hours is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmdetinsert.hours.value>5)
	{
		alert("hours cannot be more than 5 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.hours.focus();
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.min,"Minute is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmdetinsert.min.value>60)
	{
		alert("Minute cannot be more than 60 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.min.focus();
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.min,"Minute is a Numeric Field !!"))
	{
		return false;
	}
	if(! notNull(self.document.frmdetinsert.nemarks,"Negative Marks cannot be empty but can be 0 !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.nemarks,"Negative Marks is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmdetinsert.nemarks.value>999.99)
	{
		alert("Negative Marks cannot be more than 999.99 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.nemarks.focus();
		return false;
	}
	
	
	
	if(!checkNumeric(self.document.frmdetinsert.noattempts,"# of Attempts Allowed is a Numeric Field !!"))
	{
		return false;
	}
	if(! notNull(self.document.frmdetinsert.noattempts,"# of Attempts Allowed cannot be empty but canbe atleast 1 !!"))
	{ 
		return false;
	}
	if(self.document.frmdetinsert.noattempts.value==0)
	{ 
		alert("# of Attempts Allowed cannot be empty be 0 but atleast 1!!");
		return false;
	}
	if (self.document.frmdetinsert.noattempts.value>999)
	{
		alert("# of Attempts Allowed cannot be more than 999 !!");
		self.document.frmdetinsert.noattempts.value="";
		self.document.frmdetinsert.noattemptsallowed.focus();
		return false;
	}
/*	if (self.document.frmdetinsert.noquest.value.length>3)
	{
		alert("# of Questions cannot be more than 999 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.noquest.focus();
		return false;
	}
	if(! notNull(self.document.frmdetinsert.responsetime,"Response Time per Question cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.responsetime,"Response Time per Question is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmdetinsert.responsetime.value.length>3)
	{
		alert("# of Questions cannot be more than 999 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.responsetime.focus();
		return false;
	}
	
	
	if(! notNull(self.document.frmdetinsert.criteria,"Passing Percentage cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.criteria,"Passing Percentage is a Numeric Field !!"))
	{
		return false;
	}
	
	
	if(! notNull(self.document.frmdetinsert.sequenceid,"sequenceid cannot be empty !!"))
	{ 
		return false;
	}
	if(!checkNumeric(self.document.frmdetinsert.sequenceid,"sequenceid is a Numeric Field !!"))
	{
		return false;
	}
	if (self.document.frmdetinsert.sequenceid.value>100)
	{
		alert("sequenceid cannot be more than 100 !!");
	//	self.document.frmdetinsert.noquest.value="";
		self.document.frmdetinsert.sequenceid.focus();
		return false;
	}
	
	
*/
}
function checkNumber()
{
	if(! notNull(self.document.frmmaster.examname,"Exam Name cannot be empty !!"))
	{
		return false;
	}
	if (self.document.frmmaster.examname.value.length>50)
	{
		alert("Exam Name cannot be more than 50 characters !!");
		self.document.frmmaster.examname.focus();
		return false;
	}
		
	startdate=self.document.frmmaster.stdate.options[self.document.frmmaster.stdate.selectedIndex].value+self.document.frmmaster.stmonth.options[self.document.frmmaster.stmonth.selectedIndex].value+self.document.frmmaster.styear.options[self.document.frmmaster.styear.selectedIndex].value;
//alert("startdt"+startdate);

	if ( !checkDate(startdate) ) 
	{
		self.document.frmmaster.stmonth.focus();
		return false; 
	}

	enddate=self.document.frmmaster.eddate.options[self.document.frmmaster.eddate.selectedIndex].value+self.document.frmmaster.edmonth.options[self.document.frmmaster.edmonth.selectedIndex].value+self.document.frmmaster.edyear.options[self.document.frmmaster.edyear.selectedIndex].value;

//	alert("enddt"+enddate);

	if ( !checkDate(enddate) ) {
			self.document.frmmaster.edmonth.focus();
			return false; 
		}
	if (startdate==enddate)
	{
		alert("Exam Start Date and End Date cannot be same !! ");
		return false;
	}
/*	alert(self.document.frmmaster.styear.value +" " +self.document.frmmaster.edyear.value)
	if (self.document.frmmaster.styear.value > self.document.frmmaster.edyear.value)
	{
		alert("End Year cannot be before Start Year !! ");
		return false;
	}
	alert(self.document.frmmaster.stmonth.value +" " +self.document.frmmaster.edmonth.value)
	if (self.document.frmmaster.stmonth.value < self.document.frmmaster.edmonth.value)
	{
		alert("End month cannot be before Start month !! ");
		return false;
	}
	alert(self.document.frmmaster.stdate.value +" " +self.document.frmmaster.eddate.value)
	if (self.document.frmmaster.stdate.value > self.document.frmmaster.eddate.value)
	{
		alert("End date cannot be before Start Date !! ");
		return false;
	}*/
	
	if(! notNull(self.document.frmmaster.conductedby,"Conducted By cannot be empty !!"))
	{
		return false;
	}
	if (self.document.frmmaster.conductedby.value.length>250)
	{
		alert("Conducted by Field cannot be more than 250 characters !!");
		self.document.frmmaster.conducted.focus();
		return false;
	}

	if(! notNull(self.document.frmmaster.centre,"Center cannot be empty"))
	{
		return false;
	}
	if (self.document.frmmaster.centre.value.length>250)
	{
		alert("Centre Field cannot be more than 250 characters !!");
		self.document.frmmaster.centre.focus();
		return false;
	}
	
	if(! notNull(self.document.frmmaster.country,"Country cannot be empty !!"))
	{
		return false;
	}
	if (self.document.frmmaster.country.value.length>25)
	{
		alert("Country Field cannot be more than 25 characters !!");
		self.document.frmmaster.country.focus();
		return false;
	}

	if(! notNull(self.document.frmmaster.frequency,"Frequency cannot be empty !!"))
	{ 
		return false;
	}
	if(self.document.frmmaster.frequency.value==0)
	{ 
		alert("Frequency cannot be 0 but atleast 1 !!");
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
//alert(str_val);
	month_val=str_val.substr(2,2);
//alert("month "+month_val);
	day_val=str_val.substring(0,2);
//alert("day "+day_val);
	year_val=str_val.substring(4,4);
//alert("year "+ year_val);

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
function isnulls(name)
{	
	if (eval(name).value=="")
	{
		return false;
	}
	else
		return true;
}
function previous()
{
	history.back();
	return false;
}