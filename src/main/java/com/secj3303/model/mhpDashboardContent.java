package com.secj3303.model;

public class mhpDashboardContent {
    // Basic Info
    private String id;
    private String title;
    private String status;   
    private String type;     
    private String category; 
    private String date;     

    // Detailed Info (Required for the long constructor)
    private String description;
    private String contentBody;
    private String difficulty; 
    private int duration;       
    private int points;

    // Constructor 1: Short version (6 args) - For backward compatibility if needed
    public mhpDashboardContent(String id, String title, String status, String type, String category, String date) {
        this.id = id;
        this.title = title;
        this.status = status;
        this.type = type;
        this.category = category;
        this.date = date;
    }

    // Constructor 2: Full version (11 args) - THIS FIXES YOUR ERROR
    public mhpDashboardContent(String id, String title, String status, String type, String category, String date, 
                               String description, String contentBody, String difficulty, int duration, int points) {
        this.id = id;
        this.title = title;
        this.status = status;
        this.type = type;
        this.category = category;
        this.date = date;
        this.description = description;
        this.contentBody = contentBody;
        this.difficulty = difficulty;
        this.duration = duration;
        this.points = points;
    }

    // Default Constructor (Required for Spring)
    public mhpDashboardContent() {}

    // --- GETTERS AND SETTERS ---
    public String getId() { return id; }
    public void setId(String id) { this.id = id; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getContentBody() { return contentBody; }
    public void setContentBody(String contentBody) { this.contentBody = contentBody; }

    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }

    public int getDuration() { return duration; }
    public void setDuration(int duration) { this.duration = duration; }

    public int getPoints() { return points; }
    public void setPoints(int points) { this.points = points; }

    // Helper for CSS
    public String getStatusClass() {
        return "published".equalsIgnoreCase(status) ? "badge-published" : "badge-draft";
    }
}