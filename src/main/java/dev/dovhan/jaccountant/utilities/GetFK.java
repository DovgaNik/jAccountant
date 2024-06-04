package dev.dovhan.jaccountant.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public abstract class GetFK {
	public static String getFKStringByID (int id, String table, String columnName, Connection connection) {
		try {
			String sql = "SELECT * FROM " + table + " WHERE id = " + id;
			PreparedStatement preparedStmt = connection.prepareStatement(sql);
			ResultSet result = preparedStmt.executeQuery();
			result.next();
			return result.getString(columnName);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return e.getMessage();
		}
	}
}
