package dev.dovhan.jaccountant;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class Credentials {
        public static String dbUsername;
        public static String dbPassword;
        public Credentials() throws IOException {
            List<String> lines = Files.readAllLines(Path.of("D:", "credentials"));
            dbUsername = lines.get(0);
            dbPassword = lines.get(1);
        }
}