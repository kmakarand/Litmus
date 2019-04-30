package com.ngs.gbl;

import java.sql.*;
import java.util.*;

public class ConnectionPool
{
	// JDBC Driver Name.
	private String driver = null;

	// URL of Database.
	private String url = null;

	// Initial number of Connections.
	private int size = 0;

	// Username.
	private String username = null;

	// Password.
	private String password = null;

	// Vector of JDBC Connections.
	private Vector pool = null;

	public ConnectionPool()
	{
	}

	// Set the value of the JDBC Driver.
	public void setDriver(String value)
	{
		if (value != null)
		{
			driver = value;
		}
	}

	// Get the value of the JDBC Driver.
	public String getDriver()
	{
		return driver;
	}

	// Set the URL Pointing to the Datasource.
	public void setURL(String value)
	{
		if (value != null)
		{
			url = value;
		}
	}

	// Get the URL Pointing to the Datasource.
	public String getURL()
	{
		return url;
	}

	// Set the initial number of Connections.
	public void setSize(int value)
	{
		if (value > 1)
		{
			size = value;
		}
	}

	// Get the initial number of Connections.
	public int getSize()
	{
		return size;
	}

	// Set the Username.
	public void setUsername(String value)
	{
		if (value != null)
		{
			username = value;
		}
	}

	// Get the Username.
	public String getUsername()
	{
		return username;
	}

	// Set the Password.
	public void setPassword(String value)
	{
		if (value != null)
		{
			password = value;
		}
	}

	// Get the Password.
	public String getPassword()
	{
		return password;
	}

	// Create and returns a Connection.
	private Connection createConnection() throws Exception
	{
		Connection con = null;

		// Create a Connection.
		con = DriverManager.getConnection(url, username, password);

		return con;
	}

	// Initialize the Pool.
	public synchronized void initializePool() throws Exception
	{
		// Check our initial values.
		if (driver == null)
		{
			throw new Exception("No Driver Name specified !");
		}

		if (url == null)
		{
			throw new Exception("No URL specified !");
		}

		if (size < 1)
		{
			throw new Exception("Pool size is less than 1 !");
		}

		// Create the Connections.
		try
		{
			// Load the Driver Class file.
			Class.forName(driver);

			// Create Connections based on the Size number.
			for (int x = 0; x < size; x++)
			{
				//System.err.println("Opening JDBC Connection " + (x+1));

				Connection con = createConnection();

				if (con != null)
				{
					// Create a PooledConnection to encapsulate the
					// the JDBC Connection.
					PooledConnection pcon = new PooledConnection(con);

					// Add the Connection to the Pool.
					addConnection(pcon);
				}
			}
		}
		catch (SQLException sqle)
		{
			System.err.println(sqle.getMessage());
		}
		catch (ClassNotFoundException cnfe)
		{
			System.err.println(cnfe.getMessage());
		}
	}

	// Adds the PooledConnection to the Pool.
	private void addConnection(PooledConnection value)
	{
		// If the Pool is null, create a new vector
		// with the initial size of "size".
		if (pool == null)
		{
			pool = new Vector(size);
		}

		// Add the PooledConnection Object to the Vector.
		pool.addElement(value);
	}

	public synchronized void releaseConnection(Connection con)
	{
		// Find the PooledConnection Object.
		for (int x = 0; x < pool.size(); x++)
		{
			PooledConnection pcon = (PooledConnection)pool.elementAt(x);

			// Check for correct Connection.
			if (pcon.getConnection() == con)
			{
				//System.err.println("Releasing JDBC Connection " + (x+1));

				// Set its inuse attribute to false, which
				// releases it for use.
				pcon.setInUse(false);
				break;
			}
		}
	}

	// Find an available Connection.
	public synchronized Connection getConnection() throws Exception
	{
		PooledConnection pcon = null;

		// Find a Connection not in use.
		for ( int x = 0; x < pool.size(); x++)
		{
			pcon = (PooledConnection)pool.elementAt(x);

			// check to see if the Connection is in Use.
			if (pcon.inUse() == false)
			{
				// Mark it as in Use.
				pcon.setInUse(true);

				// return the JDBC Connection stored in the
				// PooledConnection Object.

				//System.err.println("Using JDBC Connection " + (x+1));
				return pcon.getConnection();
			}
		}

		// Could not find a free Connection,
		// Create and add a new one.
		try
		{
			// Create a new JDBC Connection.
			Connection con = createConnection();

			// Create a new PooledConnection, passing it the JDBC
			// Connection.
			pcon = new PooledConnection(con);

			// Mark the Connection as in use.
			pcon.setInUse(true);

			// Add the new pooledConnection Object to the pool.
			pool.addElement(pcon);
		}
		catch (Exception e)
		{
			System.err.println(e.getMessage());
		}

		// return the new Connection.
		return pcon.getConnection();
	}

	// When shutting down the pool, you need to first empty it.
	public synchronized void emptyPool()
	{
		// Iterate over the entire pool closing the
		// JDBC Connections.
		for (int x = 0; x < pool.size(); x++)
		{
			System.err.println("Closing JDBC Connection " + (x+1));

			PooledConnection pcon = (PooledConnection)pool.elementAt(x);

			// If the PooledConnection is not in use, close it.
			if (pcon.inUse() == false)
			{
				pcon.close();
			}
			else
			{
				// If it's still in use, sleep for 30 seconds and
				// force close.
				try
				{
					java.lang.Thread.sleep(30000);
					pcon.close();
				}
				catch (InterruptedException ie)
				{
					System.err.println(ie.getMessage());
				}
			}
		}
	}
}
