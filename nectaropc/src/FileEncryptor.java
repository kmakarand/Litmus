/*
 * Created on Sep 1, 2012
 *
 * To change the template for this generated file go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */

/**
 * @author Milind
 *
 * To change the template for this generated type comment go to
 * Window&gt;Preferences&gt;Java&gt;Code Generation&gt;Code and Comments
 */
import java.io.*;   
import javax.crypto.*;   
import javax.crypto.spec.*;   
import java.security.InvalidAlgorithmParameterException;   
import java.security.InvalidKeyException;   
import java.security.NoSuchAlgorithmException;   
import java.security.spec.InvalidKeySpecException;   
import java.util.*;
  
public class FileEncryptor   
{   
   private static String filename;   
   private static FileInputStream inFile;   
   private static FileOutputStream outFile;   
   static String result;   
  
public FileEncryptor(File file) throws NoSuchAlgorithmException,   
InvalidKeySpecException, NoSuchPaddingException, IOException,   
IllegalBlockSizeException, BadPaddingException, InvalidKeyException,   
InvalidAlgorithmParameterException {   
	try
	{
	
  
	System.out.println("file :"+file);
	  // File to encrypt.   
	  filename = "Log4jExample.java";   
  
	  // Password must be at least 8 characters (bytes) long   
	  String password = "12345678";   
	 System.out.println("password :"+password);
  
		inFile = new FileInputStream(filename);   
  
	  outFile = new FileOutputStream("c:\\temp.enc");   
  
	  // Use PBEKeySpec to create a key based on a password.   
	  // The password is passed as a character array   
  
	  PBEKeySpec keySpec = new PBEKeySpec(password.toCharArray());   
	  SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBEWithMD5AndDES");   
	  SecretKey passwordKey = keyFactory.generateSecret(keySpec);   
  
	  // PBE = hashing + symmetric encryption.  A 64 bit random   
	  // number (the salt) is added to the password and hashed   
	  // using a Message Digest Algorithm (MD5 in this example.).   
	  // The number of times the password is hashed is determined   
	  // by the interation count.  Adding a random number and   
	  // hashing multiple times enlarges the key space.   
  
	  byte[] salt = new byte[8];   
	  Random rnd = new Random();   
	  rnd.nextBytes(salt);   
	  int iterations = 100;   
  
	  //Create the parameter spec for this salt and interation count   
  
	  PBEParameterSpec parameterSpec = new PBEParameterSpec(salt, iterations);   
  
	  // Create the cipher and initialize it for encryption.   
  
	  Cipher cipher = Cipher.getInstance("PBEWithMD5AndDES");   
	  cipher.init(Cipher.ENCRYPT_MODE, passwordKey, parameterSpec);   
  
	  // Need to write the salt to the (encrypted) file.  The   
	  // salt is needed when reconstructing the key for decryption.   
  
	  outFile.write(salt);   
  
	  // Read the file and encrypt its bytes.   
  
	  byte[] input = new byte[64];   
	  int bytesRead;   
	  while ((bytesRead = inFile.read(input)) != -1)   
	  {   
		 byte[] output = cipher.update(input, 0, bytesRead);   
		 if (output != null) outFile.write(output);   
	  }   
  
	  byte[] output = cipher.doFinal();   
	  if (output != null) outFile.write(output);   
  
	  inFile.close();   
	  outFile.flush();   
	  outFile.close();   
  
	result = "File " + filename + " Encrypted";   
	System.out.println("result :"+result);
	}catch(Exception e){e.getStackTrace();}
  }   
  
  public static void main(String [] args)
  {
	System.out.println("result FileEncryptor:");
    FileEncryptor fe = new FileEncryptor("Log4jExample.java");
    
    
  }

/**
 * @param string
 */
public FileEncryptor(String string) {
	
	// TODO Auto-generated constructor stub
}
}  
