package dao;

import database.DatabaseConnection;
import model.Activity;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import model.Activity;

public class ActivityDAO {

    public boolean addActivity(
            int projectId,
            String activityText){

        boolean result = false;

        String sql =
                "INSERT INTO activity_feed(project_id, activity_text) VALUES (?, ?)";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            statement.setString(2, activityText);

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

    public List<Activity> getActivitiesByProject(
            int projectId){

        List<Activity> activities =
                new ArrayList<>();

        String sql =
                "SELECT * FROM activity_feed " +
                        "WHERE project_id = ? " +
                        "ORDER BY created_at DESC";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                Activity activity =
                        new Activity();

                activity.setId(
                        resultSet.getInt("id")
                );

                activity.setProjectId(
                        resultSet.getInt(
                                "project_id"
                        )
                );

                activity.setActivityText(
                        resultSet.getString(
                                "activity_text"
                        )
                );

                activity.setCreatedAt(
                        resultSet.getString(
                                "created_at"
                        )
                );

                activities.add(activity);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return activities;
    }

    public List<Activity> getRecentActivities(){

        List<Activity> activities =
                new ArrayList<>();

        String sql =
                "SELECT * FROM activities ORDER BY created_at DESC LIMIT 10";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                Activity activity =
                        new Activity();

                activity.setId(
                        resultSet.getInt("id")
                );

                activity.setProjectId(
                        resultSet.getInt(
                                "project_id"
                        )
                );

                activity.setActivityText(
                        resultSet.getString(
                                "description"
                        )
                );

                activity.setCreatedAt(
                        resultSet.getString(
                                "created_at"
                        )
                );

                activities.add(activity);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return activities;
    }
}