package com.ngs;

import java.io.FileInputStream;
import java.io.*;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.ss.usermodel.*;
import java.util.Iterator;
public class readxls {  
        public static void main(String[] args) throws Exception{
                FileInputStream input_document = new FileInputStream(new File("D:\\Nectar\\nectaropc\\WebContent\\admin\\upload\\Insurance.xls")); //Read XLS document - Office 97 -2003 format     
                HSSFWorkbook my_xls_workbook = new HSSFWorkbook(input_document); //Read the Excel Workbook in a instance object    
                HSSFSheet my_worksheet = my_xls_workbook.getSheetAt(0); //This will read the sheet for us into another object
                Iterator<Row> rowIterator = my_worksheet.iterator(); // Create iterator object
                while(rowIterator.hasNext()) {
                        Row row = rowIterator.next(); //Read Rows from Excel document       
                        Iterator<Cell> cellIterator = row.cellIterator();//Read every column for every row that is READ
                                while(cellIterator.hasNext()) {
                                        Cell cell = cellIterator.next(); //Fetch CELL
                                        switch(cell.getCellType()) { //Identify CELL type
                                        case Cell.CELL_TYPE_NUMERIC:
                                                System.out.print(cell.getNumericCellValue() + "\t\t"); //print numeric value
                                                break;
                                        case Cell.CELL_TYPE_STRING:
                                                System.out.print(cell.getStringCellValue() + "\t\t"); //print string value
                                                break;
                                        }
                                }
                System.out.println(""); // To iterate over to the next row
                }
                input_document.close(); //Close the XLS file opened for printing
        }
}