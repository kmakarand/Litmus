

package com.ngs.gbl;


public class RandomGenerator extends java.util.Random
{
   int value;
    int rows;
    int n=0;
 
   public RandomGenerator()
   {}

   public void setRows(int i)
    {
      n=i;//rows=10;
    }

	public int getRows()
    {
		return rows;
    }


    

	public int createVal()
	{
        
     
		 if (n<=0)
			throw new IllegalArgumentException("n must be positive");
		 if ((n & -n) == n)  // i.e., n is a power of 2
		      return (int)((n * (long)next(31)) >> 31);
			  int bits, val;
		 do {
			   bits = next(31);
  			   val = bits % n;
  	        } while(bits - val + (n-1) < 0);
        return val;
     }


    
  }
