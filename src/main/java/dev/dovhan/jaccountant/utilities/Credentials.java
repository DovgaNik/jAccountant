package dev.dovhan.jaccountant.utilities;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Credentials {
	public static String dbUsername;
	public static String dbPassword;
	public static String dbURL;
	public static String pathToSQL;

	public Credentials() throws IOException {
		List<String> lines = Files.readAllLines(Path.of(System.getProperty("user.home"), "invoice_credentials"));
		dbUsername = lines.get(0);
		dbPassword = lines.get(1);
		dbURL = lines.get(2);
		pathToSQL = lines.get(3);
	}
}