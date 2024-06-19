package dev.dovhan.jaccountant.utilities;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class ConnectionProvider {

	private static final String SQL_DRIVER = "com.mysql.cj.jdbc.Driver";
	public static Connection getConnection() throws ClassNotFoundException, SQLException, IOException {
		Credentials credentials = new Credentials();
		String url = Credentials.dbURL;
		String username = Credentials.dbUsername;
		String password = Credentials.dbPassword;

		Class.forName(SQL_DRIVER);
		return DriverManager.getConnection(url, username, password);
	}
}
