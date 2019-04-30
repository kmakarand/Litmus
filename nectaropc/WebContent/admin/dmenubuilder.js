function CheckAll()
{
	for (var i=0;i<document.form1.elements.length;i++)
	{
		var e = document.form1.elements[i];
		//(e.name != 'allbox') &&
		if ((e.type=='checkbox'))
		e.checked = document.form1.allbox.checked;
	}
	
}
function CheckCheckAll()
{
	var TotalBoxes = 0;
	var TotalOn = 0;
	for (var i=0;i<document.form1.elements.length;i++)
	{
		var e = document.form1.elements[i];
		if ((e.type=='checkbox'))
		{
			TotalBoxes++;
		if (e.checked)
		{
			TotalOn++;
		}
		}
	}
	if (TotalBoxes==TotalOn)
	{document.form1.allbox.checked=true;}
	else
	{document.form1.allbox.checked=false;}
}
//========================================
var i;
function klick(num){	
	j=0;
	menuArray = new Array();	
	for(i=1;i<=num;i++) {	
		ax=eval("document.form1.ckView"+ i);
	    if ( ax.checked ) {
			menuArray[j]=eval("document.form1.ckView"+i+".value");
			j++;		
		}	
	}	
	if ( menuArray.length >= 1 )	{
		menuArray.sort();
		newwin = window.open("about:blank","newwin","top=0,left=0,height=100,width=780,scrollbars=1,menubars=0;tollbars=0");
		newwin.document.open();
		newwin.document.write(createMenu());
		newwin.document.close();
	}
	else {
		alert("No option Selected");
	}
}
function createMenu() {
	returnString="<html><body><table border=0 cellspacing=2 cellpadding=2><tr valign=top>";
	for ( i=0 ; i < menuArray.length ; i++ ) {
		menuid=menuArray[i].substr(0,8);
		popArray = new Array();
		maincounter=0;
		while ( i  < menuArray.length  ) {
			if ( menuid.substr(0,2) != menuArray[i].substr(0,2) ) {
				i--;
				break;
			}
			popArray[maincounter]=menuArray[i].substr(2,menuArray[i].length);
			maincounter++;
			i++;
		}
		if ( popArray.length > 1 ) {
			urls=popArray[0].split(";");
			returnString+="<td><applet width='95' height='24' archive='/zalm/admin/Popup.jar' code='PopupNavigator.PopupNavigatorApplet.class'>"+ss(popArray)+"<param name='DelimiterChar' value=';'><param name='EscapeChar' value='\\'><param name='DefaultFontName' value='Arial'><param name='DefaultFontStyle' value='PLAIN'><param name='DefaultFontSize' value='12'><param name='Label' value='"+urls[0].substr(6,urls[0].length)+"';;PLAIN;10;0 0 0;176 185 180'><param name='DefaultFrame' value='_self'><param name='Selection' value='RECURSIVE'><param name='ShowStatus' value=''></applet></td>";
		}
		else {
			if ( i  >= menuArray.length  ) 
				i--;
			urls=menuArray[i].split(";");
			returnString+="<td><form><input type=button value='"+urls[0].substr(8,urls[0].length)+"' onClick='top.location.href=\""+urls[1]+"\";'></form></td>"
		}
	}
	returnString+="</tr></table>";
	return returnString;
}
function ss( menuArray1 ) {
	apptag="";
	apptag=new Array(menuArray1.length);
	for ( k=1 ; k < apptag.length ; k++ ) 
		apptag[k]="";
	cnt=0;
	for ( increment=0 ; increment < 6 ; increment+=2 ) {
		counter=0;
		for ( j=1 ; j < menuArray1.length ; j++ ) {
			popid="00";
			while ( j  < menuArray1.length ) {
				if ( popid != menuArray1[j].substr(increment,2)) {
					if ( menuArray1[j].substr(increment,2) != "00" ) {
						apptag[j]=apptag[j]+counter+";";
						counter++;
					}
					else {
						counter=0;
					}
				}
				else {
					if ( counter > 0 ) {
						apptag[j]=apptag[j]+(counter-1)+";";
					}
				}
				popid=menuArray1[j].substr(increment,2);
				j++;
			}
		}
		cnt+=2;
	}
	tt="";
	for ( k=1 ; k < apptag.length ; k++ ) {
		if ( apptag[k].indexOf(";") == -1 )
			apptag[k]="0";
		else 
			apptag[k]=apptag[k].substr(0,apptag[k].length-1);
		tt+="<param name='"+apptag[k] + "' value='" + menuArray1[k].substr(7,menuArray1[k].length) + "'>";
	}
	return tt;
}
