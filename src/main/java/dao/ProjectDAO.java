package dao;

import database.DatabaseConnection;
import model.Project;
import model.Application;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.ResultSet;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class ProjectDAO {

    public boolean createProject(Project project) {

        boolean result = false;

        String sql =
                "INSERT INTO projects(title, description, required_skills, creator_id, deadline, difficulty) " +
                        "VALUES (?, ?, ?, ?, ?, ?)";

        try {

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setString(
                    1,
                    project.getTitle()
            );

            statement.setString(
                    2,
                    project.getDescription()
            );

            statement.setString(
                    3,
                    project.getRequiredSkills()
            );

            statement.setInt(
                    4,
                    project.getCreatorId()
            );

            statement.setString(
                    5,
                    project.getDeadline()
            );

            statement.setInt(
                    6,
                    project.getDifficulty()
            );

            int rows =
                    statement.executeUpdate();

            if(rows > 0){

                result = true;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return result;
    }

    public List<Project> getAllProjects() {

        List<Project> projects =
                new ArrayList<>();

        String sql =
                "SELECT * FROM projects";

        try {

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                Project project =
                        new Project();

                project.setId(
                        resultSet.getInt("id")
                );

                project.setTitle(
                        resultSet.getString("title")
                );

                project.setDescription(
                        resultSet.getString("description")
                );

                project.setRequiredSkills(
                        resultSet.getString("required_skills")
                );

                project.setCreatorId(
                        resultSet.getInt("creator_id")
                );

                project.setDeadline(
                        resultSet.getString("deadline")
                );

                project.setDifficulty(
                        resultSet.getInt("difficulty")
                );

                projects.add(project);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return projects;
    }

    public int calculateCompatibility(
            String userSkills,
            String requiredSkills){

        if(userSkills == null ||
                requiredSkills == null){

            return 0;
        }

        String[] userSkillsArray =
                userSkills.toLowerCase().split(",");

        String[] requiredSkillsArray =
                requiredSkills.toLowerCase().split(",");

        int matchedSkills = 0;

        for(String required :
                requiredSkillsArray){

            for(String user :
                    userSkillsArray){

                if(user.trim()
                        .equals(required.trim())){

                    matchedSkills++;
                }
            }
        }

        int totalRequired =
                requiredSkillsArray.length;

        return (matchedSkills * 100)
                / totalRequired;
    }

    public boolean applyToProject(
            int userId,
            int projectId,
            int compatibilityScore){

        boolean result = false;

        String sql =
                "INSERT INTO applications(user_id, project_id, compatibility_score) VALUES (?, ?, ?)";

        try {

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, userId);

            statement.setInt(2, projectId);

            statement.setInt(3, compatibilityScore);

            int rows =
                    statement.executeUpdate();

            if(rows > 0){

                result = true;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return result;
    }

    public List<Application> getApplicationsByProject(
            int projectId){

        List<Application> applications =
                new ArrayList<>();

        String sql =
                "SELECT applications.*, " +
                        "users.full_name, " +
                        "users.email, " +
                        "users.profile_picture, " +
                        "users.skills " +
                        "FROM applications " +
                        "JOIN users ON applications.user_id = users.id " +
                        "WHERE applications.project_id = ?";

        try {

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                Application application =
                        new Application();

                application.setId(
                        resultSet.getInt("id")
                );

                application.setUserId(
                        resultSet.getInt("user_id")
                );

                application.setProjectId(
                        resultSet.getInt("project_id")
                );

                application.setCompatibilityScore(
                        resultSet.getInt("compatibility_score")
                );

                application.setFullName(
                        resultSet.getString("full_name")
                );

                application.setEmail(
                        resultSet.getString("email")
                );

                application.setProfilePicture(
                        resultSet.getString("profile_picture")
                );

                application.setSkills(
                        resultSet.getString("skills")
                );

                applications.add(application);
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return applications;
    }

    public Map<String, Integer> getSkillsStatistics(){

        Map<String, Integer> statistics =
                new HashMap<>();

        String sql =
                "SELECT required_skills FROM projects";

        try {

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                String skills =
                        resultSet.getString(
                                "required_skills"
                        );

                if(skills != null){

                    String[] skillsArray =
                            skills.split(",");

                    for(String skill :
                            skillsArray){

                        skill = skill.trim();

                        statistics.put(
                                skill,
                                statistics.getOrDefault(
                                        skill,
                                        0
                                ) + 1
                        );
                    }
                }
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return statistics;
    }

    public List<Project> getRecommendedProjects(
            String userSkills){

        List<Project> recommendedProjects =
                new ArrayList<>();

        List<Project> allProjects =
                getAllProjects();

        allProjects.sort((p1, p2) -> {

            int score1 =
                    calculateCompatibility(
                            userSkills,
                            p1.getRequiredSkills()
                    );

            int score2 =
                    calculateCompatibility(
                            userSkills,
                            p2.getRequiredSkills()
                    );

            return score2 - score1;
        });

        int limit =
                Math.min(3, allProjects.size());

        for(int i = 0; i < limit; i++){

            recommendedProjects.add(
                    allProjects.get(i)
            );
        }

        return recommendedProjects;
    }

    public boolean alreadyApplied(
            int userId,
            int projectId){

        boolean applied = false;

        String sql =
                "SELECT * FROM applications " +
                        "WHERE user_id = ? " +
                        "AND project_id = ?";

        try {

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, userId);

            statement.setInt(2, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            if(resultSet.next()){

                applied = true;
            }

        } catch (SQLException e) {

            e.printStackTrace();
        }

        return applied;
    }

    public Project getProjectById(
            int projectId){

        Project project = null;

        String sql =
                "SELECT * FROM projects WHERE id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, projectId);

            ResultSet resultSet =
                    statement.executeQuery();

            if(resultSet.next()){

                project =
                        new Project();

                project.setId(
                        resultSet.getInt("id")
                );

                project.setTitle(
                        resultSet.getString("title")
                );

                project.setDescription(
                        resultSet.getString("description")
                );

                project.setRequiredSkills(
                        resultSet.getString("required_skills")
                );

                project.setDifficulty(
                        resultSet.getInt("difficulty")
                );

                project.setDeadline(
                        resultSet.getString("deadline")
                );
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return project;
    }

    public List<Project> getProjectsByUser(
            int userId){

        List<Project> projects =
                new ArrayList<>();

        String sql =
                "SELECT DISTINCT p.* " +
                        "FROM projects p " +
                        "LEFT JOIN project_members pm " +
                        "ON p.id = pm.project_id " +
                        "WHERE p.creator_id = ? " +
                        "OR pm.user_id = ?";

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement statement =
                    connection.prepareStatement(sql);

            statement.setInt(1, userId);

            statement.setInt(2, userId);

            ResultSet resultSet =
                    statement.executeQuery();

            while(resultSet.next()){

                Project project =
                        new Project();

                project.setId(
                        resultSet.getInt("id")
                );

                project.setTitle(
                        resultSet.getString("title")
                );

                project.setDescription(
                        resultSet.getString("description")
                );

                project.setRequiredSkills(
                        resultSet.getString("required_skills")
                );

                project.setDifficulty(
                        resultSet.getInt("difficulty")
                );

                project.setDeadline(
                        resultSet.getString("deadline")
                );

                projects.add(project);
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return projects;
    }

    public boolean deleteProject(
            int projectId){

        boolean result = false;

        try{

            Connection connection =
                    DatabaseConnection.getConnection();

            PreparedStatement deleteTasks =
                    connection.prepareStatement(
                            "DELETE FROM tasks WHERE project_id = ?"
                    );

            deleteTasks.setInt(
                    1,
                    projectId
            );

            deleteTasks.executeUpdate();

            PreparedStatement deleteApplications =
                    connection.prepareStatement(
                            "DELETE FROM applications WHERE project_id = ?"
                    );

            deleteApplications.setInt(
                    1,
                    projectId
            );

            deleteApplications.executeUpdate();

            PreparedStatement deleteMessages =
                    connection.prepareStatement(
                            "DELETE FROM team_messages WHERE project_id = ?"
                    );

            deleteMessages.setInt(
                    1,
                    projectId
            );

            deleteMessages.executeUpdate();

            PreparedStatement deleteFiles =
                    connection.prepareStatement(
                            "DELETE FROM project_files WHERE project_id = ?"
                    );

            deleteFiles.setInt(
                    1,
                    projectId
            );

            deleteFiles.executeUpdate();

            PreparedStatement deleteActivities =
                    connection.prepareStatement(
                            "DELETE FROM activities WHERE project_id = ?"
                    );

            deleteActivities.setInt(
                    1,
                    projectId
            );

            deleteActivities.executeUpdate();

            PreparedStatement deleteProject =
                    connection.prepareStatement(
                            "DELETE FROM projects WHERE id = ?"
                    );

            deleteProject.setInt(
                    1,
                    projectId
            );

            int rows =
                    deleteProject.executeUpdate();

            if(rows > 0){

                result = true;
            }

        }catch(SQLException e){

            e.printStackTrace();
        }

        return result;
    }
}