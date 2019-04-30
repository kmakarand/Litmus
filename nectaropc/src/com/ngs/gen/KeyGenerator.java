package com.ngs.gen;

import java.io.IOException;

public class KeyGenerator 
{
	private static final int DEFAULT_KEY_SIZE = 4;
	private static String str = "abcdefghijkmnpqrstuvwxyz23456789ABCDEFGHIJKLMNPQRSTUVWXYZ";
	// 0 (Zero), 1 (One), l (small L), o (small O), O are removed to avoid confusion for user.
	
	public KeyGenerator()
	{
		System.out.println("Key : " + GenerateKey());
		System.out.println("Username: " + GenerateString(" HiT  esh ", 5, 5) );
		System.out.println("Password: " + GenerateString("Dave", 5, 5) );
	}
	
	public KeyGenerator(int size)
	{
		System.out.println("Key : " + GenerateKey(size));
	}

	public static void main(String[] args) 
	{
		System.out.println("\n*************************************************************************");
		System.out.println("*\t\t\t\t\t\t\t\t\t*");
		System.out.println("*\tRandom Key Generator\t\t\t\t\t\t*");
		System.out.println("*\t\t\t\t\t\t\t\t\t*");
		System.out.println("*\tDeveloped By:\tHitesh Dave\t\t\t\t\t*");
		System.out.println("*\tE-mail:\t\thiteshdave99@yahoo.com\t\t\t\t*");
		System.out.println("*\tCompany:\tZee Interactive Learning Systems Limited\t*");
		System.out.println("*\t\t\t\t\t\t\t\t\t*");
		System.out.println("*************************************************************************\n");

		if (args.length <= 0)
		{
			System.out.println("Size of Key is not specified. Using Default size.");
			KeyGenerator keys = new KeyGenerator();
			System.out.println("\nUSAGE: java KeyGenerator [SizeOfKey]");
		}
		else
		{
			int val = new Integer(args[0]).intValue();
			KeyGenerator keys = new KeyGenerator(val);
		}
	}

	public static String GenerateKey()
	{
		return GenerateKey(DEFAULT_KEY_SIZE);
	}

	public static String GenerateKey(int size)
	{
		String key = null;

		key = GenerateKey(str, size);

		return key.toString();
	}

	public static String GenerateKey(String validCharsString, int size)
	{
		int i = 0, strIndex = 0;
		StringBuffer key = new StringBuffer(size);

		for (i = 0; i < size; i++)
		{
			strIndex = (int) ( Math.random() * (validCharsString.length() - 1) + 1);
			key.append(validCharsString.charAt( strIndex ));
		}

		return key.toString();
	}

	public static String GenerateString(String srcString, int charsFromSourceString, int extraChars)
	{
		String validChars = "abcdefghijkmnpqrstuvwxyz23456789";

		String destString = "";
		StringBuffer fn = new StringBuffer();
		char spaceChar = ' ', strChar;

		srcString = srcString.trim();
		srcString = srcString.toLowerCase();

		for (int i=0; i < srcString.length() ; i++)
		{
			strChar = srcString.charAt(i);

			if (strChar == spaceChar)
				continue;
			fn.append(strChar);
		}

		srcString = fn.toString();

		if (srcString.length() < charsFromSourceString)
		{
			charsFromSourceString = srcString.length();
		}

		destString = destString.concat(srcString.substring(0, charsFromSourceString));
		destString = destString.concat(GenerateKey(validChars, extraChars));

		return destString;
	}
}