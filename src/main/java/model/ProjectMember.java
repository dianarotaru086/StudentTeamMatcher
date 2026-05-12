package model;

public class ProjectMember {

    private int id;

    private int projectId;

    private int userId;

    private String fullName;

    private String profilePicture;

    private String role;

    public int getId() {

        return id;
    }

    public void setId(int id) {

        this.id = id;
    }

    public int getProjectId() {

        return projectId;
    }

    public void setProjectId(
            int projectId) {

        this.projectId =
                projectId;
    }

    public int getUserId() {

        return userId;
    }

    public void setUserId(int userId) {

        this.userId = userId;
    }

    public String getFullName() {

        return fullName;
    }

    public void setFullName(
            String fullName) {

        this.fullName =
                fullName;
    }

    public String getProfilePicture() {

        return profilePicture;
    }

    public void setProfilePicture(
            String profilePicture) {

        this.profilePicture =
                profilePicture;
    }

    public String getRole() {

        return role;
    }

    public void setRole(String role) {

        this.role = role;
    }
}