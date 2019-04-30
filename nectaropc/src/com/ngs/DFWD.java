package com.ngs;

import com.ngs.gbl.*;


/*
Developer    : Makarand G. Kulkarni
Organisation : Zee Interactive Learning Systems
Project Code : Upload/Download Database
DOS	         : 07 - 05 - 2002 
DOE          : 22 - 05 - 2002
*/


/**	This is the first version of the project which download the file from the server to the client
  * side.This project provides you various facility like it keeps the track of downloading and 
  * provide you the Time of Downloading, Percentage of Downloading,Downloading rate,etc.This project
  *	keeps the track of downloading and even if the download is interruptd, it allows you to start the
  *	downloading from the point of break.This project also allows to download the file for many clients
  *	and even they got interruption, this project allows all of them to download the file from the point
  * of break in downloding the file.
  */


//package com.zils.util;

import java.net.*;
import java.io.*;

import javax.swing.*;
import java.awt.*;
import java.util.*;
import java.awt.event.*;
import java.sql.*;



public class DFWD implements ActionListener{

	Connection con=null;
	ConnectionDB db=new ConnectionDB();
	ResultSet rs = null;
	ConnectionPool pool = new ConnectionPool();
	
	private String fileName = "";
	private String url = "";
    final static JLabel lbytesread = new JLabel();
	final static JLabel lfilesize = new JLabel();
	final static JLabel lfilename = new JLabel();
	final static JLabel ldownloadrate = new JLabel();
	final static JLabel ldownloadPercent = new JLabel();
	final static JLabel lEstimatedTime = new JLabel();
	final static JLabel lMessage = new JLabel();
	final static JPanel pClose= new JPanel();
	final static JButton bClose= new JButton("Close");
	private long beginTime = 0;
	private long startTime = 0;
	private long currentTime = 0;
    private static JProgressBar bar = new JProgressBar(JProgressBar.HORIZONTAL, 0, 100);
	private long slength=0;
	private long totalSize;
	String sql="",sql1,sql2,Time="";
	long tempSize=0;
	String vFileName="";
	long dbFileSize=0;
	long dbBytesRead=0;
	long dbPercent=0;
	int dbFileId=0;
	int dbhour,dbminute,dbsecond,dbest,sec,s1,count,lastFileId,varMaxFileId,varMaxFileId1,varMinFileId;

    public DFWD(){
	}

	public DFWD(String url, String fileName){
		try{
		this.fileName = fileName;
		this.url = url;
		//System.setProperty("http.proxyHost","172.16.0.4");
        //System.setProperty("http.proxyPort","8008");
		Class.forName("com.mysql.jdbc.Driver");
	    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/nectar", "nectar", "nec76tar");

		downloadFile();
		}catch(Exception e){}
	}

	public void downloadFile(){
		
		System.out.println("downloadFile starting");
    	Download : {
		try{
			byte b[] = new byte[1024];
            slength=0;
            URL vurl=new URL(url + "/" + fileName);  
            URLConnection connection = vurl.openConnection();
            slength = connection.getContentLength();
	        InputStream ins = connection.getInputStream();
			File file = new File(fileName);
			FileOutputStream fos = new FileOutputStream(file);
			long size = 0; 
			totalSize = 0;
			long timediff=0;
			long est=0;
			int h=0,m=0,s=0;
			String vFileName=file.getName();
			long tempSize=0;
			int bt=0;
			int vpercent=0;
						
			beginTime = System.currentTimeMillis();
		   	startTime = System.currentTimeMillis();
            
			sql="Select EstTime,FileId,max(FileId)'mFileId',Percent,BytesRead,max(Percent)'mPercent',max(BytesRead)'mBytesRead',FileSize,max(FileSize)'mFileSize' from FileStorage group by FileSize,FileId";
			//con=pool.getConnection();
			rs=con.createStatement().executeQuery(sql);
            
			while(rs.next())
			{
              dbFileSize=rs.getInt("mFileSize");
			  dbBytesRead=rs.getInt("mBytesRead");
			  dbPercent=rs.getInt("mPercent");
			  dbFileId=rs.getInt("mFileId");
			  dbest=rs.getInt("EstTime");
		    }

            if(dbFileId<=0)
			dbFileId=1;
			else
			dbFileId+=1;

			System.out.println("After Database FileId"+dbFileId+"second"+dbest);
			System.out.println("Time="+h+" : "+m+" : "+dbest);
            
			totalSize=totalSize+dbBytesRead;
            int readSize= 0;
			boolean cFlag = true;

			while((size=ins.read(b))!=-1)
			{
				if(cFlag) readSize += size;
				if(readSize<=totalSize && cFlag){
				lfilename.setText("please Wait...........");
				fos.write(b);
				continue;
				}
				else{
			    //
                cFlag=false;
				lfilename.setText("File Name : "+vFileName);  
			    lfilesize.setText("File Size : " +slength+" kb");
                System.out.println("readSize:"+readSize); 
				fos.write(b);
				totalSize += size;
				System.out.println("size :"+size);
			 	bt=(int)((100*totalSize)/(slength));
				tempSize=totalSize;
				
				try{
					if(count==0)sec=0;
					System.out.println("Inserted value"+sec);
                    
					String sql6="Select max(FileId)'maxFileId' from FileStorage where FileName='"+vFileName+"'";  
					ResultSet res6=con.createStatement().executeQuery(sql6);
					while(res6.next())
					{
					   varMaxFileId1=res6.getInt("maxFileId");
					}

					  
					sql="Insert into FileStorage (FileId,FileName,FileSize,BytesRead,Percent,EstTime,Time,hour,minute,second) values ('"+dbFileId+"','"+vFileName+"',"+slength+","+totalSize+","+bt+","+sec+",'"+Time+"',"+h+","+m+","+s+")";
					System.out.println("Downloaded Percentage sql: "+sql); 
					int i=con.createStatement().executeUpdate(sql);
					}catch(Exception e){
						                 try
											{
                                              sql="Update FileStorage set BytesRead="+totalSize+",Percent="+bt+",EstTime="+sec+",Time='"+Time+"',hour="+h+",minute="+m+",second="+s+" where FileName='"+vFileName+"' and FileId="+varMaxFileId+" ";int i=con.createStatement().executeUpdate(sql); //System.out.println("Ex2 is Raised"+e.getMessage());  					 	
											}catch (Exception e1){}
					}
					

					sql1="Select max(FileId)'maxFileId' from FileStorage where FileName='"+vFileName+"'";  
					ResultSet res=con.createStatement().executeQuery(sql1);
					while(res.next())
					{
						varMaxFileId=res.getInt("maxFileId");
					}

				sql2="Select min(FileId)'minFileId' from FileStorage where FileName='"+vFileName+"'";  
				ResultSet res5=con.createStatement().executeQuery(sql2);
				while(res5.next())
				{
				  varMinFileId=res5.getInt("minFileId");  
				  //varFileId=res.getInt("FileId");
				}

				int vLastId=0;

				if(varMinFileId==varMaxFileId && varMinFileId>0)
				vLastId=varMaxFileId-1;
				else	
				vLastId=varMinFileId-1;

				System.out.println("Min File Id"+varMinFileId+"Max File Id"+varMaxFileId);
				System.out.println("Before Database FileId"+dbFileId+"second"+dbest);

				sql2="Select EstTime from FileStorage where FileId="+vLastId+" ";  
				ResultSet res1=con.createStatement().executeQuery(sql2);
				while(res1.next())
				{
				  lastFileId=res1.getInt("EstTime");  
				}
				System.out.println("Est Time"+lastFileId);

				lbytesread.setText("New Bytes Read : "+(totalSize)+"kb");
				vpercent=(bt);
				bar.setValue(vpercent);
				ldownloadPercent.setText("Downloaded Percentage : "+vpercent+" %");
                System.out.println("Downloaded Percentage : "+vpercent+" %"); 
				timediff=((System.currentTimeMillis())-(startTime));
				startTime=startTime+timediff;
				if (startTime != -1 && timediff > 0)
  			    ldownloadrate.setText("Rate : "+ ((float)(size)/timediff)* (1000f/1024f) + "kb/s");
				est=(System.currentTimeMillis()-beginTime)/1000;
				s1=(int)est;

				if(varMinFileId==varMaxFileId && varMinFileId>0)
				sec=dbest+s1-lastFileId;
				else	
				sec=dbest+s1;

				System.out.println("Time second="+sec);
				//est=est+s;
				System.out.println("sec :"+est);
			    
			    if(est>=60)
			    {
					m=((int)(est/60));
					if(est%60==0)
						est=0;
					else
						est=est%60;

					h=((int)(m/60)); 
					if(m>=60)
						{
							if(m%60==0)
								m=0;
							else
								m=m%60;
						}
				
				}
				    s=(int)(est%60);
				    Time=h+" : "+m+" : "+s;
					lEstimatedTime.setText("Estimate Time   Hour :"+Time);
					
                  //////// 
				}//end of If statement
                count++;

			}//end of while loop
			    h=sec/3600;
			    m=sec/60;
				s=sec%60;
				Time=h+" : "+m+" : "+s;

				if(h==0 && m==0 && s==0)
			    {
				 lfilename.setText("Download is done successfully........");
                 break Download;
				}

                lEstimatedTime.setText("Total Estimated Time   Hour :"+  h  +"Minutes :"+  m  +"sec :"+  s);
                lMessage.setText("Download is done successfully........");
				try{
					sql="delete from FileStorage where FileName='"+vFileName+"'";
					con=pool.getConnection();
			        int i1=con.createStatement().executeUpdate(sql);
					}catch(Exception e){}
		}catch(Exception e){
			lMessage.setText("Download is interrupted please restart the procedure........");
			System.out.println("Ex1 is Raised"+e.getMessage());
			e.printStackTrace();
		}

		}// End of Download block		
	}//end of DownloadFile Function.

	public void actionPerformed(ActionEvent e)
	{
		if(e.getSource() == bClose)
		System.exit(1);
	}


	public static void main(String[] args) 
	{
		if(args.length!=2){
			System.out.println("Usage : java DFWD <SERVER_URL_APPLICATION> <FILE_NAME>");
			System.exit(1);
		}
		JFrame frame = new JFrame("Zed CA Download Project");

		String laf = UIManager.getCrossPlatformLookAndFeelClassName();
        try {
            UIManager.setLookAndFeel(laf);  		
			}
            catch (Exception e) {e.printStackTrace();System.exit(1);}
		// Do the layout.
        frame.getContentPane().setLayout(new GridLayout(0,1));
		frame.getContentPane().add(lMessage); 
		frame.getContentPane().add(lfilename);
        frame.getContentPane().add(lbytesread); 
        frame.getContentPane().add(lfilesize);
		frame.getContentPane().add(ldownloadPercent); 
		frame.getContentPane().add(ldownloadrate);
		frame.getContentPane().add(lEstimatedTime); 
		frame.getContentPane().add(bar);
		frame.getContentPane().add(pClose);
		pClose.add(bClose);
		bClose.addActionListener(new DFWD());
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        frame.pack();
		frame.setSize(350,350);
        frame.setVisible(true);
		new DFWD(args[0],args[1]);
		
	}
}
