
//INCLUDED FUNCTIONS FOR ON MOUSE ROLLOVER

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v3.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document); return x;
}

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

// START OF SCRIPT QUIZ.JS

var ansvar="";
var r ="";
var tf=0;
var timeup=0;
var timeleft=0;
var tcount=0;
var temp=0;
var totalQuestion=0;
var totalOption=5;
var quizstarted=false;
var currentQuestion=1;
var startQuestion=1;
var totaltime=100;
var exammode=1;
var isPerQuestionTimer=0;
var Hours  =0;
var Minutes=0;
var Seconds=0;
var Time=0;
var ShowTime="";
var ShowTime2="";
//alert(totalQuestion);
answerArray = new Array();


function displayOption(k) {
	with (top.temp3.document ) {
		write('<html><style> .tde{font-family:arial;font-size:10pt;font-weight:bold;color:#ff0000;bgcolor:#facfae;} td.but{background-color:#FEF9E2}</style><body  bgcolor="#fff5e7" topmargin=0 rightmargin=0><form name=ans2 action=VerifyAnswers.jsp method=get target="_top"><input type=hidden name=timetaken>');
		write('<input type=hidden name="la" value="0">');
		if(k!=1)
		{
			write('<br><table width=100% border=0 cellspacing=0 cellpadding=0 bgColor="#fff5e7">');
			write('<tr><td width=20% class=tde>&nbsp;</td><td width=20% class=tde>A</td><td width=20% class=tde>B</td><td width=20%  class=tde>C</td><td width=20% class=tde>D</td><td width=20% class=tde>E</td></tr>');
			write('</table><br>');
			for ( i=1 ; i < startQuestion ; i++ )  {
			write('<table width=100% border=0 cellspacing=0 cellpadding=0 bgColor="#fff5e7"><tr><td align=left width=100% class=tde>'+i+'</td></tr></table>');
			}
			for ( i=startQuestion ; i <= top.totalQuestion ; i++ )  {
				color="#FFFFFF";
				if(exammode==0)
				{
					if ( currentQuestion == i )
					{color="#960317";//"#003399";
					 temp3.document.ans2.la.value=i;
					}
					if ( currentQuestion > i ) 
					color="#FFF5E7";//"#CCCCCC";
					if (i>currentQuestion)
						color="#fff5e7";
				}
				else color="#FFF5E7"
				write('<table width=100% border=0 cellspacing=0 cellpadding=0 bgColor="'+color+'">');
				
				write('<tr><td width=20% class=tde>'+i+'</td>');
				for ( j=1; j <= top.totalOption ; j++ )  {
					if ( currentQuestion > i ) {
//						alert(i+":"+answerArray[i] + " : " + (j));
//						if (answerArray[i] != null ) {
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
//						}
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

		//write('<br><input type="image" border=0 src="../images/subanswer1.gif" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage(\'Image1\','',"../images/subanswer2.gif",1)" >');
		
		write('<br> <input type="button" value="Finish Test" onclick="top.checksubmit()">');
		}//end of if(k!=1)
		else
		{write('<br><br><br>&nbsp&nbsp&nbsp&nbsp&nbsp<input type=submit value="Submit">');}
		write('</form></body></html>');
		close();
	}
	 //  alert(currentQuestion*10);
		top.temp3.scroll(0,currentQuestion*10);
		top.temp3.scroll(0,currentQuestion*10);
}

function TimerFunc()  {
	
	tcount++;
	timeleft=totaltime-tcount;//500
	temp2.tmleft=timeleft;
	
	
	if(exammode==1)	temp3.document.ans2.timetaken.value=totaltime-timeleft;
	Time=timeleft;
	//alert("Time :"+Time);
	Seconds = Math.floor(Time%60);
	//alert("Seconds:"+Seconds);
	Time = Math.floor(Time/60);
	//alert("Time 2 :"+Time);
	Minutes = Math.floor(Time%60);
	//alert("Minutes : "+Minutes);
	Time=Math.floor(Time/60);
	//alert("Time 3 :"+Time);
	Hours=Math.floor(Time%60);
	//alert("Hours :"+Hours);

	ShowTime=""+ "Hours :" +Hours+"  Minutes :"+Minutes+"  Seconds :"+Seconds;
	ShowTime2=""+"Minutes :"+Minutes+"  Seconds :"+Seconds;
	
	if(timeleft>0)
		{
			if(isPerQuestionTimer==1) 	window.status = ShowTime2 + " remaining for Question";
			if(isPerQuestionTimer==0)	window.status = ShowTime + " remaining for Exam";	
		}
	if(timeleft==60) 
		{
			//alert("Only 1 minute left"); 
		}
	if(timeleft==0)   
		{
			window.clearTimeout(tf);
			timeup=1;
			if(currentQuestion<totalQuestion)	
					{	
						temp2.showval();
						if((exammode==0)&&(isPerQuestionTimer==1)) temp2.document.TestMainbm.submit();
						else temp3.document.ans2.submit();
						if(exammode==1)	temp3.document.ans2.submit();
					}
			else 
					{	
						temp2.showval();
						temp3.document.ans2.submit();
					}
		} 
	tf = window.setTimeout("TimerFunc();",1000);
 }
 function setvar(i)  {
	temp2.setr();
	r = temp2.rname;
	//alert(r); Removed alert
	var newr="r"+i;
	if(r==newr)   {
		for(var i=0;i<totalOption;i++) 
			{
				var p = "temp3.document.ans2." + r + "[" + i + "]";
				if(eval(p).checked) 
				{
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
		//alert("i:"+i+"answer:"+answerArray[i]);
		if(answerArray[i]!=null) 
		   {
				
				if(answerArray[i]==-1)	
				{
					 //	var p = eval("temp3.document.ans2.r"+i);
					 for(var i=0;i<totalOption-1;++i)
					 {
						var p = "temp3.document.ans2." + newr+"[" + i + "]";
						eval(p).checked=false;
					 }
				
						return false;
				}
				else 
				{
				   	var p = eval("temp3.document.ans2.r"+i);
					p[answerArray[i]].checked=true;
					return false;
				}
		   }
		   else
		   { 
				//alert("Please select the appropriate answer");	
			   for(var i=0;i<totalOption-1;++i)
					 {
						var p = "temp3.document.ans2." + newr+"[" + i + "]";
						eval(p).checked=false;
					 }
			   return false;
		   }
//		for(var i=0;i<totalOption-1;++i)	{
//			var p = "temp3.document.ans2." + newr+"[" + i + "]";
//			if(eval(p).checked) 
//				eval(p).checked=false;
//			//else
//			//	newr[answerArray[currentQuestion]].checked=true;
//				//temp3.document.ans2.
//		}
	   }	
    }

function setTime() {

		if((!quizstarted)||(isPerQuestionTimer==1))
			{
				window.clearTimeout(tf);
				TimerFunc();
				quizstarted=true;
				tcount=0;
			}
		temp3.document.ans2.timetaken.value=totaltime-timeleft;//500
		

}

function checksubmit()
{
	
	if(confirm("Do you wish to finish the test ?") == true)
		temp3.document.ans2.submit();
	else
		return false;
}