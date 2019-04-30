package com.ngs;

import java.net.URL;
import java.net.HttpURLConnection;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.BufferedReader;
import java.io.InputStreamReader;

public class URLConnector {
private static HttpURLConnection connection;

public static void connect(String urlPath, boolean redirect, String method, String cookie, String credentials) {
try {
URL url = new URL(urlPath);
System.out.println("urlurl:"+url);

connection = (HttpURLConnection) url.openConnection();
connection.setInstanceFollowRedirects(redirect);

if(cookie != null)
connection.setRequestProperty("Cookie", cookie);
System.out.println("cookiecookie2:"+cookie);

if(method != null && method.equalsIgnoreCase("POST")) {
connection.setRequestMethod(method);
connection.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
}

connection.setUseCaches (false);
connection.setDoInput(true);
connection.setDoOutput(true);

if(credentials != null) {
DataOutputStream wr = new DataOutputStream (connection.getOutputStream ());
wr.writeBytes (credentials);
wr.flush ();
wr.close ();
}
} catch(Exception exception) {
//
System.out.println("Connection error");
//
}
}

public static String getCookie() {
String cookie = null;
if(connection != null) {
String headerName=null;
for (int i = 1; (headerName = connection.getHeaderFieldKey(i)) != null; i++) {
//System.out.println("Message !"+connection.getHeaderField(i));
if (headerName.equals("Set-Cookie")) {
cookie = connection.getHeaderField(i).split(";")[0];
break;
}
}
}
return cookie;
}

public static int getResponseCode() {
int responseCode = -1;

if(connection != null) {
try {
responseCode = connection.getResponseCode();
} catch(Exception exception) {
//
System.out.println("Response code error");
//
}

}

return responseCode;
}

public static String getResponse() {
StringBuffer response = new StringBuffer();

if(connection != null) {
try {
InputStream is = connection.getInputStream();
BufferedReader rd = new BufferedReader(new InputStreamReader(is));

String line = null;
while((line = rd.readLine()) != null) {
response.append(line);
response.append('\r');
}

rd.close();
} catch(Exception exception) {
//
System.out.println("Response error");
//
}
}

return response.toString();
}

public static String getErrorMessage() {
StringBuffer errorMessage = new StringBuffer();

if(connection != null) {
try {
InputStream is = connection.getErrorStream();
BufferedReader rd = new BufferedReader(new InputStreamReader(is));

String line = null;
while((line = rd.readLine()) != null) {
errorMessage.append(line);
errorMessage.append('\r');
}

rd.close();
} catch(Exception exception) {
//
System.out.println("Error in getting error message");
//
}
}

return errorMessage.toString();
}

public static void disconnect() {
if(connection != null)
connection.disconnect();
}
}
