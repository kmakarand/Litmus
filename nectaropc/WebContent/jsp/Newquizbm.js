
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
var NoOfSections=0;
var FormAction="";


answerArray = new Array();










function displayOption(k) 
{
	with (top.temp3.document )
	{
		//if(NoOfSections>1) write('<html><style>td.but{background-color:#FEF9E2}</style><body  bgcolor="#fff5e7" topmargin=0 rightmargin=0><form name=ans2 action=NewSectionManager.jsp method=get target="_top"><input type=hidden name=timetaken>');
		//else	
		write('<html><body  bgcolor="#fef9e2" topmargin=0 rightmargin=0><center><BR><h4>Answer Sheet</h4><form name=ans2 action=NewVerifyAnswers.jsp method=get target="_top"><input type=hidden name=timetaken>');
		if(k!=1)
		{
			//alert('totalQuestion'+totalQuestion);
			//alert('NoOfSections'+NoOfSections);
			//alert(''+);
			//alert(''+);
			for ( i=1 ; i < startQuestion ; i++ ) write('<table width=100% border=0 cellspacing=0 cellpadding=0 bgColor="#fff5e7"><tr><td align=left width=100%>'+i+'</td></tr></table>');
			for ( i=startQuestion ; i <= top.totalQuestion ; i++ )
						{
							color="#FFFFFF";
							if(exammode==0)
								{
									if ( currentQuestion == i )	color="tan";//"#003399";
									if ( currentQuestion > i )  color="#fef9e2";//"#CCCCCC";
									if ( i > currentQuestion )	color="#fef9e2";
								}
								else color="#FFF5E7"
							write('<table width=100% border=0 cellspacing=0 cellpadding=0 bgColor="'+color+'"><tr><td width=20%>'+i+'</td>');
							for ( j=1; j <= top.totalOption ; j++ ) 
										{
											if ( currentQuestion > i ) //To show the previous selected answers
													{
														//alert('i : '+i);
														//alert("ansarray :"+answerArray[i][j-1]);
														//alert("j :"+j);

														if ( answerArray[i][j-1] == 1 )
																{
								
																	 if(exammode!=1) {
																		// alert("1");
																		 write('<td width=20%><input type=checkbox name="r'+i+j+'"  value="'+j+'" onClick="parent.callme('+i+')" checked></td>');
																		 }
																	 else			 write('<td width=20%><input type=checkbox name="r'+i+j+'"  value="'+j+'"  checked></td>');	
								
																}
																else
																{
																	if(exammode!=1) 
																	{//alert("else");
																		write('<td width=20%><input type=checkbox name="r'+i+j+'"  value="'+j+'" onClick="parent.callme('+i+')"></td>');
																	}
																	else			write('<td width=20%><input type=checkbox name="r'+i+j+'"  value="'+j+'" ></td>');
									
																}

													}
													else //These are the new options being printed
													{
														/*
														if(exammode!=1)	 write('<td width=20%><input type=radio name="r'+i+'"  value="'+j+'" onClick="parent.setvar('+i+')"></td>');
														else			 write('<td width=20%><input type=radio name="r'+i+'"  value="'+j+'" ></td>');
														*/
														write('<td width=20%><input type=checkbox name="r'+i+j+'"  value="'+j+'" onClick="parent.callme('+i+')"></td>');
														
													}
										}//end of for2
									write('</tr></table>');
						}//end of for1

		//write('<br><input type="image" border=0 src="../images/subanswer1.gif" name="Image1" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage(\'Image1\','',"../images/subanswer2.gif",1)" >');
		
		write('<br> <input type="hidden" name="id" value=0>');
		write('<br> <input type="hidden" name="questimer" value=0>');
		write('<br> <input type="hidden" name="timeleft" value=0>');
		write('<br> <input type="hidden" name="qans" value=0>');
		write('<br> <input type="submit" value="Submit Answers" onClick="return parent.updatelast()" >');
		//write('<br> <input type="submit" value="Submit Answers ">');
		}//end of if(k!=1)
		else
		{write('<br><br><br>&nbsp&nbsp&nbsp&nbsp&nbsp<input type=submit value="Submit">');}
		write('</form></body></html>');
		close();
	}
	 //  alert(currentQuestion*10);
	//	 top.temp3.scroll(0,currentQuestion*12);
	//alert('isPerQuestionTimer'+isPerQuestionTimer);
}


function updatelast()
{
	parent.temp2.showval();
	temp3.document.ans2.id.value =parent.currentQuestion;
	temp3.document.ans2.questimer.value =parent.temp2.qtimer;
	temp3.document.ans2.timeleft.value =parent.temp2.tmleft;
	temp3.document.ans2.qans.value =parent.temp2.localvar;
	if(parent.temp2.localvar=="") temp3.document.ans2.qans.value="0";
	alert(parent.currentQuestion+':'+parent.temp2.qtimer+':'+parent.temp2.tmleft+':'+parent.temp2.localvar);

}




function TimerFunc()  {
	
	tcount++;
	timeleft=totaltime-tcount;//500
	temp2.tmleft=timeleft;
	if(exammode==1)	temp3.document.ans2.timetaken.value=totaltime-timeleft;
	Time=timeleft;
	Seconds = Math.floor(Time%60);
	Time = Math.floor(Time/60);
	Minutes =Math.floor(Time%60);
	Time=Math.floor(Time/60);
	Hours=Math.floor(Time%60);

	ShowTime=""+ "Hours :" +Hours+"  Minutes :"+Minutes+"  Seconds :"+Seconds;
	ShowTime2=""+"Minutes :"+Minutes+"  Seconds :"+Seconds;
	if(timeleft>0)
		{
			if(isPerQuestionTimer==1) 	window.status = ShowTime2 + " remaining for Question";
			if(isPerQuestionTimer==3)	window.status = ShowTime + " remaining for Exam";	
			if(isPerQuestionTimer==2)	window.status = ShowTime + " remaining for Section";	
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
						if((exammode==0)&&(isPerQuestionTimer==1)) temp2.document.NewTestMainbm.submit();
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
	if(r==newr) 
		{
			for(var i=0;i<totalOption-1;++i) 
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
		for(var i=0;i<totalOption-1;++i)
			{
				var p = "temp3.document.ans2." + newr+"[" + i + "]";
				if(eval(p).checked) 	eval(p).checked=false;
			//else
			//	newr[answerArray[currentQuestion]].checked=true;
				//temp3.document.ans2.
			}
	   }//end of alse		
    }


function callme(i)
{
	
		//alert(i);
		var ino = i;
		temp2.setr();
		//var p="";
		r = temp2.rname;
		var newr="r"+i;
			if(r==newr) 
			{
				var p="";
				ans = new Array();
				var answer="";

				for(var i=1;i<=totalOption;++i)
				{
					var rc = r+i;
					//alert(rc);
					var p = "temp3.document.ans2." + rc;// + "[" + i + "]";
					//alert("p : "+p);
					//alert("eval p :"+eval(p).checked);
					if(eval(p).checked)	
					{ans[i]= eval(p).value;
					//alert("ino"+ino);
					//alert("i"+i);

					 //alert(answerArray[ino][i-1]);	
					 answerArray[ino][i-1]=1;	
					 //alert("ans : "+answerArray[ino][i-1]);
					}
					else 
					{ans[i]=0;
					
					 answerArray[ino][i-1]=0;
					 //alert("otherans : "+answerArray[ino][i-1]);
					}
				}
				for(var i=1;i<=totalOption;++i) 	if(ans[i]!=0)	answer=answer+ans[i];
				
				if(answer=="") answer=answer+'0';
				//alert(answer);
				temp2.localvar=answer;
				//alert(temp2.localvar);
				temp2.setval();
			}
	   else {
		alert("Please select the appropriate answer");
		for(var i=1;i<=totalOption;++i)
			{
				var rc = newr+i;
				var p = "temp3.document.ans2." + rc;//+"[" + i + "]";
				if(answerArray[ino][i-1]==1) eval(p).checked=true;
				else eval(p).checked=false;

			//else
			//	newr[answerArray[currentQuestion]].checked=true;
				//temp3.document.ans2.
			}
	   }//end of alse

	
	
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
