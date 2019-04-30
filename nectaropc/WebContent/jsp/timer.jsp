<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<title> Test main </title>
<link rel="stylesheet" href="../alm.css" type="text/css">

<p id="demo1"></p>
<p id="demo2"></p>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="quiz.js"></script>

</head>
 <body>
<script language="javascript">
var localvar="";
var flag=0;
var rname="";
var qtimer;
var k;
var tmleft;
var totseconds = tmleft;
var seconds = 0;
var minutes = 0;
var hours = 0;
var myVar = setInterval(myTimer, 1000);
var n = 0;

function myTimer() {
	var d = new Date();
	n = d.getSeconds();
	totseconds = tmleft;
	seconds = Math.floor(totseconds%60);
	minutes = Math.floor(totseconds/60);
	hours = Math.floor(minutes/60);
	if (seconds==59)
		minutes = minutes + 1;
	if (minutes==59)
		hours = hours + 1;

	document.getElementById("demo2").innerHTML = "seconds :"+seconds;
	//out.println("minutes :"+minutes);
	//out.println("totseconds :"+totseconds);
	//out.println("tmleft :"+tmleft);
	
	//document.getElementById("demo1").innerHTML = "<font size=\"1\" color=\"green\"><B> Time Left </B></font>";
	document.getElementById("demo2").innerHTML = "<font size=\"1\" color=\"green\"><B> Time Left </B></font><font size=\"1\" color=\"red\"><B>hours	:"+ hours +" Minutes  :"+ Minutes +" seconds  :"+ seconds +"</B></font>";
	
}
</script>
<p id="demo"></p>

<script>
// Set the date we're counting down to
var countDownDate = new Date("Jan 5, 2021 15:37:25").getTime();

// Update the count down every 1 second
var x = setInterval(function() {

  // Get todays date and time
  var now = new Date().getTime();

  // Find the distance between now and the count down date
  var distance = countDownDate - now;

  // Time calculations for days, hours, minutes and seconds
  var days = Math.floor(distance / (1000 * 60 * 60 * 24));
  var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
  var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
  var seconds = Math.floor((distance % (1000 * 60)) / 1000);

  // Display the result in the element with id="demo"
  document.getElementById("demo").innerHTML = days + "d " + hours + "h "
  + minutes + "m " + seconds + "s ";

  // If the count down is finished, write some text 
  if (distance < 0) {
    clearInterval(x);
    document.getElementById("demo").innerHTML = "EXPIRED";
  }
}, 1000);
</script>
 </body>
  </html>