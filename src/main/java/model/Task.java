package model;

public class Task {

    private int id;

    private int projectId;

    private String title;

    private String description;

    private String status;

    private String priority;

    private String deadline;
    private int userId;

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

    public String getTitle() {

        return title;
    }

    public void setTitle(String title) {

        this.title = title;
    }

    public String getDescription() {

        return description;
    }

    public void setDescription(
            String description) {

        this.description =
                description;
    }

    public String getStatus() {

        return status;
    }

    public void setStatus(String status) {

        this.status = status;
    }

    public String getPriority() {

        return priority;
    }

    public void setPriority(
            String priority) {

        this.priority =
                priority;
    }

    public String getDeadline() {

        return deadline;
    }

    public void setDeadline(
            String deadline) {

        this.deadline =
                deadline;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}