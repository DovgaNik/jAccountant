package dev.dovhan.jaccountant.users;

import dev.dovhan.jaccountant.utilities.ConnectionProvider;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Objects;

public abstract class LoginUtils {
    private static String generateHash(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-512");
            byte[] messageDigest = md.digest(password.getBytes());
            BigInteger no = new BigInteger(1, messageDigest);
            String hashtext = no.toString(16);
            while (hashtext.length() < 32) {
                hashtext = "0" + hashtext;
            }
            return hashtext;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }

    public static void register(String user, String password) throws SQLException, IOException, ClassNotFoundException {
        Connection connection = ConnectionProvider.getConnection();
        String sql = "insert into user (username, passwordHash) values (?, ?)";
        PreparedStatement preparedStmt = connection.prepareStatement(sql);
        preparedStmt.setString (1, user);
        preparedStmt.setString (2, generateHash(password));
        preparedStmt.execute();
        connection.close();
    }

    public static boolean login (String user, String password) throws SQLException, IOException, ClassNotFoundException {
        Connection connection = ConnectionProvider.getConnection();
        String sql = "select * from  user where username = " + "'" + user + "'";
        PreparedStatement preparedStmt = connection.prepareStatement(sql);
        ResultSet result = preparedStmt.executeQuery();
        if (result.next()) {
            boolean isVerified = Objects.equals(result.getString("passwordHash"), generateHash(password));
            connection.close();
            return isVerified;
        }
        connection.close();
        return false;
    }
}
