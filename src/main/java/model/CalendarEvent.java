package model;

public class CalendarEvent {

    private int id;

    private int userId;

    private String title;

    private String description;

    private String eventDate;

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

    public String getEventDate() {

        return eventDate;
    }

    public void setEventDate(
            String eventDate) {

        this.eventDate =
                eventDate;
    }
}