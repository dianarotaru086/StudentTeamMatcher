package dao;

import database.DatabaseConnection;
import model.CalendarEvent;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class CalendarDAO {

    public boolean createEvent(
            CalendarEvent event){

        boolean result = false;

        String sql =
                "INSERT INTO calendar_events(user_id, title, description, event_date) VALUES (?, ?, ?, ?)";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(
                    1,
                    event.getUserId()
            );

            statement.setString(
                    2,
                    event.getTitle()
            );

            statement.setString(
                    3,
                    event.getDescription()
            );

            statement.setString(
                    4,
                    event.getEventDate()
            );

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

    public List<CalendarEvent> getEventsByUser(
            int userId){

        List<CalendarEvent> events =
                new ArrayList<>();

        String sql =
                "SELECT * FROM calendar_events WHERE user_id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, userId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                CalendarEvent event =
                        new CalendarEvent();

                event.setId(
                        resultSet.getInt("id")
                );

                event.setUserId(
                        resultSet.getInt("user_id")
                );

                event.setTitle(
                        resultSet.getString("title")
                );

                event.setDescription(
                        resultSet.getString(
                                "description"
                        )
                );

                event.setEventDate(
                        resultSet.getString(
                                "event_date"
                        )
                );

                events.add(event);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return events;
    }
}