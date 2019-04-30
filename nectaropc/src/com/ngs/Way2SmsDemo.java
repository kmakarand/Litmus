package com.ngs;

public class Way2SmsDemo {
public static int responseCode = -1;
public static String userCredentials = null;
public static String cookie = null;
public static String actionStr = "0aca5d06ed3d90dc";
public static Credentials credentials = new Credentials();

public static void main(String[] args) {
login("9881864520", "N3283N");
sendSMS("9881864520", "msg");
System.out.println("Message has been sent successfully!");
}

public static void setjCookie(String mycookie)
{
	cookie=mycookie;
}

public static void login(String uid, String pwd) {
credentials.append("username", "9881864520"); //mobile no
credentials.append("password", "N3283N"); //password
credentials.append("button", "Login");
userCredentials = credentials.getUserCredentials();

URLConnector.connect("http://site5.way2sms.com/Login1.action&#8221;", false, "POST", null, "userCredentials");
//cookie = URLConnector.getCookie();
System.out.println("cookiecookie:"+cookie);
responseCode = URLConnector.getResponseCode();
if(responseCode != 302 && responseCode != 200)
exit(URLConnector.getErrorMessage());
URLConnector.disconnect();
}

public static void getActionString() {
URLConnector.connect("http://site5.way2sms.com/jsp/InstantSMS.jsp&#8221;", false, "GET", cookie, null);
responseCode = URLConnector.getResponseCode();
if(responseCode == 302 || responseCode == 200) {

String str = URLConnector.getResponse();

String aStr = "name=\"Action\" id=\"Action\"";
int aStrLen = aStr.length();

int index = str.indexOf(aStr);
if(index > 0) {
str = str.substring(index + aStrLen);
index = str.indexOf("\"");
if(index > 0) {
str = str.substring(index + 1);
index = str.indexOf("\"");
if(index > 0)
actionStr = str.substring(0, index);
}
}
} else {
exit(URLConnector.getErrorMessage());
}
URLConnector.disconnect();
}

public static void sendSMS(String receiversMobNo, String msg) {
getActionString();

credentials.reset();
credentials.set("HiddenAction", "instantsms");
credentials.append("catnamedis", "Birthday");
if(actionStr != null)
credentials.append("Action", actionStr);
else
exit("Action string missing!");
credentials.append("chkall", "on");
credentials.append("MobNo", "9881864520"); //receivers mobile no
credentials.append("textArea", "Hi Nectar"); //actual message
credentials.append("bulidguid", "9881864520");
credentials.append("bulidgpwd", "N3283N");
/*credentials.append("bulidyuid", "username");
credentials.append("bulidypwd", "9881864520");
credentials.append("guid1", "9881864520");
credentials.append("gpwd1", "N3283N");
credentials.append("yuid1", "9881864520");
credentials.append("ypwd1", "N3283N");*/

userCredentials = credentials.getUserCredentials();
//System.out.println("userCredentials :"+userCredentials);

URLConnector.connect("http://site5.way2sms.com/quicksms.action&#8221;", true, "POST", cookie, userCredentials);
responseCode = URLConnector.getResponseCode();
if(responseCode != 302 && responseCode != 200)
exit(URLConnector.getErrorMessage());
URLConnector.disconnect();
}

public static void exit(String errorMsg) {
System.out.println(errorMsg);
System.exit(1);
}
}