/*
 * Created on Sep 15, 2012
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

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Enumeration;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

public class Log4jExample{
  /* Get actual class name to be printed on */
  static Logger log = Logger.getLogger(Log4jExample.class.getName());

  public static void main(String[] args)
				throws IOException,SQLException{
					
		ResourceBundle bundle = ResourceBundle.getBundle("log4j");
			for (Enumeration e = bundle.getKeys();e.hasMoreElements();) {
				String key = (String)e.nextElement();
				String msg = bundle.getString(key);
				System.out.println("key :"+key);
				System.out.println("msg :"+msg);
				
			}
			
	   log.debug("Hello this is an debug message");
	   log.info("Hello this is an info message");
	   log.debug("Here is some DEBUG");
	   log.info("Here is some INFO");
	   log.warn("Here is some WARN");
	   log.error("Here is some ERROR");
	   log.fatal("Here is some FATAL");

  }
}
 
