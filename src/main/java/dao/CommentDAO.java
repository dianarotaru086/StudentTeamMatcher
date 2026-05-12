package dao;

import database.DatabaseConnection;
import model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class CommentDAO {

    public boolean addComment(
            int projectId,
            int userId,
            String message){

        boolean result = false;

        String sql =
                "INSERT INTO project_comments(project_id, user_id, message) VALUES (?, ?, ?)";

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

        }catch(SQLException e){

            e.printStackTrace();
        }

        return result;
    }

    public List<Comment> getCommentsByProject(
            int projectId){

        List<Comment> comments =
                new ArrayList<>();

        String sql =
                "SELECT pc.*, u.full_name, u.profile_picture " +
                        "FROM project_comments pc " +
                        "JOIN users u ON pc.user_id = u.id " +
                        "WHERE pc.project_id = ? " +
                        "ORDER BY pc.created_at DESC";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                Comment comment =
                        new Comment();

                comment.setId(
                        resultSet.getInt("id")
                );

                comment.setProjectId(
                        resultSet.getInt(
                                "project_id"
                        )
                );

                comment.setUserId(
                        resultSet.getInt(
                                "user_id"
                        )
                );

                comment.setUserName(
                        resultSet.getString(
                                "full_name"
                        )
                );

                comment.setProfilePicture(
                        resultSet.getString(
                                "profile_picture"
                        )
                );

                comment.setMessage(
                        resultSet.getString(
                                "message"
                        )
                );

                comment.setCreatedAt(
                        resultSet.getString(
                                "created_at"
                        )
                );

                comments.add(comment);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return comments;
    }
}