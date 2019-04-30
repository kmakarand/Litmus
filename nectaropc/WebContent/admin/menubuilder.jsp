 
<HTML>
<HEAD>
<%@ page language="java" import="java.sql.*" session="true" %>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<TITLE> Try IT </TITLE>
<style>
TD { font-family:verdana; font-size:8pt ; color:blue  } 
</style>
<script language="javascript" src="menubuilder.js">
</script>
 
<table width="100%" cellspacing="0">
					<tr bgcolor="lightgrey">
<td>
UserName 
</td><td>
				 
	</td>
</table>	


 
<script language="javascript">
actionToPerform="add";
modifiedSelected=0;
 
%>
	menuLength=1;

function addToMenu() {
	with ( document.f1 ) {
		if ( actionToPerform == "add" ) {
			if ( tmenuid.value == "" || tmenuitem.value == "" || tmenuurl.value == "" ) {
				alert("You have to enter all value before adding/modifying");
				return false;
			}
			menuid.length++;
			menuitem.length++;
			menuurl.length++;
			addToMenu1(menuLength);
			menuLength++;
		}
		else {
			if ( tmenuid.value == "" || tmenuitem.value == "" || tmenuurl.value == "" ) {
				deleterec(modifiedSelected);
			}
			else {
				addToMenu1(modifiedSelected);
			}
		}
		tmenuid.value="";
		tmenuurl.value="";
		tmenuitem.value="";
		actionToPerform="add";
		action.value="add";
	}
}
function addToMenu1(mposition) {
	with ( document.f1 ) {
		menuid.options[mposition].text=tmenuid.value;
		menuitem.options[mposition].text=tmenuitem.value;
		menuurl.options[mposition].text=tmenuurl.value;
		menuid[mposition].value=mposition;
		menuitem[mposition].value=mposition;
		menuurl[mposition].value=mposition;
	}
}

function modify(index){
	if ( index == null || index == "" )
		return false;
	modifiedSelected=index;
	actionToPerform="modify";
	with ( document.f1 ) {
		action.value="modify";
		menuid.selectedIndex=modifiedSelected;
		menuitem.selectedIndex=modifiedSelected;
		menuurl.selectedIndex=modifiedSelected;
		tmenuid.value=menuid.options[modifiedSelected].text;
		tmenuitem.value=menuitem.options[modifiedSelected].text;
		tmenuurl.value=menuurl.options[modifiedSelected].text;
	}
}

function deleterec( index ) {
	with ( document.f1 ) {
		for ( i=0 ; i < menuid.length-1 ; i++ ) {
			if ( i >= index )  {
				menuid.options[i].text=menuid.options[i+1].text;
				menuitem.options[i].text=menuitem.options[i+1].text;
				menuurl.options[i].text=menuurl.options[i+1].text;
				menuid[i].value=i;
				menuitem[i].value=i;
				menuurl[i].value=i;
			}
		}
		menuid.length--;
		menuitem.length--;
		menuurl.length--;
		menuLength--;
	}
}

function tryit() {
	with ( document.f1 ) {
		menuArray = new Array();
		for ( i=0 ; i < menuLength ; i++ ) {
			menuArray[i]=menuid.options[i].text+" "+menuitem.options[i].text+";"+menuurl.options[i].text;
		}
	}
	menuArray.sort();
	newwin = window.open("about:blank","newwin","top=0,left=0,height=100,width=780,scrollbars=1,menubars=0;tollbars=0");
	newwin.document.open();
	newwin.document.write(createMenu());
	newwin.document.close();
}
function checkSubmit() {
	with ( document.f1 ) {
		menuids.value="";
		menuitems.value="";
		menuurls.value="";
		//for retriving values
	    
		for ( i=0 ; i < menuLength ; i++ ) {
			menuids.value+=menuid.options[i].text+"#";
			menuitems.value+=menuitem.options[i].text+"#";
			menuurls.value+=menuurl.options[i].text+"#";
		}	
		msgWindow=window.open("/zalm/admin/Logout.jsp","ImageWindow","toolbar=no,scrollbars=yes");
		menuids.value=menuids.value.substr(0,menuids.value.length-1);
		menuitems.value=menuitems.value.substr(0,menuitems.value.length-1);
		menuurls.value=menuurls.value.substr(0,menuurls.value.length-1);
		menuid.selectedIndex=-1;
		menuitem.selectedIndex=-1;
		menuurls.selectedIndex=-1;
		return true;
	}
}


</script>
</HEAD>

<BODY bgColor=#FEF9E2>
<form name=f1 method=GET>
<input type=hidden name=menuids>
<input type=hidden name=menuitems>
<input type=hidden name=menuurls>
<table border=0 cellspacing=2 cellpadding=2 width=100%>
<tr valign=top>
<td width="10%">Menu ID</td>
<td width="70%"><select name=menuid size="5" onClick="modify(value)">
 
<option value=2>user
 
		
		 </select></td>
<td width="20%"><input type=text name=tmenuid maxlength=8></td>
</tr>
<tr valign=top>
< 	 
<td width="10%">Menu Item</td>
<td width="70%"><select name=menuitem size="5" onClick="modify(value)">
		 
<option value=3>rehan
 </select></td>

<td width="20%"><input type=text name=tmenuitem></td>
</tr>
<tr valign=top>
<td width="10%">Menu Url</td>
<td width="70%"><select name=menuurl size="5" onClick="modify(value)">
		 
<option value=4>deepen

		 </select></td>
<td width="20%"><input type=text name=tmenuurl></td>
</tr>

 
<tr>
<td colspan=3>
<table border=0 cellpadding=2 cellpadding=2 width=100%>
<tr bgColor=CCCCCC>
<td width=30%><input type=button value="Try It Online" onClick="tryit()"></td>
<td width=30%><input type=button value="Add" onClick="addToMenu();" name="action"></td>
<td width=40%><input type=submit value="Save to Database" name="button" onClick="return checkSubmit()"></td>
</tr>
</table>
</td>
</tr>
</table>
</form>
</BODY>
</HTML>