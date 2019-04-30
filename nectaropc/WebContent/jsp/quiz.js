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

function TimerFunc()  {
	
	tcount++;
	timeleft=totaltime-tcount;//500
	tmleft=timeleft;
	if(exammode==1)	;//temp3.document.ans2.timetaken.value=totaltime-timeleft;
	Time=timeleft;
	Seconds =Math.floor(Time%60);
	Time	=Math.floor(Time/60);
	Minutes =Math.floor(Time%60);
	Time	=Math.floor(Time/60);
	Hours	=Math.floor(Time%60);

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
						
						showval();
						if((exammode==0)&&(isPerQuestionTimer==1)) document.NewTestMain.submit();
						else document.NewTestMain2.submit();
						if(exammode==1)	NewTestmain.submit();
					}
			else 
					{	
						showval();
						
						document.NewTestMain2.submit();
					}
		} 
	tf = window.setTimeout("TimerFunc();",1000);
 }
 

function setTime() {

		if((!quizstarted)||(isPerQuestionTimer==1))
			{
				window.clearTimeout(tf);
				TimerFunc();
				quizstarted=true;
				tcount=0;
			}
		//temp3.document.ans2.timetaken.value=totaltime-timeleft;//500
		

}

function checksubmit()
{
	
	if(confirm("Do you wish to finish the test ?") == true)
		temp3.document.ans2.submit();
	else
		return false;
}