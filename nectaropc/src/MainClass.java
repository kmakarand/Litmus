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
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.Provider;
import java.security.Security;
import java.security.Signature;
import java.util.HashSet;
import java.util.Iterator;
import java.util.Set;

import sun.misc.BASE64Encoder;

public class MainClass {
 /* public static void main(String[] args) throws Exception {
	Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());

	byte[] input = new byte[] { (byte) 0xbe, (byte) 0xef };
	Cipher cipher = Cipher.getInstance("RSA/None/NoPadding", "BC");

	KeyFactory keyFactory = KeyFactory.getInstance("RSA", "BC");
	RSAPublicKeySpec pubKeySpec = new RSAPublicKeySpec(new BigInteger(
		"12345678", 16), new BigInteger("11", 16));
	RSAPrivateKeySpec privKeySpec = new RSAPrivateKeySpec(new BigInteger(
		"12345678", 16), new BigInteger("12345678",
		16));

	RSAPublicKey pubKey = (RSAPublicKey) keyFactory.generatePublic(pubKeySpec);
	RSAPrivateKey privKey = (RSAPrivateKey) keyFactory.generatePrivate(privKeySpec);

	cipher.init(Cipher.ENCRYPT_MODE, pubKey);

	byte[] cipherText = cipher.doFinal(input);
	System.out.println("cipher: " + new String(cipherText));

	cipher.init(Cipher.DECRYPT_MODE, privKey);
	byte[] plainText = cipher.doFinal(cipherText);
	System.out.println("plain : " + new String(plainText));
  }*/
// This method returns all available services types
public static String[] getServiceTypes() {
	Set result = new HashSet();

	// All all providers
	Provider[] providers = Security.getProviders();
	for (int i=0; i<providers.length; i++) {
		// Get services provided by each provider
		Set keys = providers[i].keySet();
		for (Iterator it=keys.iterator(); it.hasNext(); ) {
			String key = (String)it.next();
			key = key.split(" ")[0];

			if (key.startsWith("Alg.Alias.")) {
				// Strip the alias
				key = key.substring(10);
			}
			int ix = key.indexOf('.');
			result.add(key.substring(0, ix));
		}
	}
	return (String[])result.toArray(new String[result.size()]);
}

// This method returns the available implementations for a service type
public static String[] getCryptoImpls(String serviceType) {
	Set result = new HashSet();

	// All all providers
	Provider[] providers = Security.getProviders();
	for (int i=0; i<providers.length; i++) {
		// Get services provided by each provider
		Set keys = providers[i].keySet();
		for (Iterator it=keys.iterator(); it.hasNext(); ) {
			String key = (String)it.next();
			key = key.split(" ")[0];

			if (key.startsWith(serviceType+".")) {
				result.add(key.substring(serviceType.length()+1));
			} else if (key.startsWith("Alg.Alias."+serviceType+".")) {
				// This is an alias
				result.add(key.substring(serviceType.length()+11));
			}
		}
	}
	return (String[])result.toArray(new String[result.size()]);
}


	public static void main(String[] args) throws Exception {
	  KeyPairGenerator kpg = KeyPairGenerator.getInstance("DSA");
	  kpg.initialize(1024);
	  KeyPair keyPair = kpg.genKeyPair();
	  byte[] data = "test".getBytes("UTF8");
	  Signature sig = Signature.getInstance("SHAwithDSA");
	  sig.initSign(keyPair.getPrivate());
	  sig.update(data);
	  byte[] signatureBytes = sig.sign();
	  System.out.println("Singature:" + new BASE64Encoder().encode(signatureBytes));
	  sig.initVerify(keyPair.getPublic());
	  sig.update(data);
	  System.out.println(sig.verify(signatureBytes));
	  String[] names = getCryptoImpls("Signature");

	}

} 

