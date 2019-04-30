
/* This code is prepared by Pinjo for the purpose of implementing the project at*/
/*Nectar Global Services*/
/*Any changes in the codes should be made in prior consultation with the company or myself
The code has been published as an opensource project and can be used as a component by
another user ---------    Support the open source drive*/

package com.ngs.gblser;
import java .io.*;


public class security 
{
	StringBuffer sbf;
	String sbf1;

		public void security()
				{
				}

		public String setString(String str) throws IOException{
		
				 
					 String quesc = new String(str); 
					 StringBufferInputStream sbis = new StringBufferInputStream(quesc); 
					 sbf= new StringBuffer(); 
					 int number = sbis.available();
					 
					 for (int i=0;i<number;i++)
                         {
						char b =(char)sbis.read();
						
 if ((b >= 'a' && b <= 'z') || (b >= 'A' && b <= 'Z') || (b =='\n') || (b == '\t') ||  (b >= '0' && b <= '9') || (b=='+') || (b=='-') || (b=='*') || (b=='/') || (b=='(')|| (b==')') || (b=='=')|| (b==',')|| (b=='$')|| (b=='^')|| (b=='"')|| (b==';')|| (b==':')|| (b=='.')|| (b=='<')|| (b=='>')|| (b=='?')||(b=='_')||(b=='[')||(b==']')||(b=='{')||(b=='}')||(b=='@')||(b=='#')||(b=='*')||(b=='!')||(b=='~')||(b=='`')||(b=='%')||(b=='|')){
	  sbf= (StringBuffer) sbf.append(b);
	 
				}else if(b==' '){
				sbf= (StringBuffer) sbf.append(' ');
				}else
					{	
			 sbf= (StringBuffer) sbf.append("<font face='symbol'>");
			 sbf= (StringBuffer) sbf.append(b);
			 sbf= (StringBuffer) sbf.append("</font>");
					} 
  }	
					 sbf1= new String(sbf);
				return sbf1;
				
				}//	end of setString




		public String getString(){
		

		return sbf1;
		
		}



}
