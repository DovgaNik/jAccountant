package dev.dovhan.jaccountant;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public abstract class ConnectionProvider {

    public static Connection getConnection() throws IOException, ClassNotFoundException, SQLException {
        Credentials credentials = new Credentials();
        String url = "jdbc:mysql://localhost:3306/jaccountant";
        String username = Credentials.dbUsername;
        String password = Credentials.dbPassword;

        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(url, username, password);
    }
}
