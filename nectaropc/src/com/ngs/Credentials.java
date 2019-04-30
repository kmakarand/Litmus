package com.ngs;


import java.util.ArrayList;
import java.net.URLEncoder;

public class Credentials {
private ArrayList list = new ArrayList();

public void set(String name, String value) {
StringBuffer buffer = new StringBuffer();

buffer.append(name);
buffer.append("=");
buffer.append(getUTF8String(value));

add(buffer.toString());
}

public void append(String name, String value) {
StringBuffer buffer = new StringBuffer();
buffer.append("&");
buffer.append(name);
buffer.append("=");
buffer.append(getUTF8String(value));
add(buffer.toString());
//System.out.println("buffer :"+buffer.toString());
}

private void add(String item) {
list.add(item);
}

private String getUTF8String(String value) {
String encodedValue = null;

try {
encodedValue = URLEncoder.encode(value, "UTF-8");
} catch(Exception exception) {
//
System.out.println("Encoding error");
//
}

return encodedValue;
}

public boolean isEmpty() {
return list.isEmpty();
}

public void reset() {
list.clear();
}

public String getUserCredentials() {
StringBuffer buffer = new StringBuffer();
int size = list.size();
//System.out.println("buffer size:"+size);
for(int i = 0; i < size; i++)
{
buffer.append(list.get(i));
//System.out.println("buffer list.get"+i+"  :  "+list.get(i));
//System.out.println("buffer :"+buffer.toString());
}
return buffer.toString();

}
}


