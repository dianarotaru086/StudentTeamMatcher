package dao;

import database.DatabaseConnection;
import model.Task;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;
import java.sql.Date;

public class TaskDAO {

    public boolean createTask(
            Task task){

        boolean result = false;

        String sql =
                "INSERT INTO tasks(project_id, user_id, title, description, status, priority, deadline) VALUES (?, ?, ?, ?, ?, ?, ?)";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(
                    1,
                    task.getProjectId()
            );

            statement.setInt(
                    2,
                    task.getUserId()
            );

            statement.setString(
                    3,
                    task.getTitle()
            );

            statement.setString(
                    4,
                    task.getDescription()
            );

            statement.setString(
                    5,
                    task.getStatus()
            );

            statement.setString(
                    6,
                    task.getPriority()
            );

            statement.setDate(
                    7,
                    java.sql.Date.valueOf(
                            task.getDeadline()
                    )
            );

            int rows =
                    statement.executeUpdate();

            if(rows > 0){

                result = true;
            }

        }catch(Exception e){

            e.printStackTrace();

            System.out.println(
                    "TASK ERROR: "
                            + e.getMessage()
            );
        }

        return result;
    }

    public List<Task> getTasksByProject(
            int projectId,
            int userId){

        List<Task> tasks =
                new ArrayList<>();

        String sql =
                "SELECT * FROM tasks\n" +
                        " WHERE project_id = ?\n" +
                        " AND user_id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);
            statement.setInt(2, userId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                Task task =
                        new Task();

                task.setId(
                        resultSet.getInt("id")
                );

                task.setProjectId(
                        resultSet.getInt(
                                "project_id"
                        )
                );

                task.setTitle(
                        resultSet.getString(
                                "title"
                        )
                );

                task.setDescription(
                        resultSet.getString(
                                "description"
                        )
                );

                task.setStatus(
                        resultSet.getString(
                                "status"
                        )
                );

                task.setPriority(
                        resultSet.getString(
                                "priority"
                        )
                );

                task.setDeadline(
                        resultSet.getString(
                                "deadline"
                        )
                );

                tasks.add(task);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return tasks;
    }

    public boolean updateTaskStatus(
            int taskId,
            String status){

        boolean result = false;

        String sql =
                "UPDATE tasks SET status = ? WHERE id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setString(1, status);

            statement.setInt(2, taskId);

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

    public boolean deleteTask(
            int taskId){

        boolean result = false;

        String sql =
                "DELETE FROM tasks WHERE id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, taskId);

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

}