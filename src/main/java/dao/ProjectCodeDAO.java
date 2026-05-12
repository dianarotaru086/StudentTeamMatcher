package dao;

import database.DatabaseConnection;
import model.ProjectCode;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;

public class ProjectCodeDAO {

    public boolean addCode(
            ProjectCode projectCode){

        boolean result = false;

        String sql =
                "INSERT INTO project_code(project_id, user_id, title, language, code) VALUES (?, ?, ?, ?, ?)";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(
                    1,
                    projectCode.getProjectId()
            );

            statement.setInt(
                    2,
                    projectCode.getUserId()
            );

            statement.setString(
                    3,
                    projectCode.getTitle()
            );

            statement.setString(
                    4,
                    projectCode.getLanguage()
            );

            statement.setString(
                    5,
                    projectCode.getCode()
            );

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

    public List<ProjectCode> getCodeByProject(
            int projectId){

        List<ProjectCode> codeList =
                new ArrayList<>();

        String sql =
                "SELECT * FROM project_code WHERE project_id = ? ORDER BY created_at DESC";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                ProjectCode code =
                        new ProjectCode();

                code.setId(
                        resultSet.getInt("id")
                );

                code.setProjectId(
                        resultSet.getInt(
                                "project_id"
                        )
                );

                code.setUserId(
                        resultSet.getInt(
                                "user_id"
                        )
                );

                code.setTitle(
                        resultSet.getString(
                                "title"
                        )
                );

                code.setLanguage(
                        resultSet.getString(
                                "language"
                        )
                );

                code.setCode(
                        resultSet.getString(
                                "code"
                        )
                );

                code.setCreatedAt(
                        resultSet.getString(
                                "created_at"
                        )
                );

                codeList.add(code);
            }

        }catch(Exception e){

            e.printStackTrace();
        }

        return codeList;
    }
}