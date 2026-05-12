package model;

public class User {

    private int id;
    private String fullName;
    private String email;
    private String password;
    private String role;
    private String skills;
    private String workStyle;
    private String profilePicture;

    public User() {
    }

    public User(int id, String fullName, String email,
                String password, String role,
                String skills, String workStyle) {

        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.password = password;
        this.role = role;
        this.skills = skills;
        this.workStyle = workStyle;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getSkills() {
        return skills;
    }

    public void setSkills(String skills) {
        this.skills = skills;
    }

    public String getWorkStyle() {
        return workStyle;
    }

    public void setWorkStyle(String workStyle) {
        this.workStyle = workStyle;
    }
    public String getProfilePicture() {

        return profilePicture;
    }

    public void setProfilePicture(
            String profilePicture) {

        this.profilePicture =
                profilePicture;
    }
}