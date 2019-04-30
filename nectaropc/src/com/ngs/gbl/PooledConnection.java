package com.ngs.gbl;

import java.sql.*;

public class PooledConnection
{
	// Real JDBC Connection.
	private Connection connection = null;

	// Boolean flag used to determine if connection is in use.
	private boolean inuse = false;

	// Constructor that takes the passed in JDBC Connection
	// and stores it in the connection attribute.
	public PooledConnection(Connection value)
	{
		if (value != null)
		{
			connection = value;
		}
	}

	// Return a reference to the JDBC Connection.
	public Connection getConnection()
	{
		// get the JDBC Connection.
		return connection;
	}

	// Set the status of the PooledConnection.
	public void setInUse(boolean value)
	{
		inuse = value;
	}

	// Returns the current status of the PooledConnection.
	public boolean inUse()
	{
		return inuse;
	}

	// Close the real JDBC Connection.
	public void close()
	{
		try
		{
			connection.close();
		}
		catch (SQLException sqle)
		{
			System.err.println(sqle.getMessage());
		}
	}
};
