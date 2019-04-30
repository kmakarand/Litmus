// FrontEnd Plus GUI for JAD
// DeCompiled : ExpiryValidation.class

package com.ngs.security;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.ByteArrayOutputStream;
import java.io.CharArrayWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.Properties;
import java.util.ResourceBundle;
import java.util.Set;
import com.ngs.gbl.*;
import java.sql.*;
import org.apache.log4j.Logger;

public class ExpiryValidation
{

    char alphabet[];
    byte codes[];
    boolean Expired;
    boolean Cheating;
    String UserMessage;
    String UserMessage1;
    String fPropertyFile;
	ConnectionPool pool = null;
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql="";
	int timePeriod=0,usageCount=0;
	String regDate="",expDate="";
	Date curDate=null;
	int totReg=0;int totLic=0;
	Logger log = Logger.getLogger(ExpiryValidation.class);
	
	public Connection getConnection()
	{
		ResourceBundle bundle = ResourceBundle.getBundle("ngs");
		for (Enumeration e = bundle.getKeys();e.hasMoreElements();) {
			 String key = (String)e.nextElement();
			 String msg = bundle.getString(key);
			 //System.out.println("key :"+key);
			 //System.out.println("msg :"+msg);
			 //session.setAttribute(key,msg);
     	 }
		Connection conn1 = null;
		try {
				String driver = bundle.getString("db.setDriver");
				String url = bundle.getString("db.setURL");
				String uid="nectar";
				String pwd="nec76tar";
				Class.forName(driver);
				conn1=DriverManager.getConnection(url,uid,pwd);		
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		return conn1;
	}
	
	
	public boolean LicenceValidation(String ClientId)
	{
		//log.debug("Inside LicenceValidation");
		
		try{
				con = getConnection();
				int clientId = Integer.parseInt(ClientId);
				//log.debug("clientId :"+clientId);
				
				sql = "SELECT count(*) AS count FROM CandidateMaster WHERE ClientID=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,clientId);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					totReg = rs.getInt("count");
					//log.debug("totReg :"+totReg);
				}
		
				sql = "SELECT UsageCount FROM ExpairyValidation WHERE ClientID=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1,clientId);
				rs = pstmt.executeQuery();
				while (rs.next())
				{
					totLic = rs.getInt("UsageCount");
					//log.debug("totLic :"+totLic);
				}
				
				if(totReg >= totLic)
				Expired=true;
				
				if(ClientId.equals("0"))
				{
					sql = "SELECT Username FROM CandidateMaster WHERE ClientID=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1,clientId);
					rs = pstmt.executeQuery();
					while (rs.next())
					{
						String userName = rs.getString("Username");
						if(userName.equals("Admin") || userName.equals("cso") || userName.equals("deo"))
						Expired=false;
						//log.info("userName :"+userName);
	
					}
				}
				
			con.close();		
		}catch(Exception exception)
		{
			exception.printStackTrace();
		}
		
		if(Expired)
		{
			UserMessage = "<html><body bgcolor='#fff5e7'><br><br><br>";
			UserMessage += "<center><table width=600 border=3 bordercolor='#960317'>";
			UserMessage += "<tr><td><center><b><font color='#960317'> ERROR</font></b>";
			UserMessage += "</center></tr></td><tr><td><i>";
			UserMessage += "An error has occured. Either you are not authorised to use this software or license period for ";
			UserMessage += "the software is over. For more details, please, contact our ";
			UserMessage += "<a href='mailto:info@nectaredutech.com'> helpdesk.</a>";
			UserMessage += "<BR><br><b>Nectar Global services</b>";
			UserMessage += "</i></tr></td></table></center></body></html>";
		}
		
		//log.info("Expired :"+Expired);
		return Expired;
	}
	
	public boolean getData()
	{
		//log.debug("Inside getdata");
		
		try{
			con = getConnection();
			sql = "SELECT RegDate,ExpDate,UsageCount FROM ExpairyValidation";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next())
			{
				
				regDate = Encrypter.decrypt(rs.getString("RegDate")).trim();
				expDate = Encrypter.decrypt(rs.getString("ExpDate")).trim();
				usageCount = rs.getInt("UsageCount");
				//log.debug("Inside getdata usageCount:"+usageCount);
				
				DateFormat df = new SimpleDateFormat("yyyy-MM-dd");
				curDate = new Date();
				
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
				String strDate = formatter.format(curDate);
				
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date startDate = sdf.parse(strDate);
				Date endDate = sdf.parse(expDate);
				//log.debug("Inside getdata startDate:"+startDate);
				//log.debug("Inside getdata endDate:"+endDate);
				
				if(startDate.compareTo(endDate)>0){
 					Expired = true;
				}else if(startDate.compareTo(endDate)<0){
					Expired = false;
					
 				}
 				
			}
			
			if(Expired)
			{
				UserMessage = "<html><body bgcolor='#fff5e7'><br><br><br>";
				UserMessage += "<center><table width=400 border=3 bordercolor='#960317'>";
				UserMessage += "<tr><td><center><b><font color='#960317'> ERROR</font></b>";
				UserMessage += "</center></tr></td><tr><td><i>";
				UserMessage += "An error has occured. Either you are not authorised to use this software or license period for ";
				UserMessage += "the software is over. For more details, please, contact our ";
				UserMessage += "<a href='mailto:info@nectaredutech.com'> helpdesk.</a>";
				UserMessage += "<BR><br><b>Nectar Global services</b>";
				UserMessage += "</i></tr></td></table></center></body></html>";
			}
			
			con.close();
		}catch(Exception exception)
		{
			exception.printStackTrace();
		}
		
		//log.debug("Inside getdata Expired :"+Expired);
		
		return Expired;
	}

    public ExpiryValidation(String s)
    {
        alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=".toCharArray();
        codes = new byte[256];
        Expired = false;
        Cheating = false;
        UserMessage = "";
        UserMessage1 = "";
        fPropertyFile = "";
        for(int i = 0; i < 256; i++)
            codes[i] = -1;

        for(int j = 65; j <= 90; j++)
            codes[j] = (byte)(j - 65);

        for(int k = 97; k <= 122; k++)
            codes[k] = (byte)((26 + k) - 97);

        for(int l = 48; l <= 57; l++)
            codes[l] = (byte)((52 + l) - 48);

        codes[43] = 62;
        codes[47] = 63;
        fPropertyFile = s;
        //System.out.println("fPropertyFile before :"+fPropertyFile);
        //File file = new File(fPropertyFile);
		File file = new File(fPropertyFile);
        char ac[] = readChars(file);
		byte abyte0[] = decode(ac);
        writeBytes(file, abyte0);
        readWriteFile();
        byte abyte1[] = readBytes(file);
        char ac1[] = encode(abyte1);
        writeChars(file, ac1);
    }

    byte[] decode(char ac[])
    {
        int i = ac.length;
        for(int j = 0; j < ac.length; j++)
            if(ac[j] > '\377' || codes[ac[j]] < 0)
                i--;

        int k = (i / 4) * 3;
        if(i % 4 == 3)
            k += 2;
        if(i % 4 == 2)
            k++;
        byte abyte0[] = new byte[k];
        int l = 0;
        int i1 = 0;
        int j1 = 0;
        for(int k1 = 0; k1 < ac.length; k1++)
        {
            byte byte0 = ac[k1] <= '\377' ? codes[ac[k1]] : -1;
            if(byte0 >= 0)
            {
                i1 <<= 6;
                l += 6;
                i1 |= byte0;
                if(l >= 8)
                {
                    l -= 8;
                    abyte0[j1++] = (byte)(i1 >> l & 0xff);
                }
            }
        }

        if(j1 != abyte0.length)
            throw new Error("Miscalculated data length (wrote " + j1 + " instead of " + abyte0.length + ")");
        else
            return abyte0;
    }

    char[] encode(byte abyte0[])
    {
        char ac[] = new char[((abyte0.length + 2) / 3) * 4];
        int i = 0;
        for(int j = 0; i < abyte0.length; j += 4)
        {
            boolean flag = false;
            boolean flag1 = false;
            int k = 0xff & abyte0[i];
            k <<= 8;
            if(i + 1 < abyte0.length)
            {
                k |= 0xff & abyte0[i + 1];
                flag1 = true;
            }
            k <<= 8;
            if(i + 2 < abyte0.length)
            {
                k |= 0xff & abyte0[i + 2];
                flag = true;
            }
            ac[j + 3] = alphabet[flag ? k & 0x3f : 64];
            k >>= 6;
            ac[j + 2] = alphabet[flag1 ? k & 0x3f : 64];
            k >>= 6;
            ac[j + 1] = alphabet[k & 0x3f];
            k >>= 6;
            ac[j] = alphabet[k & 0x3f];
            i += 3;
        }

        return ac;
    }

    public String getMessage()
    {
        return Expired ? UserMessage : UserMessage1;
    }

    public boolean isCheating()
    {
        return Cheating;
    }

    public boolean isExpired()
    {
        return Expired;
    }

    byte[] readBytes(File file)
    {
        ByteArrayOutputStream bytearrayoutputstream = new ByteArrayOutputStream();
        try
        {
            FileInputStream fileinputstream = new FileInputStream(file);
            BufferedInputStream bufferedinputstream = new BufferedInputStream(fileinputstream);
            int i = 0;
            byte abyte0[] = new byte[16384];
            while((i = bufferedinputstream.read(abyte0)) != -1) 
                if(i > 0)
                    bytearrayoutputstream.write(abyte0, 0, i);
            bufferedinputstream.close();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return bytearrayoutputstream.toByteArray();
    }

    char[] readChars(File file)
    {
        CharArrayWriter chararraywriter = new CharArrayWriter();
        try
        {
            FileReader filereader = new FileReader(file);
            BufferedReader bufferedreader = new BufferedReader(filereader);
            int i = 0;
            char ac[] = new char[16384];
            while((i = bufferedreader.read(ac)) != -1) 
                if(i > 0)
                    chararraywriter.write(ac, 0, i);
            bufferedreader.close();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
        return chararraywriter.toCharArray();
    }

    void readWriteFile()
    {
       Object obj = null;
        Object obj1 = null;
        
		fPropertyFile="C:\\ngs.properties";
        
		//System.out.println("readWriteFile fPropertyFile :"+fPropertyFile);
        try
        {
			
            FileInputStream fileinputstream = new FileInputStream(fPropertyFile);
            Properties properties = new Properties();
            properties.load(fileinputstream);
            Set states;
            String str;
			states = properties.keySet(); // get set-view of keys 
			Iterator itr = states.iterator(); 
			while(itr.hasNext()) { 
			str = (String) itr.next(); 
			//System.out.println(str + " is " + properties.getProperty(str)+ "."); 			
			}	 
	

            fileinputstream.close();
            int i = Integer.parseInt(properties.getProperty("TimePeriod"));
            int dt1 = Integer.parseInt(properties.getProperty("Date1"));
            int k = Integer.parseInt(properties.getProperty("Month1"));
            int l = Integer.parseInt(properties.getProperty("Year1"));
            int dt2 = Integer.parseInt(properties.getProperty("Date2"));
            int mn2 = Integer.parseInt(properties.getProperty("Month2"));
            int yr2 = Integer.parseInt(properties.getProperty("Year2"));
            int dt3 = Integer.parseInt(properties.getProperty("Date3"));
            int mn3 = Integer.parseInt(properties.getProperty("Month3"));
            int yr3 = Integer.parseInt(properties.getProperty("Year3"));
            int k2 = Integer.parseInt(properties.getProperty("UsageCount"));
            Date date = new Date();
            int crdt = date.getDate();
            int crmn = date.getMonth();
            int cryr = date.getYear();
            
            cryr = 10 + cryr % 10;
			//System.out.println(" j3 :"+cryr);
            crmn++;
            if(yr3 > yr2 || cryr > yr2)
                Expired = true;
            else
            if(yr3 == yr2 || cryr == yr2)
                if(mn3 > mn2 || crmn > mn2)
                    Expired = true;
                else
                if(crdt == mn2 || crmn == mn2)
                    if(dt3 > dt2 || crdt > dt2)
                        Expired = true;
                    else
                    if(dt3 == dt2 || crdt == dt2)
                        UserMessage = " <b>Today is the last day for this software</b>";
                        else
						UserMessage = " <b>Today is the last day for this software</b>";
						//System.out.println("Licence is valid");
						
						//Expired = getData();
                        
            if(Expired)
            {
                UserMessage = "<html><body bgcolor='#fff5e7'><br><br><br>";
                UserMessage += "<center><table width=400 border=3 bordercolor='#960317'>";
                UserMessage += "<tr><td><center><b><font color='#960317'> ERROR</font></b>";
                UserMessage += "</center></tr></td><tr><td><i>";
                UserMessage += "An error has occured. Either you are not authorised to use this software or license period for ";
                UserMessage += "the software is over. For more details, please, contact our ";
                UserMessage += "<a href='mailto:helpdesk@zils.com'> helpdesk.</a>";
                UserMessage += "<BR><br><b>Nectar Global services</b>";
                UserMessage += "</i></tr></td></table></center></body></html>";
            }
            if(cryr < l)
                Cheating = true;
            if(cryr < yr3 && cryr < l)
                Cheating = true;
            else
            if(crmn < mn3)
                Cheating = true;
            else
            if(crdt < dt3)
            {
                Cheating = true;
            } else
            {
                FileOutputStream fileoutputstream = new FileOutputStream(fPropertyFile, true);
                Properties properties1 = new Properties();
                k2++;
                properties1.setProperty("UsageCount", String.valueOf(k2));
                properties1.setProperty("Date3", String.valueOf(crdt));
                properties1.setProperty("Month3", String.valueOf(crmn));
                properties1.setProperty("Year3", String.valueOf(cryr));
                properties1.store(fileoutputstream, "");
                fileoutputstream.close();
            }
            if(Cheating)
            {
                UserMessage1 = "<html><body bgcolor='#fff5e7'><br><br><br>";
                UserMessage1 += "<center><table width=400 border=3 bordercolor='#960317'>";
                UserMessage1 += "<tr><td><center><b><font color='#960317'> ERROR</font></b>";
                UserMessage1 += "</center></tr></td><tr><td><i>";
                UserMessage1 += "An error has occured. Either you are not authorised to use this software or license period for ";
                UserMessage1 += "the software is over. For more details, please, contact our ";
                UserMessage1 += "<a href='mailto:helpdesk@zils.com'> helpdesk.</a>";
                UserMessage1 += "<BR><br><b>Nectar Global Services</b>";
                UserMessage1 += "</i></tr></td></table></center></body></html>";
                return;
            }
        }
        catch(Exception exception)
        {
            System.out.println("error in readPropertyFile " + exception.getMessage());
        }
    }

    void writeBytes(File file, byte abyte0[])
    {
        try
        {
            FileOutputStream fileoutputstream = new FileOutputStream(file);
            BufferedOutputStream bufferedoutputstream = new BufferedOutputStream(fileoutputstream);
            bufferedoutputstream.write(abyte0);
            bufferedoutputstream.close();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }

    void writeChars(File file, char ac[])
    {
        try
        {
            FileWriter filewriter = new FileWriter(file);
            BufferedWriter bufferedwriter = new BufferedWriter(filewriter);
            bufferedwriter.write(ac);
            bufferedwriter.close();
        }
        catch(Exception exception)
        {
            exception.printStackTrace();
        }
    }
    
	public static void main(String[] args) throws Exception {
		
		//ExpiryValidation ev = new ExpiryValidation("C:\\tomcat4\\webapps\\ztest\\jsp\\Info.log");
		//ev.getData();
		ExpiryValidation ev = new ExpiryValidation();
		ev.LicenceValidation("0");
	}

	/**
	 * 
	 */
	public ExpiryValidation() {
		}
}
