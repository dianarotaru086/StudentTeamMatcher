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
                        + "?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";

        System.out.println("[DatabaseConnection] Connecting to: " + url + " as user: " + user);

        Connection connection = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            connection = DriverManager.getConnection(url, user, password);

            System.out.println("[DatabaseConnection] Database connected successfully!");

        } catch (ClassNotFoundException e) {

            System.err.println("[DatabaseConnection] ERROR: MySQL JDBC driver not found: " + e.getMessage());
            e.printStackTrace();

        } catch (SQLException e) {

            System.err.println("[DatabaseConnection] ERROR: Failed to connect to database: " + e.getMessage());
            e.printStackTrace();
        }

        return connection;
    }
}