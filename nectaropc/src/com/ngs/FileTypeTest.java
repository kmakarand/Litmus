package com.ngs;

import org.apache.commons.io.FilenameUtils;

public class FileTypeTest {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		String filename="D:\\Nectar\\nectaropc\\WebContent\\admin\\upload\\Insurance.xlsx";
		System.out.println("Filetype :"+FilenameUtils.getExtension(filename));

	}

}
