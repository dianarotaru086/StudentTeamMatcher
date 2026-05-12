package model;

public class ProjectFile {

    private int id;

    private int projectId;

    private int userId;

    private String fileName;

    private String uploadedAt;

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

    public String getFileName() {

        return fileName;
    }

    public void setFileName(
            String fileName) {

        this.fileName =
                fileName;
    }

    public String getUploadedAt() {

        return uploadedAt;
    }

    public void setUploadedAt(
            String uploadedAt) {

        this.uploadedAt =
                uploadedAt;
    }
}