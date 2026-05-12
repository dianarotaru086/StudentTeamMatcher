package model;

public class Skill {

    private int id;

    private int userId;

    private String skillName;

    public int getId() {

        return id;
    }

    public void setId(int id) {

        this.id = id;
    }

    public int getUserId() {

        return userId;
    }

    public void setUserId(int userId) {

        this.userId = userId;
    }

    public String getSkillName() {

        return skillName;
    }

    public void setSkillName(String skillName) {

        this.skillName = skillName;
    }
}