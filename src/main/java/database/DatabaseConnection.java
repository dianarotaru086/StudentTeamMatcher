package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    public static Connection getConnection() {

        String host     = System.getenv("MYSQLHOST");
        String port     = System.getenv("MYSQLPORT");
        String database = System.getenv("MYSQLDATABASE");
        String user     = System.getenv("MYSQLUSER");
        String password = System.getenv("MYSQLPASSWORD");

        if (host == null || host.isEmpty()) {
            System.err.println("[DatabaseConnection] ERROR: MYSQLHOST environment variable is not set.");
            return null;
        }
        if (port == null || port.isEmpty()) {
            System.err.println("[DatabaseConnection] ERROR: MYSQLPORT environment variable is not set.");
            return null;
        }
        if (database == null || database.isEmpty()) {
            System.err.println("[DatabaseConnection] ERROR: MYSQLDATABASE environment variable is not set.");
            return null;
        }
        if (user == null || user.isEmpty()) {
            System.err.println("[DatabaseConnection] ERROR: MYSQLUSER environment variable is not set.");
            return null;
        }
        if (password == null) {
            System.err.println("[DatabaseConnection] ERROR: MYSQLPASSWORD environment variable is not set.");
            return null;
        }

        String url =
                "jdbc:mysql://"
                        + host
                        + ":"
                        + port
                        + "/"
                        + database
                        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC"
                        + "&connectTimeout=5000&socketTimeout=5000";

        System.out.println("[DatabaseConnection] Step 1: Building JDBC URL: " + url);
        System.out.println("[DatabaseConnection] Step 2: Connecting as user: " + user);

        Connection connection = null;

        try {

            System.out.println("[DatabaseConnection] Step 3: Loading MySQL JDBC driver...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("[DatabaseConnection] Step 4: Driver loaded. Attempting DriverManager.getConnection()...");

            connection = DriverManager.getConnection(url, user, password);

            System.out.println("[DatabaseConnection] Step 5: Database connected successfully!");

        } catch (Exception e) {

            System.err.println("[DatabaseConnection] ERROR: Exception type : " + e.getClass().getName());
            System.err.println("[DatabaseConnection] ERROR: Exception message: " + e.getMessage());
            System.err.println("[DatabaseConnection] ERROR: Full stack trace:");
            e.printStackTrace(System.err);
        }

        return connection;
    }
}