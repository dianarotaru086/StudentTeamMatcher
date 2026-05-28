package database;


import java.sql.Connection;

public class ConnectionTest {

    public static void main(String[] args) {

        System.out.println("[ConnectionTest] Starting database connection test...");

        Connection connection =
                DatabaseConnection.getConnection();

        if (connection != null) {

            System.out.println("[ConnectionTest] SUCCESS: Connection established.");

        } else {

            System.out.println("[ConnectionTest] FAILED: Connection returned null. Check stderr for details.");
        }

        System.out.println("[ConnectionTest] Test complete.");
    }
}