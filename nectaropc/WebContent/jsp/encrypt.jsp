<%@ page language="java" errorPage="errorpage.jsp" import="javax.persistence.*,com.ngs.dao.*,com.ngs.entity.*,com.ngs.security.*,java.sql.*,java.util.*,java.io.*,org.apache.log4j.Logger" session="true" %>
<%@page import="com.ngs.EntityManagerHelper"%>
<jsp:useBean id="pool" scope="application" class="com.ngs.gbl.ConnectionPool"/>
<%@page import=" java.security.*"%>
<%@page import="javax.crypto.*,javax.crypto.KeyGenerator"%>
<%!
		private static String algorithm = "DESede";
        private static Key key = null;
        private static Cipher cipher = null;
 		private static byte[] encrypt(String input)throws Exception {
            cipher.init(Cipher.ENCRYPT_MODE, key);
            byte[] inputBytes = input.getBytes();
            return cipher.doFinal(inputBytes);
        }
%>
<%!
        private static String decrypt(byte[] encryptionBytes)throws Exception {
            cipher.init(Cipher.DECRYPT_MODE, key);
            byte[] recoveredBytes =  cipher.doFinal(encryptionBytes);
            String recovered =  new String(recoveredBytes);
            return recovered;
          }
          %>
<%
			String name=request.getParameter("name");
			String password=request.getParameter("pass");
			String address=request.getParameter("address");
			String phone=request.getParameter("phone");
			int ph=Integer.parseInt(phone);
			StringBuffer buffer=new StringBuffer();
			key = KeyGenerator.getInstance(algorithm).generateKey();
			cipher = Cipher.getInstance(algorithm);
            String input = password;
            System.out.println("Entered: " + input);
            byte[] encryptionBytes = encrypt(input);
            String passw=new String(encryptionBytes);
			
			Connection con=null;
			try{
			
			con = pool.getConnection();
			PreparedStatement ps = con.prepareStatement("INSERT INTO user(name,password,address,telno) VALUES(?,?,?,?)");
			ps.setString(1,name);
			ps.setString(2,passw);
			ps.setString(3,address);
			ps.setInt(4,ph);
			int i = ps.executeUpdate();
			ps.close();
			
			}
			catch(Exception ex){
			System.out.println(ex);
			}
			try{
			Statement st=con.createStatement();
			ResultSet rs=st.executeQuery("Select * from user where id='1'");
			String str="";
			if(rs.next()){
			str=rs.getString("password");
			}
			out.println("Your password is: "+decrypt(str.getBytes()));
			System.out.println("Your password is: "+decrypt(str.getBytes()));
			}
			catch(Exception e){}
			%>