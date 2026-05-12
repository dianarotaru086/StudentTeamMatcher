package dao;

import database.DatabaseConnection;
import model.ProjectMember;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class ProjectMemberDAO {

    public boolean addMember(
            int projectId,
            int userId,
            String role){

        boolean result = false;

        String sql =
                "INSERT INTO project_members(project_id, user_id, role) VALUES (?, ?, ?)";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            statement.setInt(2, userId);

            statement.setString(3, role);

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

    public List<ProjectMember> getMembersByProject(
            int projectId){

        List<ProjectMember> members =
                new ArrayList<>();

        String sql =
                "SELECT pm.*, u.full_name, u.profile_picture " +
                        "FROM project_members pm " +
                        "JOIN users u ON pm.user_id = u.id " +
                        "WHERE pm.project_id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                ProjectMember member =
                        new ProjectMember();

                member.setId(
                        resultSet.getInt("id")
                );

                member.setProjectId(
                        resultSet.getInt(
                                "project_id"
                        )
                );

                member.setUserId(
                        resultSet.getInt(
                                "user_id"
                        )
                );

                member.setFullName(
                        resultSet.getString(
                                "full_name"
                        )
                );

                member.setProfilePicture(
                        resultSet.getString(
                                "profile_picture"
                        )
                );

                member.setRole(
                        resultSet.getString(
                                "role"
                        )
                );

                members.add(member);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return members;
    }
}