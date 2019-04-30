package com.ngs;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.Proxy;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.Map;

import javax.swing.JOptionPane;
/**
 *
 * @author ganesh
 */
public class SmsWay {
    private URLConnection sendSMSConnection;
    private String sessionCookie;
    private Proxy proxy;
    private static String cookie=null;
    private String pass=null;
    HttpURLConnection loginConnection;
    HttpURLConnection sendConnection;
    
    public static void setjCookie(String mycookie)
    {
    	cookie=mycookie;
    }
    
    //Function to support connection through an HTTP Proxy
    public void setProxy(String proxyHost,int proxyPort)
    {
        proxy=new Proxy(Proxy.Type.HTTP,java.net.InetSocketAddress.createUnresolved(proxyHost, proxyPort));
    }
    //Logging in to Way2sms and returning the authentication cookie
    //No need to Give the cookie back to sendSMS() but cookie is returned for expanding the flexibility of the code
    public String loginWay2SMS(String userName,String password)
    {
        //String cookie=null;
        URL urlLogin;
        String loginContent;
        
        if(userName==null || userName.isEmpty())
        {
            System.err.println("A Valid User Name must be present!");
            System.exit(0);
        }
        if(password==null || password.isEmpty())
        {
            System.err.println("A Valid Password must be present!");
            System.exit(0);
        }
        
        try {
            //UTF-8 encoding is the web standard so data must be encoded to UTF-8
        	userName=URLEncoder.encode(userName, "UTF-8");
            password=URLEncoder.encode(password, "UTF-8");
            pass=password;
            //urlLogin=new URL("http://site5.way2sms.com/auth.cl");
            
            loginContent="username=" + userName + "&password=" + password;
            System.out.println("loginWay2SMS loginContent 1:"+loginContent);
            //Reading the cookie
            urlLogin=new URL("http://site5.way2sms.com/Login1.action");
            loginConnection = (HttpURLConnection) urlLogin.openConnection();
            loginConnection.setRequestMethod("POST");
            loginConnection.setRequestProperty("User-agent","Mozilla/4.0");
            loginConnection.setRequestProperty("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
            loginConnection.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
            loginConnection.setRequestProperty("Connection", "keep-alive");
            loginConnection.setRequestProperty("Referer", "http://site5.way2sms.com//entry.jsp");
            loginConnection.setRequestProperty("Accept-Encoding", "gzip, deflate");
            loginConnection.setUseCaches (false);
            loginConnection.setDoInput(true);
            loginConnection.setDoOutput(true);
            
            //Writing the Content to the site
            PrintWriter printWriter = new PrintWriter(new OutputStreamWriter(loginConnection.getOutputStream()), true);
            printWriter.print(loginContent);
            printWriter.flush();
            printWriter.close();

            Map em = loginConnection.getHeaderFields();
            System.out.println("header Values......" + em.toString());

            String headerName = null;   

            for (int i = 1; (headerName = loginConnection.getHeaderFieldKey(i)) != null; i++) 
            {
                 //if(headerName.equals("Set-Cookie"))
                 {
                 System.out.println("Header Name 1: " + headerName);
                 System.out.println(loginConnection.getHeaderField(i));
                 }

            }
            
            cookie = loginConnection.getHeaderField("Set-Cookie");
            System.out.println(cookie);
           
        } catch (MalformedURLException ex) {
           System.err.println("Login URL Error");
           System.exit(0);
        } catch (UnsupportedEncodingException ex) {
            System.err.println("Error in encoding Username or Password");
            System.exit(0);
        }catch (IOException ex) {
            System.err.println("Can not connect to Login URL");
            ex.printStackTrace();
            System.exit(0);
        }
        if(cookie==null || cookie.isEmpty())
        {
            System.err.println("Some error occured...Try again in a few seconds..If still problem exists check your username and password");
        }
        sessionCookie=cookie;
        System.err.println("sessionCookie:"+sessionCookie);
        return cookie;        
    }
    public void sendSMS(String phoneNumber,String message,String action)
    {
    		if(phoneNumber==null || phoneNumber.isEmpty())
            {
                System.err.println("Enter A Valid Phone Number");
                System.exit(0);
            }
            else
            {
                try
                {
                    long testLong=Long.valueOf(phoneNumber);
                }catch(NumberFormatException ex)
                {
                    System.err.println("Invalid Phone Number");
                    System.exit(0);
                }   
            }
            if(message==null || message.isEmpty())
            {
                System.err.println("Enter A Valid Phone Number");
                System.exit(0);
            }
            else if(message.length()>140)
            {
                System.err.println("Message should be less than 140 characters");
            }
            if(action==null || action.isEmpty())
            {
                System.err.println("Enter Valid Action to send Message");
                System.exit(0);
            }
          
            
            try {
                
                message=URLEncoder.encode(message, "UTF-8");
                URL sendURL = new URL("http://site5.way2sms.com/quicksms.action");
                HttpURLConnection sendConnection = (HttpURLConnection) sendURL.openConnection();
                HttpURLConnection.setFollowRedirects(false);
                sendConnection.setRequestProperty("User-agent","Mozilla/4.0");
                sendConnection.setRequestProperty("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8");
                sendConnection.setRequestProperty("Accept-Language", "en-US,en;q=0.5");
                sendConnection.setRequestProperty("Connection", "keep-alive");
                sendConnection.setRequestProperty("Referer", "http://site5.way2sms.com/jsp/InstantSMS.jsp");
                sendConnection.setRequestProperty("Accept-Encoding", "gzip, deflate");
                sendConnection.setRequestProperty("Connection", "keep-alive");
                sendConnection.setRequestProperty("Cookie", sessionCookie);
                sendConnection.connect();

                Map em = sendConnection.getHeaderFields();
                System.out.println("header Values......" + em.toString());
                
                String headerName = null;   
                for (int i = 1; (headerName = sendConnection.getHeaderFieldKey(i)) != null; i++) 
                {
                     //if(headerName.equals("Set-Cookie"))
                     {
                     System.out.println("Header Name 2: " + headerName);
                     System.out.println(sendConnection.getHeaderField(i));
                     }

                }
                
                String sendContent="custid=undefined&HiddenAction=instantsms&Action="+action+"&login="+phoneNumber+"&pass="+pass+"&MobNo="+ phoneNumber+ "&textArea="+message;
                PrintWriter printWriter = new PrintWriter(new OutputStreamWriter(sendConnection.getOutputStream()),true);
                printWriter.print(sendContent);
                System.out.println("sendSMS	sendContent 4:"+sendContent);
                printWriter.flush();
                printWriter.close();
                //Reading the returned web page to analyse whether the operation was sucessfull
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(sendConnection.getInputStream()));
                StringBuilder SendResult=new StringBuilder();
                String line;
                while ((line=bufferedReader.readLine()) != null)
                {
                    SendResult.append(line);
                    SendResult.append('\n');
                    //Message has been submitted successfully
                }
                if(SendResult.toString().contains("Message has been submitted successfully"))
                {
                    System.out.println("Message sent to "+phoneNumber+" successfully.");
                  //  JOptionPane.showMessageDialog(null,"Message sent to "+phoneNumber+" successfully.");
                }
                else
                {
                    System.err.println("Message could not send to "+phoneNumber+". Also check login credentials");
                }
                bufferedReader.close();
               
            }catch (UnsupportedEncodingException ex) {
                System.err.println("Message content encoding error");
                System.exit(0);
            }catch (MalformedURLException ex) {
                System.err.println("Sending URL Error");
                System.exit(0);
            }catch (IOException ex) {
               System.err.println("Sending URL Connection Error");
               System.exit(0);
            }         
    }
    public void logoutWay2SMS()
    {
        try {
            HttpURLConnection logoutConnection;
            URL logoutURL;
            logoutURL = new URL("http://site5.way2sms.com/jsp/logout.jsp");
            if(proxy==null)
            {
               logoutConnection = (HttpURLConnection) logoutURL.openConnection();
            }
            else
            {
               logoutConnection = (HttpURLConnection) logoutURL.openConnection(proxy);
            }
            logoutConnection.setRequestProperty("User-Agent","Mozilla/5.0 (Windows; U; Windows NT 6.0;     en-US; rv:1.9.0.5) Gecko/2008120122 Firefox/3.0.5");
            logoutConnection.setRequestProperty("Accept", "*/*");
            logoutConnection.setRequestProperty("Cookie", sessionCookie);
            logoutConnection.setRequestMethod("GET");
            logoutConnection.setInstanceFollowRedirects(false);
            BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(logoutConnection.getInputStream()));
            while ((bufferedReader.readLine()) != null);
            bufferedReader.close();
        } catch (MalformedURLException ex) {
            System.err.println("Logout URL Error");
            System.exit(0);
        }catch (IOException ex) {
            System.err.println("Logout URL Connection Error");
            System.exit(0);
        }
    }
    public SmsWay()
    {  
        proxy=null;
    
        sendSMSConnection=null;
    }
       public static void main(String args[])
    { 
        final String USERNAME="9881864520";//REQUIRED
        final String PASSWORD="N3283N";//REQUIRED
        final String ACTION="asd456cbvgfdf";//REQUIRED : In order to understand ACTION value please read the blog
        SmsWay sms=new SmsWay();
        //HTTP PROXY
        //sms.setProxy("10.1.1.1",8080); //REQUIRED ONLY IF CONNECTING THROUGH A PROXY
       
        StringBuilder phoneNumber= new StringBuilder("9881864520");
        StringBuilder message=new StringBuilder("Welcome to Ganesh JAVA Power");
        /*if(args.length>0)
        {
          if(args[0].toLowerCase().compareTo("phone")==0)
          {
            int i=1;
            while(args[i].toLowerCase().compareTo("message")!=0)
            {
                phoneNumber.append(args[i]);
                 phoneNumber.append(';');
                i++;
            }
            for(i=i+1;i
            {
                message.append(args[i]);
                message.append(' ');
            }
          }
          else
          {
            System.out.println("USAGE : Way2SMS phone  ... message ");
            System.exit(0);
          }
        }
        else
        {
            System.out.println("USAGE : Way2SMS phone  ... message ");
            System.exit(0);
        }
       
        */
      
        String cookie=sms.loginWay2SMS(USERNAME,PASSWORD);
        String textMessage=message.toString();
        String strPhoneNumber=phoneNumber.toString();
        String arrPhoneNUmber[]=strPhoneNumber.split(";");
        for(int i=0;i< arrPhoneNUmber.length;i++)
        {
         sms.sendSMS(arrPhoneNUmber[i], textMessage, ACTION);
        }
       
        sms.logoutWay2SMS();
    }
}