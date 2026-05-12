package dao;

import database.DatabaseConnection;
import model.ProjectFile;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class ProjectFileDAO {

    public boolean uploadFile(
            int projectId,
            int userId,
            String fileName){

        boolean result = false;

        String sql =
                "INSERT INTO project_files(project_id, user_id, file_name) VALUES (?, ?, ?)";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            statement.setInt(2, userId);

            statement.setString(3, fileName);

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

    public List<ProjectFile> getFilesByProject(
            int projectId){

        List<ProjectFile> files =
                new ArrayList<>();

        String sql =
                "SELECT * FROM project_files WHERE project_id = ? ORDER BY uploaded_at DESC";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                ProjectFile file =
                        new ProjectFile();

                file.setId(
                        resultSet.getInt("id")
                );

                file.setProjectId(
                        resultSet.getInt(
                                "project_id"
                        )
                );

                file.setUserId(
                        resultSet.getInt(
                                "user_id"
                        )
                );

                file.setFileName(
                        resultSet.getString(
                                "file_name"
                        )
                );

                file.setUploadedAt(
                        resultSet.getString(
                                "uploaded_at"
                        )
                );

                files.add(file);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return files;
    }
}