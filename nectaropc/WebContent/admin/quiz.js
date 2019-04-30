var ansvar="";
var r ="";
var tf=0;
var timeup=0;
var timeleft=0;
var tcount=0;
var temp=0;
var totalQuestion=0;
var totalOption=4;
var quizstarted=false;
var currentQuestion=1;
var startQuestion=1;
var totaltime=100;
var exammode=1;
answerArray = new Array();

function displayOption() {
	with (top.temp3.document ) {
		write('<html><style>td.but{background-color:#FEF9E2}</style><body bgcolor="#ffffff" topmargin=0 rightmargin=0><form name=ans2 action=verifier2.jsp method=get target="_top"><input type=hidden name=timetaken>');
		for ( i=1 ; i < startQuestion ; i++ )  {
			write('<table width=100% border=0 cellspacing=0 cellpadding=0 bgColor="#FFFFFF"><tr><td align=left width=100%>'+i+'</td></tr></table>');
		}
		for ( i=startQuestion ; i <= top.totalQuestion ; i++ )  {
			color="#FFFFFF";
			if ( currentQuestion == i )
				color="#003399";
			if ( currentQuestion > i ) 
				color="#CCCCCC";
			write('<table width=100% border=0 cellspacing=0 cellpadding=0 bgColor="'+color+'"><tr><td width=20%>'+i+'</td>');
			for ( j=1; j <= top.totalOption ; j++ )  {
				if ( currentQuestion > i ) {
//					alert(answerArray[i] + " : " + (j-1));
//					if (answerArray[i] != null ) {
						if ( answerArray[i] == (j-1) ) {
							if(exammode!=1)
							{
							 //alert('sequential');
							 write('<td width=20%><input type=radio name="r'+i+'"  value="'+j+'" onClick="parent.setvar('+i+')" checked></td>');
							}else
							{
							 //alert('random');
							 write('<td width=20%><input type=radio name="r'+i+'"  value="'+j+'"  checked></td>');	
							}
						}
						else {
							if(exammode!=1)
							 {
							  //alert('sequential');
							  write('<td width=20%><input type=radio name="r'+i+'"  value="'+j+'" onClick="parent.setvar('+i+')"></td>');
							 }else
							  {
								//alert('random');
								 write('<td width=20%><input type=radio name="r'+i+'"  value="'+j+'" ></td>');
							  }
						}
//					}
				}
				else {
					if(exammode!=1)
					{
					 write('<td width=20%><input type=radio name="r'+i+'"  value="'+j+'" onClick="parent.setvar('+i+')"></td>');
					}else
					{
					 write('<td width=20%><input type=radio name="r'+i+'"  value="'+j+'" ></td>');
					}

				}
			}
			write('</tr></table>');
		}
		write('<input type=submit value="Submit Answer">');
		write('</form></body></html>');
		close();
	}
}

function TimerFunc()  {
	tf = window.setTimeout("TimerFunc();",1000);
	tcount++;
	timeleft=totaltime-tcount;//500
	temp2.tmleft=timeleft;
	window.status = timeleft + "  Seconds remaining";
	if(timeleft==60) {
		alert("Only 1 minute left"); 
	}
	if(timeleft==0)   {
		window.clearTimeout(tf);
		timeup=1;
		temp3.document.ans2.submit();
	} 
 }
 function setvar(i)  {
	temp2.setr();
	r = temp2.rname;
	//alert(r); Removed alert
	var newr="r"+i;
	if(r==newr)   {
		for(var i=0;i<=3;++i) {
			var p = "temp3.document.ans2." + r + "[" + i + "]";
			if(eval(p).checked) {
				answerArray[currentQuestion]=i;
				ansvar=eval(p).value;
			}
			}
			temp2.localvar=ansvar;
			//alert(temp2.localvar);
			temp2.setval();
	   }
	   else {
		alert("Please select the appropriate answer");
		for(var i=0;i<=3;++i)	{
			var p = "temp3.document.ans2." + newr+"[" + i + "]";
			if(eval(p).checked) 
				eval(p).checked=false;
			//else
			//	newr[answerArray[currentQuestion]].checked=true;
				//temp3.document.ans2.
		}
	   }	
		  
    }

function setTime() {
		if(!quizstarted) {
			TimerFunc();
			quizstarted=true;
		}
		temp3.document.ans2.timetaken.value=totaltime-timeleft;//500
}
