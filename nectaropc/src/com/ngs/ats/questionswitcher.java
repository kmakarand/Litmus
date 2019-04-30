

package com.ngs.ats;

public class questionswitcher 
{
	public questionswitcher(){}
	
	
	public String select(String value)
	{
		String pinjo=null;
		if(value.equals("1")){pinjo= new String("Multiple Options");}
			else if(value.equals("2")){pinjo= new String("Fill in the Blanks");}
				else if(value.equals("3")){pinjo= new String("Match the Column");}
						else if(value.equals("4")){pinjo= new String("True/False");}
							else if(value.equals("5")){pinjo= new String("Useless");}
		return(pinjo);
		
	}
}
