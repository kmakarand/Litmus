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

package com.ngs.security;
import java.io.IOException;
import java.security.GeneralSecurityException;
import java.security.spec.KeySpec;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.PBEParameterSpec;
import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;


public class Encrypter {
	private static final char[] PASSWORD =
		"enfldsgbnlsngdlksdsgm".toCharArray();
	private static final byte[] SALT =
		{
			(byte) 0xde,
			(byte) 0x33,
			(byte) 0x10,
			(byte) 0x12,
			(byte) 0xde,
			(byte) 0x33,
			(byte) 0x10,
			(byte) 0x12,
			};
			
			
	public static String encrypt(String property)
		throws GeneralSecurityException {		
		if(!(property.length()% 8 == 1))
		{
			while(property.length()<8)
			{
				property = property + " ";
				//System.out.println("property: "+property);
			}
			
		}
		else if (property.length() == 9)
		property = property.substring(0,9);
		else
		property = property.substring(0,8);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBEWithMD5AndDES");
		SecretKey key = keyFactory.generateSecret(new PBEKeySpec(PASSWORD));
		Cipher pbeCipher = Cipher.getInstance("PBEWithMD5AndDES");
		pbeCipher.init(Cipher.ENCRYPT_MODE,key,new PBEParameterSpec(SALT, 20));
		return base64Encode(pbeCipher.doFinal(property.getBytes()));
	}
	public static String base64Encode(byte[] bytes) 
	{ 
		// NB: This class is internal, and you probably should use another impl  
		String ret = new BASE64Encoder().encode(bytes);
		//System.out.println("BASE64Encoder().encode(bytes): "+ ret); 
		return ret;  
		   
	}      
	
	public static String decrypt(String property) throws GeneralSecurityException, IOException { 
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("PBEWithMD5AndDES");         
		SecretKey key = keyFactory.generateSecret(new PBEKeySpec(PASSWORD));         
		Cipher pbeCipher = Cipher.getInstance("PBEWithMD5AndDES");         
		pbeCipher.init(Cipher.DECRYPT_MODE, key, new PBEParameterSpec(SALT, 20));         
		return new String(pbeCipher.doFinal(base64Decode(property)));     }      
	
	public static byte[] base64Decode(String property) throws IOException {         
		// NB: This class is internal, and you probably should use another impl         
		return new BASE64Decoder().decodeBuffer(property);     
		}  
	} 
