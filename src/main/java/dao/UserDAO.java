package dao;

import database.DatabaseConnection;
import model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

public class UserDAO {

    public boolean registerUser(User user) {

        boolean result = false;

        String sql =
                "INSERT INTO users(full_name, email, password, role, skills, work_style) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";

        Connection connection = DatabaseConnection.getConnection();

        if (connection == null) {
            System.err.println("[UserDAO] registerUser: Could not obtain database connection.");
            return false;
        }

        PreparedStatement statement = null;

        try {

            statement = connection.prepareStatement(sql);

            statement.setString(1, user.getFullName());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getRole());
            statement.setString(5, user.getSkills());
            statement.setString(6, user.getWorkStyle());

            int rows = statement.executeUpdate();

            if (rows > 0) {
                result = true;
            }

        } catch (SQLException e) {

            System.err.println("[UserDAO] registerUser: SQL error: " + e.getMessage());
            e.printStackTrace();

        } finally {

            if (statement != null) {
                try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return result;
    }

    public User loginUser(String email, String password) {

        User user = null;

        String sql =
                "SELECT * FROM users WHERE email = ? AND password = ?";

        Connection connection = DatabaseConnection.getConnection();

        if (connection == null) {
            System.err.println("[UserDAO] loginUser: Could not obtain database connection.");
            return null;
        }

        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            statement = connection.prepareStatement(sql);

            statement.setString(1, email);
            statement.setString(2, password);

            resultSet = statement.executeQuery();

            if (resultSet.next()) {

                user = new User();

                user.setId(resultSet.getInt("id"));
                user.setFullName(resultSet.getString("full_name"));
                user.setEmail(resultSet.getString("email"));
                user.setRole(resultSet.getString("role"));
                user.setProfilePicture(
                        resultSet.getString(
                                "profile_picture"
                        )
                );
                user.setSkills(resultSet.getString("skills"));
                user.setWorkStyle(resultSet.getString("work_style"));
            }

        } catch (SQLException e) {

            System.err.println("[UserDAO] loginUser: SQL error: " + e.getMessage());
            e.printStackTrace();

        } finally {

            if (resultSet != null) {
                try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (statement != null) {
                try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return user;
    }

    public boolean updateUser(User user){

        boolean result = false;

        String sql =
                "UPDATE users " +
                        "SET full_name = ?, " +
                        "skills = ?, " +
                        "work_style = ? " +
                        "WHERE id = ?";

        Connection connection = DatabaseConnection.getConnection();

        if (connection == null) {
            System.err.println("[UserDAO] updateUser: Could not obtain database connection.");
            return false;
        }

        PreparedStatement statement = null;

        try {

            statement = connection.prepareStatement(sql);

            statement.setString(
                    1,
                    user.getFullName()
            );

            statement.setString(
                    2,
                    user.getSkills()
            );

            statement.setString(
                    3,
                    user.getWorkStyle()
            );

            statement.setInt(
                    4,
                    user.getId()
            );

            int rows = statement.executeUpdate();

            if(rows > 0){

                result = true;
            }

        } catch (SQLException e) {

            System.err.println("[UserDAO] updateUser: SQL error: " + e.getMessage());
            e.printStackTrace();

        } finally {

            if (statement != null) {
                try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return result;
    }

    public int calculateProfileScore(
            User user){

        int score = 0;

        if(user.getFullName() != null &&
                !user.getFullName().isEmpty()){

            score += 25;
        }

        if(user.getEmail() != null &&
                !user.getEmail().isEmpty()){

            score += 25;
        }

        if(user.getSkills() != null &&
                !user.getSkills().isEmpty()){

            score += 25;
        }

        if(user.getWorkStyle() != null &&
                !user.getWorkStyle().isEmpty()){

            score += 25;
        }

        return score;
    }

    public boolean updateProfilePicture(
            int userId,
            String profilePicture){

        boolean result = false;

        String sql =
                "UPDATE users SET profile_picture = ? WHERE id = ?";

        Connection connection = DatabaseConnection.getConnection();

        if (connection == null) {
            System.err.println("[UserDAO] updateProfilePicture: Could not obtain database connection.");
            return false;
        }

        PreparedStatement statement = null;

        try {

            statement = connection.prepareStatement(sql);

            statement.setString(
                    1,
                    profilePicture
            );

            statement.setInt(
                    2,
                    userId
            );

            int rows = statement.executeUpdate();

            if(rows > 0){

                result = true;
            }

        } catch(SQLException e){

            System.err.println("[UserDAO] updateProfilePicture: SQL error: " + e.getMessage());
            e.printStackTrace();

        } finally {

            if (statement != null) {
                try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return result;
    }

    public int getCompletedProjectsCount(
            int userId){

        int count = 0;

        String sql =
                "SELECT COUNT(*) FROM projects WHERE creator_id = ?";

        Connection connection = DatabaseConnection.getConnection();

        if (connection == null) {
            System.err.println("[UserDAO] getCompletedProjectsCount: Could not obtain database connection.");
            return 0;
        }

        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            statement = connection.prepareStatement(sql);

            statement.setInt(1, userId);

            resultSet = statement.executeQuery();

            if(resultSet.next()){

                count = resultSet.getInt(1);
            }

        } catch(SQLException e){

            System.err.println("[UserDAO] getCompletedProjectsCount: SQL error: " + e.getMessage());
            e.printStackTrace();

        } finally {

            if (resultSet != null) {
                try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (statement != null) {
                try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return count;
    }

    public int getSkillsCount(
            int userId){

        int count = 0;

        String sql =
                "SELECT COUNT(*) FROM user_skills WHERE user_id = ?";

        Connection connection = DatabaseConnection.getConnection();

        if (connection == null) {
            System.err.println("[UserDAO] getSkillsCount: Could not obtain database connection.");
            return 0;
        }

        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            statement = connection.prepareStatement(sql);

            statement.setInt(1, userId);

            resultSet = statement.executeQuery();

            if(resultSet.next()){

                count = resultSet.getInt(1);
            }

        } catch(SQLException e){

            System.err.println("[UserDAO] getSkillsCount: SQL error: " + e.getMessage());
            e.printStackTrace();

        } finally {

            if (resultSet != null) {
                try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (statement != null) {
                try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return count;
    }

    public int getApplicationsCount(
            int userId){

        int count = 0;

        String sql =
                "SELECT COUNT(*) FROM applications WHERE user_id = ?";

        Connection connection = DatabaseConnection.getConnection();

        if (connection == null) {
            System.err.println("[UserDAO] getApplicationsCount: Could not obtain database connection.");
            return 0;
        }

        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {

            statement = connection.prepareStatement(sql);

            statement.setInt(1, userId);

            resultSet = statement.executeQuery();

            if(resultSet.next()){

                count = resultSet.getInt(1);
            }

        } catch(SQLException e){

            System.err.println("[UserDAO] getApplicationsCount: SQL error: " + e.getMessage());
            e.printStackTrace();

        } finally {

            if (resultSet != null) {
                try { resultSet.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            if (statement != null) {
                try { statement.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
            try { connection.close(); } catch (SQLException e) { e.printStackTrace(); }
        }

        return count;
    }
}