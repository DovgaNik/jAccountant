package dev.dovhan.jaccountant.utilities;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public abstract class DBActions {
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

	public static int getIDByFK (Connection connection, String table, String column, String entry) {
		try {
			String sql = "SELECT * FROM " + table + " WHERE "+ column + " = " + "\"" + entry + "\"";
			PreparedStatement preparedStmt = connection.prepareStatement(sql);
			ResultSet result = preparedStmt.executeQuery();
			result.next();
			return result.getInt("id");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}
	}

	public static int getIDBy2FK (Connection connection, String table, String column1, String column2, String entry1, String entry2) {
		try {
			String sql = "SELECT id FROM " + table + " WHERE (" + column1 + ", " + column2 + ") = (?, ?)";
			PreparedStatement preparedStmt = connection.prepareStatement(sql);
			preparedStmt.setString(1, entry1);
			preparedStmt.setString(2, entry2);
			ResultSet result = preparedStmt.executeQuery();
			result.next();
			return result.getInt("id");
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return 0;
		}

	}

	public static HashMap<Integer, String> getDbAsAMap(String table, Connection connection, String columnName) {
		HashMap<Integer, String> tableMap = new HashMap<>();
		try {
			String sql = "SELECT * FROM " + table;
			PreparedStatement preparedStmt = connection.prepareStatement(sql);
			ResultSet result = preparedStmt.executeQuery();
			while (result.next()){
				tableMap.put(
						result.getInt("id"),
						result.getString(columnName)
				);
			}

		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
		return tableMap;
	}
}
