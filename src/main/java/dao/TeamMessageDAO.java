package dao;

import database.DatabaseConnection;
import model.TeamMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

public class TeamMessageDAO {

    public boolean addMessage(
            int projectId,
            int userId,
            String message){

        boolean result = false;

        String sql =
                "INSERT INTO team_messages(project_id, user_id, message) VALUES (?, ?, ?)";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            statement.setInt(2, userId);

            statement.setString(3, message);

            int rows =
                    statement.executeUpdate();

            if(rows > 0){

                result = true;
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return result;
    }

    public List<TeamMessage> getMessagesByProject(
            int projectId){

        List<TeamMessage> messages =
                new ArrayList<>();

        String sql =
                "SELECT tm.*, u.full_name, u.profile_picture " +
                        "FROM team_messages tm " +
                        "JOIN users u ON tm.user_id = u.id " +
                        "WHERE tm.project_id = ? " +
                        "ORDER BY tm.created_at ASC";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                TeamMessage message =
                        new TeamMessage();

                message.setId(
                        resultSet.getInt("id")
                );

                message.setProjectId(
                        resultSet.getInt(
                                "project_id"
                        )
                );

                message.setUserId(
                        resultSet.getInt(
                                "user_id"
                        )
                );

                message.setFullName(
                        resultSet.getString(
                                "full_name"
                        )
                );

                message.setProfilePicture(
                        resultSet.getString(
                                "profile_picture"
                        )
                );

                message.setMessage(
                        resultSet.getString(
                                "message"
                        )
                );

                message.setCreatedAt(
                        resultSet.getString(
                                "created_at"
                        )
                );

                messages.add(message);
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return messages;
    }
}