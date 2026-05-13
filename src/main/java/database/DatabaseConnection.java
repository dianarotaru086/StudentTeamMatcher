package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL =
            "jdbc:mysql://"
                    + System.getenv("MYSQLHOST")
                    + ":"
                    + System.getenv("MYSQLPORT")
                    + "/"
                    + System.getenv("MYSQLDATABASE");

    private static final String USER =
            System.getenv("MYSQLUSER");

    private static final String PASSWORD =
            System.getenv("MYSQLPASSWORD");

    public static Connection getConnection() {

        Connection connection = null;

        try {

            Class.forName(
                    "com.mysql.cj.jdbc.Driver"
            );

            connection =
                    DriverManager.getConnection(
                            URL,
                            USER,
                            PASSWORD
                    );

            System.out.println(
                    "Database connected successfully!"
            );

        } catch (
                ClassNotFoundException |
                SQLException e
        ) {

            e.printStackTrace();
        }

        return connection;
    }
}