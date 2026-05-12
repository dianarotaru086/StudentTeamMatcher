package model;

public class Comment {

    private int id;

    private int projectId;

    private int userId;

    private String userName;

    private String profilePicture;

    private String message;

    private String createdAt;

    public int getId() {

        return id;
    }

    public void setId(int id) {

        this.id = id;
    }

    public int getProjectId() {

        return projectId;
    }

    public void setProjectId(int projectId) {

        this.projectId = projectId;
    }

    public int getUserId() {

        return userId;
    }

    public void setUserId(int userId) {

        this.userId = userId;
    }

    public String getUserName() {

        return userName;
    }

    public void setUserName(
            String userName) {

        this.userName =
                userName;
    }

    public String getProfilePicture() {

        return profilePicture;
    }

    public void setProfilePicture(
            String profilePicture) {

        this.profilePicture =
                profilePicture;
    }

    public String getMessage() {

        return message;
    }

    public void setMessage(
            String message) {

        this.message =
                message;
    }

    public String getCreatedAt() {

        return createdAt;
    }

    public void setCreatedAt(
            String createdAt) {

        this.createdAt =
                createdAt;
    }
}