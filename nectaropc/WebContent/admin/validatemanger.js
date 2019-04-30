function checkEmpty(field,message) {
	if ( field.value == "" ) {
		alert(message);
		field.focus();
		return false;
	}
	return true;
}


function checkInvalidChars(field,message) {
	var s = field.value;
	if(s.length == 0)
       	return false ;
	for( i = 0; i < s.length; i++ )	{
		if( !((s.charAt(i) >= 'a' && s.charAt(i) <= 'z') || (s.charAt(i) >= 'A' && s.charAt(i) <= 'Z') || ( s.charAt(i) == " " ))  )   {
			field.focus();
			alert(message); 
			return false ; }
	}
	return true ;
}


function checkEmail( field ) 
{   
	emailStr=field.value;
	var emailPat=/^(.+)@(.+)$/
	var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]"
	var validChars="\[^\\s" + specialChars + "\]"

	var quotedUser="(\"[^\"]*\")"
	var ipDomainPat=/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/

	var atom=validChars + '+'
	var word="(" + atom + "|" + quotedUser + ")"
	var userPat=new RegExp("^" + word + "(\\." + word + ")*$")
	var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$")
	var matchArray=emailStr.match(emailPat)
	if (matchArray==null) 
	{
		alert("Email address seems incorrect (check @ and .'s)")
		return false
	}
	var user=matchArray[1]
	var domain=matchArray[2]

	if (user.match(userPat)==null) 
	{
		alert("The username doesn't seem to be valid.")
		return false
	}

	var IPArray=domain.match(ipDomainPat)
	if (IPArray!=null) 
	{
		for (var i=1;i<=4;i++) 
		{
			if (IPArray[i]>255) 
			{
				alert("Destination IP address is invalid!")
				return false
	    		}
    		}
	}
	return true
}

function checkZip(field) {
	for(i=0; i<field.value.length; i++)	{
		if((field.value.charAt(i) <'0')  || (field.value.charAt(i) >'9') ) {	
			alert("Enter valid ZIP Code");
			field.focus();
			return false;
		}
	}
	return true;
}

function checkDate(str_val){
	month_val=str_val.substr(3,2);
	day_val=str_val.substr(0,2);
	year_val=str_val.substr(6,4);
	mondays=new Array('0','31','28','31','30','31','30','31','31','30','31','30','31');
	if ( year_val%4 == 0  && (year_val %100 != 0  || year_val % 400 == 0) )
		mondays[2]='29';
	if ( str_val.length < 10 ) {
		alert("Invalid Date format");
		return false; }
	if(month_val < 1 || month_val > 12) {
		alert("Invalid Date format");
		return false; }
	if(day_val < 1 || day_val >31) {
		alert("Invalid Date format");
		return false;  }
	if( day_val > mondays[eval(month_val)] ) {
		alert("No. of days exceeds from No. of days allowed in Month");
		return false;  	 }
	return true;
}


function checkLogin(field) {
      var s = field.value;
      for( i = 0; i < s.length; i++ ) {
            if( !((s.charAt(i) >= 'a' && s.charAt(i) <= 'z') || (s.charAt(i) >= 'A' && s.charAt(i) <= 'Z') || (s.charAt(i) >= '0' && s.charAt(i) <= '9') || (s.charAt(i) == '#' || s.charAt(i) == '_') )) 	{
                   return false ;
				break;
            }
      }
      return true ;
}

function checkNumeric(field)
{
	var strString = field.value;
	var strValidChars = "0123456789.-";
	var strChar;
	var blnResult = true;

	for (i = 0; i < strString.length && blnResult == true; i++)
	{
		strChar = strString.charAt(i);
		if (strValidChars.indexOf(strChar) == -1)
		{
			blnResult = false;
		}
	}
	return blnResult;
}

