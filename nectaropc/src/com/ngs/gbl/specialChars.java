package com.ngs.gbl;

import java.lang.*;


public class specialChars{
	
	String invals1="";
	
	public specialChars(){
	
	}

	public String check(String invals)
	{
		char xxx = '\'';
         char xx1 ='\\';
         char xx2 ='\"';          
         int vallen=invals.length();     
         for(int h=0;h<vallen;h++){
          if(invals.charAt(h) == xxx){
           invals1=invals.substring(0,h)+ "\\'" + invals.substring(h+1,invals.length());    
           h +=1;
           invals = invals1;
           }
          else if(invals.charAt(h) == xx1){       
           invals1=invals.substring(0,h) + xx1 + xx1 + invals.substring(h+1,invals.length()); 
           h += 5;
           invals = invals1;      
           }
          else if(invals.charAt(h) == xx2){
           invals1=invals.substring(0,h) + "\\\"" + invals.substring(h+1,invals.length()); 
           h +=1;
           invals = invals1;   
           }
		  
		 } return invals; 
	
     }
}
