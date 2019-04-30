<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 


      <%
            // declare a connection by using Connection interface 
            Connection connection = null;

            /* Create string of connection url within specified format with machine 
			name, port number and database name. Here machine name id localhost 
			and database name is student. */

            String connectionURL = "jdbc:mysql://localhost:3306/nectar";

            /*declare a resultSet that works as a table resulted by execute a specified 
			sql query. */
            ResultSet rs = null;

            // Declare statement.
            PreparedStatement psmnt = null;
           
		    // declare InputStream object to store binary stream of given image.
			InputStream sImage;

            try {

                // Load JDBC driver "com.mysql.jdbc.Driver"
                Class.forName("com.mysql.jdbc.Driver").newInstance();

				/* Create a connection by using getConnection() method that takes 
				parameters of string type connection url, user name and password to 
				connect to database. */
                connection = DriverManager.getConnection(connectionURL, "nectar", "nec76tar");

				/* prepareStatement() is used for create statement object that is 
	           used for sending sql statements to the specified database. */
                psmnt = connection.prepareStatement("SELECT image FROM imageDetails WHERE QuestionID = ?");

                psmnt.setString(1, "1754");
                rs = psmnt.executeQuery();
                if(rs.next()) {
                      byte[] bytearray = new byte[1048576];
                      int size=0;
                      sImage = rs.getBinaryStream(1);
                      //response.reset();
                      response.setContentType("image/jpeg");

                      while((size=sImage.read(bytearray))!= -1 ){

                            response.getOutputStream().write(bytearray,0,size);
				      }
			    }
		    }
            catch(Exception ex){
				out.println("error :"+ex);
            }
	
           finally {
                // close all the connections.
                rs.close();
                psmnt.close();
                connection.close();
           }
			
     %>
	