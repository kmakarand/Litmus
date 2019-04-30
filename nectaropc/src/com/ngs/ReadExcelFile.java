package com.ngs;

import java.io.*;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;

import org.apache.poi.hssf.model.Sheet;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class ReadExcelFile {
	
	public static String checkDataTypeHSSFCell(HSSFCell cell)
	{
		boolean flag=false;
		int intCellValue=0;String strCellValue="";
		
		if(cell.getCellType() == cell.CELL_TYPE_NUMERIC) { 
		intCellValue = (int)cell.getNumericCellValue(); 
		strCellValue = String.valueOf(intCellValue); 
		} else { 
		strCellValue = cell.toString(); 
		}
		return strCellValue;
	}
	public static String checkDataTypeXSSFCell(XSSFCell cell)
	{
		boolean flag=false;
		int intCellValue=0;String strCellValue="";
		
		if(cell.getCellType() == cell.CELL_TYPE_NUMERIC) { 
		intCellValue = (int)cell.getNumericCellValue(); 
		strCellValue = String.valueOf(intCellValue); 
		} else { 
		strCellValue = cell.toString(); 
		}
		return strCellValue;
	}
	
	public static void main(String[] args) {
		
		String filepath="E:\\Nectar\\nectaropc\\WebContent\\admin\\";
		String filename="Aptitude-2019.sql";
		String fileList="Aptitude-2019.xlsx";
		String datasheetname="Aptitude";
		String varExamID="10529";
		int queNumber=1;
		
		////System.out.println("loadExcelData :"+readXLS(filepath,filename,fileList,varExamID,queNumber,datasheetname));
		System.out.println("loadExcelData :"+readXLSX(filepath,filename,fileList,varExamID,queNumber,datasheetname));
	}
	
	public static boolean readXLS(String filepath,String filename,String fileList,String varExamID,int queNumber,String datasheetname)
	{
		boolean checkflag =false;
		try {
			
			//System.out.println("UPLOAD :"+filepath+"\\upload\\"+fileList);
	        //System.out.println("DOWNLOAD :"+filepath+"\\download\\"+filename);
			
			FileInputStream fileInputStream = new FileInputStream(filepath+"\\upload\\"+fileList);
			
			FileWriter writer = new FileWriter(filepath+"\\download\\"+filename);
			BufferedWriter buffer = new BufferedWriter(writer); 
			HSSFWorkbook my_xls_workbook = new HSSFWorkbook(fileInputStream); //Read the Excel Workbook in a instance object    
            HSSFSheet worksheet = my_xls_workbook.getSheet(datasheetname); //This will read the sheet for us into another object
			
			int PartyID=6,ExamType=1,NoOfOptions=0,Answer=0,NewAnswer=0,LevelID=1,ExamID=0,Marks=1,Image=0,Status=2,ResonableTime=127,count=0;
			String Question="",Option1="",Option2="",Option3="",Option4="",Option5="",Explanation="NA",RRN="NA",QuestionID="",CodeID="01000000";
		 	String InsertionDate=null;int rowcount=0;
		 	String UpdateValidityDate=null;Timestamp tm=null;HashMap hm = new HashMap();
		 	String hedQuestion="",hedOption1="",hedOption2="",hedOption3="",hedOption4="",hedOption5="",hedAnswer="",hedNoOfOptions="";
		 	Date fdate = new Date();
	        SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        InsertionDate=UpdateValidityDate=sdfDest.format(fdate);
	        String a1Val="",c1Val="",d1Val="",e1Val="",f1Val="",g1Val="";
	        String b1Val="",h1Val="";
	        //System.out.println("InsertionDate:"+InsertionDate);
	        //System.out.println("UpdateValidityDate:"+UpdateValidityDate);
	        //System.out.println("queNumber :"+queNumber);
		 	
		 	// add an iterator for every row and column
	        Iterator rows = worksheet.rowIterator(); 
	        //System.out.println("Row Num:"+worksheet.getLastRowNum());
	        int noofrows=0;
	        //queNumber = queNumber + rowcount;
	        int totrowcnt = worksheet.getLastRowNum();
	        //System.out.println("totrowcnt:"+totrowcnt);
	       
	        for(rowcount=0;rowcount<=worksheet.getLastRowNum();rowcount++) {
	        	
		        	HSSFRow row1 = (HSSFRow) worksheet.getRow(rowcount);
		        	
		        	if(rowcount<1){
		        	
		        	HSSFCell cellR1A1 = row1.getCell((short) 0);
					a1Val = checkDataTypeHSSFCell(cellR1A1);
					HSSFCell cellR1B1 = row1.getCell((short) 1);
					b1Val = checkDataTypeHSSFCell(cellR1B1);
					HSSFCell cellR1C1 = row1.getCell((short) 2);
					c1Val = checkDataTypeHSSFCell(cellR1C1);
					HSSFCell cellR1D1 = row1.getCell((short) 3);
					d1Val = checkDataTypeHSSFCell(cellR1D1);
					HSSFCell cellR1E1 = row1.getCell((short) 4);
					e1Val = checkDataTypeHSSFCell(cellR1E1);
					HSSFCell cellR1F1 = row1.getCell((short) 5);
					f1Val = checkDataTypeHSSFCell(cellR1F1);
					HSSFCell cellR1G1 = row1.getCell((short) 6);
					g1Val = checkDataTypeHSSFCell(cellR1G1);
					HSSFCell cellR1H1 = row1.getCell((short) 7);
					h1Val = checkDataTypeHSSFCell(cellR1H1);
					/*HSSFCell cellC1 = row1.getCell((short) 2);
					boolean c1Val = cellC1.getBooleanCellValue();
					HSSFCell cellD1 = row1.getCell((short) 3);
					Date d1Val = cellD1.getDateCellValue();*/
					
					hedQuestion=a1Val;
					hedNoOfOptions=b1Val;
					hedOption1=c1Val;
					hedOption2=d1Val;
					hedOption3=e1Val;
					hedOption4=f1Val;
					hedOption5=g1Val;
					hedAnswer=h1Val;
					//NewAnswer=Answer;
					/*//System.out.println("Header Question :"+hedQuestion);
				  	//System.out.println("Header NoOfOptions :"+hedNoOfOptions);
				  	//System.out.println("Header Option1 :"+hedOption1);
				  	//System.out.println("Header Option2 :"+hedOption2);
				  	//System.out.println("Header Option3 :"+hedOption3);
				  	//System.out.println("Header Option4 :"+hedOption4);
				  	//System.out.println("Header Option5 :"+hedOption5);
				  	//System.out.println("Header Answer :"+hedAnswer);*/
	        	}
	        	else
	        	{
	        		HSSFCell cellR1A1 = row1.getCell((short) 0);
					a1Val = checkDataTypeHSSFCell(cellR1A1);
					HSSFCell cellR1B1 = row1.getCell((short) 1);
					int ib1Val = (int) cellR1B1.getNumericCellValue();
					HSSFCell cellR1C1 = row1.getCell((short) 2);
					c1Val = checkDataTypeHSSFCell(cellR1C1);
					HSSFCell cellR1D1 = row1.getCell((short) 3);
					d1Val = checkDataTypeHSSFCell(cellR1D1);
					HSSFCell cellR1E1 = row1.getCell((short) 4);
					e1Val = checkDataTypeHSSFCell(cellR1E1);
					HSSFCell cellR1F1 = row1.getCell((short) 5);
					f1Val = checkDataTypeHSSFCell(cellR1F1);
					HSSFCell cellR1G1 = row1.getCell((short) 6);
					g1Val = checkDataTypeHSSFCell(cellR1G1);
					HSSFCell cellR1H1 = row1.getCell((short) 7);
					int ih1Val = (int) cellR1H1.getNumericCellValue();
					
					Question=a1Val;
					NoOfOptions=ib1Val;
					Option1=c1Val;
					Option2=d1Val;
					Option3=e1Val;
					Option4=f1Val;
					Option5=g1Val;
					Answer=ih1Val;
					Question=Question.replace("'", "\\'");
					NoOfOptions=Integer.parseInt((String.valueOf(NoOfOptions)).replace("'", "\\'"));
					Option1=Option1.replace("'", "\\'");
					Option2=Option2.replace("'", "\\'");
					Option3=Option3.replace("'", "\\'");
					Option4=Option4.replace("'", "\\'");
					Option5=Option5.replace("'", "\\'");
					Answer=Integer.parseInt((String.valueOf(Answer)).replace("'", "\\'"));
					NewAnswer=Answer;
					
					//System.out.println("Question :"+Question);
				  	//System.out.println("NoOfOptions:"+NoOfOptions);
				  	//System.out.println("Option1:"+Option1);
				  	//System.out.println("Option2:"+Option2);
				  	//System.out.println("Option3:"+Option3);
				  	//System.out.println("Option4 :"+Option4);
				  	//System.out.println("Option5:"+Option5);
				  	//System.out.println("Answer :"+Answer);
					
					String data=("INSERT INTO QuestionMaster(QuestionID,CodeID,PartyID,Question,ExamType,NoOfOptions,Option1," +
		  					"Option2,Option3,Option4,Option5,Answer,NewAnswer,Explanation,LevelID,ExamID,InsertionDate," +
		  					"UpdateValidityDate,Status,Image,ResonableTime,Marks,RRN)");
		  			
		  			if(queNumber>1000)
		  			QuestionID = String.valueOf(queNumber);
		  			else
					QuestionID = varExamID+queNumber;
		  			
		  			//System.out.println("QuestionID :"+QuestionID);
		  			

		  		 	String value=(" VALUES ('"+QuestionID+"','"+CodeID+"',"+PartyID+",'"+Question+"','"+ExamType+"',"+NoOfOptions+","+
		  				   "'"+Option1+"','"+Option2+"','"+Option3+"','"+Option4+"','"+Option5+"',"+Answer+","+NewAnswer+"," +
		  					"'"+Explanation+"','"+LevelID+"','"+varExamID+"','"+InsertionDate+"','"+UpdateValidityDate+"'," +
		  					""+Status+","+Image+","+ResonableTime+","+Marks+",'"+RRN+"');");
		  		 	
		  		 	
				  	//System.out.println("NewAnswer :"+NewAnswer);
					//System.out.println(data+value);
					//System.out.println("Number of Rows: " + rowcount);
		  		 	  
				    String sqlData = data+value;
				    
				    if(sqlData.contains("img"))
				    //System.out.println("String Contains img: " + sqlData);
				    
				    if(rowcount<totrowcnt)
				    buffer.write(sqlData+"\n");  
				    else
				    buffer.write(sqlData); 
				    						
				    queNumber++;
					checkflag=true;
	        	  }
				
		        	
		       }
	        	
	        	buffer.close(); 
			    //System.out.println("Success"); 
	        	//System.out.println("Number of Rows: " + rowcount);
	        	
	        	
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return checkflag;
	}
	
	public static boolean readXLSX(String filepath,String filename,String fileList,String varExamID,int queNumber,String datasheetname)
	{
		boolean checkflag =false;
		try {
			
			//System.out.println("UPLOAD :"+filepath+"\\upload\\"+fileList);
	        //System.out.println("DOWNLOAD :"+filepath+"\\download\\"+filename);
			
			FileInputStream fileInputStream = new FileInputStream(filepath+"\\upload\\"+fileList);
			FileWriter writer = new FileWriter(filepath+"\\download\\"+filename);
			BufferedWriter buffer = new BufferedWriter(writer); 
			
		    XSSFWorkbook my_xlsx_workbook = new XSSFWorkbook(fileInputStream); //Read the Excel Workbook in a instance object    
            XSSFSheet worksheet = my_xlsx_workbook.getSheet(datasheetname); //This wil
			
			int PartyID=6,ExamType=1,NoOfOptions=0,Answer=0,NewAnswer=0,LevelID=1,ExamID=0,Marks=1,Image=0,Status=2,ResonableTime=127,count=0;
			String Question="",Option1="",Option2="",Option3="",Option4="",Option5="",Explanation="NA",RRN="NA",QuestionID="",CodeID="01000000";
		 	String InsertionDate=null;int rowcount=0;
		 	String UpdateValidityDate=null;Timestamp tm=null;HashMap hm = new HashMap();
		 	String hedQuestion="",hedOption1="",hedOption2="",hedOption3="",hedOption4="",hedOption5="",hedAnswer="",hedNoOfOptions="";
		 	Date fdate = new Date();
	        SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        InsertionDate=UpdateValidityDate=sdfDest.format(fdate);
	        String a1Val="",c1Val="",d1Val="",e1Val="",f1Val="",g1Val="";
	        String b1Val="",h1Val="";
	        String sqlData="";int cnt=0;
	        //System.out.println("InsertionDate:"+InsertionDate);
	        //System.out.println("UpdateValidityDate:"+UpdateValidityDate);
	        //System.out.println("queNumber :"+queNumber);
		 	
		 	// add an iterator for every row and column
	        Iterator rows = worksheet.rowIterator(); 
	        //System.out.println("Row Num:"+worksheet.getLastRowNum());
	        int noofrows=0;
	        //queNumber = queNumber + rowcount;
	        int totrowcnt = worksheet.getLastRowNum();
	        //System.out.println("totrowcnt:"+totrowcnt);
	       
	        for(rowcount=0;rowcount<=worksheet.getLastRowNum();rowcount++) {
	        	
	        		XSSFRow row1 = (XSSFRow) worksheet.getRow(rowcount);
		        	
		        	if(rowcount<1){
		        	
		        	XSSFCell cellR1A1 = row1.getCell((short) 0);
					a1Val = checkDataTypeXSSFCell(cellR1A1);
					XSSFCell cellR1B1 = row1.getCell((short) 1);
					b1Val = checkDataTypeXSSFCell(cellR1B1);
					XSSFCell cellR1C1 = row1.getCell((short) 2);
					c1Val = checkDataTypeXSSFCell(cellR1C1);
					XSSFCell cellR1D1 = row1.getCell((short) 3);
					d1Val = checkDataTypeXSSFCell(cellR1D1);
					XSSFCell cellR1E1 = row1.getCell((short) 4);
					e1Val = checkDataTypeXSSFCell(cellR1E1);
					XSSFCell cellR1F1 = row1.getCell((short) 5);
					f1Val = checkDataTypeXSSFCell(cellR1F1);
					XSSFCell cellR1G1 = row1.getCell((short) 6);
					g1Val = checkDataTypeXSSFCell(cellR1G1);
					XSSFCell cellR1H1 = row1.getCell((short) 7);
					h1Val = checkDataTypeXSSFCell(cellR1H1);
					/*XSSFCell cellC1 = row1.getCell((short) 2);
					boolean c1Val = cellC1.getBooleanCellValue();
					XSSFCell cellD1 = row1.getCell((short) 3);
					Date d1Val = cellD1.getDateCellValue();*/
					
					hedQuestion=a1Val;
					hedNoOfOptions=b1Val;
					hedOption1=c1Val;
					hedOption2=d1Val;
					hedOption3=e1Val;
					hedOption4=f1Val;
					hedOption5=g1Val;
					hedAnswer=h1Val;
					//NewAnswer=Answer;
					/*//System.out.println("Header Question :"+hedQuestion);
				  	//System.out.println("Header NoOfOptions :"+hedNoOfOptions);
				  	//System.out.println("Header Option1 :"+hedOption1);
				  	//System.out.println("Header Option2 :"+hedOption2);
				  	//System.out.println("Header Option3 :"+hedOption3);
				  	//System.out.println("Header Option4 :"+hedOption4);
				  	//System.out.println("Header Option5 :"+hedOption5);
				  	//System.out.println("Header Answer :"+hedAnswer);*/
	        	}
	        	else
	        	{
	        		XSSFCell cellR1A1 = row1.getCell((short) 0);
					a1Val = checkDataTypeXSSFCell(cellR1A1);
					XSSFCell cellR1B1 = row1.getCell((short) 1);
					int ib1Val = (int) cellR1B1.getNumericCellValue();
					XSSFCell cellR1C1 = row1.getCell((short) 2);
					c1Val = checkDataTypeXSSFCell(cellR1C1);
					XSSFCell cellR1D1 = row1.getCell((short) 3);
					d1Val = checkDataTypeXSSFCell(cellR1D1);
					XSSFCell cellR1E1 = row1.getCell((short) 4);
					e1Val = checkDataTypeXSSFCell(cellR1E1);
					XSSFCell cellR1F1 = row1.getCell((short) 5);
					f1Val = checkDataTypeXSSFCell(cellR1F1);
					XSSFCell cellR1G1 = row1.getCell((short) 6);
					g1Val = checkDataTypeXSSFCell(cellR1G1);
					XSSFCell cellR1H1 = row1.getCell((short) 7);
					int ih1Val = (int) cellR1H1.getNumericCellValue();
					
					Question=a1Val;
					NoOfOptions=ib1Val;
					Option1=c1Val;
					Option2=d1Val;
					Option3=e1Val;
					Option4=f1Val;
					Option5=g1Val;
					Answer=ih1Val;
					Question=Question.replace("'", "\\'");
					NoOfOptions=Integer.parseInt((String.valueOf(NoOfOptions)).replace("'", "\\'"));
					Option1=Option1.replace("'", "\\'");
					Option2=Option2.replace("'", "\\'");
					Option3=Option3.replace("'", "\\'");
					Option4=Option4.replace("'", "\\'");
					Option5=Option5.replace("'", "\\'");
					Answer=Integer.parseInt((String.valueOf(Answer)).replace("'", "\\'"));
					NewAnswer=Answer;
					
					//System.out.println("Question :"+Question);
				  	//System.out.println("NoOfOptions:"+NoOfOptions);
				  	//System.out.println("Option1:"+Option1);
				  	//System.out.println("Option2:"+Option2);
				  	//System.out.println("Option3:"+Option3);
				  	//System.out.println("Option4 :"+Option4);
				  	//System.out.println("Option5:"+Option5);
				  	//System.out.println("Answer :"+Answer);
					
					String data=("INSERT INTO QuestionMaster(QuestionID,CodeID,PartyID,Question,ExamType,NoOfOptions,Option1," +
		  					"Option2,Option3,Option4,Option5,Answer,NewAnswer,Explanation,LevelID,ExamID,InsertionDate," +
		  					"UpdateValidityDate,Status,Image,ResonableTime,Marks,RRN)");
		  			
		  			if(queNumber>1000)
		  			QuestionID = String.valueOf(queNumber);
		  			else
					QuestionID = varExamID+queNumber;
		  			
		  			//System.out.println("QuestionID :"+QuestionID);
		  			

		  		 	String value=(" VALUES ('"+QuestionID+"','"+CodeID+"',"+PartyID+",'"+Question+"','"+ExamType+"',"+NoOfOptions+","+
		  				   "'"+Option1+"','"+Option2+"','"+Option3+"','"+Option4+"','"+Option5+"',"+Answer+","+NewAnswer+"," +
		  					"'"+Explanation+"','"+LevelID+"','"+varExamID+"','"+InsertionDate+"','"+UpdateValidityDate+"'," +
		  					""+Status+","+Image+","+ResonableTime+","+Marks+",'"+RRN+"');");
		  		 	
		  		 	
				  	//System.out.println("NewAnswer :"+NewAnswer);
					System.out.println(data+value);
					//System.out.println("Number of Rows: " + rowcount);
		  		 	  
				     
					sqlData = data+value;
				    
				    if(sqlData.contains("img"))
				    {
				    System.out.println("String Contains img: " + sqlData);
				    //cnt++;
				    }
				    //System.out.println("String Contains cnt: " + cnt);
				    
				    if(rowcount<totrowcnt)
				    buffer.write(sqlData+"\n");  
				    else
				    buffer.write(sqlData); 
				    						
				    queNumber++;
					checkflag=true;
	        	  }
				
		        	
		       }
	        	
	        	buffer.close(); 
			    //System.out.println("Success"); 
	        	//System.out.println("Number of Rows: " + rowcount);
	        	
	        	
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return checkflag;
	}
}