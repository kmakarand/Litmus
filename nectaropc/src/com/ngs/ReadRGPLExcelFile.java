package com.ngs;

import java.io.BufferedWriter;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
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

public class ReadRGPLExcelFile {
	
	public static String checkDataType(HSSFCell cell)
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
		
		String filepath="C:\\Tomcat6\\webapps\\nectar\\admin\\";
		String filename="RGPL_StockList.xls";
		String fileList="RGPL_StockList.xls";
		System.out.println("loadExcelData :"+loadExcelData(filepath,filename,fileList));
	}
	
	public static boolean loadExcelData(String filepath,String filename,String fileList)
	{
		
		boolean checkflag =false;
		try {
			BufferedWriter bw = new BufferedWriter(new FileWriter(filepath+"download\\"+fileList));
			FileInputStream fileInputStream = new FileInputStream(filepath+"upload\\"+fileList);
			//BufferedWriter bw = new BufferedWriter(new FileWriter(filepath+"download\\"+filename));
			//FileInputStream fileInputStream = new FileInputStream("C:\\Tomcat6\\webapps\\nectar\\admin\\upload\\RGPL_StockList.xls");
			HSSFWorkbook workbook = new HSSFWorkbook(fileInputStream);
			HSSFSheet worksheet = workbook.getSheet("RGMO");
			int PartyID=6,ExamType=1,NoOfOptions=0,Answer=0,NewAnswer=0,LevelID=1,ExamID=0,Marks=1,Image=0,Status=2,ResonableTime=127,count=0;
			String Question="",Option1="",Option2="",Option3="",Option4="",Option5="",Explanation="NA",RRN="NA",QuestionID="",CodeID="01000000";
		 	String InsertionDate=null;int rowcount=0;
		 	String UpdateValidityDate=null;Timestamp tm=null;HashMap hm = new HashMap();
		 	String hedQuestion="",hedOption1="",hedOption2="",hedOption3="",hedOption4="",hedOption5="",hedAnswer="",hedNoOfOptions="";
		 	String SRNO="",MATERIAL="",SIZE="";
		 	int QTY=0,KGSqmRM=0,Unitprice=0,TotalPrice=0;
		 	Date fdate = new Date();
	        SimpleDateFormat sdfDest =new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	        InsertionDate=UpdateValidityDate=sdfDest.format(fdate);
	        String a1Val="",c1Val="",d1Val="",e1Val="",f1Val="",g1Val="";
	        String b1Val="",h1Val="";
	        //System.out.println("InsertionDate:"+InsertionDate);
	        //System.out.println("UpdateValidityDate:"+UpdateValidityDate);
		 	
		 	// add an iterator for every row and column
	        Iterator rows = worksheet.rowIterator(); 
	        System.out.println("Row Num:"+worksheet.getLastRowNum());
	        int noofrows=0;
	        //queNumber = queNumber + rowcount;
	       
	        for(rowcount=0;rowcount<worksheet.getLastRowNum()+1;rowcount++) {
	        	
		        	HSSFRow row1 = (HSSFRow) worksheet.getRow(rowcount);
		        	

		        	if(rowcount<1){
		        	
		        	HSSFCell cellR1A1 = row1.getCell((short) 0);
					a1Val = checkDataType(cellR1A1);
					HSSFCell cellR1B1 = row1.getCell((short) 1);
					b1Val = checkDataType(cellR1B1);
					HSSFCell cellR1C1 = row1.getCell((short) 2);
					c1Val = checkDataType(cellR1C1);
					HSSFCell cellR1D1 = row1.getCell((short) 3);
					d1Val = checkDataType(cellR1D1);
					HSSFCell cellR1E1 = row1.getCell((short) 4);
					e1Val = checkDataType(cellR1E1);
					HSSFCell cellR1F1 = row1.getCell((short) 5);
					f1Val = checkDataType(cellR1F1);
					HSSFCell cellR1G1 = row1.getCell((short) 6);
					g1Val = checkDataType(cellR1G1);
					HSSFCell cellR1H1 = row1.getCell((short) 7);
					h1Val = checkDataType(cellR1H1);
					/*HSSFCell cellC1 = row1.getCell((short) 2);
					boolean c1Val = cellC1.getBooleanCellValue();
					HSSFCell cellD1 = row1.getCell((short) 3);
					Date d1Val = cellD1.getDateCellValue();*/
					
					hedQuestion=a1Val;
					/*hedNoOfOptions=b1Val;
					hedOption1=c1Val;
					hedOption2=d1Val;
					hedOption3=e1Val;
					hedOption4=f1Val;
					hedOption5=g1Val;
					hedAnswer=h1Val;*/
					//NewAnswer=Answer;
					System.out.println("Header Question :"+hedQuestion);
				  	/*System.out.println("Header NoOfOptions :"+hedNoOfOptions);
				  	System.out.println("Header Option1 :"+hedOption1);
				  	System.out.println("Header Option2 :"+hedOption2);
				  	System.out.println("Header Option3 :"+hedOption3);
				  	System.out.println("Header Option4 :"+hedOption4);
				  	System.out.println("Header Option5 :"+hedOption5);
				  	System.out.println("Header Answer :"+hedAnswer);*/
	        	}
	        	else
	        	{
	        		/*HSSFCell cellR1A1 = row1.getCell((short) 0);
					a1Val = checkDataType(cellR1A1);
					HSSFCell cellR1B1 = row1.getCell((short) 1);
					int ib1Val = (int) cellR1B1.getNumericCellValue();
					HSSFCell cellR1C1 = row1.getCell((short) 2);
					c1Val = checkDataType(cellR1C1);
					HSSFCell cellR1D1 = row1.getCell((short) 3);
					d1Val = checkDataType(cellR1D1);
					HSSFCell cellR1E1 = row1.getCell((short) 4);
					e1Val = checkDataType(cellR1E1);
					HSSFCell cellR1F1 = row1.getCell((short) 5);
					f1Val = checkDataType(cellR1F1);
					HSSFCell cellR1G1 = row1.getCell((short) 6);
					g1Val = checkDataType(cellR1G1);
					HSSFCell cellR1H1 = row1.getCell((short) 7);
					int ih1Val = (int) cellR1B1.getNumericCellValue();
					
					Question=a1Val;
					NoOfOptions=ib1Val;
					Option1=c1Val;
					Option2=d1Val;
					Option3=e1Val;
					Option4=f1Val;
					Option5=g1Val;
					Answer=ih1Val;
					NewAnswer=Answer;
					
					String data=("INSERT INTO QuestionMaster(QuestionID,CodeID,PartyID,Question,ExamType,NoOfOptions,Option1," +
		  					"Option2,Option3,Option4,Option5,Answer,NewAnswer,Explanation,LevelID,ExamID,InsertionDate," +
		  					"UpdateValidityDate,Status,Image,ResonableTime,Marks,RRN)");
		  			
		  			if(queNumber>100)
		  			QuestionID = String.valueOf(queNumber);
		  			else
					QuestionID = varExamID+queNumber;

		  		 	String value=(" VALUES ('"+QuestionID+"','"+CodeID+"',"+PartyID+",'"+Question+"','"+ExamType+"',"+NoOfOptions+","+
		  				   "'"+Option1+"','"+Option2+"','"+Option3+"','"+Option4+"','"+Option5+"',"+Answer+","+NewAnswer+"," +
		  					"'"+Explanation+"','"+LevelID+"','"+varExamID+"','"+InsertionDate+"','"+UpdateValidityDate+"'," +
		  					""+Status+","+Image+","+ResonableTime+","+Marks+",'"+RRN+"');");
		  		 	
		  		 	
				  	//System.out.println("NewAnswer :"+NewAnswer);
					System.out.println(data+value);
					bw.write(data+value+"\n");
					queNumber++;
					checkflag=true;*/
	        	  }
				
				}
	        	System.out.println("Number of Rows: " + rowcount);
	        	bw.close();
			
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return checkflag;
	}
}