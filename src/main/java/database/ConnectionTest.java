package database;


import java.sql.Connection;

public class ConnectionTest {

    public static void main(String[] args) {

        Connection connection =
                DatabaseConnection.getConnection();

        if (connection != null) {

            System.out.println("SUCCESS!");

        } else {

            System.out.println("FAILED!");
        }
    }
}