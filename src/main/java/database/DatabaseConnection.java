package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {

    private static final String URL =
            "jdbc:mysql://mysql-12048c84-rotarudianardm-fe26.h.aivencloud.com:23485/student_matcher?sslMode=REQUIRED&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8";

    private static final String USER =
            "avnadmin";

    private static final String PASSWORD =
            "AVNS_uRcm_UmeKlIrJ1T3vXd";

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
                ClassNotFoundException
                | SQLException e
        ) {

            e.printStackTrace();
        }

        return connection;
    }
}