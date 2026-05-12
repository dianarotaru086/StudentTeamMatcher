package dao;

import database.DatabaseConnection;
import model.Skill;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

public class SkillDAO {

    public boolean addSkill(
            int userId,
            String skillName){

        boolean result = false;

        String sql =
                "INSERT INTO user_skills(user_id, skill_name) VALUES (?, ?)";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, userId);

            statement.setString(2, skillName);

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

    public List<Skill> getSkillsByUser(
            int userId){

        List<Skill> skills =
                new ArrayList<>();

        String sql =
                "SELECT * FROM user_skills WHERE user_id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, userId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                Skill skill =
                        new Skill();

                skill.setId(
                        resultSet.getInt("id")
                );

                skill.setUserId(
                        resultSet.getInt("user_id")
                );

                skill.setSkillName(
                        resultSet.getString("skill_name")
                );

                skills.add(skill);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return skills;
    }

    public boolean deleteSkill(int skillId){

        boolean result = false;

        String sql =
                "DELETE FROM user_skills WHERE id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, skillId);

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