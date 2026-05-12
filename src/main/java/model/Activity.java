package model;

public class Activity {

    private int id;

    private int projectId;

    private String activityText;

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

    public void setProjectId(
            int projectId) {

        this.projectId =
                projectId;
    }

    public String getActivityText() {

        return activityText;
    }

    public void setActivityText(
            String activityText) {

        this.activityText =
                activityText;
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