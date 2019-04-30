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

import java.security.*;
import javax.crypto.*;
import javax.crypto.KeyGenerator;
 
public class AlgorithmTest {
	public static void main(String[] args) throws Exception {
		String algorithm = "PBEWithMD5AndDES";
 
		//KeyGenerator.getInstance(algorithm);
		System.out.println("KeyGenerator OK");
 
		Cipher.getInstance(algorithm);
		System.out.println("Cipher OK");
 
		SecretKeyFactory.getInstance(algorithm);
		System.out.println("SecretKeyFactory OK");
	}
}
/*End code*/


